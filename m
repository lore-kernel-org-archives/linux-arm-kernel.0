From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 28 Jan 2013 08:27:44 -0300
Subject: [PATCH] sunxi: a10-cubieboard: Add user LEDs to the device tree
Message-ID: <1359372464-5811-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cubieboard has two LEDs available for use, a blue one (labeled LED1)
and a green one (labeled LED2).

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
This patch requires all of the sunxi pinctrl/gpio/led patches by
Maxime Ripard to function.

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 5cab825..88e2dc1 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -27,6 +27,15 @@
 	};
 
 	soc {
+		pinctrl at 01c20800 {
+			led_pins_cubieboard: led_pins at 0 {
+				allwinner,pins = "PH20", "PH21";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <1>;
+				allwinner,pull = <0>;
+			};
+		};
+
 		uart0: uart at 01c28000 {
 			status = "okay";
 		};
@@ -35,4 +44,21 @@
 			status = "okay";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_cubieboard>;
+
+		blue {
+			label = "cubieboard::blue";
+			gpios = <&pio 7 21 0>; /* LED1 */
+		};
+
+		green {
+			label = "cubieboard::green";
+			gpios = <&pio 7 20 0>; /* LED2 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
-- 
1.8.1.1
