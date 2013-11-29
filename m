From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 29 Nov 2013 21:27:38 +0100
Subject: [PATCHv2 2/4] ARM: mvebu: NETGEAR ReadyNAS 102 .dts cleanup
In-Reply-To: <cover.1385756371.git.arno@natisbad.org>
References: <cover.1385756371.git.arno@natisbad.org>
Message-ID: <10b7a81f838d2bc554cb55c329532e0cadc73619.1385756371.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The patch does some cleanup work on NETGEAR ReadyNAS 102 .dts
file. Changes are listed below

 - Added missing button mpp in pinctrl
 - Converted from value to macros for GPIO voltage level
 - Converted all numeric input key values to macros
 - Added GPIO keys pins to pinctrl
 - Made button names more explicit
 - Document ethernet PHY (Marvell 88E1318) via a comment
 - Made G762 clock node name unique by including g762 in it
 - Fixed all node names and labels to use respectively '-' and '_'
 - Changed order of included files from general to local
 - Removed useless clocks and gpio-keys properties

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 81 +++++++++++++++-----------
 1 file changed, 48 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 8ac2ac1..6411105 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -11,6 +11,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 #include "armada-370.dtsi"
 
 / {
@@ -77,6 +79,21 @@
 					marvell,function = "gpio";
 				};
 
+				backup_button_pin: backup-button-pin {
+					marvell,pins = "mpp58";
+					marvell,function = "gpio";
+				};
+
+				power_button_pin: power-button-pin {
+					marvell,pins = "mpp62";
+					marvell,function = "gpio";
+				};
+
+				reset_button_pin: reset-button-pin {
+					marvell,pins = "mpp6";
+					marvell,function = "gpio";
+				};
+
 				poweroff: poweroff {
 					marvell,pins = "mpp8";
 					marvell,function = "gpio";
@@ -84,7 +101,7 @@
 			};
 
 			mdio {
-				phy0: ethernet-phy at 0 {
+				phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
 					reg = <0>;
 				};
 			};
@@ -117,78 +134,76 @@
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
-		pinctrl-0 = < &power_led_pin
-			      &sata1_led_pin
-			      &sata2_led_pin
-			      &backup_led_pin >;
+		pinctrl-0 = <&power_led_pin
+			     &sata1_led_pin
+			     &sata2_led_pin
+			     &backup_led_pin>;
 		pinctrl-names = "default";
 
-		blue_power_led {
+		blue-power-led {
 			label = "rn102:blue:pwr";
-			gpios = <&gpio1 25 1>;  /* GPIO 57 Active Low */
+			gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		green_sata1_led {
+		green-sata1-led {
 			label = "rn102:green:sata1";
-			gpios = <&gpio0 15 1>;  /* GPIO 15 Active Low */
+			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		green_sata2_led {
+		green-sata2-led {
 			label = "rn102:green:sata2";
-			gpios = <&gpio0 14 1>;   /* GPIO 14 Active Low */
+			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		green_backup_led {
+		green-backup-led {
 			label = "rn102:green:backup";
-			gpios = <&gpio1 24 1>;   /* GPIO 56 Active Low */
+			gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 	};
 
-	gpio_keys {
+	gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
+		pinctrl-0 = <&power_button_pin
+			     &reset_button_pin
+			     &backup_button_pin>;
+		pinctrl-names = "default";
 
-		button at 1 {
+		power-button {
 			label = "Power Button";
-			linux,code = <116>;     /* KEY_POWER */
-			gpios = <&gpio1 30 0>;
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 30 GPIO_ACTIVE_HIGH>;
 		};
 
-		button at 2 {
+		reset-button {
 			label = "Reset Button";
-			linux,code = <0x198>;   /* KEY_RESTART */
-			gpios = <&gpio0 6 1>;
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 		};
 
-		button at 3 {
+		backup-button {
 			label = "Backup Button";
-			linux,code = <133>;     /* KEY_COPY */
-			gpios = <&gpio1 26 1>;
+			linux,code = <KEY_COPY>;
+			gpios = <&gpio1 26 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-	gpio_poweroff {
+	gpio-poweroff {
 		compatible = "gpio-poweroff";
 		pinctrl-0 = <&poweroff>;
 		pinctrl-names = "default";
-		gpios = <&gpio0 8 1>;
+		gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
 	};
-
 };
-- 
1.8.4.4
