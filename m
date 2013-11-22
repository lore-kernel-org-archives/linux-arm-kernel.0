From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 22 Nov 2013 21:07:01 +0100
Subject: [PATCH 3/4] ARM: mvebu: NETGEAR ReadyNAS 104 .dts file cleanup
In-Reply-To: <cover.1385148929.git.arno@natisbad.org>
References: <cover.1385148929.git.arno@natisbad.org>
Message-ID: <bd899cfc2b0b3d22a7442d76b3901ca81ca86f11.1385148929.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The patch does some cleanup work on NETGEAR ReadyNAS 104 .dts
file. Changes are listed below:

 - Completed conversion from value to macros for GPIO voltage level
 - Converted all numeric input key values to macros
 - Fixed all node names and labels to use respectively '-' and '_'
 - Made button names more explicit
 - Changed order of included files from general to local
 - Removed useless clocks and gpio-keys properties
 - Added compatible string for PHY (marvell,mv88e1318s)
 - Made G762 clock node name unique by including g762 in it
 
Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn104.dts | 66 +++++++++++++-------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 50b5150..853ddf7 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -11,8 +11,9 @@
 
 /dts-v1/;
 
-#include "armada-370.dtsi"
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include "armada-370.dtsi"
 
 / {
 	model = "NETGEAR ReadyNAS 104";
@@ -59,12 +60,12 @@
 					marvell,function = "gpio";
 				};
 
-				backup_key_pin: backup-key-pin {
+				backup_button_pin: backup-button-pin {
 					marvell,pins = "mpp52";
 					marvell,function = "gpio";
 				};
 
-				power_key_pin: power-key-pin {
+				power_button_pin: power-button-pin {
 					marvell,pins = "mpp62";
 					marvell,function = "gpio";
 				};
@@ -79,7 +80,7 @@
 					marvell,function = "gpio";
 				};
 
-				reset_key_pin: reset-key-pin {
+				reset_button_pin: reset-button-pin {
 					marvell,pins = "mpp65";
 					marvell,function = "gpio";
 				};
@@ -87,10 +88,12 @@
 
 			mdio {
 				phy0: ethernet-phy at 0 {
+					compatible = "marvell,88e1318s";
 					reg = <0>;
 				};
 
 				phy1: ethernet-phy at 1 {
+					compatible = "marvell,88e1318s";
 					reg = <1>;
 				};
 			};
@@ -136,90 +139,85 @@
 	};
 
 	clocks {
-	       #address-cells = <1>;
-	       #size-cells = <0>;
-
-	       g762_clk: fixedclk {
+	       g762_clk: g762-oscillator {
 			 compatible = "fixed-clock";
 			 #clock-cells = <0>;
 			 clock-frequency = <8192>;
 	       };
 	};
 
-	gpio_leds {
+	gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-0 = <&backup_led_pin &power_led_pin>;
 		pinctrl-names = "default";
 
-		blue_backup_led {
+		blue-backup-led {
 			label = "rn104:blue:backup";
-			gpios = <&gpio1 31 0>;   /* GPIO 63 Active High */
+			gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		blue_power_led {
+		blue-power-led {
 			label = "rn104:blue:pwr";
-			gpios = <&gpio2 0 1>;    /* GPIO 64 Active Low */
+			gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "keep";
 		};
 
-		sata1_led {
+		blue-sata1-led {
 			label = "rn104:blue:sata1";
 			gpios = <&pca9554 0 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		sata2_led {
+		blue-sata2-led {
 			label = "rn104:blue:sata2";
 			gpios = <&pca9554 1 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		sata3_led {
+		blue-sata3-led {
 			label = "rn104:blue:sata3";
 			gpios = <&pca9554 2 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		sata4_led {
+		blue-sata4-led {
 			label = "rn104:blue:sata4";
 			gpios = <&pca9554 3 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-0 = <&backup_key_pin
-			     &power_key_pin
-			     &reset_key_pin>;
+		pinctrl-0 = <&backup_button_pin
+			     &power_button_pin
+			     &reset_button_pin>;
 		pinctrl-names = "default";
 
-		button at 1 {
+		backup-button {
 			label = "Backup Button";
-			linux,code = <133>;     /* KEY_COPY */
-			gpios = <&gpio1 20 1>;
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
 		};
 
-		button at 2 {
+		power-button {
 			label = "Power Button";
-			linux,code = <116>;     /* KEY_POWER */
-			gpios = <&gpio1 30 0>;
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
 		};
 
-		button at 3 {
+		reset-button {
 			label = "Reset Button";
-			linux,code = <0x198>;   /* KEY_RESTART */
-			gpios = <&gpio2 1 1>;
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-	gpio_poweroff {
+	gpio-poweroff {
 		compatible = "gpio-poweroff";
 		pinctrl-0 = <&poweroff>;
 		pinctrl-names = "default";
-		gpios = <&gpio1 28 1>;
+		gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
 	};
 };
-- 
1.8.4.4
