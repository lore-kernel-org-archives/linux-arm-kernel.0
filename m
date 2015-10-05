From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:55 +0200
Subject: [PATCH 15/17] ARM: pxa: viper: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-16-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a PWM lookup table to provide the PWM to the pwm-backlight device.
The driver has a legacy code path that is required only because boards
still use the legacy method of requesting PWMs by global ID. Replacing
these usages allows that legacy fallback to be removed.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-pxa/viper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 4841d6cefe76..b09e8cadd41f 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -39,6 +39,7 @@
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/serial_8250.h>
 #include <linux/smc91x.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/usb/isp116x.h>
 #include <linux/mtd/mtd.h>
@@ -350,6 +351,11 @@ static struct pxafb_mach_info fb_info = {
 	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
 };
 
+static struct pwm_lookup viper_pwm_lookup[] = {
+	PWM_LOOKUP("pxa25x-pwm.0", 0, "pwm-backlight.0", NULL, 1000000,
+		   PWM_POLARITY_NORMAL),
+};
+
 static int viper_backlight_init(struct device *dev)
 {
 	int ret;
@@ -398,10 +404,8 @@ static void viper_backlight_exit(struct device *dev)
 }
 
 static struct platform_pwm_backlight_data viper_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
-	.pwm_period_ns	= 1000000,
 	.enable_gpio	= -1,
 	.init		= viper_backlight_init,
 	.notify		= viper_backlight_notify,
@@ -939,6 +943,7 @@ static void __init viper_init(void)
 		smc91x_device.num_resources--;
 
 	pxa_set_i2c_info(NULL);
+	pwm_add_table(viper_pwm_lookup, ARRAY_SIZE(viper_pwm_lookup));
 	platform_add_devices(viper_devs, ARRAY_SIZE(viper_devs));
 
 	viper_init_vcore_gpios();
-- 
2.5.0
