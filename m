From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:57 +0200
Subject: [PATCH 17/17] ARM: pxa: zylonite: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-18-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/zylonite.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 77daea478e88..e20359a7433c 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/smc91x.h>
 
@@ -120,11 +121,14 @@ static inline void zylonite_init_leds(void) {}
 #endif
 
 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
+static struct pwm_lookup zylonite_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.1", 1, "pwm-backlight.0", NULL, 10000,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data zylonite_backlight_data = {
-	.pwm_id		= 3,
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
-	.pwm_period_ns	= 10000,
 	.enable_gpio	= -1,
 };
 
@@ -206,6 +210,7 @@ static struct pxafb_mach_info zylonite_sharp_lcd_info = {
 
 static void __init zylonite_init_lcd(void)
 {
+	pwm_add_table(zylonite_pwm_lookup, ARRAY_SIZE(zylonite_pwm_lookup));
 	platform_device_register(&zylonite_backlight_device);
 
 	if (lcd_id & 0x20) {
-- 
2.5.0
