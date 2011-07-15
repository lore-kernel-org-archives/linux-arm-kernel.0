From: banajit.g@samsung.com (Banajit Goswami)
Date: Fri, 15 Jul 2011 20:12:44 +0530
Subject: [PATCH 4/8] ARM: S5PV210: Add PWM backlight support on Samsung
	SMDKV210 board
In-Reply-To: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
References: <1310740968-26722-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1310740968-26722-5-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight using PWM timer for
Samsung SMDKV210 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig         |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c |   54 ++++++++-------------------------
 2 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 37b5a97..79bb3a0 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -134,6 +134,7 @@ config MACH_SMDKV210
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
 	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_BACKLIGHT
 	select SAMSUNG_DEV_IDE
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index c6a9e86..c4d9b7d 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -45,6 +45,7 @@
 #include <plat/pm.h>
 #include <plat/fb.h>
 #include <plat/s5p-time.h>
+#include <plat/backlight.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -210,45 +211,6 @@ static struct s3c_fb_platdata smdkv210_lcd0_pdata __initdata = {
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
 };
 
-static int smdkv210_backlight_init(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(S5PV210_GPD0(3), "Backlight");
-	if (ret) {
-		printk(KERN_ERR "failed to request GPD for PWM-OUT 3\n");
-		return ret;
-	}
-
-	/* Configure GPIO pin with S5PV210_GPD_0_3_TOUT_3 */
-	s3c_gpio_cfgpin(S5PV210_GPD0(3), S3C_GPIO_SFN(2));
-
-	return 0;
-}
-
-static void smdkv210_backlight_exit(struct device *dev)
-{
-	s3c_gpio_cfgpin(S5PV210_GPD0(3), S3C_GPIO_OUTPUT);
-	gpio_free(S5PV210_GPD0(3));
-}
-
-static struct platform_pwm_backlight_data smdkv210_backlight_data = {
-	.pwm_id		= 3,
-	.max_brightness	= 255,
-	.dft_brightness	= 255,
-	.pwm_period_ns	= 78770,
-	.init		= smdkv210_backlight_init,
-	.exit		= smdkv210_backlight_exit,
-};
-
-static struct platform_device smdkv210_backlight_device = {
-	.name		= "pwm-backlight",
-	.dev		= {
-		.parent		= &s3c_device_timer[3].dev,
-		.platform_data	= &smdkv210_backlight_data,
-	},
-};
-
 static struct platform_device *smdkv210_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_cfcon,
@@ -270,8 +232,6 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 	&samsung_device_keypad,
 	&smdkv210_dm9000,
 	&smdkv210_lcd_lte480wv,
-	&s3c_device_timer[3],
-	&smdkv210_backlight_device,
 };
 
 static void __init smdkv210_dm9000_init(void)
@@ -310,6 +270,16 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.oversampling_shift	= 2,
 };
 
+/* LCD Backlight data */
+static struct samsung_bl_gpio_info smdkv210_bl_gpio_info = {
+	.no = S5PV210_GPD0(3),
+	.func = S3C_GPIO_SFN(2),
+};
+
+static struct platform_pwm_backlight_data smdkv210_bl_data = {
+	.pwm_id = 3,
+};
+
 static void __init smdkv210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -341,6 +311,8 @@ static void __init smdkv210_machine_init(void)
 
 	s3c_fb_set_platdata(&smdkv210_lcd0_pdata);
 
+	samsung_bl_set(&smdkv210_bl_gpio_info, &smdkv210_bl_data);
+
 	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
 }
 
-- 
1.7.2.3
