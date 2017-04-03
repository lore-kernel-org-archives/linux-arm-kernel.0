From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Apr 2017 11:14:36 +0200
Subject: [PATCH v3 12/20] ARM: dts: sun8i: Enable dwmac-sun8i on the Orange Pi
 plus
In-Reply-To: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
Message-ID: <20170403091444.29876-13-clabbe.montjoie@gmail.com>
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
index 8c40ab7..6852006 100644
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
+		pins = "PD6";
+		function = "gpio_out";
+		drive-strength = <10>;
+	};
 };
 
 &usbphy {
 	usb3_vbus-supply = <&reg_usb3_vbus>;
 };
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
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
