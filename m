From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:20 +0100
Subject: [PATCH 04/10] ARM: ux500: move AB8500 audio interface 1 settings to DT
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the pin muxing and configuration for audio interface
one over to the device tree as a hog configuration.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 20 +++++++++++++++++++-
 arch/arm/mach-ux500/board-mop500-pins.c | 10 ----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index cdf2b3fd22dc..3aae4ec5bcc9 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -33,7 +33,8 @@
 						    <&gpio26_default_mode>,
 						    <&gpio35_default_mode>,
 						    <&ycbcr_default_mode>,
-						    <&pwm_default_mode>;
+						    <&pwm_default_mode>,
+						    <&adi1_default_mode>;
 
 					/*
 					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
@@ -283,6 +284,23 @@
 							};
 						};
 					};
+					/* This sets up audio interface 1 */
+					adi1 {
+						adi1_default_mode: adi1_default {
+							default_mux {
+								ste,function = "adi1";
+								ste,pins = "adi1_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO17_P5",
+									 "GPIO18_R5",
+									 "GPIO19_U5",
+									 "GPIO20_T5";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index b75089faf956..d0b262242ab7 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -57,16 +57,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
 
 	/*
-	 * pins 17,18,19 and 20 are muxed in AUDIO interface 1
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("adi1_d_1", "adi1"),
-	AB8500_PIN_HOG("GPIO17_P5", in_pd),
-	AB8500_PIN_HOG("GPIO18_R5", in_pd),
-	AB8500_PIN_HOG("GPIO19_U5", in_pd),
-	AB8500_PIN_HOG("GPIO20_T5", in_pd),
-
-	/*
 	 * pins 21,22 and 23 are muxed in USB UICC
 	 * configured in INPUT PULL DOWN
 	 */
-- 
1.8.5.3
