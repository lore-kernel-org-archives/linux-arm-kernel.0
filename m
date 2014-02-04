From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:19 +0100
Subject: [PATCH 03/10] ARM: ux500: move AB8500 PWM out settings to device tree
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the muxing and biasing of the AB8500 PWM output pins
over to the device tree for affected platforms.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 18 +++++++++++++++++-
 arch/arm/mach-ux500/board-mop500-pins.c | 10 ----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 2b548e90878e..cdf2b3fd22dc 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -32,7 +32,8 @@
 						    <&gpio42_default_mode>,
 						    <&gpio26_default_mode>,
 						    <&gpio35_default_mode>,
-						    <&ycbcr_default_mode>;
+						    <&ycbcr_default_mode>,
+						    <&pwm_default_mode>;
 
 					/*
 					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
@@ -267,6 +268,21 @@
 							};
 						};
 					};
+					/* This sets up the PWM pins 14 and 15 */
+					pwm {
+						pwm_default_mode: pwm_default {
+							default_mux {
+								ste,function = "pwmout";
+								ste,pins = "pwmout1_d_1", "pwmout2_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO14_F14",
+									 "GPIO15_B17";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index d58513b08a6d..b75089faf956 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -57,16 +57,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
 
 	/*
-	 * pins 14,15 are muxed in PWM1 and PWM2
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("pwmout1_d_1", "pwmout"),
-	AB8500_PIN_HOG("GPIO14_F14", in_pd),
-
-	AB8500_MUX_HOG("pwmout2_d_1", "pwmout"),
-	AB8500_PIN_HOG("GPIO15_B17", in_pd),
-
-	/*
 	 * pins 17,18,19 and 20 are muxed in AUDIO interface 1
 	 * configured in INPUT PULL DOWN
 	 */
-- 
1.8.5.3
