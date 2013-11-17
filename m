From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:59 +0100
Subject: [PATCH 10/21] ARM: ux500: move SKE pin config to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-11-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the SKE keypad pin control table out of the board
file and into the device tree. This was previously set to be
active on all MOP500 and HREF boards but after reading the
schematic this seems incorrect: the HREFv60 and later uses
one of these for MC5 and no reference designs have the SKE
connected to any hardware so just leave the pins alone
in the power-on state.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 90 ++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi     |  7 ++
 arch/arm/mach-ux500/board-mop500-pins.c        | 87 -------------------------
 3 files changed, 97 insertions(+), 87 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index 779829a1e143..854a4a6e521e 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -631,6 +631,96 @@
 					};
 				};
 			};
+
+			ske {
+				/* SKE keys on position 2 in an 8x8 matrix */
+				ske_kpa2_default_mode: ske_kpa2_default {
+					default_mux {
+						ste,function = "kp";
+						ste,pins = "kp_a_2";
+					};
+					default_cfg1 {
+						ste,pins =
+						"GPIO153_B17", /* I7 */
+						"GPIO154_C16", /* I6 */
+						"GPIO155_C19", /* I5 */
+						"GPIO156_C17", /* I4 */
+						"GPIO161_D21", /* I3 */
+						"GPIO162_D20", /* I2 */
+						"GPIO163_C20", /* I1 */
+						"GPIO164_B21"; /* I0 */
+						ste,config = <&in_pd>;
+					};
+					default_cfg2 {
+						ste,pins =
+						"GPIO157_A18", /* O7 */
+						"GPIO158_C18", /* O6 */
+						"GPIO159_B19", /* O5 */
+						"GPIO160_B20", /* O4 */
+						"GPIO165_C21", /* O3 */
+						"GPIO166_A22", /* O2 */
+						"GPIO167_B24", /* O1 */
+						"GPIO168_C22"; /* O0 */
+						ste,config = <&out_lo>;
+					};
+				};
+				ske_kpa2_sleep_mode: ske_kpa2_sleep {
+					sleep_cfg1 {
+						ste,pins =
+						"GPIO153_B17", /* I7 */
+						"GPIO154_C16", /* I6 */
+						"GPIO155_C19", /* I5 */
+						"GPIO156_C17", /* I4 */
+						"GPIO161_D21", /* I3 */
+						"GPIO162_D20", /* I2 */
+						"GPIO163_C20", /* I1 */
+						"GPIO164_B21"; /* I0 */
+						ste,config = <&slpm_in_pu_wkup_pdis_en>;
+					};
+					sleep_cfg2 {
+						ste,pins =
+						"GPIO157_A18", /* O7 */
+						"GPIO158_C18", /* O6 */
+						"GPIO159_B19", /* O5 */
+						"GPIO160_B20", /* O4 */
+						"GPIO165_C21", /* O3 */
+						"GPIO166_A22", /* O2 */
+						"GPIO167_B24", /* O1 */
+						"GPIO168_C22"; /* O0 */
+						ste,config = <&slpm_out_lo_pdis>;
+					};
+				};
+				/*
+				 * SKE keys on position 1 and "other C1" combi giving
+				 * six rows of six keys.
+				 */
+				ske_kpaoc1_default_mode: ske_kpaoc1_default {
+					default_mux {
+						ste,function = "kp";
+						ste,pins = "kp_a_1", "kp_oc1_1";
+					};
+					default_cfg1 {
+						ste,pins =
+						"GPIO91_B6", /* KP_O0 */
+						"GPIO90_A3", /* KP_O1 */
+						"GPIO87_B3", /* KP_O2 */
+						"GPIO86_C6", /* KP_O3 */
+						"GPIO96_D8", /* KP_O6 */
+						"GPIO94_D7"; /* KP_O7 */
+						ste,config = <&out_lo>;
+					};
+					default_cfg2 {
+						ste,pins =
+						"GPIO93_B7", /* KP_I0 */
+						"GPIO92_D6", /* KP_I1 */
+						"GPIO89_E6", /* KP_I2 */
+						"GPIO88_C4", /* KP_I3 */
+						"GPIO97_D9", /* KP_I6 */
+						"GPIO95_E8"; /* KP_I7 */
+						ste,config = <&in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
index 456a25fbfaee..ee143b0a5baa 100644
--- a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
@@ -91,6 +91,13 @@
 		ste,sleep-pull-disable = <SLPM_PDIS_ENABLED>;
 	};
 
+	slpm_in_pu_wkup_pdis_en: slpm_in_wkup_pdis_en {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-input = <SLPM_INPUT_PULLUP>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_ENABLED>;
+	};
+
 	slpm_out_lo: slpm_out_lo {
 		ste,sleep = <SLPM_ENABLED>;
 		ste,sleep-output = <SLPM_OUTPUT_LOW>;
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 4cc4cb151474..07ddb89a6dbe 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -323,42 +323,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 
 /* Pin control settings */
 static struct pinctrl_map __initdata mop500_family_pinmap[] = {
-	/* ske default state */
-	DB8500_MUX("kp_a_2", "kp", "nmk-ske-keypad"),
-	DB8500_PIN("GPIO153_B17", in_pd, "nmk-ske-keypad"), /* I7 */
-	DB8500_PIN("GPIO154_C16", in_pd, "nmk-ske-keypad"), /* I6 */
-	DB8500_PIN("GPIO155_C19", in_pd, "nmk-ske-keypad"), /* I5 */
-	DB8500_PIN("GPIO156_C17", in_pd, "nmk-ske-keypad"), /* I4 */
-	DB8500_PIN("GPIO161_D21", in_pd, "nmk-ske-keypad"), /* I3 */
-	DB8500_PIN("GPIO162_D20", in_pd, "nmk-ske-keypad"), /* I2 */
-	DB8500_PIN("GPIO163_C20", in_pd, "nmk-ske-keypad"), /* I1 */
-	DB8500_PIN("GPIO164_B21", in_pd, "nmk-ske-keypad"), /* I0 */
-	DB8500_PIN("GPIO157_A18", out_lo, "nmk-ske-keypad"), /* O7 */
-	DB8500_PIN("GPIO158_C18", out_lo, "nmk-ske-keypad"), /* O6 */
-	DB8500_PIN("GPIO159_B19", out_lo, "nmk-ske-keypad"), /* O5 */
-	DB8500_PIN("GPIO160_B20", out_lo, "nmk-ske-keypad"), /* O4 */
-	DB8500_PIN("GPIO165_C21", out_lo, "nmk-ske-keypad"), /* O3 */
-	DB8500_PIN("GPIO166_A22", out_lo, "nmk-ske-keypad"), /* O2 */
-	DB8500_PIN("GPIO167_B24", out_lo, "nmk-ske-keypad"), /* O1 */
-	DB8500_PIN("GPIO168_C22", out_lo, "nmk-ske-keypad"), /* O0 */
-	/* ske sleep state */
-	DB8500_PIN_SLEEP("GPIO153_B17", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I7 */
-	DB8500_PIN_SLEEP("GPIO154_C16", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I6 */
-	DB8500_PIN_SLEEP("GPIO155_C19", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I5 */
-	DB8500_PIN_SLEEP("GPIO156_C17", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I4 */
-	DB8500_PIN_SLEEP("GPIO161_D21", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I3 */
-	DB8500_PIN_SLEEP("GPIO162_D20", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I2 */
-	DB8500_PIN_SLEEP("GPIO163_C20", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I1 */
-	DB8500_PIN_SLEEP("GPIO164_B21", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I0 */
-	DB8500_PIN_SLEEP("GPIO157_A18", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O7 */
-	DB8500_PIN_SLEEP("GPIO158_C18", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O6 */
-	DB8500_PIN_SLEEP("GPIO159_B19", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O5 */
-	DB8500_PIN_SLEEP("GPIO160_B20", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O4 */
-	DB8500_PIN_SLEEP("GPIO165_C21", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O3 */
-	DB8500_PIN_SLEEP("GPIO166_A22", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O2 */
-	DB8500_PIN_SLEEP("GPIO167_B24", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O1 */
-	DB8500_PIN_SLEEP("GPIO168_C22", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O0 */
-
 	/* STM APE pins states */
 	DB8500_MUX_STATE("stmape_c_1", "stmape",
 		"stm", "ape_mipi34"),
@@ -561,41 +525,6 @@ static struct pinctrl_map __initdata mop500_pinmap[] = {
 	 * Runtime stuff: make it possible to mux in the SKE keypad
 	 * and bias the pins
 	 */
-	/* ske default state */
-	DB8500_MUX("kp_a_2", "kp", "nmk-ske-keypad"),
-	DB8500_PIN("GPIO153_B17", in_pu, "nmk-ske-keypad"), /* I7 */
-	DB8500_PIN("GPIO154_C16", in_pu, "nmk-ske-keypad"), /* I6 */
-	DB8500_PIN("GPIO155_C19", in_pu, "nmk-ske-keypad"), /* I5 */
-	DB8500_PIN("GPIO156_C17", in_pu, "nmk-ske-keypad"), /* I4 */
-	DB8500_PIN("GPIO161_D21", in_pu, "nmk-ske-keypad"), /* I3 */
-	DB8500_PIN("GPIO162_D20", in_pu, "nmk-ske-keypad"), /* I2 */
-	DB8500_PIN("GPIO163_C20", in_pu, "nmk-ske-keypad"), /* I1 */
-	DB8500_PIN("GPIO164_B21", in_pu, "nmk-ske-keypad"), /* I0 */
-	DB8500_PIN("GPIO157_A18", out_lo, "nmk-ske-keypad"), /* O7 */
-	DB8500_PIN("GPIO158_C18", out_lo, "nmk-ske-keypad"), /* O6 */
-	DB8500_PIN("GPIO159_B19", out_lo, "nmk-ske-keypad"), /* O5 */
-	DB8500_PIN("GPIO160_B20", out_lo, "nmk-ske-keypad"), /* O4 */
-	DB8500_PIN("GPIO165_C21", out_lo, "nmk-ske-keypad"), /* O3 */
-	DB8500_PIN("GPIO166_A22", out_lo, "nmk-ske-keypad"), /* O2 */
-	DB8500_PIN("GPIO167_B24", out_lo, "nmk-ske-keypad"), /* O1 */
-	DB8500_PIN("GPIO168_C22", out_lo, "nmk-ske-keypad"), /* O0 */
-	/* ske sleep state */
-	DB8500_PIN_SLEEP("GPIO153_B17", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I7 */
-	DB8500_PIN_SLEEP("GPIO154_C16", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I6 */
-	DB8500_PIN_SLEEP("GPIO155_C19", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I5 */
-	DB8500_PIN_SLEEP("GPIO156_C17", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I4 */
-	DB8500_PIN_SLEEP("GPIO161_D21", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I3 */
-	DB8500_PIN_SLEEP("GPIO162_D20", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I2 */
-	DB8500_PIN_SLEEP("GPIO163_C20", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I1 */
-	DB8500_PIN_SLEEP("GPIO164_B21", slpm_in_pu_wkup_pdis_en, "nmk-ske-keypad"), /* I0 */
-	DB8500_PIN_SLEEP("GPIO157_A18", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O7 */
-	DB8500_PIN_SLEEP("GPIO158_C18", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O6 */
-	DB8500_PIN_SLEEP("GPIO159_B19", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O5 */
-	DB8500_PIN_SLEEP("GPIO160_B20", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O4 */
-	DB8500_PIN_SLEEP("GPIO165_C21", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O3 */
-	DB8500_PIN_SLEEP("GPIO166_A22", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O2 */
-	DB8500_PIN_SLEEP("GPIO167_B24", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O1 */
-	DB8500_PIN_SLEEP("GPIO168_C22", slpm_out_lo_pdis, "nmk-ske-keypad"), /* O0 */
 };
 
 /*
@@ -655,22 +584,6 @@ static struct pinctrl_map __initdata hrefv60_pinmap[] = {
 	DB8500_PIN_HOG("GPIO77_H1", gpio_out_lo), /* NFC_ENA */
 	DB8500_PIN_HOG("GPIO144_B13", gpio_in_pd), /* NFC_IRQ */
 	DB8500_PIN_HOG("GPIO142_C11", gpio_out_lo), /* NFC_RESET */
-	/*
-	 * SKE keyboard partly on alt A and partly on "Other alt C1"
-	 * Driver KP_O1,2,3,6,7 low and pull up KP_I 0,2,3 for three
-	 * rows of 6 keys, then pull up force sensing interrup and
-	 * drive reset and force sensing WU low.
-	 */
-	DB8500_MUX_HOG("kp_a_1", "kp"),
-	DB8500_MUX_HOG("kp_oc1_1", "kp"),
-	DB8500_PIN_HOG("GPIO90_A3", out_lo), /* KP_O1 */
-	DB8500_PIN_HOG("GPIO87_B3", out_lo), /* KP_O2 */
-	DB8500_PIN_HOG("GPIO86_C6", out_lo), /* KP_O3 */
-	DB8500_PIN_HOG("GPIO96_D8", out_lo), /* KP_O6 */
-	DB8500_PIN_HOG("GPIO94_D7", out_lo), /* KP_O7 */
-	DB8500_PIN_HOG("GPIO93_B7", in_pu), /* KP_I0 */
-	DB8500_PIN_HOG("GPIO89_E6", in_pu), /* KP_I2 */
-	DB8500_PIN_HOG("GPIO88_C4", in_pu), /* KP_I3 */
 	DB8500_PIN_HOG("GPIO91_B6", gpio_in_pu), /* FORCE_SENSING_INT */
 	DB8500_PIN_HOG("GPIO92_D6", gpio_out_lo), /* FORCE_SENSING_RST */
 	DB8500_PIN_HOG("GPIO97_D9", gpio_out_lo), /* FORCE_SENSING_WU */
-- 
1.8.3.1
