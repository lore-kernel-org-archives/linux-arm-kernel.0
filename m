From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 May 2013 11:44:54 +0200
Subject: [PATCH 17/21] arm: kirkwood: openblocks_a6: affect pinmux configs to
 the right devices
In-Reply-To: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369388699-25975-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369388699-25975-18-git-send-email-thomas.petazzoni@free-electrons.com>
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
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index d27f724..a05b382 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -19,15 +19,21 @@
 	ocp at f1000000 {
 		serial at 12000 {
 			status = "ok";
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 		};
 
 		serial at 12100 {
 			status = "ok";
+			pinctrl-0 = <&pmx_uart1>;
+			pinctrl-names = "default";
 		};
 
 		nand at 3000000 {
 			chip-delay = <25>;
 			status = "okay";
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 
 			partition at 0 {
 				label = "uboot";
@@ -67,6 +73,8 @@
 
 		i2c at 11100 {
 			status = "okay";
+			pinctrl-0 = <&pmx_twsi1>;
+			pinctrl-names = "default";
 
 			s35390a: s35390a at 30 {
 				compatible = "s35390a";
@@ -75,16 +83,12 @@
 		};
 
 		pinctrl: pinctrl at 10000 {
-			pinctrl-0 = < &pmx_nand &pmx_uart0
-				&pmx_uart1 &pmx_twsi1
-				&pmx_dip_sw0 &pmx_dip_sw1
-				&pmx_dip_sw2 &pmx_dip_sw3
-				&pmx_gpio_0 &pmx_gpio_1
-				&pmx_gpio_2 &pmx_gpio_3
-				&pmx_gpio_4 &pmx_gpio_5
-				&pmx_gpio_6 &pmx_gpio_7
-				&pmx_led_red &pmx_led_green
-				&pmx_led_yellow >;
+			pinctrl-0 = <&pmx_dip_sw0 &pmx_dip_sw1
+				     &pmx_dip_sw2 &pmx_dip_sw3
+				     &pmx_gpio_0 &pmx_gpio_1
+				     &pmx_gpio_2 &pmx_gpio_3
+				     &pmx_gpio_4 &pmx_gpio_5
+				     &pmx_gpio_6 &pmx_gpio_7>;
 			pinctrl-names = "default";
 
 			pmx_uart0: pmx-uart0 {
@@ -193,6 +197,8 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_red &pmx_led_green &pmx_led_yellow>;
+		pinctrl-names = "default";
 
 		led-red {
 			label = "obsa6:red:stat";
-- 
1.7.9.5
