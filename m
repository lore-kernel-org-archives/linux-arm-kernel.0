From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:51 +0100
Subject: [PATCH 02/21] ARM: ux500: move I2C pin control to the device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the static, device-tied pin control configuration
out of the board file board-mop500-pins.c and into the device
tree. Define possible states also for I2C4 even if it's not
used by any board file at this time.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 105 +++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi                |  21 +++++
 arch/arm/boot/dts/ste-snowball.dts             |  24 ++++++
 arch/arm/mach-ux500/board-mop500-pins.c        |  22 ------
 4 files changed, 150 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index d979de27b6e1..d2e63f3fb687 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -109,6 +109,111 @@
 					};
 				};
 			};
+
+			/* Settings for all I2C default and sleep states */
+			i2c0 {
+				i2c0_default_mode: i2c_default {
+					default_mux {
+						ste,function = "i2c0";
+						ste,pins = "i2c0_a_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO147_C15", "GPIO148_B16"; /* SDA/SCL */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c0_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO147_C15", "GPIO148_B16"; /* SDA/SCL */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
+
+			i2c1 {
+				i2c1_default_mode: i2c_default {
+					default_mux {
+						ste,function = "i2c1";
+						ste,pins = "i2c1_b_2";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO16_AD3", "GPIO17_AD4"; /* SDA/SCL */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c1_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO16_AD3", "GPIO17_AD4"; /* SDA/SCL */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
+
+			i2c2 {
+				i2c2_default_mode: i2c_default {
+					default_mux {
+						ste,function = "i2c2";
+						ste,pins = "i2c2_b_2";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO10_AF5", "GPIO11_AG4"; /* SDA/SCL */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c2_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO10_AF5", "GPIO11_AG4"; /* SDA/SCL */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
+
+			i2c3 {
+				i2c3_default_mode: i2c_default {
+					default_mux {
+						ste,function = "i2c3";
+						ste,pins = "i2c3_c_2";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO229_AG7", "GPIO230_AF7"; /* SDA/SCL */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c3_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO229_AG7", "GPIO230_AF7"; /* SDA/SCL */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
+
+			/*
+			 * Activating I2C4 will conflict with UART1 about the same pins so do not
+			 * enable I2C4 and UART1 at the same time.
+			 */
+			i2c4 {
+				i2c4_default_mode: i2c_default {
+					default_mux {
+						ste,function = "i2c4";
+						ste,pins = "i2c4_b_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO4_AH6", "GPIO5_AG6"; /* SDA/SCL */
+						ste,config = <&in_pu>;
+					};
+				};
+
+				i2c4_sleep_mode: i2c_sleep {
+					sleep_cfg1 {
+						ste,pins = "GPIO4_AH6", "GPIO5_AG6"; /* SDA/SCL */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 914a5f4399e5..1863241c911e 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -51,7 +51,22 @@
 			status = "okay";
 		};
 
+		i2c at 80004000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c0_default_mode>;
+			pinctrl-1 = <&i2c0_sleep_mode>;
+		};
+
+		i2c at 80122000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c1_default_mode>;
+			pinctrl-1 = <&i2c1_sleep_mode>;
+		};
+
 		i2c at 80128000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c2_default_mode>;
+			pinctrl-1 = <&i2c2_sleep_mode>;
 			lp5521 at 33 {
 				compatible = "national,lp5521";
 				reg = <0x33>;
@@ -95,6 +110,12 @@
 			};
 		};
 
+		i2c at 80110000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c3_default_mode>;
+			pinctrl-1 = <&i2c3_sleep_mode>;
+		};
+
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
 			arm,primecell-periphid = <0x10480180>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 16d28863ef6e..f8df43e0791d 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -176,6 +176,30 @@
 			status = "okay";
 		};
 
+		i2c at 80004000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c0_default_mode>;
+			pinctrl-1 = <&i2c0_sleep_mode>;
+		};
+
+		i2c at 80122000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c1_default_mode>;
+			pinctrl-1 = <&i2c1_sleep_mode>;
+		};
+
+		i2c at 80128000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c2_default_mode>;
+			pinctrl-1 = <&i2c2_sleep_mode>;
+		};
+
+		i2c at 80110000 {
+			pinctrl-names = "default","sleep";
+			pinctrl-0 = <&i2c3_default_mode>;
+			pinctrl-1 = <&i2c3_sleep_mode>;
+		};
+
 		cpufreq-cooling {
 			status = "okay";
 		};
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index c6225191141f..1f1e53972063 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -61,8 +61,6 @@ BIAS(slpm_out_lo_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_out_hi_wkup_pdis, PIN_SLEEPMODE_ENABLED|PIN_SLPM_OUTPUT_HIGH|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_in_nopull_wkup_pdis, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_INPUT_NOPULL|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_in_pu_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|PIN_SLPM_INPUT_PULLUP|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
 BIAS(out_lo_wkup_pdis, PIN_SLPM_OUTPUT_LOW|
@@ -391,26 +389,6 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	DB8500_PIN("GPIO69_E2", in_pu, "0-0070"),
 	/* LCD VSI1 sleep state */
 	DB8500_PIN_SLEEP("GPIO69_E2", slpm_in_wkup_pdis, "0-0070"),
-	/* Mux in i2c0 block, default state */
-	DB8500_MUX("i2c0_a_1", "i2c0", "nmk-i2c.0"),
-	/* i2c0 sleep state */
-	DB8500_PIN_SLEEP("GPIO147_C15", slpm_in_nopull_wkup_pdis, "nmk-i2c.0"), /* SDA */
-	DB8500_PIN_SLEEP("GPIO148_B16", slpm_in_nopull_wkup_pdis, "nmk-i2c.0"), /* SCL */
-	/* Mux in i2c1 block, default state  */
-	DB8500_MUX("i2c1_b_2", "i2c1", "nmk-i2c.1"),
-	/* i2c1 sleep state */
-	DB8500_PIN_SLEEP("GPIO16_AD3", slpm_in_nopull_wkup_pdis, "nmk-i2c.1"), /* SDA */
-	DB8500_PIN_SLEEP("GPIO17_AD4", slpm_in_nopull_wkup_pdis, "nmk-i2c.1"), /* SCL */
-	/* Mux in i2c2 block, default state  */
-	DB8500_MUX("i2c2_b_2", "i2c2", "nmk-i2c.2"),
-	/* i2c2 sleep state */
-	DB8500_PIN_SLEEP("GPIO10_AF5", slpm_in_nopull_wkup_pdis, "nmk-i2c.2"), /* SDA */
-	DB8500_PIN_SLEEP("GPIO11_AG4", slpm_in_nopull_wkup_pdis, "nmk-i2c.2"), /* SCL */
-	/* Mux in i2c3 block, default state  */
-	DB8500_MUX("i2c3_c_2", "i2c3", "nmk-i2c.3"),
-	/* i2c3 sleep state */
-	DB8500_PIN_SLEEP("GPIO229_AG7", slpm_in_nopull_wkup_pdis, "nmk-i2c.3"), /* SDA */
-	DB8500_PIN_SLEEP("GPIO230_AF7", slpm_in_nopull_wkup_pdis, "nmk-i2c.3"), /* SCL */
 	/* Mux in SDI0 (here called MC0) used for removable MMC/SD/SDIO cards */
 	DB8500_MUX("mc0_a_1", "mc0", "sdi0"),
 	DB8500_PIN("GPIO18_AC2", out_hi, "sdi0"), /* CMDDIR */
-- 
1.8.3.1
