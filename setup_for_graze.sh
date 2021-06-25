#!/usr/bin/env bash

# install prerequisites
sudo apt-get install -y libusb-1.0-0-dev

# compile
make

# install the binary to /usr/sbin/uhubctl
sudo make install

# give non-root users permissions for the USB hubs
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="14b0", MODE="0666"' | \
  sudo tee -a /etc/udev/rules.d/52-usb.rules > /dev/null

# make it so!
sudo udevadm trigger --attr-match=subsystem=usb
