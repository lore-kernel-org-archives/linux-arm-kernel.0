From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 22 Nov 2013 16:27:09 +0100
Subject: [PATCH] ARM: kirkwood: ReadyNAS Duo v2 .dts cleanup
Message-ID: <87li0ge9te.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The patch does some cleanup work on NETGEAR ReadyNAS Duo v2 .dts
file. Changes are listed below:

 - Converted GPIO voltage level from value to macros
 - Converted all numeric input key values to macros
 - Fixed bad spacing
 - Added some space between some nodes to improve readability
 - Made button node names more explicit
 - Added compatible string for PHY (marvell,mv88e1318s)
 - Added header for the file to describe content and author
 - Made G762 clock node name unique by including g762 in it
 - Fixed all node names and labels to use respectively '-' and '_'
 - Removed useless clocks and gpio-keys properties

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
Hi Jason,

This patch applies above the one adding gpio-poweroff driver for the Duo
v2 I just sent a few minutes ago. Most of the changes it contains were
Suggested-By: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> ;-)
If you have additional ideas or see things that should be fixed, I am
interested. As soon as I get a final version of this one, I will push
the same kind of cleanup patches for the RN102 and RN014 boards.

 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 98 +++++++++++++---------
 1 file changed, 60 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 551bfed..0961e80 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -1,5 +1,17 @@
+/*
+ * Device Tree file for NETGEAR ReadyNAS Duo v2
+ *
+ * Copyright (C) 2013, Arnaud EBALARD <arno@natisbad.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "kirkwood.dtsi"
 #include "kirkwood-6282.dtsi"
@@ -33,34 +45,42 @@
 				marvell,pins = "mpp47";
 				marvell,function = "gpio";
 			};
+
 			pmx_button_backup: pmx-button-backup {
 				marvell,pins = "mpp45";
 				marvell,function = "gpio";
 			};
+
 			pmx_button_reset: pmx-button-reset {
 				marvell,pins = "mpp13";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_power: pmx-led-blue-power {
 				marvell,pins = "mpp31";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_activity: pmx-led-blue-activity {
 				marvell,pins = "mpp38";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_disk1: pmx-led-blue-disk1 {
 				marvell,pins = "mpp23";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_disk2: pmx-led-blue-disk2 {
 				marvell,pins = "mpp22";
 				marvell,function = "gpio";
 			};
+
 			pmx_led_blue_backup: pmx-led-blue-backup {
 				marvell,pins = "mpp29";
 				marvell,function = "gpio";
 			};
+
 			pmx_poweroff: pmx-poweroff {
 				marvell,pins = "mpp30";
 				marvell,function = "gpio";
@@ -68,10 +88,7 @@
 		};
 
 		clocks {
-		       #address-cells = <1>;
-		       #size-cells = <0>;
-
-		       g762_clk: fixedclk {
+		       g762_clk: g762-oscillator {
 				 compatible = "fixed-clock";
 				 #clock-cells = <0>;
 				 clock-frequency = <8192>;
@@ -117,49 +134,53 @@
 
 		power_led {
 			label = "status:blue:power_led";
-			gpios = <&gpio0 31 1>;   /* GPIO 31 Active Low */
+			gpios = <&gpio0 31 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
+
 		activity_led {
 			label = "status:blue:activity_led";
-			gpios = <&gpio1 6 1>;    /* GPIO 38 Active Low */
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
+
 		disk1_led {
 			label = "status:blue:disk1_led";
-			gpios = <&gpio0 23 1>;   /* GPIO 23 Active Low */
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 		};
+
 		disk2_led {
 			label = "status:blue:disk2_led";
-			gpios = <&gpio0 22 1>;   /* GPIO 22 Active Low */
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
 		};
+
 		backup_led {
 			label = "status:blue:backup_led";
-			gpios = <&gpio0 29 1>;   /* GPIO 29 Active Low*/
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-0 = <&pmx_button_power &pmx_button_backup
 			     &pmx_button_reset>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		power-button {
 			label = "Power Button";
-			linux,code = <116>;     /* KEY_POWER */
-			gpios = <&gpio1 15 1>;
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		button at 2 {
+
+		reset-button {
 			label = "Reset Button";
-			linux,code = <0x198>;   /* KEY_RESTART */
-			gpios = <&gpio0 13 1>;
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
 		};
-		button at 3 {
+
+		backup-button {
 			label = "Backup Button";
-			linux,code = <133>;     /* KEY_COPY */
-			gpios = <&gpio1 13 1>;
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -170,23 +191,23 @@
 		gpios = <&gpio0 30 GPIO_ACTIVE_LOW>;
 	};
 
-        regulators {
-                compatible = "simple-bus";
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                usb_power: regulator at 1 {
-                        compatible = "regulator-fixed";
-                        reg = <1>;
-                        regulator-name = "USB 3.0 Power";
-                        regulator-min-microvolt = <5000000>;
-                        regulator-max-microvolt = <5000000>;
-                        enable-active-high;
-                        regulator-always-on;
-                        regulator-boot-on;
-                        gpio = <&gpio1 14 0>;
-                };
-        };
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb3_regulator: usb3-regulator {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "USB 3.0 Power";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			enable-active-high;
+			regulator-always-on;
+			regulator-boot-on;
+			gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &nand {
@@ -224,6 +245,7 @@
 
 	ethphy0: ethernet-phy at 0 {
 		device_type = "ethernet-phy";
+		compatible = "marvell,88e1318s";
 		reg = <0>;
 	};
 };
-- 
1.8.4.4
