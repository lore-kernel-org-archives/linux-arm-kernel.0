From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Oct 2014 17:50:41 +0800
Subject: [PATCH 4/6] ARM: dts: sun9i: Add GPIO LEDs for A80 Optimus board
In-Reply-To: <1414489843-2680-1-git-send-email-wens@csie.org>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
Message-ID: <1414489843-2680-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 Optimus board has 3 usable LEDs that are controlled via GPIO.

This patch adds support for 2 of them which are driver by GPIOs in the
main pin controller. The remaining one uses GPIO from the R_PIO
controller, which we don't support yet.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 25fe775..91eda76 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -64,6 +64,13 @@
 				/* Enable internal pull-up */
 				allwinner,pull = <1>;
 			};
+
+			led_pins_optimus: led_pins at 0 {
+				allwinner,pins = "PH0", "PH1";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 07000000 {
@@ -78,4 +85,22 @@
 			status = "okay";
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_optimus>;
+
+		led2 {
+			label = "a80_optimus:led2:usr";
+			gpios = <&pio 7 0 0>;
+		};
+
+		/* led3 is on PM15, in R_PIO */
+
+		led4 {
+			label = "a80_optimus:led4:usr";
+			gpios = <&pio 7 1 0>;
+		};
+	};
 };
-- 
2.1.1
