From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 17:23:39 +0100
Subject: [PATCH 1/3] arm: kirkwood: affect pins to their devices on OpenBlocks
 A6
In-Reply-To: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362587021-32762-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl configuration done for the Kirkwood-based OpenBlocks A6
board was somewhat strange: all pins for all devices were selected
through "hogs", i.e as pins of the pinctrl device. Even though it
works, it isn't the proper way of doing things: pins should preferably
be associated to whatever device they belong to.

Therefore, this patch moves the selection of pin muxing of the
relevant pins to the UART nodes, the I2C node, the NAND node and the
gpio-leds node.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index ede7fe0d..087681d 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -19,17 +19,23 @@
 	ocp at f1000000 {
 		serial at 12000 {
 			clock-frequency = <200000000>;
+			pinctrl-0 = <&pmx_uart0>;
+			pinctrl-names = "default";
 			status = "ok";
 		};
 
 		serial at 12100 {
 			clock-frequency = <200000000>;
+			pinctrl-0 = <&pmx_uart1>;
+			pinctrl-names = "default";
 			status = "ok";
 		};
 
 		nand at 3000000 {
 			chip-delay = <25>;
 			status = "okay";
+			pinctrl-0 = <&pmx_nand>;
+			pinctrl-names = "default";
 
 			partition at 0 {
 				label = "uboot";
@@ -69,6 +75,8 @@
 
 		i2c at 11100 {
 			status = "okay";
+			pinctrl-0 = <&pmx_twsi1>;
+			pinctrl-names = "default";
 
 			s35390a: s35390a at 30 {
 				compatible = "s35390a";
@@ -77,16 +85,12 @@
 		};
 
 		pinctrl: pinctrl at 10000 {
-			pinctrl-0 = < &pmx_nand &pmx_uart0
-				&pmx_uart1 &pmx_twsi1
-				&pmx_dip_sw0 &pmx_dip_sw1
+			pinctrl-0 = <&pmx_dip_sw0 &pmx_dip_sw1
 				&pmx_dip_sw2 &pmx_dip_sw3
 				&pmx_gpio_0 &pmx_gpio_1
 				&pmx_gpio_2 &pmx_gpio_3
 				&pmx_gpio_4 &pmx_gpio_5
-				&pmx_gpio_6 &pmx_gpio_7
-				&pmx_led_red &pmx_led_green
-				&pmx_led_yellow >;
+				&pmx_gpio_6 &pmx_gpio_7>;
 			pinctrl-names = "default";
 
 			pmx_uart0: pmx-uart0 {
@@ -195,6 +199,9 @@
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_led_red &pmx_led_green
+				&pmx_led_yellow>;
+		pinctrl-names = "default";
 
 		led-red {
 			label = "obsa6:red:stat";
-- 
1.7.9.5
