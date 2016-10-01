From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  1 Oct 2016 14:18:57 +0200
Subject: [PATCH v3 0/3] usb/phy: Add Amlogic Meson8b and GXBB USB support
In-Reply-To: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161001121900.1168-1-martin.blumenstingl@googlemail.com>
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


Changes since v2:
- integrated a patch from Axel Lin to add the USB_SUPPORT dependency
- renamed driver (Kconfig, source and docs) to phy-meson8b-usb2 as the
  driver is only compatible with the USB2 PHY found on Meson8b and GXBB
  (newer SoC versions are using a different USB PHY and I could not
  find anything that the Meson8b / GXBB and GXL / GXM USB PHYs have in
  common)
- switch from device_reset_optional to reset_control_reset and move
  this call to phy_meson8b_usb2_power_on. This will allow us to simply
  switch to devm_reset_control_get_optional_shared in the future, once
  the reset control supports reset pulses for shared reset lines
- updated documentation example (use dash instead of unserscore in node
  name and use a better reg example)
- dropped the following patches as they were accepted upstream (the
  only patch which remains from the original series is the actual PHY
  driver):
  - "usb: dwc2: add support for Meson8b and GXBB SoCs" (f94310ac076e in
    arm-soc.git/next/late)
  - "Documentation: dt-bindings: Add documentation for the Meson USB2
    PHYs" (c940d7658de0 in arm-soc.git/next/late)
  - "ARM64: meson-gxbb: add USB Nodes" (566603e5e6b6 in
    arm-soc.git/next/late)
  - "ARM64: meson-gxbb-p20x: Enable USB Nodes" (8735053d7968 in
    arm-soc.git/next/late)
  - "ARM64: meson-gxbb-vega-s95: Enable USB Nodes" (c763eb82a01d in
    arm-soc.git/next/late)

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

Martin Blumenstingl (3):
  Documentation: dt-bindings: update the meson-usb2-phy example
  Documentation: dt-bindings: rename meson-usb2-phy to meson8b-usb2-phy
  phy: meson: add USB2 PHY support for Meson8b and GXBB

 .../{meson-usb2-phy.txt => meson8b-usb2-phy.txt}   |   6 +-
 drivers/phy/Kconfig                                |  13 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-meson8b-usb2.c                     | 284 +++++++++++++++++++++
 4 files changed, 301 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/phy/{meson-usb2-phy.txt => meson8b-usb2-phy.txt} (87%)
 create mode 100644 drivers/phy/phy-meson8b-usb2.c

-- 
2.10.0
