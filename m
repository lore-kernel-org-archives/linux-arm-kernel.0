From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 16 Feb 2017 13:48:51 +0100
Subject: [PATCH 13/21] ARM: dts: sun8i: Enable dwmac-sun8i on the Orange Pi
 plus
In-Reply-To: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
Message-ID: <20170216124859.14346-14-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the Orange PI plus.
It uses an external PHY rtl8211e via RGMII.

This patch create the needed regulator, emac and phy nodes.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 8c40ab7..17b2b92 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -58,6 +58,18 @@
 		enable-active-high;
 		gpio = <&pio 6 11 GPIO_ACTIVE_HIGH>;
 	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac_power_pin_orangepi>;
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &ehci3 {
@@ -86,8 +98,32 @@
 		pins = "PG11";
 		function = "gpio_out";
 	};
+
+	gmac_power_pin_orangepi: gmac_power_pin at 0 {
+		allwinner,pins = "PD6";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+		};
 };
 
 &usbphy {
 	usb3_vbus-supply = <&reg_usb3_vbus>;
 };
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
