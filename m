From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sat, 3 Jul 2010 01:40:24 +0200
Subject: [PATCH 2/2] ARM: S3C64XX: Add audio support to SmartQ
Message-ID: <4c2e7f40.d37b0e0a.2178.3d69@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the I?C board information for the WM8987 used in the SmartQ as audio
codec and adds the I?C/I?S platform drivers.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smartq.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 028d080..ee77255 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -199,6 +199,9 @@ static struct platform_device smartq_lcd_power_device = {
 	.dev.platform_data	= &smartq_lcd_power_data,
 };
 
+static struct i2c_board_info smartq_i2c_devs[] __initdata = {
+	{ I2C_BOARD_INFO("wm8750", 0x1a), },
+};
 
 static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_hsmmc1,	/* Init iNAND first, ... */
@@ -213,6 +216,7 @@ static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_timer[1],
 	&s3c_device_ts,
 	&s3c_device_usb_hsotg,
+	&s3c64xx_device_iis0,
 	&smartq_backlight_device,
 	&smartq_lcd_power_device,
 	&smartq_usb_otg_vbus_dev,
@@ -354,6 +358,9 @@ void __init smartq_machine_init(void)
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c24xx_ts_set_platdata(&smartq_touchscreen_pdata);
 
+	i2c_register_board_info(0, smartq_i2c_devs,
+				ARRAY_SIZE(smartq_i2c_devs));
+
 	WARN_ON(smartq_power_off_init());
 	WARN_ON(smartq_usb_host_init());
 	WARN_ON(smartq_usb_otg_init());
-- 
1.7.0.4
