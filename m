From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 16 Feb 2017 13:48:47 +0100
Subject: [PATCH 09/21] ARM: dts: sun8i: Enable dwmac-sun8i on the Banana Pi M2+
In-Reply-To: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
Message-ID: <20170216124859.14346-10-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: LABBE Corentin <clabbe.montjoie@gmail.com>

The dwmac-sun8i hardware is present on the Banana Pi M2+
It uses an external PHY rtl8211e via RGMII.

This patch create the needed regulator, emac and phy nodes.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index c0c49dd..a4f7b99 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -91,6 +91,18 @@
 		pinctrl-0 = <&wifi_en_bpi_m2p>;
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
 	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		      compatible = "regulator-fixed";
+		      pinctrl-names = "default";
+		      pinctrl-0 = <&gmac_power_pin_orangepi>;
+		      regulator-name = "gmac-3v3";
+		      regulator-min-microvolt = <3300000>;
+		      regulator-max-microvolt = <3300000>;
+		      startup-delay-us = <100000>;
+		      enable-active-high;
+		      gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	      };
 };
 
 &ehci1 {
@@ -187,3 +199,29 @@
 	/* USB VBUS is on as long as VCC-IO is on */
 	status = "okay";
 };
+
+&pio {
+	gmac_power_pin_orangepi: gmac_power_pin at 0 {
+		 allwinner,pins = "PD6";
+		 allwinner,function = "gpio_out";
+		 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	 };
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		reg = <0>;
+	};
+};
+
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
-- 
2.10.2
