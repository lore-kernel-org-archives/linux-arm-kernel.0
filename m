From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 22:06:46 -0500
Subject: [PATCH v6 0/5] da8xx USB PHY platform devices and clocks
Message-ID: <1477451211-31979-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It has been almost 6 months since the v5 submission, so here is a recap:

* There were a number of phy and usb dependencies that were submitted
  separately.
* The last of the usb dependencies has finally made its way into linux-next
  today.
* This series was recently included in "[PATCH/RFT v2 00/17] Add DT support for
  ohci-da8xx". I am breaking it back out again as a standalone series.


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

David Lechner (5):
  ARM: davinci: da8xx: add usb phy clocks
  ARM: davinci: da8xx: Add CFGCHIP syscon platform declaration.
  ARM: davinci: da8xx: Add USB PHY platform declaration
  ARM: DTS: da850: Add cfgchip syscon node
  ARM: DTS: da850: Add usb phy node

 arch/arm/boot/dts/da850.dtsi                |   9 ++
 arch/arm/mach-davinci/board-da830-evm.c     |  52 +++---
 arch/arm/mach-davinci/board-da850-evm.c     |   4 +
 arch/arm/mach-davinci/board-mityomapl138.c  |   4 +
 arch/arm/mach-davinci/board-omapl138-hawk.c |  23 ++-
 arch/arm/mach-davinci/devices-da8xx.c       |  28 ++++
 arch/arm/mach-davinci/include/mach/da8xx.h  |   6 +
 arch/arm/mach-davinci/usb-da8xx.c           | 243 +++++++++++++++++++++++++++-
 8 files changed, 327 insertions(+), 42 deletions(-)

-- 
2.7.4
