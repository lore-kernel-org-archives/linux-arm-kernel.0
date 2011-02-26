From: banajit.g@samsung.com (Banajit Goswami)
Date: Sat, 26 Feb 2011 13:29:05 +0900
Subject: [PATCH 5/6] ARM: S5PC100: Add PWM backlight support on SMDKC100
In-Reply-To: <1298694546-16816-1-git-send-email-banajit.g@samsung.com>
References: <1298694546-16816-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1298694546-16816-6-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight using PWM timer for
Samsung SMDKC100 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig         |    1 +
 arch/arm/mach-s5pc100/mach-smdkc100.c |   48 ++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index b8fbf2f..608722f 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -58,6 +58,7 @@ config MACH_SMDKC100
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_IDE
 	select SAMSUNG_DEV_KEYPAD
+	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index dd192a2..22d5348 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -23,12 +23,15 @@
 #include <linux/fb.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include <mach/map.h>
 #include <mach/regs-fb.h>
+#include <mach/regs-gpio.h>
+
 #include <video/platform_lcd.h>
 
 #include <asm/irq.h>
@@ -107,9 +110,6 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 static void smdkc100_lcd_power_set(struct plat_lcd_data *pd,
 				   unsigned int power)
 {
-	/* backlight */
-	gpio_direction_output(S5PC100_GPD(0), power);
-
 	if (power) {
 		/* module reset */
 		gpio_direction_output(S5PC100_GPH0(6), 1);
@@ -178,6 +178,44 @@ static struct samsung_keypad_platdata smdkc100_keypad_data __initdata = {
 	.rows		= 2,
 	.cols		= 8,
 };
+
+static int smdkc100_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(S5PC100_GPD(0), "Backlight");
+	if (ret) {
+		printk(KERN_ERR "failed to request GPF for PWM-OUT0\n");
+		return ret;
+	}
+
+	/* Configure GPIO pin with S5PC100_GPD_TOUT_0 */
+	s3c_gpio_cfgpin(S5PC100_GPD(0), (0x2 << 0));
+
+	return 0;
+}
+
+static void smdkc100_backlight_exit(struct device *dev)
+{
+	s3c_gpio_cfgpin(S5PC100_GPD(0), S3C_GPIO_OUTPUT);
+	gpio_free(S5PC100_GPD(0));
+}
+
+static struct platform_pwm_backlight_data smdkc100_backlight_data = {
+	.pwm_id		= 0,
+	.max_brightness	= 255,
+	.dft_brightness	= 255,
+	.pwm_period_ns	= 78770,
+	.init		= smdkc100_backlight_init,
+	.exit		= smdkc100_backlight_exit,
+};
+
+static struct platform_device smdkc100_backlight_device = {
+	.name		= "pwm-backlight",
+	.dev		= {
+		.parent		= &s3c_device_timer[0].dev,
+		.platform_data	= &smdkc100_backlight_data,
+	},
+};
 
 static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_adc,
@@ -200,6 +238,9 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
 	&s5pc100_device_spdif,
+	&s3c_device_timer[0],
+	&s3c_device_timer[1],
+	&smdkc100_backlight_device,
 };
 
 static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
@@ -233,7 +274,6 @@ static void __init smdkc100_machine_init(void)
 	s5pc100_spdif_setup_gpio(S5PC100_SPDIF_GPD);
 
 	/* LCD init */
-	gpio_request(S5PC100_GPD(0), "GPD");
 	gpio_request(S5PC100_GPH0(6), "GPH0");
 	smdkc100_lcd_power_set(&smdkc100_lcd_power_data, 0);
 	platform_add_devices(smdkc100_devices, ARRAY_SIZE(smdkc100_devices));
-- 
1.6.5.2
