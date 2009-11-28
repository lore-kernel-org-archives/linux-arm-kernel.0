From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 28 Nov 2009 04:05:31 +0100
Subject: [PATCH] ARM: gta02: Add vibrator support
In-Reply-To: <1259377532-8012-3-git-send-email-lars@metafoo.de>
References: <1259377532-8012-1-git-send-email-lars@metafoo.de>
	<1259377532-8012-2-git-send-email-lars@metafoo.de>
	<1259377532-8012-3-git-send-email-lars@metafoo.de>
Message-ID: <1259377532-8012-4-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vibrator found on the gta02 is controlled by the s3c pwm controller.
Instead of writing a special vibrator driver/class the vibrator is represented
as a led device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-By: Nelson Castillo <arhuaco@freaks-unidos.net>
---
 arch/arm/mach-s3c2442/mach-gta02.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2442/mach-gta02.c b/arch/arm/mach-s3c2442/mach-gta02.c
index 6f08dca..13b14ab 100644
--- a/arch/arm/mach-s3c2442/mach-gta02.c
+++ b/arch/arm/mach-s3c2442/mach-gta02.c
@@ -615,6 +615,12 @@ static struct led_pwm gta02_pwm_leds[] = {
 		.pwm_period_ns = 1000000,
 		.pwm_id = 1,
 	},
+	{
+		.name = "gta02::vibrator",
+		.max_brightness = 0x3f,
+		.pwm_period_ns = 60000000,
+		.pwm_id = 3,
+	}
 };
 
 static struct led_pwm_platform_data gta02_pwm_leds_pdata = {
@@ -634,6 +640,7 @@ static void gta02_enable_pwm_pins(void)
 {
 	s3c2410_gpio_cfgpin(GTA02_GPIO_PWR_LED1, S3C2410_GPB0_TOUT0);
 	s3c2410_gpio_cfgpin(GTA02_GPIO_PWR_LED2, S3C2410_GPB1_TOUT1);
+	s3c2410_gpio_cfgpin(GTA02_GPIO_VIBRATOR_ON, S3C2410_GPB3_TOUT3);
 }
 
 static void __init gta02_map_io(void)
@@ -655,6 +662,7 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&gta02_nor_flash,
 	&s3c_device_timer[0],
 	&s3c_device_timer[1],
+	&s3c_device_timer[3],
 	&s3c_device_iis,
 	&s3c_device_i2c0,
 	&gta02_buttons_device,
-- 
1.5.6.5
