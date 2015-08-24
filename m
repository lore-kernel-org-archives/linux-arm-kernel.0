From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 24 Aug 2015 08:40:03 +0000
Subject: [PATCH v4 0/5] bcm2835: auxiliar device support for spi
Message-ID: <1440405608-3995-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The BCM2835 contains 3 auxiliar devices:
* spi1
* spi2
* uart1

All of those 3 devices are enabled/disabled via a shared register,
which is set by default to be disabled.

Access to this register needs to get serialized.

So fter several iterations of discussions with the following idea:
* syscon - device tree should describe HW not drivers to use -
           'compatiblity = "brcm,bcm2835-aux-enable", "syscon";'
           is not acceptable
* regulator - it is not necessarily a regulator or a power gate
              that is implemented in HW, so it is not valid to use
              this framework

The recommendation was made to create a new minimal API in soc
just for access to this shared enable/disable register.

This patch-series implements:
* the bcm2835-auxiliar device enable/disable api in soc.
* the bcm2835-auxiliar spi device driver

The uart1 device driver (ns16550 based) is not implemented so far
but should be using the same API.

Martin Sperl (5):
  soc: bcm2835: auxiliar devices enable infrastructure
  ARM: bcm2835: add DT for the bcm2835 auxiliar devices
  dt/bindings: bcm2835: add binding documentation for bcm2835-aux
  spi: bcm2835: new driver implementing auxiliar spi1/spi2 on the
    bcm2835 soc
  dt/bindings: bcm2835: Add binding documentation for auxiliar spi
    devices

 .../bindings/soc/bcm/brcm,bcm2835-aux.txt          |   27 ++
 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |   61 +++
 arch/arm/boot/dts/bcm2835.dtsi                     |   37 ++
 arch/arm/configs/bcm2835_defconfig                 |    1 +
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/bcm/Kconfig                            |   11 +
 drivers/soc/bcm/Makefile                           |    1 +
 drivers/soc/bcm/bcm2835-aux.c                      |  154 ++++++
 drivers/spi/Kconfig                                |   12 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm2835aux.c                       |  506 ++++++++++++++++++++
 include/linux/soc/bcm/bcm2835-aux.h                |   23 +
 13 files changed, 836 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-aux.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-spi.txt
 create mode 100644 drivers/soc/bcm/Kconfig
 create mode 100644 drivers/soc/bcm/Makefile
 create mode 100644 drivers/soc/bcm/bcm2835-aux.c
 create mode 100644 drivers/spi/spi-bcm2835aux.c
 create mode 100644 include/linux/soc/bcm/bcm2835-aux.h

--
1.7.10.4
