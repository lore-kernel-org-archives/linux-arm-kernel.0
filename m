From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 28 May 2011 21:05:03 +0200
Subject: [PATCH 3/3] ARM: mxs/tx28: convert to new leds-gpio registration
	helper
In-Reply-To: <1306609503-31746-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1306609503-31746-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1306609503-31746-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to move the led definition to .init.rodata.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/Kconfig     |    1 +
 arch/arm/mach-mxs/mach-tx28.c |    5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index f114960..162b0b0 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -55,6 +55,7 @@ config MACH_MX28EVK
 config MODULE_TX28
 	bool
 	select SOC_IMX28
+	select LEDS_GPIO_REGISTER
 	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index b65e371..fff6b17 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -117,7 +117,7 @@ static const iomux_cfg_t tx28_stk5v3_pads[] __initconst = {
 		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
 };
 
-static struct gpio_led tx28_stk5v3_leds[] = {
+static const struct gpio_led tx28_stk5v3_leds[] __initconst = {
 	{
 		.name = "GPIO-LED",
 		.default_trigger = "heartbeat",
@@ -159,8 +159,7 @@ static void __init tx28_stk5v3_init(void)
 	/* spi via ssp will be added when available */
 	spi_register_board_info(tx28_spi_board_info,
 			ARRAY_SIZE(tx28_spi_board_info));
-	mxs_add_platform_device("leds-gpio", 0, NULL, 0,
-			&tx28_stk5v3_led_data, sizeof(tx28_stk5v3_led_data));
+	gpio_led_register_device(0, &tx28_stk5v3_led_data);
 	mx28_add_mxs_i2c(0);
 	i2c_register_board_info(0, tx28_stk5v3_i2c_boardinfo,
 			ARRAY_SIZE(tx28_stk5v3_i2c_boardinfo));
-- 
1.7.2.5
