From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:24 +0100
Subject: [PATCH 08/10] ARM: ux500: move AB8500 modem I2C settings to DT
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the pin setup of the AB8500 modem I2C pins
(SCL/SDA) from the board file to the device tree.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 18 +++++++++++++++++-
 arch/arm/mach-ux500/board-mop500-pins.c |  8 --------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index beb59f99eff8..333b554c0bf7 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -37,7 +37,8 @@
 						    <&adi1_default_mode>,
 						    <&usbuicc_default_mode>,
 						    <&dmic_default_mode>,
-						    <&extcpena_default_mode>;
+						    <&extcpena_default_mode>,
+						    <&modsclsda_default_mode>;
 
 					/*
 					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
@@ -354,6 +355,21 @@
 							};
 						};
 					};
+					/* Modem I2C setup (SCL and SDA pins) */
+					modsclsda {
+						modsclsda_default_mode: modsclsda_default {
+							default_mux {
+								ste,function = "modsclsda";
+								ste,pins = "modsclsda_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO40_T19",
+									"GPIO41_U19";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index bbd5bc56f7f0..cbe91714f57f 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -55,14 +55,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	/* sysclkreq4 disable, mux in gpio configured in input pulldown */
 	AB8500_MUX_STATE("gpio3_a_1", "gpio", "regulator.36", PINCTRL_STATE_SLEEP),
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
-
-	/*
-	 * pins 40 and 41 are muxed in MODCSLSDA
-	 * configured INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("modsclsda_d_1", "modsclsda"),
-	AB8500_PIN_HOG("GPIO40_T19", in_pd),
-	AB8500_PIN_HOG("GPIO41_U19", in_pd),
 };
 
 static struct pinctrl_map __initdata ab8505_pinmap[] = {
-- 
1.8.5.3
