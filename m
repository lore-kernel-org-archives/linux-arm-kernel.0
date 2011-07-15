From: banajit.g@samsung.com (Banajit Goswami)
Date: Fri, 15 Jul 2011 20:12:45 +0530
Subject: [PATCH 5/8] ARM: S5PC100: Add PWM backlight support on Samsung
	SMDKC100 board
In-Reply-To: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
References: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1310740968-26722-6-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight using PWM timer for
Samsung SMDKC100 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig         |    1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c |   55 ++++++++------------------------
 2 files changed, 15 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 608722f..e8a33c4 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -56,6 +56,7 @@ config MACH_SMDKC100
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
 	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_IDE
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 0525cb3..c89d6ec 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -51,6 +51,7 @@
 #include <plat/keypad.h>
 #include <plat/ts.h>
 #include <plat/audio.h>
+#include <plat/backlight.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -179,45 +180,6 @@ static struct samsung_keypad_platdata smdkc100_keypad_data __initdata = {
 	.cols		= 8,
 };
 
-static int smdkc100_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(S5PC100_GPD(0), "Backlight");
-	if (ret) {
-		printk(KERN_ERR "failed to request GPF for PWM-OUT0\n");
-		return ret;
-	}
-
-	/* Configure GPIO pin with S5PC100_GPD_TOUT_0 */
-	s3c_gpio_cfgpin(S5PC100_GPD(0), S3C_GPIO_SFN(2));
-
-	return 0;
-}
-
-static void smdkc100_backlight_exit(struct device *dev)
-{
-	s3c_gpio_cfgpin(S5PC100_GPD(0), S3C_GPIO_OUTPUT);
-	gpio_free(S5PC100_GPD(0));
-}
-
-static struct platform_pwm_backlight_data smdkc100_backlight_data = {
-	.pwm_id		= 0,
-	.max_brightness	= 255,
-	.dft_brightness	= 255,
-	.pwm_period_ns	= 78770,
-	.init		= smdkc100_backlight_init,
-	.exit		= smdkc100_backlight_exit,
-};
-
-static struct platform_device smdkc100_backlight_device = {
-	.name		= "pwm-backlight",
-	.dev		= {
-		.parent		= &s3c_device_timer[0].dev,
-		.platform_data	= &smdkc100_backlight_data,
-	},
-};
-
 static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_cfcon,
@@ -239,8 +201,6 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
 	&s5pc100_device_spdif,
-	&s3c_device_timer[0],
-	&smdkc100_backlight_device,
 };
 
 static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
@@ -249,6 +209,16 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.oversampling_shift	= 2,
 };
 
+/* LCD Backlight data */
+static struct samsung_bl_gpio_info smdkc100_bl_gpio_info = {
+	.no = S5PC100_GPD(0),
+	.func = S3C_GPIO_SFN(2),
+};
+
+static struct platform_pwm_backlight_data smdkc100_bl_data = {
+	.pwm_id = 0,
+};
+
 static void __init smdkc100_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -276,6 +246,9 @@ static void __init smdkc100_machine_init(void)
 	/* LCD init */
 	gpio_request(S5PC100_GPH0(6), "GPH0");
 	smdkc100_lcd_power_set(&smdkc100_lcd_power_data, 0);
+
+	samsung_bl_set(&smdkc100_bl_gpio_info, &smdkc100_bl_data);
+
 	platform_add_devices(smdkc100_devices, ARRAY_SIZE(smdkc100_devices));
 }
 
-- 
1.7.2.3
