From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 21 Nov 2018 14:11:39 +0100
Subject: [PATCH 0/5] nvmem: Enable OTP access for Raspberry Pi
Message-ID: <1542805904-6446-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VC4 firmware exposes a mailbox interface that allows the ARM core
to access only the customer part (8 cells * 32 bits) of the OTP memory.
This version brings read-only support, but could also be extended to
write support. Beside the kernelspace support this is also a limited userspace
alternative to the vendor specific "vcgencmd otp_dump".

I think this driver could be helpful for vendors, which integrate the
Raspberry Pi Compute Module in their products need to store unique data
like a serial or additional MAC address in the OTP.

Note for testers: This series needs "firmware: raspberrypi: Fix firmware calls
with large buffers" from James Hughes to work properly.

Changes since RFC:
- implement improvements suggested by Rob Herring and Eric Anholt
- extend Kconfig description
- define nvmem type and read only
- make MODULE_LICENSE match license text
- add patches to enable driver in bcm2835 and multi_v7 defconfig
- rebased on current srini/nvmem.git/for-next

Stefan Wahren (5):
  dt-bindings: nvmem: add binding for Raspberry Pi OTP
  nvmem: add driver for Raspberry Pi OTP
  ARM: dts: bcm2835-rpi: Enable OTP access for Raspberry Pi
  ARM: bcm2835_defconfig: Enable Raspberry Pi OTP driver
  ARM: multi_v7_defconfig: Enable Raspberry Pi OTP driver

 .../nvmem/raspberrypi,bcm2835-customer-otp.txt     |  22 ++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   4 +
 arch/arm/configs/bcm2835_defconfig                 |   2 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/nvmem/Kconfig                              |  10 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/raspberrypi-otp.c                    | 113 +++++++++++++++++++++
 7 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
 create mode 100644 drivers/nvmem/raspberrypi-otp.c

-- 
2.7.4
