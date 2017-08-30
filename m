From: embed3d@gmail.com (Philipp Rossak)
Date: Wed, 30 Aug 2017 05:01:06 +0200
Subject: [PATCH 3/7] ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Nanopi M1
 Plus
In-Reply-To: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
References: <1504062070-13523-1-git-send-email-embed3d@gmail.com>
Message-ID: <1504062070-13523-4-git-send-email-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Rossak <embed3d@gmail.com>

The dwmac-sun8i hardware is present on the Nanopi M1 Plus.
It uses an external PHY.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
index ece275b..b9c6c27 100644
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
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &ehci1 {
@@ -55,12 +69,30 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
 	status = "okay";
 };
 
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
2.7.4
