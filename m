From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 12 Sep 2010 00:46:40 +0300
Subject: [PATCH v2 5/5] h1940: add UDA1380 to i2c devices list
In-Reply-To: <1283871605-32068-6-git-send-email-anarsoul@gmail.com>
References: <1283871605-32068-6-git-send-email-anarsoul@gmail.com>
Message-ID: <1284241600-32738-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2: add uda1380 reset pin

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2410/mach-h1940.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index e60177b..723f314 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/pwm_backlight.h>
+#include <linux/i2c.h>
 #include <video/platform_lcd.h>
 
 #include <linux/mmc/host.h>
@@ -59,6 +60,8 @@
 #include <plat/mci.h>
 #include <plat/ts.h>
 
+#include <sound/uda1380.h>
+
 #define H1940_LATCH		((void __force __iomem *)0xF8000000)
 
 #define H1940_PA_LATCH		S3C2410_CS2
@@ -365,12 +368,26 @@ static struct platform_device h1940_lcd_powerdev = {
 	.dev.platform_data      = &h1940_lcd_power_data,
 };
 
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power	= H1940_LATCH_UDA_POWER,
+	.gpio_reset	= S3C2410_GPA(12),
+	.dac_clk	= UDA1380_DAC_CLK_SYSCLK,
+};
+
+static struct i2c_board_info h1940_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x1a),
+		.platform_data = &uda1380_info,
+	},
+};
+
 static struct platform_device *h1940_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
+	&s3c_device_pcm,
 	&s3c_device_usbgadget,
 	&h1940_device_leds,
 	&h1940_device_bluetooth,
@@ -465,6 +482,9 @@ static void __init h1940_init(void)
 	gpio_direction_output(H1940_LATCH_SD_POWER, 0);
 
 	platform_add_devices(h1940_devices, ARRAY_SIZE(h1940_devices));
+
+	i2c_register_board_info(0, h1940_i2c_devices,
+		ARRAY_SIZE(h1940_i2c_devices));
 }
 
 MACHINE_START(H1940, "IPAQ-H1940")
-- 
1.7.2.2
