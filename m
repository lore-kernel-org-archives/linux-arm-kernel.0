From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 10 May 2011 10:50:56 +0200
Subject: [PATCH] [wip] ARM: imx: register "leds-gpio" device using new helper
	function
In-Reply-To: <1305017456-10910-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110510073152.GF29089@pengutronix.de>
	<1305017456-10910-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1305017456-10910-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts eukrea_mbimx27-baseboard to the new helper function.

bloat-o-meter reports for this change:

	add/remove: 1/1 grow/shrink: 0/1 up/down: 128/-220 (-92)
	function                                     old     new   delta
	gpio_led_register_device                       -     128    +128
	platform_devices                              28      24      -4
	leds_gpio                                    216       -    -216

Additionally gpio_led_info (12 bytes) and gpio_leds (32 Bytes) are
initdata now as is gpio_led_register_device.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
This is just an example and probably doesn't apply to the imx tree as
is. I will convert all imx machines when there's an agreement for the
patch providing the helper function.

 arch/arm/mach-imx/Kconfig                    |    1 +
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |   18 +++---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 56b930a..ef16471 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -222,6 +222,7 @@ choice
 
 config MACH_EUKREA_MBIMX27_BASEBOARD
 	bool "Eukrea MBIMX27 development board"
+	select LEDS_GPIO_REGISTER
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_SSI
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index fa5288018..3479f66 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -113,7 +113,7 @@ eukrea_mbimx27_keymap_data __initconst = {
 	.keymap_size    = ARRAY_SIZE(eukrea_mbimx27_keymap),
 };
 
-static struct gpio_led gpio_leds[] = {
+static const struct gpio_led gpio_leds[] __initconst = {
 	{
 		.name			= "led1",
 		.default_trigger	= "heartbeat",
@@ -128,19 +128,11 @@ static struct gpio_led gpio_leds[] = {
 	},
 };
 
-static struct gpio_led_platform_data gpio_led_info = {
+static const struct gpio_led_platform_data gpio_led_info __initconst = {
 	.leds		= gpio_leds,
 	.num_leds	= ARRAY_SIZE(gpio_leds),
 };
 
-static struct platform_device leds_gpio = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &gpio_led_info,
-	},
-};
-
 static struct imx_fb_videomode eukrea_mbimx27_modes[] = {
 	{
 		.mode = {
@@ -294,10 +286,6 @@ static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
 	},
 };
 
-static struct platform_device *platform_devices[] __initdata = {
-	&leds_gpio,
-};
-
 static const struct imxmmc_platform_data sdhc_pdata __initconst = {
 	.dat3_card_detect = 1,
 };
@@ -378,5 +366,5 @@ void __init eukrea_mbimx27_baseboard_init(void)
 
 	imx27_add_imx_keypad(&eukrea_mbimx27_keymap_data);
 
-	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	gpio_led_register_device(-1, &gpio_led_info);
 }
-- 
1.7.4.1
