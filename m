From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:55 +0200
Subject: [PATCH 18/21] arm: kirkwood: topkick: affect pinmux configs to the
 right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-19-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the pinmux mechanism was added in Kirkwood, the device driver
core was not yet providing the possibility of attaching pinmux
configurations to all devices, drivers had to do it explicitly, and
not all drivers were doing this.

Now that the driver core does that in a generic way, it makes sense to
attach the pinmux configuration to their corresponding devices.

This allows the pinctrl subsystem to show in debugfs to which device
is related which pins, for example:

pin 41 (PIN41): gpio-leds.1 mvebu-gpio:41 function gpio group mpp41
pin 42 (PIN42): gpio-leds.1 mvebu-gpio:42 function gpio group mpp42
pin 43 (PIN43): gpio-leds.1 mvebu-gpio:43 function gpio group mpp43

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-topkick.dts |   51 ++++++++++++++++----------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 66eb45b..940b54f 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -19,18 +19,6 @@
 	ocp at f1000000 {
 		pinctrl: pinctrl at 10000 {
 			/*
-			 * GPIO LED layout
-			 *
-			 *       /-SYS_LED(2)
-			 *       |
-			 *       |   /-DISK_LED
-			 *       |   |
-			 *       |   |   /-WLAN_LED(2)
-			 *       |   |   |
-			 * [SW] [*] [*] [*]
-			 */
-
-			/*
 			 * Switch positions
 			 *
 			 *     /-SW_LEFT(2)
@@ -41,19 +29,8 @@
 			 *     |   |   |
 			 * PS [L] [I] [R] LEDS
 			 */
-			pinctrl-0 = < &pmx_led_disk_yellow
-				      &pmx_sata0_pwr_enable
-				      &pmx_led_sys_red
-				      &pmx_led_sys_blue
-				      &pmx_led_wifi_green
-				      &pmx_sw_left
-				      &pmx_sw_right
-				      &pmx_sw_idle
-				      &pmx_sw_left2
-				      &pmx_led_wifi_yellow
-				      &pmx_uart0
-				      &pmx_nand
-				      &pmx_twsi0 >;
+			pinctrl-0 = <&pmx_sw_left &pmx_sw_right
+				     &pmx_sw_idle &pmx_sw_left2>;
 			pinctrl-names = "default";
 
 			pmx_led_disk_yellow: pmx-led-disk-yellow {
@@ -109,10 +86,14 @@
 
 		serial at 12000 {
 			status = "ok";
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 		};
 
 		nand at 3000000 {
 			status = "okay";
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 
 			partition at 0 {
 				label = "u-boot";
@@ -147,6 +128,8 @@
 
 		i2c at 11000 {
 			status = "ok";
+			pinctrl-0 = <&pmx_twsi0>;
+			pinctrl-names = "default";
 		};
 
 		mvsdio at 90000 {
@@ -158,7 +141,23 @@
 	};
 
 	gpio-leds {
+		/*
+		 * GPIO LED layout
+		 *
+		 *       /-SYS_LED(2)
+		 *       |
+		 *       |   /-DISK_LED
+		 *       |   |
+		 *       |   |   /-WLAN_LED(2)
+		 *       |   |   |
+		 * [SW] [*] [*] [*]
+		 */
+
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_disk_yellow &pmx_led_sys_red
+			     &pmx_led_sys_blue &pmx_led_wifi_green
+			     &pmx_led_wifi_yellow>;
+		pinctrl-names = "default";
 
 		disk {
 			label = "topkick:yellow:disk";
@@ -187,6 +186,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-0 = <&pmx_sata0_pwr_enable>;
+		pinctrl-names = "default";
 
 		sata0_power: regulator at 1 {
 			compatible = "regulator-fixed";
-- 
1.7.9.5
