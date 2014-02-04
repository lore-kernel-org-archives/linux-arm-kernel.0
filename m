From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:23 +0100
Subject: [PATCH 07/10] ARM: ux500: move AB8500 EXTCPENA from board file to DT
In-Reply-To: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
References: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1391543546-11158-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the configuration of the AB8500 EXTCPENA pin
from the board file to the device tree.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 17 +++++++++++++++--
 arch/arm/mach-ux500/board-mop500-pins.c |  7 -------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
index 6222b8e951c2..beb59f99eff8 100644
--- a/arch/arm/boot/dts/ste-href-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -36,7 +36,8 @@
 						    <&pwm_default_mode>,
 						    <&adi1_default_mode>,
 						    <&usbuicc_default_mode>,
-						    <&dmic_default_mode>;
+						    <&dmic_default_mode>,
+						    <&extcpena_default_mode>;
 
 					/*
 					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
@@ -340,7 +341,19 @@
 							};
 						};
 					};
-
+					extcpena {
+						extcpena_default_mode: extcpena_default {
+							default_mux {
+								ste,function = "extcpena";
+								ste,pins = "extcpena_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO34_R17";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
 				};
 			};
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 851f530e6e16..bbd5bc56f7f0 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -57,13 +57,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
 
 	/*
-	 * pins 34 is muxed in EXTCPENA
-	 * configured INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("extcpena_d_1", "extcpena"),
-	AB8500_PIN_HOG("GPIO34_R17", in_pd),
-
-	/*
 	 * pins 40 and 41 are muxed in MODCSLSDA
 	 * configured INPUT PULL DOWN
 	 */
-- 
1.8.5.3
