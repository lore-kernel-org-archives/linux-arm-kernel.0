From: chao.xie@marvell.com (Chao Xie)
Date: Wed,  6 Feb 2013 02:23:35 -0500
Subject: [V6 PATCH 00/16] mv-usb phy enhancement patches
Message-ID: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are divied into 2 parts

1. PHY driver
To remove the callbacks in the platform data, a usb PHY driver
for marvell udc/otg/ehci is written.
For device tree support, it is not good to pass the callback
pointers by platform data. The PHY driver also removes the
block.

  usb: phy: mv_usb2: add PHY driver for marvell usb2 controller
  usb: gadget: mv_udc: use PHY driver for udc
  usb: ehci: ehci-mv: use PHY driver for ehci
  usb: otg: mv_otg: use PHY driver for otg
Above patches are marvell usb PHY driver support.

  arm: mmp2: change the defintion of usb devices
  arm: pxa910: change the defintion of usb devices
  arm: brownstone: add usb support for the board
  arm: ttc_dkb: add usb support
  arm: mmp: remove the usb phy setting
  arm: mmp: remove usb devices from pxa168
Above patches are for SOC/board support for marvell usb PHY
driver.

2. external chip support
The marvell usb controller can detect the vbus/idpin, but it
need PHY and usb clocks to be enabled.
Based on measurement it will import 15mA current, and increase
the power when the usb is not used.
Using a external chip to detect vbus/idpin changes will save
the power.
In fact the marvell PMIC 88pm860x and 88pm80x can do it. The
drivers are located at drivers/mfd.
So add a middle layer in the marvell usb PHY driver.
PMIC call the APIs in middle driver to registers the callback
for vbus/idpin detection/query
udc/otg/ehci driver will call the APIs to get vbus/idpin changes
and query the states of the vbus/idpin.
  usb: phy: mv_usb2_phy: add externel chip support
  usb: gadget: mv_udc: add extern chip support
  usb: ehci: ehci-mv: add extern chip support
  usb: otg: mv_otg: add extern chip support
Above patches are the middle layer suppor for udc/otg/ehci

  arm: mmp: add extern chip support for brownstone
  arm: mmp: add extern chip support for ttc_dkb
Above patches are corresponding board file changes

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


Chao Xie (16):
  usb: phy: mv_usb2: add PHY driver for marvell usb2 controller
  usb: gadget: mv_udc: use PHY driver for udc
  usb: ehci: ehci-mv: use PHY driver for ehci
  usb: otg: mv_otg: use PHY driver for otg
  arm: mmp2: change the defintion of usb devices
  arm: pxa910: change the defintion of usb devices
  arm: brownstone: add usb support for the board
  arm: ttc_dkb: add usb support
  arm: mmp: remove the usb phy setting
  arm: mmp: remove usb devices from pxa168
  usb: phy: mv_usb2_phy: add externel chip support
  usb: gadget: mv_udc: add extern chip support
  usb: ehci: ehci-mv: add extern chip support
  usb: otg: mv_otg: add extern chip support
  arm: mmp: add extern chip support for brownstone
  arm: mmp: add extern chip support for ttc_dkb

 arch/arm/mach-mmp/brownstone.c            |   45 +++
 arch/arm/mach-mmp/devices.c               |  278 ----------------
 arch/arm/mach-mmp/include/mach/mmp2.h     |    4 +
 arch/arm/mach-mmp/include/mach/pxa910.h   |    7 +-
 arch/arm/mach-mmp/include/mach/regs-usb.h |  253 ---------------
 arch/arm/mach-mmp/mmp2.c                  |    4 +
 arch/arm/mach-mmp/pxa168.c                |   42 ---
 arch/arm/mach-mmp/pxa910.c                |    4 +
 arch/arm/mach-mmp/ttc_dkb.c               |   32 ++-
 drivers/usb/gadget/mv_udc.h               |    5 +-
 drivers/usb/gadget/mv_udc_core.c          |   70 ++--
 drivers/usb/host/ehci-mv.c                |   49 ++--
 drivers/usb/otg/mv_otg.c                  |   96 +++----
 drivers/usb/otg/mv_otg.h                  |    5 +-
 drivers/usb/phy/Kconfig                   |    7 +
 drivers/usb/phy/Makefile                  |    1 +
 drivers/usb/phy/mv_usb2_phy.c             |  503 +++++++++++++++++++++++++++++
 include/linux/platform_data/mv_usb.h      |   22 +-
 include/linux/usb/mv_usb2.h               |  128 ++++++++
 19 files changed, 832 insertions(+), 723 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-usb.h
 create mode 100644 drivers/usb/phy/mv_usb2_phy.c
 create mode 100644 include/linux/usb/mv_usb2.h

-- 
1.7.4.1
