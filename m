From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 11 Sep 2016 15:41:05 +0200
Subject: [PATCH v2 0/6] usb/phy: Add Amlogic Meson8b and GXBB USB support
In-Reply-To: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160911134111.31141-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial support for the DWC2 USB controllers and Meson
specific USB PHYs found in Meson8b and GXBB SoCs, which means:
- new DWC2 bindings and platform specific core configuration
- a PHY driver supporting the USB2 PHY on Meson8b and GXBB SoCs

The first DWC2 controller is usually configured in OTG mode, whereas
the second DWC2 controller is usually configured in host(-only) mode.

Unfortunately no (public) datasheet is available and the reference PHY
driver does not contain comments or speaking register name definitions.
The nice people from BayLibre have already requested the datasheets
(currently we can for example only guess that there is a mux clock
inside the PHY, but we don't know it's parents).

With this series both DWC2 controllers are configure in host mode,
because the reference driver polls some of the PHY registers in OTG
mode and then re-configures the dwc2 driver instance accordingly (if
anyone is interested, this is the relevant piece of code: [0]). This
seems good enough for the beginning though.


Changes since v1:
- the patch "clk: gxbb: expose USB clocks" was not sent again as it was
  already applied by Kevin Hilman (thanks!)
- dropped (unnecessary) USB PHY bus from .dts
- remove underscores from PHY node names in .dts
- rename the dwc2 nodes in the .dts to usb (as per convention)
- remove unused struct reset_control from phy_meson_usb2_priv
- removed refcounting "reset" workaround and only specify the reset for
  the first PHY in the .dts (Jerome has reported that his boards don't
  need the explicit reset, while my board needs it). In addition (to
  make this work) the driver now treats the reset as optional
- use the RESET_USB_OTG definition (from
  <dt-bindings/reset/amlogic,meson-gxbb-reset.h>) instead of a magic
  number in the .dts


[0] https://github.com/150balbes/Amlogic_s905-kernel/blob/master/drivers/amlogic/usb/dwc_otg/310/dwc_otg_driver.c#L642


Jerome Brunet (2):
  usb: dwc2: add support for Meson8b and GXBB SoCs
  ARM64: meson-gxbb-p20x: Enable USB Nodes

Martin Blumenstingl (4):
  Documentation: dt-bindings: Add documentation for the Meson USB2 PHYs
  phy: meson: add USB2 PHY support for Meson8b and GXBB
  ARM64: meson-gxbb: add USB Nodes
  ARM64: meson-gxbb-vega-s95: Enable USB Nodes

 .../devicetree/bindings/phy/meson-usb2-phy.txt     |  27 ++
 Documentation/devicetree/bindings/usb/dwc2.txt     |   2 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  29 +++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  30 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  43 ++++
 drivers/phy/Kconfig                                |  11 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-meson-usb2.c                       | 280 +++++++++++++++++++++
 drivers/usb/dwc2/platform.c                        |  34 +++
 9 files changed, 457 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-usb2-phy.txt
 create mode 100644 drivers/phy/phy-meson-usb2.c

-- 
2.9.3
