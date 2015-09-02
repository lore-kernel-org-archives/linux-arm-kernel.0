From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  2 Sep 2015 22:32:54 +0200
Subject: [PATCH] ARM: nomadik: add accelerometer IRQ and pin setting
Message-ID: <1441225974-27134-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LIS3LV02DL accelerometer on the Nomadik NHK15 can generate
IRQs by the DRDY line. Map this in the DTS file and set up the
pin as input to the SoC.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index b2bde1296623..bae977b859f2 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -46,8 +46,15 @@
 				};
 			};
 		};
+		lis3lv02dl {
+			lis3lv02dl_nhk_mode: lis3lv02dl_nhk {
+				nhk_cfg1 {
+					pins = "GPIO82_C10"; // IRQ line
+					ste,input = <0>;
+				};
+			};
+		};
 	};
-
 	src at 101e0000 {
 		/* These chrystal outputs are not used on this board */
 		disable-sxtalo;
@@ -75,6 +82,10 @@
 		lis3lv02dl at 1d {
 			/* Accelerometer */
 			compatible = "st,lis3lv02dl-accel";
+			interrupt-parent = <&gpio2>;
+			interrupts = <18 IRQ_TYPE_EDGE_RISING>; // GPIO 82
+			pinctrl-0 = <&lis3lv02dl_nhk_mode>;
+			pinctrl-names = "default";
 			reg = <0x1d>;
 		};
 		stmpe0: stmpe2401 at 43 {
-- 
2.4.3
