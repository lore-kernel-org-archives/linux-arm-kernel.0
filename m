From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 13 Jul 2010 02:15:28 +0200
Subject: [PATCH] ARM: S3C6410: Move SmartQ LCD control platform definition to
	shared file
Message-ID: <4c3bb022.487e0e0a.085f.ffffcf37@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This shares the common LCD control platform definition used in the SmartQ 5 and
7. This also corrects it as a GPIO bitbanged SPI device instead of an I?C one,
which was wrong.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smartq.c  |   32 ++++++++++++++++++++++++++++++--
 arch/arm/mach-s3c64xx/mach-smartq5.c |   28 ----------------------------
 arch/arm/mach-s3c64xx/mach-smartq7.c |   28 ----------------------------
 3 files changed, 30 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 028d080..54309da 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/pwm_backlight.h>
 #include <linux/serial_core.h>
+#include <linux/spi/spi_gpio.h>
 #include <linux/usb/gpio_vbus.h>
 
 #include <asm/mach-types.h>
@@ -184,6 +185,33 @@ static struct s3c_hwmon_pdata smartq_hwmon_pdata __initdata = {
 	},
 };
 
+static int __init smartq_lcd_setup_gpio(void)
+{
+	int ret;
+
+	ret = gpio_request(S3C64XX_GPM(3), "LCD power");
+	if (ret < 0)
+		return ret;
+
+	/* turn power off */
+	gpio_direction_output(S3C64XX_GPM(3), 0);
+
+	return 0;
+}
+
+/* GPM0 -> CS */
+static struct spi_gpio_platform_data smartq_lcd_control = {
+	.sck			= S3C64XX_GPM(1),
+	.mosi			= S3C64XX_GPM(2),
+	.miso			= S3C64XX_GPM(2),
+};
+
+static struct platform_device smartq_lcd_control_device = {
+	.name			= "spi-gpio",
+	.id			= 1,
+	.dev.platform_data	= &smartq_lcd_control,
+};
+
 static void smartq_lcd_power_set(struct plat_lcd_data *pd, unsigned int power)
 {
 	gpio_direction_output(S3C64XX_GPM(3), power);
@@ -199,7 +227,6 @@ static struct platform_device smartq_lcd_power_device = {
 	.dev.platform_data	= &smartq_lcd_power_data,
 };
 
-
 static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_hsmmc1,	/* Init iNAND first, ... */
 	&s3c_device_hsmmc0,	/* ... then the external SD card */
@@ -214,6 +241,7 @@ static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_ts,
 	&s3c_device_usb_hsotg,
 	&smartq_backlight_device,
+	&smartq_lcd_control_device,
 	&smartq_lcd_power_device,
 	&smartq_usb_otg_vbus_dev,
 };
@@ -252,7 +280,6 @@ static int __init smartq_power_off_init(void)
 	/* leave power on */
 	gpio_direction_output(S3C64XX_GPK(15), 0);
 
-
 	pm_power_off = smartq_power_off;
 
 	return ret;
@@ -354,6 +381,7 @@ void __init smartq_machine_init(void)
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c24xx_ts_set_platdata(&smartq_touchscreen_pdata);
 
+	WARN_ON(smartq_lcd_setup_gpio());
 	WARN_ON(smartq_power_off_init());
 	WARN_ON(smartq_usb_host_init());
 	WARN_ON(smartq_usb_otg_init());
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 1d0326e..82a9043 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -12,7 +12,6 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
-#include <linux/i2c-gpio.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/leds.h>
@@ -33,31 +32,6 @@
 
 #include "mach-smartq.h"
 
-static void __init smartq5_lcd_setup_gpio(void)
-{
-	gpio_request(S3C64XX_GPM(0), "LCD SCEN pin");
-	gpio_request(S3C64XX_GPM(1), "LCD SCL pin");
-	gpio_request(S3C64XX_GPM(2), "LCD SDA pin");
-	gpio_request(S3C64XX_GPM(3), "LCD power");
-
-	/* turn power off */
-	gpio_direction_output(S3C64XX_GPM(0), 1);
-	gpio_direction_input(S3C64XX_GPM(1));
-	gpio_direction_input(S3C64XX_GPM(2));
-	gpio_direction_output(S3C64XX_GPM(3), 0);
-}
-
-static struct i2c_gpio_platform_data smartq5_lcd_control = {
-	.sda_pin		= S3C64XX_GPM(2),
-	.scl_pin		= S3C64XX_GPM(1),
-};
-
-static struct platform_device smartq5_lcd_control_device = {
-	.name			= "i2c-gpio",
-	.id			= 1,
-	.dev.platform_data	= &smartq5_lcd_control,
-};
-
 static struct gpio_led smartq5_leds[] __initdata = {
 	{
 		.name			= "smartq5:green",
@@ -160,7 +134,6 @@ static struct s3c_fb_platdata smartq5_lcd_pdata __initdata = {
 static struct platform_device *smartq5_devices[] __initdata = {
 	&smartq5_leds_device,
 	&smartq5_buttons_device,
-	&smartq5_lcd_control_device,
 };
 
 static void __init smartq5_machine_init(void)
@@ -168,7 +141,6 @@ static void __init smartq5_machine_init(void)
 	s3c_fb_set_platdata(&smartq5_lcd_pdata);
 
 	smartq_machine_init();
-	smartq5_lcd_setup_gpio();
 
 	platform_add_devices(smartq5_devices, ARRAY_SIZE(smartq5_devices));
 }
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index e0bc78e..c4868db 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -12,7 +12,6 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
-#include <linux/i2c-gpio.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/leds.h>
@@ -33,31 +32,6 @@
 
 #include "mach-smartq.h"
 
-static void __init smartq7_lcd_setup_gpio(void)
-{
-	gpio_request(S3C64XX_GPM(0), "LCD CSB pin");
-	gpio_request(S3C64XX_GPM(3), "LCD power");
-	gpio_request(S3C64XX_GPM(4), "LCD power status");
-
-	/* turn power off */
-	gpio_direction_output(S3C64XX_GPM(0), 1);
-	gpio_direction_output(S3C64XX_GPM(3), 0);
-	gpio_direction_input(S3C64XX_GPM(4));
-}
-
-static struct i2c_gpio_platform_data smartq7_lcd_control = {
-	.sda_pin		= S3C64XX_GPM(2),
-	.scl_pin		= S3C64XX_GPM(1),
-	.sda_is_open_drain	= 1,
-	.scl_is_open_drain	= 1,
-};
-
-static struct platform_device smartq7_lcd_control_device = {
-	.name			= "i2c-gpio",
-	.id			= 1,
-	.dev.platform_data	= &smartq7_lcd_control,
-};
-
 static struct gpio_led smartq7_leds[] __initdata = {
 	{
 		.name			= "smartq7:red",
@@ -176,7 +150,6 @@ static struct s3c_fb_platdata smartq7_lcd_pdata __initdata = {
 static struct platform_device *smartq7_devices[] __initdata = {
 	&smartq7_leds_device,
 	&smartq7_buttons_device,
-	&smartq7_lcd_control_device,
 };
 
 static void __init smartq7_machine_init(void)
@@ -184,7 +157,6 @@ static void __init smartq7_machine_init(void)
 	s3c_fb_set_platdata(&smartq7_lcd_pdata);
 
 	smartq_machine_init();
-	smartq7_lcd_setup_gpio();
 
 	platform_add_devices(smartq7_devices, ARRAY_SIZE(smartq7_devices));
 }
-- 
1.7.0.4
