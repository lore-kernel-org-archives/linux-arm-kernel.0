From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Oct 2014 11:05:49 +0800
Subject: [PATCH v2 4/6] ARM: dts: sun9i: Add GPIO LEDs for A80 Optimus board
In-Reply-To: <1414724751-25580-1-git-send-email-wens@csie.org>
References: <1414724751-25580-1-git-send-email-wens@csie.org>
Message-ID: <1414724751-25580-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 Optimus board has 3 usable LEDs that are controlled via GPIO.

This patch adds support for 2 of them which are driver by GPIOs in the
main pin controller. The remaining one uses GPIO from the R_PIO
controller, which we don't support yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 955436a..87b1355 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -64,6 +64,13 @@
 				/* Enable internal pull-up */
 				allwinner,pull = <1>;
 			};
+
+			led_pins_optimus: led-pins at 0 {
+				allwinner,pins = "PH0", "PH1";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 07000000 {
@@ -78,4 +85,24 @@
 			status = "okay";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_optimus>;
+
+		/* The LED names match those found on the board */
+
+		led2 {
+			label = "optimus:led2:usr";
+			gpios = <&pio 7 1 0>;
+		};
+
+		/* led3 is on PM15, in R_PIO */
+
+		led4 {
+			label = "optimus:led4:usr";
+			gpios = <&pio 7 0 0>;
+		};
+	};
 };
-- 
2.1.1
