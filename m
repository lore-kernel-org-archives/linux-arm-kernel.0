From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 13 Aug 2010 21:17:59 +0200
Subject: [PATCH 4/5] ARM: S3C64XX: Add audio support to SmartQ
Message-ID: <4c659a6d.cf7d0e0a.0e01.ffffcf25@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the I?C board information for the WM8987 used in the SmartQ as audio
codec and adds the I?C/I?S platform drivers.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smartq.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 20ddce6..3a9639b 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -227,6 +227,10 @@ static struct platform_device smartq_lcd_power_device = {
 	.dev.platform_data	= &smartq_lcd_power_data,
 };
 
+static struct i2c_board_info smartq_i2c_devs[] __initdata = {
+	{ I2C_BOARD_INFO("wm8987", 0x1a), },
+};
+
 static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_hsmmc1,	/* Init iNAND first, ... */
 	&s3c_device_hsmmc0,	/* ... then the external SD card */
@@ -240,6 +244,7 @@ static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_timer[1],
 	&s3c_device_ts,
 	&s3c_device_usb_hsotg,
+	&s3c64xx_device_iis0,
 	&smartq_backlight_device,
 	&smartq_lcd_control_device,
 	&smartq_lcd_power_device,
@@ -381,6 +386,9 @@ void __init smartq_machine_init(void)
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c24xx_ts_set_platdata(&smartq_touchscreen_pdata);
 
+	i2c_register_board_info(0, smartq_i2c_devs,
+				ARRAY_SIZE(smartq_i2c_devs));
+
 	WARN_ON(smartq_lcd_setup_gpio());
 	WARN_ON(smartq_power_off_init());
 	WARN_ON(smartq_usb_host_init());
-- 
1.7.0.4
