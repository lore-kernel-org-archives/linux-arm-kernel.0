From: david@lechnology.com (David Lechner)
Date: Mon, 31 Oct 2016 15:47:18 -0500
Subject: [PATCH v8 0/3] da8xx USB PHY platform devices and clocks
Message-ID: <1477946841-16126-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I reworked the "[PATCH v6 4/5] ARM: DTS: da850: Add cfgchip syscon node" and
"[PATCH v6 5/5] ARM: DTS: da850: Add usb phy node" patches that were dropped
from linux-davinci into the new "ARM: dts: da850: Add cfgchip syscon node"
patch. This should be OK unless it is decided that the BayLibre guys should
rework it so that the entire SYSCFG0 is a single syscon device. I don't see
any compelling reason to do that though.

v8 changes:
* Dropped v7 patches that have been accepted into linux-davinci already
* New patch for CFGCHIP syscon/USB PHY DT node
* Rebased other patches

v7 changes:
* Dropped v6 patches that have been accepted into linux-davinci already
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

David Lechner (2):
  ARM: dts: da850: Add cfgchip syscon node
  ARM: davinci: da8xx: add usb phy clocks

 arch/arm/boot/dts/da850.dtsi                |  10 ++
 arch/arm/mach-davinci/board-da830-evm.c     |  31 +---
 arch/arm/mach-davinci/board-omapl138-hawk.c |  15 +-
 arch/arm/mach-davinci/da8xx-dt.c            |  12 ++
 arch/arm/mach-davinci/include/mach/da8xx.h  |   3 +
 arch/arm/mach-davinci/usb-da8xx.c           | 267 ++++++++++++++++++++++++++--
 6 files changed, 296 insertions(+), 42 deletions(-)

-- 
2.7.4
