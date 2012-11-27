From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 27 Nov 2012 01:03:56 -0800
Subject: [PATCH v2] ARM: eukrea_mbimx27-baseboard - use stock
 get_pendown_state() in ads7846
In-Reply-To: <20121127074209.GL10369@pengutronix.de>
References: <20121124082529.GA7687@core.coreip.homeip.net>
 <20121127074209.GL10369@pengutronix.de>
Message-ID: <20121127090356.GA25658@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default implementation matches exactly our custom one so we can switch
to using the default one. As a bonus the driver will take care of setting
GPIO line for us.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Adjusted to use IMX_GPIO_NR() macro.

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 98aef57..f361143 100644
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
+	.gpio_pendown		= IMX_GPIO_NR(4, 25),
 	.keep_vref_on		= 1,
 };
 
@@ -323,7 +307,6 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 	/* ADS7846 Touchscreen controller init */
 	mxc_gpio_mode(GPIO_PORTD | 25 | GPIO_GPIO | GPIO_IN);
-	ads7846_dev_init();
 #endif
 
 	/* SPI_CS0 init */
