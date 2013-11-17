From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:58 +0100
Subject: [PATCH 09/21] ARM: ux500: move MCDE pin config to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-10-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the MCDE pin control table out of the board file
and into the device tree. Some pins and configs have been
marked as used by sub-devices or slaves to the MCDE, such
as I2C device 0-070 which is the HDMI interface circuit
AV8100, but the pins rather belong to the MCDE SOC block
as they come out of the main ASIC. The touch screen GPIO
is not related to MCDE so this gets deleted and need to
be tied to the respective touch screen (I2C) device
once that device is added instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 27 ++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi                |  6 ++++++
 arch/arm/boot/dts/ste-snowball.dts             |  6 ++++++
 arch/arm/mach-ux500/board-mop500-pins.c        | 19 ------------------
 4 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index ec990d8e1029..779829a1e143 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -604,6 +604,33 @@
 					};
 				};
 			};
+
+			mcde {
+				lcd_default_mode: lcd_default {
+					default_mux {
+						/* Mux in VSI0 and all the data lines */
+						ste,function = "lcd";
+						ste,pins =
+						"lcdvsi0_a_1", /* VSI0 for LCD */
+						"lcd_d0_d7_a_1", /* Data lines */
+						"lcd_d8_d11_a_1", /* TV-out */
+						"lcdaclk_b_1", /* Clock line for TV-out */
+						"lcdvsi1_a_1"; /* VSI1 for HDMI */
+					};
+					default_cfg1 {
+						ste,pins =
+						"GPIO68_E1", /* VSI0 */
+						"GPIO69_E2"; /* VSI1 */
+						ste,config = <&in_pu>;
+					};
+				};
+				lcd_sleep_mode: lcd_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO69_E2"; /* VSI1 */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 4fda2d933488..56772c3ebb28 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -261,5 +261,11 @@
 				};
 			};
 		};
+
+		mcde at a0350000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&lcd_default_mode>;
+			pinctrl-1 = <&lcd_sleep_mode>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 4763b805e754..53febe58a1cb 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -362,5 +362,11 @@
 				};
 			};
 		};
+
+		mcde at a0350000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&lcd_default_mode>;
+			pinctrl-1 = <&lcd_sleep_mode>;
+		};
 	};
 };
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 8fba58c98da2..4cc4cb151474 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -46,8 +46,6 @@ BIAS(gpio_out_lo, PIN_OUTPUT_LOW|PIN_GPIOMODE_ENABLED);
 /* Sleep modes */
 BIAS(slpm_in_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_wkup_pdis, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_out_lo_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_DISABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_out_lo_wkup_pdis, PIN_SLEEPMODE_ENABLED|
@@ -325,23 +323,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 
 /* Pin control settings */
 static struct pinctrl_map __initdata mop500_family_pinmap[] = {
-	/*
-	 * LCD, set TE0 (using LCD VSI0) and D14 (touch screen interrupt) to
-	 * pull-up
-	 * TODO: is this really correct? Snowball doesn't have a LCD.
-	 */
-	DB8500_MUX_HOG("lcdvsi0_a_1", "lcd"),
-	DB8500_PIN_HOG("GPIO68_E1", in_pu),
-	DB8500_PIN_HOG("GPIO84_C2", gpio_in_pu),
-	/* Mux in LCD data lines 8 thru 11 and LCDA CLK for MCDE TVOUT */
-	DB8500_MUX("lcd_d8_d11_a_1", "lcd", "mcde-tvout"),
-	DB8500_MUX("lcdaclk_b_1", "lcda", "mcde-tvout"),
-	/* Mux in LCD VSI1 and pull it up for MCDE HDMI output */
-	DB8500_MUX("lcdvsi1_a_1", "lcd", "0-0070"),
-	DB8500_PIN("GPIO69_E2", in_pu, "0-0070"),
-	/* LCD VSI1 sleep state */
-	DB8500_PIN_SLEEP("GPIO69_E2", slpm_in_wkup_pdis, "0-0070"),
-
 	/* ske default state */
 	DB8500_MUX("kp_a_2", "kp", "nmk-ske-keypad"),
 	DB8500_PIN("GPIO153_B17", in_pd, "nmk-ske-keypad"), /* I7 */
-- 
1.8.3.1
