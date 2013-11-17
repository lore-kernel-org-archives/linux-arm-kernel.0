From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:10 +0100
Subject: [PATCH 21/21] ARM: ux500: move snowball pin configs to device tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-22-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the few remaining snowball pin configurations to the device
tree, reference these as hogs to the pin controller until there
are real devices that can make use of them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts      | 59 +++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-pins.c | 19 -----------
 2 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 605188ba30cd..9070c3701c89 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -357,6 +357,16 @@
 		};
 
 		pinctrl {
+			/*
+			 * Set this up using hogs, as time goes by and as seems fit, these
+			 * can be moved over to being controlled by respective device.
+			 */
+			pinctrl-names = "default";
+			pinctrl-0 = <&accel_snowball_mode>,
+				  <&magneto_snowball_mode>,
+				  <&gbf_snowball_mode>,
+				  <&wlan_snowball_mode>;
+
 			ethernet {
 				/*
 				 * Mux in "SM" which is used for the
@@ -425,6 +435,55 @@
 
 				};
 			};
+			accelerometer {
+				accel_snowball_mode: accel_snowball {
+					/* Accelerometer lines */
+					snowball_cfg1 {
+						ste,pins =
+						"GPIO163_C20", /* ACCEL_IRQ1 */
+						"GPIO164_B21"; /* ACCEL_IRQ2 */
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+			magnetometer {
+				magneto_snowball_mode: magneto_snowball {
+					snowball_cfg1 {
+						ste,pins = "GPIO165_C21"; /* MAG_DRDY */
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
+			gbf {
+				gbf_snowball_mode: gbf_snowball {
+					/*
+					 * GBF (GPS, Bluetooth, FM-radio) interface,
+					 * pull low to reset state
+					 */
+					snowball_cfg1 {
+						ste,pins = "GPIO171_D23"; /* GBF_ENA_RESET */
+						ste,config = <&gpio_out_lo>;
+					};
+				 };
+			};
+			wlan {
+				wlan_snowball_mode: wlan_snowball {
+					/*
+					 * Activate this mode with the WLAN chip.
+					 * These are plain GPIO pins used by WLAN
+					 */
+					snowball_cfg1 {
+						ste,pins =
+						"GPIO161_D21", /* WLAN_PMU_EN */
+						"GPIO215_AH13"; /* WLAN_ENA */
+						ste,config = <&gpio_out_lo>;
+					};
+					snowball_cfg2 {
+						ste,pins = "GPIO216_AG12"; /* WLAN_IRQ */
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 		};
 
 		mcde at a0350000 {
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index aae9cfcfd56a..ff532ba30610 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -23,11 +23,6 @@ BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
 BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
 BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
 
-/* These also force them into GPIO mode */
-BIAS(gpio_in_pu, PIN_INPUT_PULLUP|PIN_GPIOMODE_ENABLED);
-BIAS(gpio_out_hi, PIN_OUTPUT_HIGH|PIN_GPIOMODE_ENABLED);
-BIAS(gpio_out_lo, PIN_OUTPUT_LOW|PIN_GPIOMODE_ENABLED);
-
 /* We use these to define hog settings that are always done on boot */
 #define DB8500_MUX_HOG(group,func) \
 	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-db8500", group, func)
@@ -296,18 +291,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 	AB8505_PIN_HOG("GPIO53_D15", in_pd),
 };
 
-static struct pinctrl_map __initdata snowball_pinmap[] = {
-	/*  Accelerometer/Magnetometer */
-	DB8500_PIN_HOG("GPIO163_C20", gpio_in_pu), /* ACCEL_IRQ1 */
-	DB8500_PIN_HOG("GPIO164_B21", gpio_in_pu), /* ACCEL_IRQ2 */
-	DB8500_PIN_HOG("GPIO165_C21", gpio_in_pu), /* MAG_DRDY */
-	/* WLAN/GBF */
-	DB8500_PIN_HOG("GPIO161_D21", gpio_out_lo), /* WLAN_PMU_EN */
-	DB8500_PIN_HOG("GPIO171_D23", gpio_out_hi), /* GBF_ENA */
-	DB8500_PIN_HOG("GPIO215_AH13", gpio_out_lo), /* WLAN_ENA */
-	DB8500_PIN_HOG("GPIO216_AG12", gpio_in_pu), /* WLAN_IRQ */
-};
-
 void __init mop500_pinmaps_init(void)
 {
 	if (machine_is_u8520())
@@ -320,8 +303,6 @@ void __init mop500_pinmaps_init(void)
 
 void __init snowball_pinmaps_init(void)
 {
-	pinctrl_register_mappings(snowball_pinmap,
-				  ARRAY_SIZE(snowball_pinmap));
 	pinctrl_register_mappings(ab8500_pinmap,
 				  ARRAY_SIZE(ab8500_pinmap));
 }
-- 
1.8.3.1
