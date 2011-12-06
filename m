From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 6 Dec 2011 18:43:11 +0800
Subject: [RFC PATCH 0/3] Use Generic USB PHY Layer at i.MX Platform
Message-ID: <1323168194-24191-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi balbi, others,

I have created this patchset to show how a generic USB PHY Layer to work.
There are two USB PHYs (UTMI and ULPI) at i.MX51 BBG board, we can use
two phys together with Heikki proposal's generic phy file at i.MX USB 
host driver, and let both otg host(UTMI) and host 1 (ULPI)work together.

With this patchset, I hope we can find how USB PHY Layer works, and what
it can do, and improve Heikki's patch. 

Split PHY from OTG can give the benefit for the situation which only needs
to use the PHY. So, I hope we can mainline generic USB PHY driver earlier.

Peter Chen (3):
  USB: Add Generic USB PHY Layer code
  USB: ehci-mxc: Use new phy structure code for mxc host use
  ARM: mx51: Create two usb phy platform drivers

 arch/arm/mach-mx5/Kconfig                         |    4 +
 arch/arm/mach-mx5/board-mx51_babbage.c            |   33 ++-
 arch/arm/plat-mxc/Makefile                        |    1 +
 arch/arm/plat-mxc/devices/Kconfig                 |    6 +
 arch/arm/plat-mxc/devices/Makefile                |    2 +
 arch/arm/plat-mxc/devices/platform-fsl-phy-ulpi.c |   18 +
 arch/arm/plat-mxc/devices/platform-fsl-phy-utmi.c |   18 +
 arch/arm/plat-mxc/include/mach/devices-common.h   |    5 +
 arch/arm/plat-mxc/include/mach/mxc_phy.h          |   20 ++
 arch/arm/plat-mxc/include/mach/ulpi.h             |   11 -
 arch/arm/plat-mxc/ulpi.c                          |  114 ++++++-
 arch/arm/plat-mxc/utmi.c                          |  121 +++++++
 drivers/usb/host/ehci-mxc.c                       |   28 +-
 drivers/usb/otg/Kconfig                           |    2 +
 drivers/usb/otg/Makefile                          |    1 +
 drivers/usb/otg/phy.c                             |  368 +++++++++++++++++++++
 drivers/usb/otg/ulpi.c                            |   99 +++---
 include/linux/usb/phy.h                           |  250 ++++++++++++++
 18 files changed, 1020 insertions(+), 81 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-fsl-phy-ulpi.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-fsl-phy-utmi.c
 create mode 100644 arch/arm/plat-mxc/include/mach/mxc_phy.h
 create mode 100644 arch/arm/plat-mxc/utmi.c
 create mode 100644 drivers/usb/otg/phy.c
 create mode 100644 include/linux/usb/phy.h
