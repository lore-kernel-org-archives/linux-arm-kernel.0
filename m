From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 27 Mar 2016 00:27:26 +0100
Subject: [PATCH] ARM: nomadik: add accelerometer IRQ and pin setting
Message-ID: <1459034846-29326-1-git-send-email-linus.walleij@linaro.org>
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
index 4a21c6492dbb..d35aa88791ad 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -57,8 +57,15 @@
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
@@ -86,6 +93,10 @@
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
