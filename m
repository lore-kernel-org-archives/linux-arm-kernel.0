From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:56 +0100
Subject: [PATCH 07/21] ARM: ux500: move SPI pin config to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the SPI pin control table out of the board file
and into the device tree. Move the specific setting for
SSP0 on the HREFprev60 into the prev60-specific DTS file.
The SPI2 configuration is not really connected to any device,
as it will conflict with GPIO218 which is used on all HREFs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 61 ++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-hrefprev60.dtsi          | 22 ++++++++++
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi     | 31 +++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c        | 19 --------
 4 files changed, 114 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index 6868fec95d64..ec990d8e1029 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -215,6 +215,67 @@
 				};
 			};
 
+			/* Settings for all SPI default and sleep states */
+			spi2 {
+				spi2_default_mode: spi_default {
+					default_mux {
+						ste,function = "spi2";
+						ste,pins = "spi2_oc1_2";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO216_AG12"; /* FRM */
+						ste,config = <&gpio_out_hi>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO218_AH11"; /* RXD */
+						ste,config = <&in_pd>;
+					};
+					default_cfg3 {
+						ste,pins =
+						"GPIO215_AH13", /* TXD */
+						"GPIO217_AH12"; /* CLK */
+						ste,config = <&out_lo>;
+					};
+				};
+
+				spi2_idle_mode: spi_idle {
+					/*
+					 * The idle mode is basically sleep mode sans wakeups. Also
+					 * note that we have muxes the pins off the function here
+					 * as we do not state any muxing.
+					 */
+					idle_cfg1 {
+						ste,pins = "GPIO218_AH11"; /* RXD */
+						ste,config = <&slpm_in_pdis>;
+					};
+					idle_cfg2 {
+						ste,pins = "GPIO215_AH13"; /* TXD */
+						ste,config = <&slpm_out_lo_pdis>;
+					};
+					idle_cfg3 {
+						ste,pins = "GPIO217_AH12"; /* CLK */
+						ste,config = <&slpm_pdis>;
+					};
+				};
+
+				spi2_sleep_mode: spi_sleep {
+					sleep_cfg1 {
+						ste,pins =
+						"GPIO216_AG12", /* FRM */
+						"GPIO218_AH11"; /* RXD */
+						ste,config = <&slpm_in_wkup_pdis>;
+					};
+					sleep_cfg2 {
+						ste,pins = "GPIO215_AH13"; /* TXD */
+						ste,config = <&slpm_out_lo_wkup_pdis>;
+					};
+					sleep_cfg3 {
+						ste,pins = "GPIO217_AH12"; /* CLK */
+						ste,config = <&slpm_wkup_pdis>;
+					};
+				};
+			};
+
 			/* Settings for all MMC/SD/SDIO default and sleep states */
 			sdi0 {
 				/* This is the external SD card slot, 4 bits wide */
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 6fc94ea65ab9..32295e396ff8 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -51,6 +51,15 @@
 			};
 		};
 
+		ssp at 80002000 {
+			/*
+			 * On the first generation boards, this SSP/SPI port was connected
+			 * to the AB8500.
+			 */
+			pinctrl-names = "default";
+			pinctrl-0 = <&ssp0_hrefprev60_mode>;
+		};
+
 		vmmci: regulator-gpio {
 			gpios = <&tc3589x_gpio 18 0x4>;
 			enable-gpio = <&tc3589x_gpio 17 0x4>;
@@ -59,6 +68,19 @@
 		};
 
 		pinctrl {
+			ssp0 {
+				ssp0_hrefprev60_mode: ssp0_hrefprev60_default {
+					hrefprev60_mux {
+						ste,function = "ssp0";
+						ste,pins = "ssp0_a_1";
+					};
+					hrefprev60_cfg1 {
+						ste,pins = "GPIO145_C13"; /* RXD */
+						ste,config = <&in_pd>;
+					};
+
+				};
+			};
 			sdi0 {
 				/* This additional pin needed on early MOP500 and HREFs previous to v60 */
 				sdi0_default_mode: sdi0_default {
diff --git a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
index 9f3e87573f86..456a25fbfaee 100644
--- a/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi
@@ -41,6 +41,23 @@
 		ste,output = <OUTPUT_LOW>;
 	};
 
+	gpio_out_hi: gpio_output_high {
+		ste,gpio = <GPIOMODE_ENABLED>;
+		ste,output = <OUTPUT_HIGH>;
+	};
+
+	slpm_pdis: slpm_pdis {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_DISABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
+	};
+
+	slpm_wkup_pdis: slpm_wkup_pdis {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
+	};
+
 	slpm_wkup_pdis_en: slpm_wkup_pdis_en {
 		ste,sleep = <SLPM_ENABLED>;
 		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
@@ -53,6 +70,13 @@
 		ste,sleep-wakeup = <SLPM_WAKEUP_ENABLE>;
 	};
 
+	slpm_in_pdis: slpm_in_pdis {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-input = <SLPM_DIR_INPUT>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_DISABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
+	};
+
 	slpm_in_wkup_pdis: slpm_in_wkup_pdis {
 		ste,sleep = <SLPM_ENABLED>;
 		ste,sleep-input = <SLPM_DIR_INPUT>;
@@ -86,6 +110,13 @@
 		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
 	};
 
+	slpm_out_lo_pdis: slpm_out_lo_pdis {
+		ste,sleep = <SLPM_ENABLED>;
+		ste,sleep-output = <SLPM_OUTPUT_LOW>;
+		ste,sleep-wakeup = <SLPM_WAKEUP_DISABLE>;
+		ste,sleep-pull-disable = <SLPM_PDIS_DISABLED>;
+	};
+
 	slpm_out_lo_wkup_pdis: slpm_out_lo_wkup_pdis {
 		ste,sleep = <SLPM_ENABLED>;
 		ste,sleep-output = <SLPM_OUTPUT_LOW>;
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index a6d431bd0659..8fba58c98da2 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -342,22 +342,6 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	/* LCD VSI1 sleep state */
 	DB8500_PIN_SLEEP("GPIO69_E2", slpm_in_wkup_pdis, "0-0070"),
 
-	/* Mux in SPI2 pins on the "other C1" altfunction */
-	DB8500_MUX("spi2_oc1_2", "spi2", "spi2"),
-	DB8500_PIN("GPIO216_AG12", gpio_out_hi, "spi2"), /* FRM */
-	DB8500_PIN("GPIO218_AH11", in_pd, "spi2"), /* RXD */
-	DB8500_PIN("GPIO215_AH13", out_lo, "spi2"), /* TXD */
-	DB8500_PIN("GPIO217_AH12", out_lo, "spi2"), /* CLK */
-	/* SPI2 idle state */
-	DB8500_PIN_IDLE("GPIO218_AH11", slpm_in_wkup_pdis, "spi2"), /* RXD */
-	DB8500_PIN_IDLE("GPIO215_AH13", slpm_out_lo_wkup_pdis, "spi2"), /* TXD */
-	DB8500_PIN_IDLE("GPIO217_AH12", slpm_wkup_pdis, "spi2"), /* CLK */
-	/* SPI2 sleep state */
-	DB8500_PIN_SLEEP("GPIO216_AG12", slpm_in_wkup_pdis, "spi2"), /* FRM */
-	DB8500_PIN_SLEEP("GPIO218_AH11", slpm_in_wkup_pdis, "spi2"), /* RXD */
-	DB8500_PIN_SLEEP("GPIO215_AH13", slpm_out_lo_wkup_pdis, "spi2"), /* TXD */
-	DB8500_PIN_SLEEP("GPIO217_AH12", slpm_wkup_pdis, "spi2"), /* CLK */
-
 	/* ske default state */
 	DB8500_MUX("kp_a_2", "kp", "nmk-ske-keypad"),
 	DB8500_PIN("GPIO153_B17", in_pd, "nmk-ske-keypad"), /* I7 */
@@ -582,9 +566,6 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
  * on-chip pins as the HREFv60 and later does.
  */
 static struct pinctrl_map __initdata mop500_pinmap[] = {
-	/* Mux in SSP0, pull down RXD pin */
-	DB8500_MUX_HOG("ssp0_a_1", "ssp0"),
-	DB8500_PIN_HOG("GPIO145_C13", pd),
 	/*
 	 * XENON Flashgun on image processor GPIO (controlled from image
 	 * processor firmware), mux in these image processor GPIO lines 0
-- 
1.8.3.1
