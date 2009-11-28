From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 28 Nov 2009 04:05:30 +0100
Subject: [PATCH] ARM: gta02: Add LED support
In-Reply-To: <1259377532-8012-2-git-send-email-lars@metafoo.de>
References: <1259377532-8012-1-git-send-email-lars@metafoo.de>
	<1259377532-8012-2-git-send-email-lars@metafoo.de>
Message-ID: <1259377532-8012-3-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the LEDs found on the gta02 smartphone.
There are three leds in total. Two of the are going to be controlled by leds-pwm
driver. One by the leds-gpio driver.
In theory all LEDs could be driven by the pwm driver, but one the pwm timers is
needed for other purposes, so we stick to a simple gpio driven led here.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-By: Nelson Castillo <arhuaco@freaks-unidos.net>
---
 arch/arm/mach-s3c2442/mach-gta02.c |   70 ++++++++++++++++++++++++++++++++---
 1 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
index 0f0c619..6f08dca 100644
--- a/arch/arm/mach-s3c2442/mach-gta02.c
+++ b/arch/arm/mach-s3c2442/mach-gta02.c
@@ -60,6 +60,9 @@
 
 #include <linux/gpio_keys.h>
 
+#include <linux/leds.h>
+#include <linux/leds_pwm.h>
+
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -409,11 +412,6 @@ static struct platform_device gta02_nor_flash = {
 };
 
 
-struct platform_device s3c24xx_pwm_device = {
-	.name		= "s3c24xx_pwm",
-	.num_resources	= 0,
-};
-
 static struct i2c_board_info gta02_i2c_devs[] __initdata = {
 	{
 		I2C_BOARD_INFO("pcf50633", 0x73),
@@ -583,6 +581,61 @@ static struct platform_device gta02_buttons_device = {
 	},
 };
 
+/* LEDs */
+static struct gpio_led gta02_gpio_leds[] = {
+	{
+		.name = "gta02:red:aux",
+		.gpio = GTA02_GPIO_AUX_LED,
+	},
+};
+
+static struct gpio_led_platform_data gta02_gpio_leds_pdata = {
+	.leds = gta02_gpio_leds,
+	.num_leds = ARRAY_SIZE(gta02_gpio_leds),
+};
+
+static struct platform_device gta02_leds_device = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev = {
+		.platform_data = &gta02_gpio_leds_pdata,
+	},
+};
+
+static struct led_pwm gta02_pwm_leds[] = {
+	{
+		.name = "gta02:orange:power",
+		.max_brightness = 0xff,
+		.pwm_period_ns = 1000000,
+		.pwm_id = 0,
+	},
+	{
+		.name = "gta02:blue:power",
+		.max_brightness = 0xff,
+		.pwm_period_ns = 1000000,
+		.pwm_id = 1,
+	},
+};
+
+static struct led_pwm_platform_data gta02_pwm_leds_pdata = {
+	.num_leds = ARRAY_SIZE(gta02_pwm_leds),
+	.leds = gta02_pwm_leds,
+};
+
+static struct platform_device gta02_pwm_leds_device = {
+	.name	= "leds_pwm",
+	.id	= -1,
+	.dev = {
+		.platform_data = &gta02_pwm_leds_pdata,
+	}
+};
+
+static void gta02_enable_pwm_pins(void)
+{
+	s3c2410_gpio_cfgpin(GTA02_GPIO_PWR_LED1, S3C2410_GPB0_TOUT0);
+	s3c2410_gpio_cfgpin(GTA02_GPIO_PWR_LED2, S3C2410_GPB1_TOUT1);
+}
+
 static void __init gta02_map_io(void)
 {
 	s3c24xx_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
@@ -600,10 +653,13 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&s3c_device_usbgadget,
 	&s3c_device_nand,
 	&gta02_nor_flash,
-	&s3c24xx_pwm_device,
+	&s3c_device_timer[0],
+	&s3c_device_timer[1],
 	&s3c_device_iis,
 	&s3c_device_i2c0,
 	&gta02_buttons_device,
+	&gta02_leds_device,
+	&gta02_pwm_leds_device,
 };
 
 /* These guys DO need to be children of PMU. */
@@ -662,6 +718,8 @@ static void __init gta02_machine_init(void)
 	i2c_register_board_info(0, gta02_i2c_devs, ARRAY_SIZE(gta02_i2c_devs));
 
 	platform_add_devices(gta02_devices, ARRAY_SIZE(gta02_devices));
+	gta02_enable_pwm_pins();
+
 	pm_power_off = gta02_poweroff;
 }
 
-- 
1.5.6.5
