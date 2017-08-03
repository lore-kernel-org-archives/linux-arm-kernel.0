From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Aug 2017 16:14:03 +0800
Subject: [PATCH 0/8] ARM: sun8i: a83t: Add USB host support
Message-ID: <20170803081411.22389-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series enables USB host support for the Allwinner A83T SoC.
The A83T's USB OTG PHY uses different controls. The USB 2.0 host
PHYs are the same as previous chips. And the HSIC part is actually
used on some boards.

The external bits needed for proper USB OTG support is not there
yet, namely the regulators and power supplies for VBUS sensing and
control. This will be enabled later on. However the OTG controller
is the same as the one found in previous chips. This has been tested
under U-boot.

Patch 1 adds some properties that were missing for the H3. The H3
has 4 USB host controllers, so there are also 4 USB host PHYs. The
properies for the last one were missing.

Patch 2 adds a compatible string for the A83T USB PHY block.

Patch 3 adds support for a secondary clock for the HSIC PHY. The
HSIC block takes a 480MHz clock and a 12MHz clock. All known chips
only have at most 1 HSIC capable host/PHY.

Patch 4 adds support for the A83T's USB PHYs. The difference is
mainly how the OTG PHY (PHY0) is configured.

Patch 5 adds the device nodes for the USB PHY and hosts.

Patch 6 adds the device node for the USB OTG controller.

Patch 7 enables the USB hosts and peripherals on the Cubietruck Plus.

Patch 8 enables the USB hosts and peripherals on the H8Homlet v2.

The first four patches would go through linux-phy, while I will
take the other four through the sunxi tree. For those who want
to test this, the series is based on my previous "ARM: sun8i: a83t:
Add support for MMC controllers v3" and "mfd: axp20x: Add basic
support for AXP813 v2" series.


Regards
ChenYu

Chen-Yu Tsai (8):
  dt-bindings: phy: sun4i-usb-phy: Add property descriptions for H3
  dt-bindings: phy: sun4i-usb-phy: Add compatible string for A83T
  phy: sun4i-usb: Support secondary clock for HSIC PHY
  phy: sun4i-usb: Support A83T USB PHYs
  ARM: sun8i: a83t: Add USB PHY and host device nodes
  ARM: sun8i: a83t: Add device node for USB OTG controller
  ARM: sun8i: a83t: cubietruck-plus: Enable onboard USB peripherals
  ARM: sun8i: a83t: h8homlet-v2: Enable USB ports

 .../devicetree/bindings/phy/sun4i-usb-phy.txt      | 10 ++-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 29 ++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 49 ++++++++++--
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 76 +++++++++++++++++++
 drivers/phy/allwinner/phy-sun4i-usb.c              | 87 +++++++++++++++++++---
 5 files changed, 232 insertions(+), 19 deletions(-)

-- 
2.13.3
