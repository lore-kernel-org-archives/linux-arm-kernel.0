From: banajit.g@samsung.com (Banajit Goswami)
Date: Wed,  2 Mar 2011 16:27:27 +0900
Subject: [PATCH V2 6/6] ARM: SAMSUNG: Add PWM backlight support on Samsung
	S5PV210
In-Reply-To: <1299050847-16148-1-git-send-email-banajit.g@samsung.com>
References: <1299050847-16148-1-git-send-email-banajit.g@samsung.com>
Message-ID: <1299050847-16148-5-git-send-email-banajit.g@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for LCD backlight control using PWM timer
for Samsung's SMDKV210 board.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
---
Changes since v1:
- Used common GPIO macro
- Removed redundant timers

 arch/arm/mach-s5pv210/Kconfig         |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c |   43 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 53aabef..d7fd031 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -130,6 +130,7 @@ config MACH_SMDKV210
 	select SAMSUNG_DEV_ADC
 	select SAMSUNG_DEV_IDE
 	select SAMSUNG_DEV_KEYPAD
+	select SAMSUNG_DEV_PWM
 	select SAMSUNG_DEV_TS
 	select S5PV210_SETUP_FB_24BPP
 	select S5PV210_SETUP_I2C1
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index bc9fdb5..8833e7b 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -18,6 +18,7 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
+#include <linux/pwm_backlight.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -43,6 +44,7 @@
 #include <plat/keypad.h>
 #include <plat/pm.h>
 #include <plat/fb.h>
+#include <plat/gpio-cfg.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define SMDKV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -208,6 +210,45 @@ static struct s3c_fb_platdata smdkv210_lcd0_pdata __initdata = {
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
 };
 
+static int smdkv210_backlight_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(S5PV210_GPD0(3), "Backlight");
+	if (ret) {
+		printk(KERN_ERR "failed to request GPD for PWM-OUT 3\n");
+		return ret;
+	}
+
+	/* Configure GPIO pin with S5PV210_GPD_0_3_TOUT_3 */
+	s3c_gpio_cfgpin(S5PV210_GPD0(3), S3C_GPIO_SFN(2));
+
+	return 0;
+}
+
+static void smdkv210_backlight_exit(struct device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPD0(3), S3C_GPIO_OUTPUT);
+	gpio_free(S5PV210_GPD0(3));
+}
+
+static struct platform_pwm_backlight_data smdkv210_backlight_data = {
+	.pwm_id		= 3,
+	.max_brightness	= 255,
+	.dft_brightness	= 255,
+	.pwm_period_ns	= 78770,
+	.init		= smdkv210_backlight_init,
+	.exit		= smdkv210_backlight_exit,
+};
+
+static struct platform_device smdkv210_backlight_device = {
+	.name		= "pwm-backlight",
+	.dev		= {
+		.parent		= &s3c_device_timer[3].dev,
+		.platform_data	= &smdkv210_backlight_data,
+	},
+};
+
 static struct platform_device *smdkv210_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_cfcon,
@@ -229,6 +270,8 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 	&samsung_device_keypad,
 	&smdkv210_dm9000,
 	&smdkv210_lcd_lte480wv,
+	&s3c_device_timer[3],
+	&smdkv210_backlight_device,
 };
 
 static void __init smdkv210_dm9000_init(void)
-- 
1.6.5.2
