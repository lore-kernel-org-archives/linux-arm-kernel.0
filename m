From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  8 May 2017 10:59:25 +0200
Subject: [PATCH] ARM: dts: imx28: add gpio-ranges for internal gpio controller
Message-ID: <20170508085925.18342-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

with this patch applied I get the following lines in dmesg which looks
fine:

	[    0.227913] gpio gpiochip0: (80018000.pinctrl:gpio at 0): created GPIO range 0->31 ==> 80018000.pinctrl PIN 0->31
	[    0.236100] gpio gpiochip1: (80018000.pinctrl:gpio at 1): created GPIO range 0->31 ==> 80018000.pinctrl PIN 32->63
	[    0.244463] gpio gpiochip2: (80018000.pinctrl:gpio at 2): created GPIO range 0->31 ==> 80018000.pinctrl PIN 64->95
	[    0.253020] gpio gpiochip3: (80018000.pinctrl:gpio at 3): created GPIO range 0->31 ==> 80018000.pinctrl PIN 96->127
	[    0.261639] gpio gpiochip4: (80018000.pinctrl:gpio at 4): created GPIO range 0->31 ==> 80018000.pinctrl PIN 128->159

But when looking at a used gpio

	# cat /sys/kernel/debug/gpio
	gpiochip0: GPIOs 0-31, parent: platform/80018000.pinctrl:gpio at 0, 80018000.pinctrl:gpio at 0:
	...
	 gpio-20  (LED4                |?                   ) out hi
	...

	# grep "pin 20 " /sys/kernel/debug/pinctrl/80018000.pinctrl/pinmux-pins
	pin 20 (GPMI_RDY0): leds (GPIO UNCLAIMED) function leds group leds.0

I wonder why there is still "GPIO UNCLAIMED". I would have expected that
this disappears and somehow references the gpio_request issued by the
led-gpio driver after my patch.

What am I missing?

Best regards
Uwe

 arch/arm/boot/dts/imx28.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 148fcf4d3b98..cfad2295cc46 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -182,6 +182,7 @@
 					#gpio-cells = <2>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					gpio-ranges = <&pinctrl 0 0 32>;
 				};
 
 				gpio1: gpio at 1 {
@@ -192,6 +193,7 @@
 					#gpio-cells = <2>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					gpio-ranges = <&pinctrl 0 32 32>;
 				};
 
 				gpio2: gpio at 2 {
@@ -202,6 +204,7 @@
 					#gpio-cells = <2>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					gpio-ranges = <&pinctrl 0 64 32>;
 				};
 
 				gpio3: gpio at 3 {
@@ -212,6 +215,7 @@
 					#gpio-cells = <2>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					gpio-ranges = <&pinctrl 0 96 32>;
 				};
 
 				gpio4: gpio at 4 {
@@ -222,6 +226,7 @@
 					#gpio-cells = <2>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
+					gpio-ranges = <&pinctrl 0 128 32>;
 				};
 
 				duart_pins_a: duart at 0 {
-- 
2.11.0
