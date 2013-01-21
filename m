From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 21 Jan 2013 05:07:18 -0500
Subject: [V4 PATCH 00/26] mv-usb fix and enhancement patches
In-Reply-To: <xiechao.mail@gmail.com>
References: <xiechao.mail@gmail.com>
Message-ID: <1358762864-9249-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are divied into 4 parts
1. bug fixes
  usb: gadget: mv_udc: use udc_start and udc_stop functions
  usb: gadget: mv_udc: use devm_xxx for probe
  usb: gadget: mv_udc: fix the warning of mv_udc_remove
  usb: otg: mv_otg: use devm_xxx for probe
  usb: host: ehci-mv: remove unused variable
  usb: gadget: mv_udc: fix the value of tranceiver
  usb: gadget: mv_udc: make mv_udc depends on ARCH_MMP or ARCH_PXA
Above patches are bug fixes.

2. PHY driver
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

3. external chip support
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

4. device tree support
After removing the callbacks in platform data, and the not
constant variables in platform data. All the information needed
by udc/otg/ehci driver are constant.

  usb: gadget: mv_udc: add device tree support
  usb: otg: mv_otg: add device tree support
  usb: ehci: ehci-mv: add device tree support
Above patches are device tree support for udc/otg/ehci driver.

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

Chao Xie (26):
  usb: gadget: mv_udc: use udc_start and udc_stop functions
  usb: gadget: mv_udc: use devm_xxx for probe
  usb: gadget: mv_udc: fix the warning of mv_udc_remove
  usb: otg: mv_otg: use devm_xxx for probe
  usb: host: ehci-mv: remove unused variable
  usb: gadget: mv_udc: fix the value of tranceiver
  usb: gadget: mv_udc: make mv_udc depends on ARCH_MMP or ARCH_PXA
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
  usb: gadget: mv_udc: add device tree support
  usb: otg: mv_otg: add device tree support
  usb: ehci: ehci-mv: add device tree support

 arch/arm/mach-mmp/brownstone.c            |   45 +++
 arch/arm/mach-mmp/devices.c               |  278 ----------------
 arch/arm/mach-mmp/include/mach/mmp2.h     |    4 +
 arch/arm/mach-mmp/include/mach/pxa910.h   |    7 +-
 arch/arm/mach-mmp/include/mach/regs-usb.h |  253 --------------
 arch/arm/mach-mmp/mmp2.c                  |    4 +
 arch/arm/mach-mmp/pxa168.c                |   42 ---
 arch/arm/mach-mmp/pxa910.c                |    4 +
 arch/arm/mach-mmp/ttc_dkb.c               |   32 +-
 drivers/usb/gadget/mv_udc.h               |   10 +-
 drivers/usb/gadget/mv_udc_core.c          |  385 +++++++++++-----------
 drivers/usb/host/ehci-mv.c                |  158 ++++++----
 drivers/usb/otg/mv_otg.c                  |  283 +++++++++--------
 drivers/usb/otg/mv_otg.h                  |   11 +-
 drivers/usb/phy/Kconfig                   |    7 +
 drivers/usb/phy/Makefile                  |    1 +
 drivers/usb/phy/mv_usb2_phy.c             |  508 +++++++++++++++++++++++++++++
 include/linux/platform_data/mv_usb.h      |   22 +-
 include/linux/usb/mv_usb2.h               |   97 ++++++
 19 files changed, 1171 insertions(+), 980 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-usb.h
 create mode 100644 drivers/usb/phy/mv_usb2_phy.c
 create mode 100644 include/linux/usb/mv_usb2.h

-- 
1.7.4.1
