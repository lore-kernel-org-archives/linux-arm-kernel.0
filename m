From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 17 Nov 2013 12:04:00 +0100
Subject: [PATCH 11/21] ARM: ux500: drop STM pinmap settings
In-Reply-To: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
References: <1384686250-10542-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1384686250-10542-12-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pin mappings for the STM (System Trace Macrocell) are not
really used by anything: we have no driver for is and the settings
are not connected to any device. We can recreate the different
mux outputs in the device tree the day we need them. Drop these
for now.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 200 --------------------------------
 1 file changed, 200 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 07ddb89a6dbe..c311d11d6c3d 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -27,7 +27,6 @@ static enum custom_pin_cfg_t pinsfor;
 #define BIAS(a,b) static unsigned long a[] = { b }
 
 BIAS(pd, PIN_PULL_DOWN);
-BIAS(in_nopull, PIN_INPUT_NOPULL);
 BIAS(in_pu, PIN_INPUT_PULLUP);
 BIAS(in_pd, PIN_INPUT_PULLDOWN);
 BIAS(out_lo, PIN_OUTPUT_LOW);
@@ -43,15 +42,6 @@ BIAS(gpio_in_pu_slpm_gpio_nopull, PIN_INPUT_PULLUP|PIN_GPIOMODE_ENABLED|PIN_SLPM
 BIAS(gpio_in_pd_slpm_gpio_nopull, PIN_INPUT_PULLDOWN|PIN_GPIOMODE_ENABLED|PIN_SLPM_GPIO|PIN_SLPM_INPUT_NOPULL);
 BIAS(gpio_out_hi, PIN_OUTPUT_HIGH|PIN_GPIOMODE_ENABLED);
 BIAS(gpio_out_lo, PIN_OUTPUT_LOW|PIN_GPIOMODE_ENABLED);
-/* Sleep modes */
-BIAS(slpm_in_wkup_pdis, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_DIR_INPUT|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_out_lo_pdis, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_DISABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_out_lo_wkup_pdis, PIN_SLEEPMODE_ENABLED|
-	PIN_SLPM_OUTPUT_LOW|PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_DISABLED);
-BIAS(slpm_in_pu_wkup_pdis_en, PIN_SLEEPMODE_ENABLED|PIN_SLPM_INPUT_PULLUP|
-	PIN_SLPM_WAKEUP_ENABLE|PIN_SLPM_PDIS_ENABLED);
 
 /* We use these to define hog settings that are always done on boot */
 #define DB8500_MUX_HOG(group,func) \
@@ -321,190 +311,6 @@ static struct pinctrl_map __initdata ab8505_pinmap[] = {
 	AB8505_PIN_HOG("GPIO53_D15", in_pd),
 };
 
-/* Pin control settings */
-static struct pinctrl_map __initdata mop500_family_pinmap[] = {
-	/* STM APE pins states */
-	DB8500_MUX_STATE("stmape_c_1", "stmape",
-		"stm", "ape_mipi34"),
-	DB8500_PIN_STATE("GPIO70_G5", in_nopull,
-		"stm", "ape_mipi34"), /* clk */
-	DB8500_PIN_STATE("GPIO71_G4", in_nopull,
-		"stm", "ape_mipi34"), /* dat3 */
-	DB8500_PIN_STATE("GPIO72_H4", in_nopull,
-		"stm", "ape_mipi34"), /* dat2 */
-	DB8500_PIN_STATE("GPIO73_H3", in_nopull,
-		"stm", "ape_mipi34"), /* dat1 */
-	DB8500_PIN_STATE("GPIO74_J3", in_nopull,
-		"stm", "ape_mipi34"), /* dat0 */
-
-	DB8500_PIN_STATE("GPIO70_G5", slpm_out_lo_pdis,
-		"stm", "ape_mipi34_sleep"), /* clk */
-	DB8500_PIN_STATE("GPIO71_G4", slpm_out_lo_pdis,
-		"stm", "ape_mipi34_sleep"), /* dat3 */
-	DB8500_PIN_STATE("GPIO72_H4", slpm_out_lo_pdis,
-		"stm", "ape_mipi34_sleep"), /* dat2 */
-	DB8500_PIN_STATE("GPIO73_H3", slpm_out_lo_pdis,
-		"stm", "ape_mipi34_sleep"), /* dat1 */
-	DB8500_PIN_STATE("GPIO74_J3", slpm_out_lo_pdis,
-		"stm", "ape_mipi34_sleep"), /* dat0 */
-
-	DB8500_MUX_STATE("stmape_oc1_1", "stmape",
-		"stm", "ape_microsd"),
-	DB8500_PIN_STATE("GPIO23_AA4", in_nopull,
-		"stm", "ape_microsd"), /* clk */
-	DB8500_PIN_STATE("GPIO25_Y4", in_nopull,
-		"stm", "ape_microsd"), /* dat0 */
-	DB8500_PIN_STATE("GPIO26_Y2", in_nopull,
-		"stm", "ape_microsd"), /* dat1 */
-	DB8500_PIN_STATE("GPIO27_AA2", in_nopull,
-		"stm", "ape_microsd"), /* dat2 */
-	DB8500_PIN_STATE("GPIO28_AA1", in_nopull,
-		"stm", "ape_microsd"), /* dat3 */
-
-	DB8500_PIN_STATE("GPIO23_AA4", slpm_out_lo_wkup_pdis,
-		"stm", "ape_microsd_sleep"), /* clk */
-	DB8500_PIN_STATE("GPIO25_Y4", slpm_in_wkup_pdis,
-		"stm", "ape_microsd_sleep"), /* dat0 */
-	DB8500_PIN_STATE("GPIO26_Y2", slpm_in_wkup_pdis,
-		"stm", "ape_microsd_sleep"), /* dat1 */
-	DB8500_PIN_STATE("GPIO27_AA2", slpm_in_wkup_pdis,
-		"stm", "ape_microsd_sleep"), /* dat2 */
-	DB8500_PIN_STATE("GPIO28_AA1", slpm_in_wkup_pdis,
-		"stm", "ape_microsd_sleep"), /* dat3 */
-
-	/*  STM Modem pins states */
-	DB8500_MUX_STATE("stmmod_oc3_2", "stmmod",
-		"stm", "mod_mipi34"),
-	DB8500_MUX_STATE("uartmodrx_oc3_1", "uartmod",
-		"stm", "mod_mipi34"),
-	DB8500_MUX_STATE("uartmodtx_oc3_1", "uartmod",
-		"stm", "mod_mipi34"),
-	DB8500_PIN_STATE("GPIO70_G5", in_nopull,
-		"stm", "mod_mipi34"), /* clk */
-	DB8500_PIN_STATE("GPIO71_G4", in_nopull,
-		"stm", "mod_mipi34"), /* dat3 */
-	DB8500_PIN_STATE("GPIO72_H4", in_nopull,
-		"stm", "mod_mipi34"), /* dat2 */
-	DB8500_PIN_STATE("GPIO73_H3", in_nopull,
-		"stm", "mod_mipi34"), /* dat1 */
-	DB8500_PIN_STATE("GPIO74_J3", in_nopull,
-		"stm", "mod_mipi34"), /* dat0 */
-	DB8500_PIN_STATE("GPIO75_H2", in_pu,
-		"stm", "mod_mipi34"), /* uartmod rx */
-	DB8500_PIN_STATE("GPIO76_J2", out_lo,
-		"stm", "mod_mipi34"), /* uartmod tx */
-
-	DB8500_PIN_STATE("GPIO70_G5", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_sleep"), /* clk */
-	DB8500_PIN_STATE("GPIO71_G4", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_sleep"), /* dat3 */
-	DB8500_PIN_STATE("GPIO72_H4", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_sleep"), /* dat2 */
-	DB8500_PIN_STATE("GPIO73_H3", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_sleep"), /* dat1 */
-	DB8500_PIN_STATE("GPIO74_J3", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_sleep"), /* dat0 */
-	DB8500_PIN_STATE("GPIO75_H2", slpm_in_wkup_pdis,
-		"stm", "mod_mipi34_sleep"), /* uartmod rx */
-	DB8500_PIN_STATE("GPIO76_J2", slpm_out_lo_wkup_pdis,
-		"stm", "mod_mipi34_sleep"), /* uartmod tx */
-
-	DB8500_MUX_STATE("stmmod_b_1", "stmmod",
-		"stm", "mod_microsd"),
-	DB8500_MUX_STATE("uartmodrx_oc3_1", "uartmod",
-		"stm", "mod_microsd"),
-	DB8500_MUX_STATE("uartmodtx_oc3_1", "uartmod",
-		"stm", "mod_microsd"),
-	DB8500_PIN_STATE("GPIO23_AA4", in_nopull,
-		"stm", "mod_microsd"), /* clk */
-	DB8500_PIN_STATE("GPIO25_Y4", in_nopull,
-		"stm", "mod_microsd"), /* dat0 */
-	DB8500_PIN_STATE("GPIO26_Y2", in_nopull,
-		"stm", "mod_microsd"), /* dat1 */
-	DB8500_PIN_STATE("GPIO27_AA2", in_nopull,
-		"stm", "mod_microsd"), /* dat2 */
-	DB8500_PIN_STATE("GPIO28_AA1", in_nopull,
-		"stm", "mod_microsd"), /* dat3 */
-	DB8500_PIN_STATE("GPIO75_H2", in_pu,
-		"stm", "mod_microsd"), /* uartmod rx */
-	DB8500_PIN_STATE("GPIO76_J2", out_lo,
-		"stm", "mod_microsd"), /* uartmod tx */
-
-	DB8500_PIN_STATE("GPIO23_AA4", slpm_out_lo_wkup_pdis,
-		"stm", "mod_microsd_sleep"), /* clk */
-	DB8500_PIN_STATE("GPIO25_Y4", slpm_in_wkup_pdis,
-		"stm", "mod_microsd_sleep"), /* dat0 */
-	DB8500_PIN_STATE("GPIO26_Y2", slpm_in_wkup_pdis,
-		"stm", "mod_microsd_sleep"), /* dat1 */
-	DB8500_PIN_STATE("GPIO27_AA2", slpm_in_wkup_pdis,
-		"stm", "mod_microsd_sleep"), /* dat2 */
-	DB8500_PIN_STATE("GPIO28_AA1", slpm_in_wkup_pdis,
-		"stm", "mod_microsd_sleep"), /* dat3 */
-	DB8500_PIN_STATE("GPIO75_H2", slpm_in_wkup_pdis,
-		"stm", "mod_microsd_sleep"), /* uartmod rx */
-	DB8500_PIN_STATE("GPIO76_J2", slpm_out_lo_wkup_pdis,
-		"stm", "mod_microsd_sleep"), /* uartmod tx */
-
-	/*  STM dual Modem/APE pins state */
-	DB8500_MUX_STATE("stmmod_oc3_2", "stmmod",
-		"stm", "mod_mipi34_ape_mipi60"),
-	DB8500_MUX_STATE("stmape_c_2", "stmape",
-		"stm", "mod_mipi34_ape_mipi60"),
-	DB8500_MUX_STATE("uartmodrx_oc3_1", "uartmod",
-		"stm", "mod_mipi34_ape_mipi60"),
-	DB8500_MUX_STATE("uartmodtx_oc3_1", "uartmod",
-		"stm", "mod_mipi34_ape_mipi60"),
-	DB8500_PIN_STATE("GPIO70_G5", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* clk */
-	DB8500_PIN_STATE("GPIO71_G4", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat3 */
-	DB8500_PIN_STATE("GPIO72_H4", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat2 */
-	DB8500_PIN_STATE("GPIO73_H3", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat1 */
-	DB8500_PIN_STATE("GPIO74_J3", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat0 */
-	DB8500_PIN_STATE("GPIO75_H2", in_pu,
-		"stm", "mod_mipi34_ape_mipi60"), /* uartmod rx */
-	DB8500_PIN_STATE("GPIO76_J2", out_lo,
-		"stm", "mod_mipi34_ape_mipi60"), /* uartmod tx */
-	DB8500_PIN_STATE("GPIO155_C19", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* clk */
-	DB8500_PIN_STATE("GPIO156_C17", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat3 */
-	DB8500_PIN_STATE("GPIO157_A18", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat2 */
-	DB8500_PIN_STATE("GPIO158_C18", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat1 */
-	DB8500_PIN_STATE("GPIO159_B19", in_nopull,
-		"stm", "mod_mipi34_ape_mipi60"), /* dat0 */
-
-	DB8500_PIN_STATE("GPIO70_G5", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* clk */
-	DB8500_PIN_STATE("GPIO71_G4", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat3 */
-	DB8500_PIN_STATE("GPIO72_H4", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat2 */
-	DB8500_PIN_STATE("GPIO73_H3", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat1 */
-	DB8500_PIN_STATE("GPIO74_J3", slpm_out_lo_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat0 */
-	DB8500_PIN_STATE("GPIO75_H2", slpm_in_wkup_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* uartmod rx */
-	DB8500_PIN_STATE("GPIO76_J2", slpm_out_lo_wkup_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* uartmod tx */
-	DB8500_PIN_STATE("GPIO155_C19", slpm_in_wkup_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* clk */
-	DB8500_PIN_STATE("GPIO156_C17", slpm_in_wkup_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat3 */
-	DB8500_PIN_STATE("GPIO157_A18", slpm_in_wkup_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat2 */
-	DB8500_PIN_STATE("GPIO158_C18", slpm_in_wkup_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat1 */
-	DB8500_PIN_STATE("GPIO159_B19", slpm_in_wkup_pdis,
-		"stm", "mod_mipi34_ape_mipi60_sleep"), /* dat0 */
-};
-
 /*
  * These are specifically for the MOP500 and HREFP (pre-v60) version of the
  * board, which utilized a TC35892 GPIO expander instead of using a lot of
@@ -690,8 +496,6 @@ static void __init mop500_href_family_pinmaps_init(void)
 
 void __init mop500_pinmaps_init(void)
 {
-	pinctrl_register_mappings(mop500_family_pinmap,
-				  ARRAY_SIZE(mop500_family_pinmap));
 	pinctrl_register_mappings(mop500_pinmap,
 				  ARRAY_SIZE(mop500_pinmap));
 	mop500_href_family_pinmaps_init();
@@ -705,8 +509,6 @@ void __init mop500_pinmaps_init(void)
 
 void __init snowball_pinmaps_init(void)
 {
-	pinctrl_register_mappings(mop500_family_pinmap,
-				  ARRAY_SIZE(mop500_family_pinmap));
 	pinctrl_register_mappings(snowball_pinmap,
 				  ARRAY_SIZE(snowball_pinmap));
 	pinctrl_register_mappings(u8500_pinmap,
@@ -717,8 +519,6 @@ void __init snowball_pinmaps_init(void)
 
 void __init hrefv60_pinmaps_init(void)
 {
-	pinctrl_register_mappings(mop500_family_pinmap,
-				  ARRAY_SIZE(mop500_family_pinmap));
 	pinctrl_register_mappings(hrefv60_pinmap,
 				  ARRAY_SIZE(hrefv60_pinmap));
 	mop500_href_family_pinmaps_init();
-- 
1.8.3.1
