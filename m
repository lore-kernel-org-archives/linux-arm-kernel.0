From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  9 Jun 2017 23:34:36 +0800
Subject: [PATCH] ARM: sun8i: h3: Enable EMAC with external PHY on Orange Pi
 Plus 2E
Message-ID: <20170609153436.18370-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi Plus 2E, unlike the Orange Pi PC and PC Plus which its
schematics are based on, uses an external Realtek RTL8211E PHY in
RGMII mode, with a GPIO enabling the regulator for I/O signalling
power supplies. The PHY's main power supply is enabled by the main
5V power supply.

Add the regulator and PHY nodes, and override the PHY phandle under
the EMAC node, so that the EMAC works properly on this board.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
index 5851a47a3089..80026f3caafc 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts
@@ -50,4 +50,30 @@
 / {
 	model = "Xunlong Orange Pi Plus 2E";
 	compatible = "xunlong,orangepi-plus2e", "allwinner,sun8i-h3";
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
 };
-- 
2.11.0
