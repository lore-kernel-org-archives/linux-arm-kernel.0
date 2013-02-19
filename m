From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 19 Feb 2013 11:23:13 +0530
Subject: [PATCH v2 0/5] Generic PHY Framework
Message-ID: <1361253198-7401-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a generic PHY framework that provides a set of APIs for the PHY drivers
to create/destroy a PHY and APIs for the PHY users to obtain a reference to
the PHY with or without using phandle. To obtain a reference to the PHY
without using phandle, the platform specfic intialization code (say from board
file) should have already called phy_bind with the binding information. The
binding information consists of phy's device name, phy user device name and an
index. The index is used when the same phy user binds to mulitple phys.

This framework will be of use only to devices that uses external PHY (PHY
functionality is not embedded within the controller).

The intention of creating this framework is to bring the phy drivers spread
all over the Linux kernel to drivers/phy to increase code re-use and to
increase code maintainability.

Comments to make PHY as bus wasn't done because PHY devices can be part of
other bus and making a same device attached to multiple bus leads to bad
design.

Changes from v1:
* Added Documentation for the PHY framework
* Added few more APIs mostly w.r.t devres
* Modified omap-usb2 and twl4030 to make use of the new framework

Did USB enumeration testing in panda and beagle.

Kishon Vijay Abraham I (5):
  drivers: phy: add generic PHY framework
  usb: phy: omap-usb2: use the new generic PHY framework
  usb: otg: twl4030: use the new generic PHY framework
  ARM: OMAP: USB: Add phy binding information
  usb: musb: omap2430: use the new generic PHY framework

 Documentation/ABI/testing/sysfs-class-phy    |   15 +
 Documentation/phy.txt                        |  113 ++++++
 MAINTAINERS                                  |    7 +
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +
 arch/arm/mach-omap2/board-3430sdp.c          |    2 +
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +
 arch/arm/mach-omap2/board-cm-t35.c           |    2 +
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +
 arch/arm/mach-omap2/board-igep0020.c         |    2 +
 arch/arm/mach-omap2/board-ldp.c              |    2 +
 arch/arm/mach-omap2/board-omap3beagle.c      |    2 +
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +
 arch/arm/mach-omap2/board-omap3logic.c       |    2 +
 arch/arm/mach-omap2/board-omap3pandora.c     |    2 +
 arch/arm/mach-omap2/board-omap3stalker.c     |    2 +
 arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +
 arch/arm/mach-omap2/board-overo.c            |    2 +
 arch/arm/mach-omap2/board-rm680.c            |    2 +
 arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +
 drivers/Kconfig                              |    2 +
 drivers/Makefile                             |    2 +
 drivers/phy/Kconfig                          |   13 +
 drivers/phy/Makefile                         |    5 +
 drivers/phy/phy-core.c                       |  519 ++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.h                 |    2 +
 drivers/usb/musb/omap2430.c                  |   22 +-
 drivers/usb/otg/twl4030-usb.c                |   41 ++
 drivers/usb/phy/omap-usb2.c                  |   49 +++
 include/linux/phy/phy.h                      |  198 ++++++++++
 include/linux/usb/omap_usb.h                 |    3 +
 31 files changed, 1019 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-phy
 create mode 100644 Documentation/phy.txt
 create mode 100644 drivers/phy/Kconfig
 create mode 100644 drivers/phy/Makefile
 create mode 100644 drivers/phy/phy-core.c
 create mode 100644 include/linux/phy/phy.h

-- 
1.7.10.4
