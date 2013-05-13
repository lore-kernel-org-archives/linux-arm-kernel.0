From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:31 -0400
Subject: [V9 PATCH 00/12] mv-usb phy driver
Message-ID: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches create the mv-usb phy driver

The patches remove the callbacks in the platform data for phy
initialization and shutdown, and directly write a phy driver
and make udc/ehci/otg to call it.

  usb: phy: protect phy init and shutdown for mutiple deivces
  usb: phy: mv_usb2: add PHY driver for marvell usb2 controller
Above patches are marvell usb PHY driver support.

  usb: gadget: mv_udc: use PHY driver for udc
  usb: ehci: ehci-mv: use PHY driver for ehci
  usb: phy: phy-mv-usb: use USB2 PHY driver for otg
Above patches modify the udc/ehci/otg drivers to make use of PHY
driver.

  usb: mv_u3d: usb phy drivers for phy operation
Above patch is the fix for marvel usb3 gadget driver. It will make
use of PHY driver.

  arm: mmp2: change the defintion of usb devices
  arm: pxa910: change the defintion of usb devices
  arm: ttc_dkb: modify usb support
  arm: mmp: remove unused usb devices
  arm: brownstone: add usb support for the board
Above patches are the changes from SOCes.

  usb: mv_usb: remove the phy callbacks in pdata
Above patch finally remove the callbacks for PHY in pdata.

V2->V1:
  Change the Signed-off-by to be right email address

v3->v2
  re-format the patches to new code base

v4->v3
  1. make mv udc gadget driver depend on ARCH_PXA and ARCH_MMP
  2. remove __devinit and __devexit
  3. make the driver compiled successful if CONFIG_MV_USB2_PHY is not defined.
  The modified patches are
  usb: gadget: mv_udc: make mv_udc depends on ARCH_MMP or ARCH_PXA
  usb: phy: mv_usb2: add PHY driver for marvell usb2 controller

v5->v4
  make the struct mv_usb2_extern_chip member ->head to be
  struct atomic_notifier_head instead of struct atomic_notifier_head *.

v6->v5
  the bug fix patches are merged.
  Removed the dependcy of ARCH_MMP and ARCH_PXA, and make the driver can be
  compiled for x86.
  The device tree support patches need modification, remove them from this
  patch series, and they will be submitted in another series.


v7->v6
  Use usb_add_phy_dev and related APIs to add PHY drivers.
  Removed the device tree support in PHY driver. It will be added in another
  patch series.

v8->v7
  bugs fix in phy driver.
  directly use devm_usb_get_phy_dev return value for error return.

v9->v8
  Remove u2o_xxx.
  Add prefix for register definition
  Move mutex to common PHY layer
  Use module_platform_driver() to register driver
  Use usleep_range to replace udelay

V10->V9
  Grammar fix in comments.

Chao Xie (12):
  usb: phy: protect phy init and shutdown for mutiple deivces
  usb: phy: mv_usb2: add PHY driver for marvell usb2 controller
  usb: gadget: mv_udc: use PHY driver for udc
  usb: ehci: ehci-mv: use PHY driver for ehci
  usb: phy: phy-mv-usb: use USB2 PHY driver for otg
  usb: mv_u3d: usb phy drivers for phy operation
  arm: mmp2: change the defintion of usb devices
  arm: pxa910: change the defintion of usb devices
  arm: ttc_dkb: modify usb support
  arm: mmp: remove unused usb devices
  arm: brownstone: add usb support for the board
  usb: mv_usb: remove the phy callbacks in pdata

 arch/arm/mach-mmp/brownstone.c          |   56 +++++
 arch/arm/mach-mmp/include/mach/mmp2.h   |    4 +
 arch/arm/mach-mmp/include/mach/pxa910.h |    7 +-
 arch/arm/mach-mmp/mmp2.c                |    4 +
 arch/arm/mach-mmp/pxa910.c              |    4 +
 arch/arm/mach-mmp/ttc_dkb.c             |   39 +++-
 drivers/usb/gadget/mv_u3d.h             |    3 +-
 drivers/usb/gadget/mv_u3d_core.c        |   54 ++---
 drivers/usb/gadget/mv_udc.h             |    2 +-
 drivers/usb/gadget/mv_udc_core.c        |   50 ++---
 drivers/usb/host/ehci-mv.c              |   49 ++---
 drivers/usb/phy/Kconfig                 |    6 +
 drivers/usb/phy/Makefile                |    1 +
 drivers/usb/phy/phy-mv-usb.c            |   53 ++---
 drivers/usb/phy/phy-mv-usb.h            |    2 +-
 drivers/usb/phy/phy-mv-usb2.c           |  380 +++++++++++++++++++++++++++++++
 drivers/usb/phy/phy.c                   |    6 +
 include/linux/platform_data/mv_usb.h    |    3 -
 include/linux/usb/mv_usb2.h             |   29 +++
 include/linux/usb/phy.h                 |   22 ++-
 20 files changed, 624 insertions(+), 150 deletions(-)
 create mode 100644 drivers/usb/phy/phy-mv-usb2.c
 create mode 100644 include/linux/usb/mv_usb2.h

-- 
1.7.4.1
