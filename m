From: matt.porter@linaro.org (Matt Porter)
Date: Mon, 25 Nov 2013 13:15:58 -0500
Subject: [PATCH v3 0/9] USB Device Controller support for BCM281xx
Message-ID: <1385403367-18144-1-git-send-email-matt.porter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
	- Rebased on 3.13-rc1
	- Fix braces in phy_get_bus_width()/phy_set_bus_width()
	- Drop generic phy conversion to use the same support from
	  the Exynos generic phy conversion series
	- Modify dts support to match the "device" phy name required
	  in the v3 Exynos generic phy conversion
	- Add s3c-hsotg phy_init/phy_exit support
	- Fix typo on reg property in kona phy binding
	- Replace phy driver reg struct with offset defines
	- Move phy soft reset to phy driver init
	- Fix dts node names to match ePAPR conventions

Changes since v1:
	- Convert USB phy driver to generic phy subsystem
	- Add phy bus width apis
	- Drop dwc2 phy bus width DT property in favor of querying the
	  phy provider for bus width
	- Add generic phy/clock properties to dwc2 DT binding
	- Add generic phy subsystem support to s3c-hsotg with the
	  existing usb phy and pdata phy methods as a fallback
	- Split bindings out to separate patches to match the latest
	  DT binding review guidelines

This series adds USB Device Controller support for the Broadcom
BCM281xx family of parts. BCM281xx contains a DWC2 OTG block and
s3c-hsotg is used to support UDC operation.

Part 1 adds phy bus width support to the generic phy subsystem

Parts 2-6 allows s3c-hsotg to build on non-Samsung platforms, supports
the dwc2 binding, adds phy_init/phy_exit support, and supports fetching
phy bus width using the generic phy layer.

Parts 7-8 add a generic phy binding and driver for the BCM Kona USB PHY.

Part 9 adds the DT nodes to enable UDC support on both BCM281xx boards
in the kernel.

This series depends on:
	- "Update Kona drivers to use clocks" series
	  https://lkml.org/lkml/2013/11/14/450
	- "Add new Exynos USB 2.0 PHY driver" series
	  https://lkml.org/lkml/2013/11/5/271

Matt Porter (9):
  phy: add phy_get_bus_width()/phy_set_bus_width() calls
  staging: dwc2: update DT binding to add generic clock/phy properties
  usb: gadget: s3c-hsotg: enable build for other platforms
  usb: gadget: s3c-hsotg: add snps,dwc2 compatible string
  usb: gadget: s3c-hsotg: use generic phy_init()/phy_exit() support
  usb: gadget: s3c-hsotg: get phy bus width from phy subsystem
  phy: add Broadcom Kona USB2 PHY DT binding
  phy: add Broadcom Kona USB2 PHY driver
  ARM: dts: add usb udc support to bcm281xx

 .../devicetree/bindings/phy/bcm-kona-usb2-phy.txt  |  15 ++
 Documentation/devicetree/bindings/staging/dwc2.txt |  10 ++
 arch/arm/boot/dts/bcm11351-brt.dts                 |   6 +
 arch/arm/boot/dts/bcm11351.dtsi                    |  18 +++
 arch/arm/boot/dts/bcm28155-ap.dts                  |   8 ++
 drivers/phy/Kconfig                                |   6 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-bcm-kona-usb2.c                    | 158 +++++++++++++++++++++
 drivers/usb/gadget/Kconfig                         |   7 +-
 drivers/usb/gadget/s3c-hsotg.c                     |  22 ++-
 drivers/usb/gadget/s3c-hsotg.h                     |   1 +
 include/linux/phy/phy.h                            |  20 +++
 12 files changed, 265 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/bcm-kona-usb2-phy.txt
 create mode 100644 drivers/phy/phy-bcm-kona-usb2.c

-- 
1.8.4
