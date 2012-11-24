From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 24 Nov 2012 00:25:30 -0800
Subject: [PATCH] ARM: eukrea_mbimx27-baseboard - use stock
 get_pendown_state() in ads7846
Message-ID: <20121124082529.GA7687@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default implementation matches exactly our custom one so we can switch
to using the default one. As a bonus the driver will take care of setting
GPIO line for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Not tested - no hardware, but should be fine.

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 98aef57..b20fc55 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -238,24 +238,8 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-#define ADS7846_PENDOWN (GPIO_PORTD | 25)
-
-static void __maybe_unused ads7846_dev_init(void)
-{
-	if (gpio_request(ADS7846_PENDOWN, "ADS7846 pendown") < 0) {
-		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
-		return;
-	}
-	gpio_direction_input(ADS7846_PENDOWN);
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(ADS7846_PENDOWN);
-}
-
 static struct ads7846_platform_data ads7846_config __initdata = {
-	.get_pendown_state	= ads7846_get_pendown_state,
+	.gpio_pendown		= (GPIO_PORTD | 25),
 	.keep_vref_on		= 1,
 };
 
@@ -323,7 +307,6 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 	/* ADS7846 Touchscreen controller init */
 	mxc_gpio_mode(GPIO_PORTD | 25 | GPIO_GPIO | GPIO_IN);
-	ads7846_dev_init();
 #endif
 
 	/* SPI_CS0 init */
-- 
1.7.11.7


-- 
Dmitry
