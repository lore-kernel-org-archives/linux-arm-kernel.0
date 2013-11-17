From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:55 +0100
Subject: [PATCH 06/21] ARM: ux500: move MUSB pin config to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the MUSB pin control table out of the board file
and into the device tree. Tie the config to the on-chip MUSB
device rather than the ab8500-usb device which is off-chip.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 55 ++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi                |  6 +++
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi     | 13 ++++++
 arch/arm/boot/dts/ste-snowball.dts             |  5 +++
 arch/arm/mach-ux500/board-mop500-pins.c        | 25 ------------
 5 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index 7408d3a898a5..6868fec95d64 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -488,6 +488,61 @@
 					};
 				};
 			};
+
+
+			musb {
+				musb_default_mode: musb_default {
+					default_mux {
+						ste,function = "usb";
+						ste,pins = "usb_a_1";
+					};
+					default_cfg1 {
+						ste,pins =
+						"GPIO256_AF28", /* NXT */
+						"GPIO258_AD29", /* XCLK */
+						"GPIO259_AC29", /* DIR */
+						"GPIO260_AD28", /* DAT7 */
+						"GPIO261_AD26", /* DAT6 */
+						"GPIO262_AE26", /* DAT5 */
+						"GPIO263_AG29", /* DAT4 */
+						"GPIO264_AE27", /* DAT3 */
+						"GPIO265_AD27", /* DAT2 */
+						"GPIO266_AC28", /* DAT1 */
+						"GPIO267_AC27"; /* DAT0 */
+						ste,config = <&in_nopull>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO257_AE29"; /* STP */
+						ste,config = <&out_hi>;
+					};
+				};
+
+				musb_sleep_mode: musb_sleep {
+					sleep_cfg1 {
+						ste,pins =
+						"GPIO256_AF28", /* NXT */
+						"GPIO258_AD29", /* XCLK */
+						"GPIO259_AC29"; /* DIR */
+						ste,config = <&slpm_wkup_pdis_en>;
+					};
+					sleep_cfg2 {
+						ste,pins = "GPIO257_AE29"; /* STP */
+						ste,config = <&slpm_out_hi_wkup_pdis>;
+					};
+					sleep_cfg3 {
+						ste,pins =
+						"GPIO260_AD28", /* DAT7 */
+						"GPIO261_AD26", /* DAT6 */
+						"GPIO262_AE26", /* DAT5 */
+						"GPIO263_AG29", /* DAT4 */
+						"GPIO264_AE27", /* DAT3 */
+						"GPIO265_AD27", /* DAT2 */
+						"GPIO266_AC28", /* DAT1 */
+						"GPIO267_AC27"; /* DAT0 */
+						ste,config = <&slpm_in_wkup_pdis_en>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 85260846deae..4fda2d933488 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -30,6 +30,12 @@
 	};
 
 	soc {
+		usb_per5 at a03e0000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&musb_default_mode>;
+			pinctrl-1 = <&musb_sleep_mode>;
+		};
+
 		uart at 80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&uart0_default_mode>;
diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
index 9aea983e78b5..9f3e87573f86 100644
--- a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
@@ -41,6 +41,12 @@
 		ste,output = <OUTPUT_LOW>;
 	};
 
+	slpm_wkup_pdis_en: slpm_wkup_pdis_en {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_ENABLED>;
+	};
+
 	slpm_in_pu: slpm_in_pu {
 		ste,sleep = <SLPM_ENABLED>;
 		ste,sleep-input = <SLPM_INPUT_PULLUP>;
@@ -54,6 +60,13 @@
 		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
 	};
 
+	slpm_in_wkup_pdis_en: slpm_in_wkup_pdis_en {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-input = <SLPM_DIR_INPUT>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_ENABLED>;
+	};
+
 	slpm_out_lo: slpm_out_lo {
 		ste,sleep = <SLPM_ENABLED>;
 		ste,sleep-output = <SLPM_OUTPUT_LOW>;
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 65180b2bc409..4763b805e754 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -85,6 +85,11 @@
 	};
 
 	soc {
+		usb_per5 at a03e0000 {
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&musb_default_mode>;
+			pinctrl-1 = <&musb_sleep_mode>;
+		};
 
 		sound {
 			compatible = "stericsson,snd-soc-mop500";
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index c032392294a0..a6d431bd0659 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -30,7 +30,6 @@ BIAS(pd, PIN_PULL_DOWN);
 BIAS(in_nopull, PIN_INPUT_NOPULL);
 BIAS(in_pu, PIN_INPUT_PULLUP);
 BIAS(in_pd, PIN_INPUT_PULLDOWN);
-BIAS(out_hi, PIN_OUTPUT_HIGH);
 BIAS(out_lo, PIN_OUTPUT_LOW);
 
 BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
@@ -47,18 +46,12 @@ BIAS(gpio_out_lo, PIN_OUTPUT_LOW|PIN_GPIOMODE_ENABLED);
 /* Sleep modes */
 BIAS(slpm_in_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_in_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
 BIAS(slpm_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
 BIAS(slpm_out_lo_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_DISABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_out_lo_wkup_pdis, PIN_SLEEPMODE_ENABLED|
 	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_out_hi_wkup_pdis, PIN_SLEEPMODE_ENABLED|PIN_SLPM_OUTPUT_HIGH|
-	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
 BIAS(slpm_in_pu_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|PIN_SLPM_INPUT_PULLUP|
 	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
 
@@ -349,24 +342,6 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	/* LCD VSI1 sleep state */
 	DB8500_PIN_SLEEP("GPIO69_E2", slpm_in_wkup_pdis, "0-0070"),
 
-	/* Mux in USB pins, drive STP high */
-	/* USB default state */
-	DB8500_MUX("usb_a_1", "usb", "ab8500-usb.0"),
-	DB8500_PIN("GPIO257_AE29", out_hi, "ab8500-usb.0"), /* STP */
-	/* USB sleep state */
-	DB8500_PIN_SLEEP("GPIO256_AF28", slpm_wkup_pdis_en, "ab8500-usb.0"), /* NXT */
-	DB8500_PIN_SLEEP("GPIO257_AE29", slpm_out_hi_wkup_pdis, "ab8500-usb.0"), /* STP */
-	DB8500_PIN_SLEEP("GPIO258_AD29", slpm_wkup_pdis_en, "ab8500-usb.0"), /* XCLK */
-	DB8500_PIN_SLEEP("GPIO259_AC29", slpm_wkup_pdis_en, "ab8500-usb.0"), /* DIR */
-	DB8500_PIN_SLEEP("GPIO260_AD28", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT7 */
-	DB8500_PIN_SLEEP("GPIO261_AD26", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT6 */
-	DB8500_PIN_SLEEP("GPIO262_AE26", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT5 */
-	DB8500_PIN_SLEEP("GPIO263_AG29", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT4 */
-	DB8500_PIN_SLEEP("GPIO264_AE27", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT3 */
-	DB8500_PIN_SLEEP("GPIO265_AD27", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT2 */
-	DB8500_PIN_SLEEP("GPIO266_AC28", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT1 */
-	DB8500_PIN_SLEEP("GPIO267_AC27", slpm_in_wkup_pdis_en, "ab8500-usb.0"), /* DAT0 */
-
 	/* Mux in SPI2 pins on the "other C1" altfunction */
 	DB8500_MUX("spi2_oc1_2", "spi2", "spi2"),
 	DB8500_PIN("GPIO216_AG12", gpio_out_hi, "spi2"), /* FRM */
-- 
1.8.3.1
