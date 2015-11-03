From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Nov 2015 15:27:02 +0100
Subject: [PATCH] ARM: ux500: push down Rohm TS to STUIB
Message-ID: <1446560822-19442-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Rohm touchscreen reset and IRQ lines were registered and
configured at the HREF board level of the design, but it is an
integral part of the UIB (User Interface Board). Fix this by
pushing down the pin control node to the u8500 UIB file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-stuib.dtsi  | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi | 18 ------------------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/ste-href-stuib.dtsi
index 78b75256c638..c3987ad06d79 100644
--- a/arch/arm/boot/dts/ste-href-stuib.dtsi
+++ b/arch/arm/boot/dts/ste-href-stuib.dtsi
@@ -114,6 +114,8 @@
 				rohm,touch-max-x = <384>;
 				rohm,touch-max-y = <704>;
 				rohm,flip-y;
+				pinctrl-names = "default";
+				pinctrl-0 = <&touch_rohm_mode>;
 			};
 
 			bu21013_tp at 5d {
@@ -124,6 +126,8 @@
 				rohm,touch-max-x = <384>;
 				rohm,touch-max-y = <704>;
 				rohm,flip-y;
+				pinctrl-names = "default";
+				pinctrl-0 = <&touch_rohm_mode>;
 			};
 		};
 
@@ -166,6 +170,25 @@
 					};
 				};
 			};
+			touch {
+				touch_rohm_mode: touch_rohm {
+					/*
+					 * ROHM touch screen uses GPIO 143 for
+					 * RST1, GPIO 146 for RST2 and
+					 * GPIO 67 for interrupts. Pull-up
+					 * the IRQ line and drive both
+					 * reset signals low.
+					 */
+					stuib_cfg1 {
+						pins = "GPIO143_D12", "GPIO146_D13";
+						ste,config = <&gpio_out_lo>;
+					};
+					stuib_cfg2 {
+						pins = "GPIO67_G2";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 810cda743b6d..3d1ea1ecbd15 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -43,7 +43,6 @@
 				  <&vaudio_hf_hrefv60_mode>,
 				  <&gbf_hrefv60_mode>,
 				  <&hdtv_hrefv60_mode>,
-				  <&touch_hrefv60_mode>,
 				  <&gpios_hrefv60_mode>;
 
 			sdi0 {
@@ -190,23 +189,6 @@
 					};
 				 };
 			};
-			touch {
-				touch_hrefv60_mode: touch_hrefv60 {
-					/*
-					 * Touch screen uses GPIO 143 for RST1, GPIO 146 for RST2 and
-					 * GPIO 67 for interrupts. Pull-up the IRQ line and drive both
-					 * reset signals low.
-					 */
-					hrefv60_cfg1 {
-						pins = "GPIO143_D12", "GPIO146_D13";
-						ste,config = <&gpio_out_lo>;
-					};
-					hrefv60_cfg2 {
-						pins = "GPIO67_G2";
-						ste,config = <&gpio_in_pu>;
-					};
-				};
-			};
 			mcde {
 				lcd_hrefv60_mode: lcd_hrefv60 {
 					/*
-- 
2.4.3
