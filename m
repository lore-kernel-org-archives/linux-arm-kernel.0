From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:22 +0100
Subject: [PATCH 06/10] ARM: ux500: move AB8500 DMIC settings to DT
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-6-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This move the AB8500 DMIC (microphone) pin setup from the board
file to the device tree.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 25 ++++++++++++++++++++++++-
 arch/arm/mach-ux500/board-mop500-pins.c | 24 ------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 9cf12d5d0923..6222b8e951c2 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -35,7 +35,8 @@
 						    <&ycbcr_default_mode>,
 						    <&pwm_default_mode>,
 						    <&adi1_default_mode>,
-						    <&usbuicc_default_mode>;
+						    <&usbuicc_default_mode>,
+						    <&dmic_default_mode>;
 
 					/*
 					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
@@ -318,6 +319,28 @@
 							};
 						};
 					};
+					/* This sets up the microphone pins */
+					dmic {
+						dmic_default_mode: dmic_default {
+							default_mux {
+								ste,function = "dmic";
+								ste,pins = "dmic12_d_1",
+									 "dmic34_d_1",
+									 "dmic56_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO27_J6",
+									 "GPIO28_K6",
+									 "GPIO29_G6",
+									 "GPIO30_H6",
+									 "GPIO31_F5",
+									 "GPIO32_G5";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 443b1f4b828a..851f530e6e16 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -57,30 +57,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
 
 	/*
-	 * pins 27,28 are muxed in DMIC12
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("dmic12_d_1", "dmic"),
-	AB8500_PIN_HOG("GPIO27_J6", in_pd),
-	AB8500_PIN_HOG("GPIO28_K6", in_pd),
-
-	/*
-	 * pins 29,30 are muxed in DMIC34
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("dmic34_d_1", "dmic"),
-	AB8500_PIN_HOG("GPIO29_G6", in_pd),
-	AB8500_PIN_HOG("GPIO30_H6", in_pd),
-
-	/*
-	 * pins 31,32 are muxed in DMIC56
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("dmic56_d_1", "dmic"),
-	AB8500_PIN_HOG("GPIO31_F5", in_pd),
-	AB8500_PIN_HOG("GPIO32_G5", in_pd),
-
-	/*
 	 * pins 34 is muxed in EXTCPENA
 	 * configured INPUT PULL DOWN
 	 */
-- 
1.8.5.3
