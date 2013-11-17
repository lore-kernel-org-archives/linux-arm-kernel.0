From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:03:53 +0100
Subject: [PATCH 04/21] ARM: ux500: move MSP pin control to the device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the static, device-tied pin control configuration
out of the board file board-mop500-pins.c and into the device
tree. Add nodes for MSP0 and MSP2 on the HREF and Snowball
so we can reference the pins properly.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 63 ++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-href.dtsi                | 14 ++++++
 arch/arm/boot/dts/ste-snowball.dts             | 14 ++++++
 arch/arm/mach-ux500/board-mop500-pins.c        | 30 ------------
 4 files changed, 91 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index 23583b0546d9..7408d3a898a5 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -425,6 +425,69 @@
 					};
 				};
 			};
+
+			/*
+			 * Multi-rate serial ports (MSPs) - MSP3 output is internal and
+			 * cannot be muxed onto any pins.
+			 */
+			msp0 {
+				msp0_default_mode: msp0_default {
+					default_msp0_mux {
+						ste,function = "msp0";
+						ste,pins = "msp0txrx_a_1", "msp0tfstck_a_1";
+					};
+					default_msp0_cfg {
+						ste,pins =
+						"GPIO12_AC4", /* TXD */
+						"GPIO15_AC3", /* RXD */
+						"GPIO13_AF3", /* TFS */
+						"GPIO14_AE3"; /* TCK */
+						ste,config = <&in_nopull>;
+					};
+				};
+			};
+
+			msp1 {
+				msp1_default_mode: msp1_default {
+					default_mux {
+						ste,function = "msp1";
+						ste,pins = "msp1txrx_a_1", "msp1_a_1";
+					};
+					default_cfg1 {
+						ste,pins = "GPIO33_AF2";
+						ste,config = <&out_lo>;
+					};
+					default_cfg2 {
+						ste,pins =
+						"GPIO34_AE1",
+						"GPIO35_AE2",
+						"GPIO36_AG2";
+						ste,config = <&in_nopull>;
+					};
+
+				};
+			};
+
+			msp2 {
+				msp2_default_mode: msp2_default {
+					/* MSP2 usually used for HDMI audio */
+					default_mux {
+						ste,function = "msp2";
+						ste,pins = "msp2_a_1";
+					};
+					default_cfg1 {
+						ste,pins =
+						"GPIO193_AH27", /* TXD */
+						"GPIO194_AF27", /* TCK */
+						"GPIO195_AG28"; /* TFS */
+						ste,config = <&in_pd>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO196_AG26"; /* RXD */
+						ste,config = <&out_lo>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 845eb25f5d26..85260846deae 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -180,7 +180,21 @@
 			stericsson,audio-codec = <&codec>;
 		};
 
+		msp0: msp at 80123000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msp0_default_mode>;
+			status = "okay";
+		};
+
 		msp1: msp at 80124000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msp1_default_mode>;
+			status = "okay";
+		};
+
+		msp2: msp at 80117000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msp2_default_mode>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index c2cb3ea637dc..65180b2bc409 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -93,7 +93,21 @@
 			stericsson,audio-codec = <&codec>;
 		};
 
+		msp0: msp at 80123000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msp0_default_mode>;
+			status = "okay";
+		};
+
 		msp1: msp at 80124000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msp1_default_mode>;
+			status = "okay";
+		};
+
+		msp2: msp at 80117000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msp2_default_mode>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 0f9a0776cf90..f7034cbdc630 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -28,12 +28,10 @@ static enum custom_pin_cfg_t pinsfor;
 
 BIAS(pd, PIN_PULL_DOWN);
 BIAS(in_nopull, PIN_INPUT_NOPULL);
-BIAS(in_nopull_slpm_nowkup, PIN_INPUT_NOPULL|PIN_SLPM_WAKEUP_DISABLE);
 BIAS(in_pu, PIN_INPUT_PULLUP);
 BIAS(in_pd, PIN_INPUT_PULLDOWN);
 BIAS(out_hi, PIN_OUTPUT_HIGH);
 BIAS(out_lo, PIN_OUTPUT_LOW);
-BIAS(out_lo_slpm_nowkup, PIN_OUTPUT_LOW|PIN_SLPM_WAKEUP_DISABLE);
 
 BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
 BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
@@ -335,22 +333,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 /* Pin control settings */
 static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	/*
-	 * uMSP0, mux in 4 pins, regular placement of RX/TX
-	 * explicitly set the pins to no pull
-	 */
-	DB8500_MUX_HOG("msp0txrx_a_1", "msp0"),
-	DB8500_MUX_HOG("msp0tfstck_a_1", "msp0"),
-	DB8500_PIN_HOG("GPIO12_AC4", in_nopull), /* TXD */
-	DB8500_PIN_HOG("GPIO15_AC3", in_nopull), /* RXD */
-	DB8500_PIN_HOG("GPIO13_AF3", in_nopull), /* TFS */
-	DB8500_PIN_HOG("GPIO14_AE3", in_nopull), /* TCK */
-	/* MSP2 for HDMI, pull down TXD, TCK, TFS  */
-	DB8500_MUX_HOG("msp2_a_1", "msp2"),
-	DB8500_PIN_HOG("GPIO193_AH27", in_pd), /* TXD */
-	DB8500_PIN_HOG("GPIO194_AF27", in_pd), /* TCK */
-	DB8500_PIN_HOG("GPIO195_AG28", in_pd), /* TFS */
-	DB8500_PIN_HOG("GPIO196_AG26", out_lo), /* RXD */
-	/*
 	 * LCD, set TE0 (using LCD VSI0) and D14 (touch screen interrupt) to
 	 * pull-up
 	 * TODO: is this really correct? Snowball doesn't have a LCD.
@@ -363,18 +345,6 @@ static struct pinctrl_map __initdata mop500_family_pinmap[] = {
 	 * TODO: set for snowball and HREF really??
 	 */
 	DB8500_PIN_HOG("GPIO218_AH11", gpio_in_pu),
-	/*
-	 * The following pin sets were known as "runtime pins" before being
-	 * converted to the pinctrl model. Here we model them as "default"
-	 * states.
-	 */
-	/* MSP1 for ALSA codec */
-	DB8500_MUX_HOG("msp1txrx_a_1", "msp1"),
-	DB8500_MUX_HOG("msp1_a_1", "msp1"),
-	DB8500_PIN_HOG("GPIO33_AF2", out_lo_slpm_nowkup),
-	DB8500_PIN_HOG("GPIO34_AE1", in_nopull_slpm_nowkup),
-	DB8500_PIN_HOG("GPIO35_AE2", in_nopull_slpm_nowkup),
-	DB8500_PIN_HOG("GPIO36_AG2", in_nopull_slpm_nowkup),
 	/* Mux in LCD data lines 8 thru 11 and LCDA CLK for MCDE TVOUT */
 	DB8500_MUX("lcd_d8_d11_a_1", "lcd", "mcde-tvout"),
 	DB8500_MUX("lcdaclk_b_1", "lcda", "mcde-tvout"),
-- 
1.8.3.1
