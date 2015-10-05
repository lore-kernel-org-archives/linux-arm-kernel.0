From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:52 +0200
Subject: [PATCH 12/17] ARM: pxa: pcm990: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-13-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/pcm990-baseboard.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 9a0c8affdadb..1453fd95ced5 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 
 #include <media/mt9v022.h>
@@ -148,11 +149,14 @@ static struct pxafb_mach_info pcm990_fbinfo __initdata = {
 };
 #endif
 
+static struct pwm_lookup pcm990_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.0", NULL, 78770,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data pcm990_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 1023,
 	.dft_brightness	= 1023,
-	.pwm_period_ns	= 78770,
 	.enable_gpio	= -1,
 };
 
@@ -542,6 +546,7 @@ void __init pcm990_baseboard_init(void)
 #ifndef CONFIG_PCM990_DISPLAY_NONE
 	pxa_set_fb_info(NULL, &pcm990_fbinfo);
 #endif
+	pwm_add_table(pcm990_pwm_lookup, ARRAY_SIZE(pcm990_pwm_lookup));
 	platform_device_register(&pcm990_backlight_device);
 
 	/* MMC */
-- 
2.5.0
