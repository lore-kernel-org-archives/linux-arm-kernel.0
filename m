From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun,  8 Jul 2012 19:12:20 +0200
Subject: [PATCH 06/10] MACH/Samsung/Mini2440: use leds-gpio driver for board
 leds
In-Reply-To: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1341767544-17447-7-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Belisko <marek.belisko@open-nandra.com>

Intention of this patch is convert existing usage of leds-s3c24xx driver
to use generic gpio-leds driver. Leds are separated to 2 devices.
First device handle 4 available leds. Second device is used to drive
LCD backlight. Backlight can be controlled via parameter b so we need
separate device which is registered or not depending on parameter.

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
Acked-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c |  122 +++++++++++++++------------------
 1 file changed, 54 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 110af98..fd5fe9d 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -39,7 +39,6 @@
 
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/leds-gpio.h>
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
 #include <mach/irqs.h>
@@ -441,81 +440,71 @@ static struct platform_device mini2440_button_device = {
 };
 
 /* LEDS */
-
-static struct s3c24xx_led_platdata mini2440_led1_pdata = {
-	.name		= "led1",
-	.gpio		= S3C2410_GPB(5),
-	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
-	.def_trigger	= "heartbeat",
-};
-
-static struct s3c24xx_led_platdata mini2440_led2_pdata = {
-	.name		= "led2",
-	.gpio		= S3C2410_GPB(6),
-	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
-	.def_trigger	= "nand-disk",
-};
-
-static struct s3c24xx_led_platdata mini2440_led3_pdata = {
-	.name		= "led3",
-	.gpio		= S3C2410_GPB(7),
-	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
-	.def_trigger	= "mmc0",
-};
-
-static struct s3c24xx_led_platdata mini2440_led4_pdata = {
-	.name		= "led4",
-	.gpio		= S3C2410_GPB(8),
-	.flags		= S3C24XX_LEDF_ACTLOW | S3C24XX_LEDF_TRISTATE,
-	.def_trigger	= "",
-};
-
-static struct s3c24xx_led_platdata mini2440_led_backlight_pdata = {
-	.name		= "backlight",
-	.gpio		= S3C2410_GPG(4),
-	.def_trigger	= "backlight",
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "led1",
+		.gpio			= S3C2410_GPB(5),
+		.active_low		= 1,
+		.default_trigger	= "heartbeat",
+	},
+	{
+		.name			= "led2",
+		.gpio			= S3C2410_GPB(6),
+		.active_low		= 1,
+		.default_trigger	= "nand-disk",
+		.default_state		= LEDS_GPIO_DEFSTATE_OFF,
+	},
+	{
+		.name			= "led3",
+		.gpio			= S3C2410_GPB(7),
+		.active_low		= 1,
+		.default_trigger	= "mmc0",
+		.default_state		= LEDS_GPIO_DEFSTATE_OFF,
+	},
+	{
+		.name			= "led4",
+		.gpio			= S3C2410_GPB(8),
+		.active_low		= 1,
+		.default_trigger	= "none",
+		.default_state		= LEDS_GPIO_DEFSTATE_OFF,
+	}
 };
 
-static struct platform_device mini2440_led1 = {
-	.name		= "s3c24xx_led",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &mini2440_led1_pdata,
-	},
+static struct gpio_led backlight_led[] = {
+	{
+		.name			= "backlight",
+		.gpio			= S3C2410_GPG(4),
+		.active_low		= 0,
+		.default_trigger	= "backlight",
+		.default_state		= LEDS_GPIO_DEFSTATE_ON,
+	}
 };
 
-static struct platform_device mini2440_led2 = {
-	.name		= "s3c24xx_led",
-	.id		= 2,
-	.dev		= {
-		.platform_data	= &mini2440_led2_pdata,
-	},
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
 };
 
-static struct platform_device mini2440_led3 = {
-	.name		= "s3c24xx_led",
-	.id		= 3,
-	.dev		= {
-		.platform_data	= &mini2440_led3_pdata,
-	},
+static struct gpio_led_platform_data backlight_info = {
+	.leds		= backlight_led,
+	.num_leds	= ARRAY_SIZE(backlight_led),
 };
 
-static struct platform_device mini2440_led4 = {
-	.name		= "s3c24xx_led",
-	.id		= 4,
-	.dev		= {
-		.platform_data	= &mini2440_led4_pdata,
-	},
+static struct platform_device mini2440_leds = {
+	.name	= "leds-gpio",
+	.id	= 0,
+	.dev	= {
+		.platform_data	= &gpio_led_info,
+	}
 };
 
 static struct platform_device mini2440_led_backlight = {
-	.name		= "s3c24xx_led",
-	.id		= 5,
-	.dev		= {
-		.platform_data	= &mini2440_led_backlight_pdata,
-	},
+	.name	= "leds-gpio",
+	.id	= 1,
+	.dev	= {
+		.platform_data	= &backlight_info,
+	}
 };
-
 /* AUDIO */
 
 static struct s3c24xx_uda134x_platform_data mini2440_audio_pins = {
@@ -566,10 +555,7 @@ static struct platform_device *mini2440_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_usbgadget,
 	&mini2440_device_eth,
-	&mini2440_led1,
-	&mini2440_led2,
-	&mini2440_led3,
-	&mini2440_led4,
+	&mini2440_leds,
 	&mini2440_button_device,
 	&s3c_device_nand,
 	&s3c_device_sdi,
-- 
1.7.10
