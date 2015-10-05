From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:48 +0200
Subject: [PATCH 08/17] ARM: pxa: mioa701: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-9-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/mioa701.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 29997bde277d..039f2601487b 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -26,6 +26,7 @@
 #include <linux/input.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/rtc.h>
 #include <linux/leds.h>
@@ -181,12 +182,15 @@ static unsigned long mioa701_pin_config[] = {
 	MFP_CFG_OUT(GPIO116, AF0, DRIVE_HIGH),
 };
 
+static struct pwm_lookup mioa701_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight", NULL, 4000 * 1024,
+		   PWM_POLARITY_NORMAL),
+};
+
 /* LCD Screen and Backlight */
 static struct platform_pwm_backlight_data mioa701_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 100,
 	.dft_brightness	= 50,
-	.pwm_period_ns	= 4000 * 1024,	/* Fl = 250kHz */
 	.enable_gpio	= -1,
 };
 
@@ -751,6 +755,7 @@ static void __init mioa701_machine_init(void)
 	pxa_set_udc_info(&mioa701_udc_info);
 	pxa_set_ac97_info(&mioa701_ac97_info);
 	pm_power_off = mioa701_poweroff;
+	pwm_add_table(mioa701_pwm_lookup, ARRAY_SIZE(mioa701_pwm_lookup));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gsm_init();
 
-- 
2.5.0
