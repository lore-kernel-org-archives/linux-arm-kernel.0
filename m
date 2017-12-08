From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Dec 2017 15:31:57 +0800
Subject: [PATCH 2/2] ARM: dts: sun8i: a83t: Enable Ethernet on two boards
In-Reply-To: <20171208073157.14599-1-wens@csie.org>
References: <20171208073157.14599-1-wens@csie.org>
Message-ID: <20171208073157.14599-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubietruck Plus has a Realtek RTL8211E RGMII PHY tied to the EMAC.
The AXP818 PMIC's regulators provide main power and secondary signaling
voltages to the PHY. The latter is always on, as it also supplies the
pingroup on the SoC, which has other uses.

The Bananapi M3 has a Realtek RTL8211E RGMII PHY tied to the EMAC.
The AXP818 PMIC's SW regulators provides power to the PHY.

This patch enables Ethernet with the EMAC on both these boards by
enabling the emac node and setting all the required properties.
A proper ethernet alias is added as well.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts     | 19 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index c606af3dbfed..6550bf0e594b 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -52,6 +52,7 @@
 	compatible = "sinovoip,bpi-m3", "allwinner,sun8i-a83t";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -88,6 +89,24 @@
 	/* TODO GL830 USB-to-SATA bridge downstream w/ GPIO power controls */
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_sw>;
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii";
+	allwinner,rx-delay-ps = <700>;
+	allwinner,tx-delay-ps = <700>;
+	status = "okay";
+};
+
+&mdio {
+	rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 7f0a3f6d0cf2..6da08cd0e107 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -52,6 +52,7 @@
 	compatible = "cubietech,cubietruck-plus", "allwinner,sun8i-a83t";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -154,6 +155,22 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_dldo4>;
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&mdio {
+	rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.15.0
