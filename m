From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  5 Jun 2017 21:21:28 +0200
Subject: [PATCH 3/5] ARM: sun50i: orangepi-pc2: Enable dwmac-sun8i
In-Reply-To: <20170605192130.25320-1-clabbe.montjoie@gmail.com>
References: <20170605192130.25320-1-clabbe.montjoie@gmail.com>
Message-ID: <20170605192130.25320-4-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the Orange PI PC2.
It uses an external PHY rtl8211e via RGMII.

This patch create the needed regulator, emac and phy nodes.
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
index dfecc17dcc92..a8296feee884 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
@@ -59,6 +59,7 @@
 	};
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -91,6 +92,16 @@
 		};
 	};
 
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_usb0_vbus: usb0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb0-vbus";
@@ -126,12 +137,28 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
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
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.13.0
