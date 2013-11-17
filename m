From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:03 +0100
Subject: [PATCH 14/21] ARM: ux500: move the WLAN GPIO pin setup to the device
 tree
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-15-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves some of the pin setup related to the CW1200 WLAN
module over to the device tree. As the driver is not yet
activated for the CW1200 WLAN we do not assign this pinctrl
state to any device node yet.

Get rid of the cmdline argument passing of a certain U9500
platform variant, as this is not supported by the kernel or
any device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 19 +++++++
 arch/arm/mach-ux500/board-mop500-pins.c        | 75 --------------------------
 2 files changed, 19 insertions(+), 75 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index 854a4a6e521e..addfcc7c2750 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -721,6 +721,25 @@
 					};
 				};
 			};
+
+			wlan {
+				wlan_default_mode: wlan_default {
+					/*
+					 * Activate this mode with the WLAN chip.
+					 * These are plain GPIO pins used by WLAN
+					 */
+					default_cfg1 {
+						ste,pins =
+						"GPIO226_AF8", /* WLAN_PMU_EN */
+						"GPIO85_D5"; /* WLAN_ENA */
+						ste,config = <&gpio_out_lo>;
+					};
+					default_cfg2 {
+						ste,pins = "GPIO4_AH6"; /* WLAN_IRQ on UART1 */
+						ste,config = <&gpio_in_pu>;
+					};
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 4535702a8e3f..d0d527a3d205 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -16,19 +16,11 @@
 
 #include "board-mop500.h"
 
-enum custom_pin_cfg_t {
-	PINS_FOR_DEFAULT,
-	PINS_FOR_U9500,
-};
-
-static enum custom_pin_cfg_t pinsfor;
-
 /* These simply sets bias for pins */
 #define BIAS(a,b) static unsigned long a[] = { b }
 
 BIAS(pd, PIN_PULL_DOWN);
 BIAS(in_pu, PIN_INPUT_PULLUP);
-BIAS(in_pd, PIN_INPUT_PULLDOWN);
 BIAS(out_lo, PIN_OUTPUT_LOW);
 
 BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
@@ -38,8 +30,6 @@ BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
 /* These also force them into GPIO mode */
 BIAS(gpio_in_pu, PIN_INPUT_PULLUP|PIN_GPIOMODE_ENABLED);
 BIAS(gpio_in_pd, PIN_INPUT_PULLDOWN|PIN_GPIOMODE_ENABLED);
-BIAS(gpio_in_pu_slpm_gpio_nopull, PIN_INPUT_PULLUP|PIN_GPIOMODE_ENABLED|PIN_SLPM_GPIO|PIN_SLPM_INPUT_NOPULL);
-BIAS(gpio_in_pd_slpm_gpio_nopull, PIN_INPUT_PULLDOWN|PIN_GPIOMODE_ENABLED|PIN_SLPM_GPIO|PIN_SLPM_INPUT_NOPULL);
 BIAS(gpio_out_hi, PIN_OUTPUT_HIGH|PIN_GPIOMODE_ENABLED);
 BIAS(gpio_out_lo, PIN_OUTPUT_LOW|PIN_GPIOMODE_ENABLED);
 
@@ -317,8 +307,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
  * and SSP1 ports (previously connected to the AB8500) as generic GPIO lines.
  */
 static struct pinctrl_map __initdata hrefv60_pinmap[] = {
-	/* Drive WLAN_ENA low */
-	DB8500_PIN_HOG("GPIO85_D5", gpio_out_lo), /* WLAN_ENA */
 	/*
 	 * XENON Flashgun on image processor GPIO (controlled from image
 	 * processor firmware), mux in these image processor GPIO lines 0
@@ -384,27 +372,6 @@ static struct pinctrl_map __initdata hrefv60_pinmap[] = {
 	DB8500_PIN_HOG("GPIO83_D3", gpio_in_pu), /* ACC_INT2 */
 };
 
-static struct pinctrl_map __initdata u9500_pinmap[] = {
-	/* WLAN_IRQ line */
-	DB8500_PIN_HOG("GPIO144_B13", gpio_in_pu),
-	/* HSI */
-	DB8500_MUX_HOG("hsir_a_1", "hsi"),
-	DB8500_MUX_HOG("hsit_a_2", "hsi"),
-	DB8500_PIN_HOG("GPIO219_AG10", in_pd), /* RX FLA0 */
-	DB8500_PIN_HOG("GPIO220_AH10", in_pd), /* RX DAT0 */
-	DB8500_PIN_HOG("GPIO221_AJ11", out_lo), /* RX RDY0 */
-	DB8500_PIN_HOG("GPIO222_AJ9", out_lo), /* TX FLA0 */
-	DB8500_PIN_HOG("GPIO223_AH9", out_lo), /* TX DAT0 */
-	DB8500_PIN_HOG("GPIO224_AG9", in_pd), /* TX RDY0 */
-	DB8500_PIN_HOG("GPIO225_AG8", in_pd), /* CAWAKE0 */
-	DB8500_PIN_HOG("GPIO226_AF8", gpio_out_hi), /* ACWAKE0 */
-};
-
-static struct pinctrl_map __initdata u8500_pinmap[] = {
-	DB8500_PIN_HOG("GPIO226_AF8", gpio_out_lo), /* WLAN_PMU_EN */
-	DB8500_PIN_HOG("GPIO4_AH6", gpio_in_pu), /* WLAN_IRQ */
-};
-
 static struct pinctrl_map __initdata snowball_pinmap[] = {
 	/* Mux in SSP0 connected to AB8500, pull down RXD pin */
 	DB8500_MUX_HOG("ssp0_a_1", "ssp0"),
@@ -426,47 +393,8 @@ static struct pinctrl_map __initdata snowball_pinmap[] = {
 	DB8500_PIN_HOG("GPIO216_AG12", gpio_in_pu), /* WLAN_IRQ */
 };
 
-/*
- * passing "pinsfor=" in kernel cmdline allows for custom
- * configuration of GPIOs on u8500 derived boards.
- */
-static int __init early_pinsfor(char *p)
-{
-	pinsfor = PINS_FOR_DEFAULT;
-
-	if (strcmp(p, "u9500-21") == 0)
-		pinsfor = PINS_FOR_U9500;
-
-	return 0;
-}
-early_param("pinsfor", early_pinsfor);
-
-int pins_for_u9500(void)
-{
-	if (pinsfor == PINS_FOR_U9500)
-		return 1;
-
-	return 0;
-}
-
-static void __init mop500_href_family_pinmaps_init(void)
-{
-	switch (pinsfor) {
-	case PINS_FOR_U9500:
-		pinctrl_register_mappings(u9500_pinmap,
-					  ARRAY_SIZE(u9500_pinmap));
-		break;
-	case PINS_FOR_DEFAULT:
-		pinctrl_register_mappings(u8500_pinmap,
-					  ARRAY_SIZE(u8500_pinmap));
-	default:
-		break;
-	}
-}
-
 void __init mop500_pinmaps_init(void)
 {
-	mop500_href_family_pinmaps_init();
 	if (machine_is_u8520())
 		pinctrl_register_mappings(ab8505_pinmap,
 					  ARRAY_SIZE(ab8505_pinmap));
@@ -479,8 +407,6 @@ void __init snowball_pinmaps_init(void)
 {
 	pinctrl_register_mappings(snowball_pinmap,
 				  ARRAY_SIZE(snowball_pinmap));
-	pinctrl_register_mappings(u8500_pinmap,
-				  ARRAY_SIZE(u8500_pinmap));
 	pinctrl_register_mappings(ab8500_pinmap,
 				  ARRAY_SIZE(ab8500_pinmap));
 }
@@ -489,7 +415,6 @@ void __init hrefv60_pinmaps_init(void)
 {
 	pinctrl_register_mappings(hrefv60_pinmap,
 				  ARRAY_SIZE(hrefv60_pinmap));
-	mop500_href_family_pinmaps_init();
 	pinctrl_register_mappings(ab8500_pinmap,
 				  ARRAY_SIZE(ab8500_pinmap));
 }
-- 
1.8.3.1
