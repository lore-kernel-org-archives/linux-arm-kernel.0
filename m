From: david@lechnology.com (David Lechner)
Date: Wed, 26 Oct 2016 19:18:14 -0500
Subject: [PATCH v7 0/4] da8xx USB PHY platform devices and clocks
Message-ID: <1477527498-21930-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series depends on [v3] ARM: davinci: da8xx: Fix some redefined symbol
warnings <https://patchwork.kernel.org/patch/9397005/> being applied first.

v7 changes:
* Dropped patches that have been accepted into linux-davinci already
* New patch for adding device names to clock lookup tables
* Picked up related patch from Axel Haslam for registering USB PHY clocks on
  device tree boards and added error checking to to that patch
* Rebased on latest linux-davinci + linux-next
* Added devices instead of NULL in clk_get() where appropriate usb-da8xx.c
* Re-ordered patches so that they apply/build cleanly

v6 changes:

* Combine "ARM: davinci: da8xx: Enable the usb20 "per" clk on phy_clk_enable"
  from the "[PATCH/RFT v2 00/17] Add DT support for ohci-da8xx" series with
  the "ARM: davinci: da8xx: add usb phy clocks" patch in this series.
* Change the syscon and da8xx-usb-phy device ids to -1.

v5 changes: renamed "usbphy" to "usb_phy" or "usb-phy" as appropriate

v4 changes: fix strict checkpatch complaint

v3 changes:

* Fixed the davinci device tree declarations to use the preferred DT address
  convention so that the items I have added can be correct too.
* Moved that davinci clock init so that we don't have to call ioremap in the
  clock mux functions.
* Added a new "syscon" device for the CFGCHIP registers. This is used by the
  USB PHY driver and will be used in the future in common clock framework
  drivers.
* USB clocks are moved to a common file instead of having duplicated code.
* PHY driver uses syscon for CFGCHIP registers instead of using them directly.

Axel Haslam (1):
  ARM: davinci: da8xx: register USB PHY clocks in the DT file

David Lechner (3):
  ARM: davinci: da8xx: Add USB PHY platform declaration
  ARM: davinci: da8xx: Add USB device names to clock lookup tables
  ARM: davinci: da8xx: add usb phy clocks

 arch/arm/mach-davinci/board-da830-evm.c     |  49 ++---
 arch/arm/mach-davinci/board-omapl138-hawk.c |  20 ++-
 arch/arm/mach-davinci/da830.c               |   4 +-
 arch/arm/mach-davinci/da850.c               |   4 +-
 arch/arm/mach-davinci/da8xx-dt.c            |  14 ++
 arch/arm/mach-davinci/include/mach/da8xx.h  |   4 +
 arch/arm/mach-davinci/usb-da8xx.c           | 270 ++++++++++++++++++++++++++--
 7 files changed, 307 insertions(+), 58 deletions(-)

-- 
2.7.4
