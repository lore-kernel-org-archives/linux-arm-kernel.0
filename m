From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:19 +0100
Subject: [PATCH v2 05/18] arm64: dts: allwinner: a64: Orange Pi Win: Add
 Ethernet node
In-Reply-To: <20180726003532.18751-1-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
Message-ID: <20180726003532.18751-6-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win has the usual Gigabit PHY connected to the EMAC.
Its power is controlled by GPIO PD14.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index c9cabe987c19..0cadcd59edd9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
+ * Copyright (C) 2017-2018 Samuel Holland <samuel@sholland.org>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
@@ -51,6 +52,7 @@
 	compatible = "xunlong,orangepi-win", "allwinner,sun50i-a64";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -58,6 +60,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
+		status = "okay";
+	};
+
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
@@ -74,6 +87,22 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_3v3>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.14.4
