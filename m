From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  7 Sep 2010 17:32:26 +0300
Subject: [PATCH 3/3] rx1950: add UDA1380 to i2c devices list
In-Reply-To: <1283869946-28296-1-git-send-email-anarsoul@gmail.com>
References: <1283869946-28296-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1283869946-28296-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c2440/mach-rx1950.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 3328c86..d971aa9 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -30,6 +30,7 @@
 #include <linux/pwm.h>
 #include <linux/s3c_adc_battery.h>
 #include <linux/leds.h>
+#include <linux/i2c.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -58,6 +59,8 @@
 #include <plat/irq.h>
 #include <plat/ts.h>
 
+#include <sound/uda1380.h>
+
 #define LCD_PWM_PERIOD 192960
 #define LCD_PWM_DUTY 127353
 
@@ -671,11 +674,17 @@ static struct platform_device rx1950_device_gpiokeys = {
 	.dev.platform_data = &rx1950_gpio_keys_data,
 };
 
-static struct s3c2410_platform_i2c rx1950_i2c_data = {
-	.flags = 0,
-	.slave_addr = 0x42,
-	.frequency = 400 * 1000,
-	.sda_delay = S3C2410_IICLC_SDA_DELAY5 | S3C2410_IICLC_FILTER_ON,
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power	= S3C2410_GPJ(0),
+	.gpio_reset	= S3C2410_GPD(0),
+	.dac_clk	= UDA1380_DAC_CLK_SYSCLK,
+};
+
+static struct i2c_board_info rx1950_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x1a),
+		.platform_data = &uda1380_info,
+	},
 };
 
 static struct platform_device *rx1950_devices[] __initdata = {
@@ -683,6 +692,7 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
 	&s3c_device_iis,
+	&s3c_device_pcm,
 	&s3c_device_usbgadget,
 	&s3c_device_rtc,
 	&s3c_device_nand,
@@ -731,7 +741,7 @@ static void __init rx1950_init_machine(void)
 	s3c24xx_udc_set_platdata(&rx1950_udc_cfg);
 	s3c24xx_ts_set_platdata(&rx1950_ts_cfg);
 	s3c24xx_mci_set_platdata(&rx1950_mmc_cfg);
-	s3c_i2c0_set_platdata(&rx1950_i2c_data);
+	s3c_i2c0_set_platdata(NULL);
 	s3c_nand_set_platdata(&rx1950_nand_info);
 
 	/* Turn off suspend on both USB ports, and switch the
@@ -762,6 +772,9 @@ static void __init rx1950_init_machine(void)
 	WARN_ON(gpio_request(S3C2410_GPB(1), "LCD power"));
 
 	platform_add_devices(rx1950_devices, ARRAY_SIZE(rx1950_devices));
+
+	i2c_register_board_info(0, rx1950_i2c_devices,
+		ARRAY_SIZE(rx1950_i2c_devices));
 }
 
 /* H1940 and RX3715 need to reserve this for suspend */
-- 
1.7.2.2
