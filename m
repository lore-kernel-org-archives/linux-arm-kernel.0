From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:18 +0100
Subject: [PATCH 02/10] ARM: ux500: move AB8500 YCBCR settings to device tree
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the pin control settings for the YCBCR connector
on the AB8500 over to the device tree as a hog.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 23 ++++++++++++++++++++++-
 arch/arm/mach-ux500/board-mop500-pins.c | 10 ----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 58b00d0f023e..2b548e90878e 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -31,7 +31,8 @@
 						    <&gpio39_default_mode>,
 						    <&gpio42_default_mode>,
 						    <&gpio26_default_mode>,
-						    <&gpio35_default_mode>;
+						    <&gpio35_default_mode>,
+						    <&ycbcr_default_mode>;
 
 					/*
 					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
@@ -246,6 +247,26 @@
 							};
 						};
 					};
+					/*
+					 * This sets up the YCBCR connector pins, i.e. analog video out.
+					 * Set as input with no bias.
+					 */
+					ycbcr {
+						ycbcr_default_mode: ycbcr_default {
+							default_mux {
+								ste,function = "ycbcr";
+								ste,pins = "ycbcr0123_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO6_Y18",
+									 "GPIO7_AA20",
+									 "GPIO8_W18",
+									 "GPIO9_AA19";
+								input-enable;
+								bias-disable;
+							};
+						};
+					};
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 139298043685..d58513b08a6d 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -57,16 +57,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
 
 	/*
-	 * pins 6,7,8 and 9 are muxed in YCBCR0123
-	 * configured in INPUT PULL UP
-	 */
-	AB8500_MUX_HOG("ycbcr0123_d_1", "ycbcr"),
-	AB8500_PIN_HOG("GPIO6_Y18", in_nopull),
-	AB8500_PIN_HOG("GPIO7_AA20", in_nopull),
-	AB8500_PIN_HOG("GPIO8_W18", in_nopull),
-	AB8500_PIN_HOG("GPIO9_AA19", in_nopull),
-
-	/*
 	 * pins 14,15 are muxed in PWM1 and PWM2
 	 * configured in INPUT PULL DOWN
 	 */
-- 
1.8.5.3
