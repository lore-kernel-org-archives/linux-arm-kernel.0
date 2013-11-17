From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:06 +0100
Subject: [PATCH 17/21] ARM: ux500: move HREFv60plus pin configs to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-18-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the few remaining HREFv60 pin configurations to the device
tree, reference these as hogs to the pin controller until there
are real devices that can make use of them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefv60plus.dtsi  | 155 +++++++++++++++++++++++++++++++-
 arch/arm/mach-ux500/board-mop500-pins.c |  53 -----------
 2 files changed, 153 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 25b4848e9a6a..941bf9ad6f01 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -62,9 +62,23 @@
 		};
 
 		pinctrl {
-			/* Set this up using hogs */
+			/*
+			 * Set this up using hogs, as time goes by and as seems fit, these
+			 * can be moved over to being controlled by respective device.
+			 */
 			pinctrl-names = "default";
-			pinctrl-0 = <&ipgpio_hrefv60_mode>;
+			pinctrl-0 = <&ipgpio_hrefv60_mode>,
+				  <&accel_hrefv60_mode>,
+				  <&magneto_hrefv60_mode>,
+				  <&etm_hrefv60_mode>,
+				  <&nahj_hrefv60_mode>,
+				  <&nfc_hrefv60_mode>,
+				  <&force_hrefv60_mode>,
+				  <&dipro_hrefv60_mode>,
+				  <&vaudio_hf_hrefv60_mode>,
+				  <&gbf_hrefv60_mode>,
+				  <&hdtv_hrefv60_mode>,
+				  <&touch_hrefv60_mode>;
 
 			sdi0 {
 				/* SD card detect GPIO pin, extend default state */
@@ -100,8 +114,145 @@
 						ste,pins = "GPIO64_F3";
 						ste,config = <&out_lo>;
 					};
+				};
+			};
+			accelerometer {
+				accel_hrefv60_mode: accel_hrefv60 {
+					/* Accelerometer interrupt lines 1 & 2 */
+					hrefv60_cfg1 {
+						ste,pins = "GPIO82_C1", "GPIO83_D3";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+			magnetometer {
+				magneto_hrefv60_mode: magneto_hrefv60 {
+					/* Magnetometer uses GPIO 31 and 32, pull these up/down respectively */
+					hrefv60_cfg1 {
+						ste,pins = "GPIO31_V3";
+						ste,config = <&gpio_in_pu>;
+					};
+					hrefv60_cfg2 {
+						ste,pins = "GPIO32_V2";
+						ste,config = <&gpio_in_pd>;
+					};
+				};
+			};
+			etm {
+				/*
+				 * Drive D19-D23 for the ETM PTM trace interface low,
+				 * (presumably pins are unconnected therefore grounded here,
+				 * the "other alt C1" setting enables these pins)
+				 */
+				etm_hrefv60_mode: etm_hrefv60 {
+					hrefv60_cfg1 {
+						ste,pins =
+						"GPIO70_G5",
+						"GPIO71_G4",
+						"GPIO72_H4",
+						"GPIO73_H3",
+						"GPIO74_J3";
+						ste,config = <&gpio_out_lo>;
+					};
 				 };
 			};
+			nahj {
+				nahj_hrefv60_mode: nahj_hrefv60 {
+					/* NAHJ CTRL on GPIO76 to low, CTRL_INV on GPIO216 to high */
+					hrefv60_cfg1 {
+						ste,pins = "GPIO76_J2";
+						ste,config = <&gpio_out_lo>;
+					};
+					hrefv60_cfg2 {
+						ste,pins = "GPIO216_AG12";
+						ste,config = <&gpio_out_hi>;
+					};
+				 };
+			};
+			nfc {
+				nfc_hrefv60_mode: nfc_hrefv60 {
+					/* NFC ENA and RESET to low, pulldown IRQ line */
+					hrefv60_cfg1 {
+						ste,pins =
+						"GPIO77_H1", /* NFC_ENA */
+						"GPIO142_C11"; /* NFC_RESET */
+						ste,config = <&gpio_out_lo>;
+					};
+					hrefv60_cfg2 {
+						ste,pins = "GPIO144_B13"; /* NFC_IRQ */
+						ste,config = <&gpio_in_pd>;
+					};
+				 };
+			};
+			force {
+				force_hrefv60_mode: force_hrefv60 {
+					hrefv60_cfg1 {
+						ste,pins = "GPIO91_B6"; /* FORCE_SENSING_INT */
+						ste,config = <&gpio_in_pu>;
+					};
+					hrefv60_cfg2 {
+						ste,pins =
+						"GPIO92_D6", /* FORCE_SENSING_RST */
+						"GPIO97_D9"; /* FORCE_SENSING_WU */
+						ste,config = <&gpio_out_lo>;
+					};
+				 };
+			};
+			dipro {
+				dipro_hrefv60_mode: dipro_hrefv60 {
+					hrefv60_cfg1 {
+						ste,pins = "GPIO139_C9"; /* DIPRO_INT */
+						ste,config = <&gpio_in_pu>;
+					};
+				 };
+			};
+			vaudio_hf {
+				vaudio_hf_hrefv60_mode: vaudio_hf_hrefv60 {
+					/* Audio Amplifier HF enable GPIO */
+					hrefv60_cfg1 {
+						ste,pins = "GPIO149_B14"; /* VAUDIO_HF_EN, enable MAX8968 */
+						ste,config = <&gpio_out_hi>;
+					};
+				 };
+			};
+			gbf {
+				gbf_hrefv60_mode: gbf_hrefv60 {
+					/*
+					 * GBF (GPS, Bluetooth, FM-radio) interface,
+					 * pull low to reset state
+					 */
+					hrefv60_cfg1 {
+						ste,pins = "GPIO171_D23"; /* GBF_ENA_RESET */
+						ste,config = <&gpio_out_lo>;
+					};
+				 };
+			};
+			hdtv {
+				hdtv_hrefv60_mode: hdtv_hrefv60 {
+					/* MSP : HDTV INTERFACE GPIO line */
+					hrefv60_cfg1 {
+						ste,pins = "GPIO192_AJ27";
+						ste,config = <&gpio_in_pd>;
+					};
+				 };
+			};
+			touch {
+				touch_hrefv60_mode: touch_hrefv60 {
+					/*
+					 * Touch screen uses GPIO 143 for RST1, GPIO 146 for RST2 and
+					 * GPIO 67 for interrupts. Pull-up the IRQ line and drive both
+					 * reset signals low.
+					 */
+					hrefv60_cfg1 {
+						ste,pins = "GPIO143_D12", "GPIO146_D13";
+						ste,config = <&gpio_out_lo>;
+					};
+					hrefv60_cfg2 {
+						ste,pins = "GPIO67_G2";
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 			mcde {
 				lcd_hrefv60_mode: lcd_hrefv60 {
 					/*
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 6cc71d02957f..71ee944ea70f 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -27,7 +27,6 @@ BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
 
 /* These also force them into GPIO mode */
 BIAS(gpio_in_pu, PIN_INPUT_PULLUP|PIN_GPIOMODE_ENABLED);
-BIAS(gpio_in_pd, PIN_INPUT_PULLDOWN|PIN_GPIOMODE_ENABLED);
 BIAS(gpio_out_hi, PIN_OUTPUT_HIGH|PIN_GPIOMODE_ENABLED);
 BIAS(gpio_out_lo, PIN_OUTPUT_LOW|PIN_GPIOMODE_ENABLED);
 
@@ -299,56 +298,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 	AB8505_PIN_HOG("GPIO53_D15", in_pd),
 };
 
-/*
- * The HREFv60 series of platforms is using available pins on the DB8500
- * insteaf of the Toshiba I2C GPIO expander, reusing some pins like the SSP0
- * and SSP1 ports (previously connected to the AB8500) as generic GPIO lines.
- */
-static struct pinctrl_map __initdata hrefv60_pinmap[] = {
-	/* Magnetometer uses GPIO 31 and 32, pull these up/down respectively */
-	DB8500_PIN_HOG("GPIO31_V3", gpio_in_pu), /* EN1 */
-	DB8500_PIN_HOG("GPIO32_V2", gpio_in_pd), /* DRDY */
-	/*
-	 * Touch screen uses GPIO 143 for RST1, GPIO 146 for RST2 and
-	 * GPIO 67 for interrupts. Pull-up the IRQ line and drive both
-	 * reset signals low.
-	 */
-	DB8500_PIN_HOG("GPIO143_D12", gpio_out_lo), /* TOUCH_RST1 */
-	DB8500_PIN_HOG("GPIO67_G2", gpio_in_pu), /* TOUCH_INT2 */
-	DB8500_PIN_HOG("GPIO146_D13", gpio_out_lo), /* TOUCH_RST2 */
-	/*
-	 * Drive D19-D23 for the ETM PTM trace interface low,
-	 * (presumably pins are unconnected therefore grounded here,
-	 * the "other alt C1" setting enables these pins)
-	 */
-	DB8500_PIN_HOG("GPIO70_G5", gpio_out_lo),
-	DB8500_PIN_HOG("GPIO71_G4", gpio_out_lo),
-	DB8500_PIN_HOG("GPIO72_H4", gpio_out_lo),
-	DB8500_PIN_HOG("GPIO73_H3", gpio_out_lo),
-	DB8500_PIN_HOG("GPIO74_J3", gpio_out_lo),
-	/* NAHJ CTRL on GPIO 76 to low, CTRL_INV on GPIO216 to high */
-	DB8500_PIN_HOG("GPIO76_J2", gpio_out_lo), /* CTRL */
-	DB8500_PIN_HOG("GPIO216_AG12", gpio_out_hi), /* CTRL_INV */
-	/* NFC ENA and RESET to low, pulldown IRQ line */
-	DB8500_PIN_HOG("GPIO77_H1", gpio_out_lo), /* NFC_ENA */
-	DB8500_PIN_HOG("GPIO144_B13", gpio_in_pd), /* NFC_IRQ */
-	DB8500_PIN_HOG("GPIO142_C11", gpio_out_lo), /* NFC_RESET */
-	DB8500_PIN_HOG("GPIO91_B6", gpio_in_pu), /* FORCE_SENSING_INT */
-	DB8500_PIN_HOG("GPIO92_D6", gpio_out_lo), /* FORCE_SENSING_RST */
-	DB8500_PIN_HOG("GPIO97_D9", gpio_out_lo), /* FORCE_SENSING_WU */
-	/* DiPro Sensor interrupt */
-	DB8500_PIN_HOG("GPIO139_C9", gpio_in_pu), /* DIPRO_INT */
-	/* Audio Amplifier HF enable */
-	DB8500_PIN_HOG("GPIO149_B14", gpio_out_hi), /* VAUDIO_HF_EN, enable MAX8968 */
-	/* GBF interface, pull low to reset state */
-	DB8500_PIN_HOG("GPIO171_D23", gpio_out_lo), /* GBF_ENA_RESET */
-	/* MSP : HDTV INTERFACE GPIO line */
-	DB8500_PIN_HOG("GPIO192_AJ27", gpio_in_pd),
-	/* Accelerometer interrupt lines */
-	DB8500_PIN_HOG("GPIO82_C1", gpio_in_pu), /* ACC_INT1 */
-	DB8500_PIN_HOG("GPIO83_D3", gpio_in_pu), /* ACC_INT2 */
-};
-
 static struct pinctrl_map __initdata snowball_pinmap[] = {
 	/* Mux in SSP0 connected to AB8500, pull down RXD pin */
 	DB8500_MUX_HOG("ssp0_a_1", "ssp0"),
@@ -390,8 +339,6 @@ void __init snowball_pinmaps_init(void)
 
 void __init hrefv60_pinmaps_init(void)
 {
-	pinctrl_register_mappings(hrefv60_pinmap,
-				  ARRAY_SIZE(hrefv60_pinmap));
 	pinctrl_register_mappings(ab8500_pinmap,
 				  ARRAY_SIZE(ab8500_pinmap));
 }
-- 
1.8.3.1
