From: banajit.g@samsung.com (Banajit Goswami)
Date: Wed,  2 Mar 2011 16:27:23 +0900
Subject: [PATCH V2 2/6] ARM: SAMSUNG: Add PWM backlight support on Samsung
	S3C6410
Message-ID: <1299050847-16148-1-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight using PWM timer for
Samsung SMDK6410 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
Changes since v1:
- Used common GPIO macro
- Removed redundant timers

 arch/arm/mach-s3c64xx/Kconfig         |    1 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   45 ++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f3a953f..e4177e2 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -143,6 +143,7 @@ config MACH_SMDK6410
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
 	select SAMSUNG_DEV_KEYPAD
+	select SAMSUNG_DEV_PWM
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index e85192a..4a3fe0c 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -28,6 +28,7 @@
 #include <linux/delay.h>
 #include <linux/smsc911x.h>
 #include <linux/regulator/fixed.h>
+#include <linux/pwm_backlight.h>
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #include <linux/mfd/wm8350/core.h>
@@ -48,6 +49,7 @@
 #include <mach/hardware.h>
 #include <mach/regs-fb.h>
 #include <mach/map.h>
+#include <mach/gpio-bank-f.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -118,7 +120,6 @@ static void smdk6410_lcd_power_set(struct plat_lcd_data *pd,
 {
 	if (power) {
 		gpio_direction_output(S3C64XX_GPF(13), 1);
-		gpio_direction_output(S3C64XX_GPF(15), 1);
 
 		/* fire nRESET on power up */
 		gpio_direction_output(S3C64XX_GPN(5), 0);
@@ -126,7 +127,6 @@ static void smdk6410_lcd_power_set(struct plat_lcd_data *pd,
 		gpio_direction_output(S3C64XX_GPN(5), 1);
 		msleep(1);
 	} else {
-		gpio_direction_output(S3C64XX_GPF(15), 0);
 		gpio_direction_output(S3C64XX_GPF(13), 0);
 	}
 }
@@ -269,6 +269,45 @@ static struct samsung_keypad_platdata smdk6410_keypad_data __initdata = {
 	.cols		= 8,
 };
 
+static int smdk6410_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(S3C64XX_GPF(15), "Backlight");
+	if (ret) {
+		printk(KERN_ERR "failed to request GPF for PWM-OUT1\n");
+		return ret;
+	}
+
+	/* Configure GPIO pin with S3C64XX_GPF15_PWM_TOUT1 */
+	s3c_gpio_cfgpin(S3C64XX_GPF(15), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+static void smdk6410_backlight_exit(struct device *dev)
+{
+	s3c_gpio_cfgpin(S3C64XX_GPF(15), S3C_GPIO_OUTPUT);
+	gpio_free(S3C64XX_GPF(15));
+}
+
+static struct platform_pwm_backlight_data smdk6410_backlight_data = {
+	.pwm_id		= 1,
+	.max_brightness	= 255,
+	.dft_brightness	= 255,
+	.pwm_period_ns	= 78770,
+	.init		= smdk6410_backlight_init,
+	.exit		= smdk6410_backlight_exit,
+};
+
+static struct platform_device smdk6410_backlight_device = {
+	.name		= "pwm-backlight",
+	.dev		= {
+		.parent		= &s3c_device_timer[1].dev,
+		.platform_data	= &smdk6410_backlight_data,
+	},
+};
+
 static struct map_desc smdk6410_iodesc[] = {};
 
 static struct platform_device *smdk6410_devices[] __initdata = {
@@ -298,6 +337,8 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_rtc,
 	&s3c_device_ts,
 	&s3c_device_wdt,
+	&s3c_device_timer[1],
+	&smdk6410_backlight_device,
 };
 
 #ifdef CONFIG_REGULATOR
@@ -693,7 +735,6 @@ static void __init smdk6410_machine_init(void)
 
 	gpio_request(S3C64XX_GPN(5), "LCD power");
 	gpio_request(S3C64XX_GPF(13), "LCD power");
-	gpio_request(S3C64XX_GPF(15), "LCD power");
 
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
-- 
1.6.5.2
