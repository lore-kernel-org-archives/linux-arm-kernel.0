From: luaraneda@gmail.com (Luis Araneda)
Date: Tue,  1 Aug 2017 01:01:15 -0400
Subject: [PATCH] ARM: dts: sun8i: h3: Enable EMAC with external PHY on NanoPi
 M1 Plus
Message-ID: <20170801050115.21497-1-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Nanopi M1 Plus uses an external Realtek RTL8211E PHY in RGMII mode,
enabled by a GPIO-based regulator.

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 31 +++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index 8ddd1b2cc..54727990c 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
@@ -45,6 +45,20 @@
 / {
 	model = "FriendlyArm NanoPi M1 Plus";
 	compatible = "friendlyarm,nanopi-m1-plus", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+	};
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
 };
 
 &ehci1 {
@@ -55,6 +69,23 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
 &ohci1 {
 	status = "okay";
 };
-- 
2.13.3
