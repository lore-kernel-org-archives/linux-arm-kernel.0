From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:43 +0200
Subject: [PATCH 03/17] ARM: pxa: ezx: Use PWM lookup table
In-Reply-To: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
References: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444034997-9805-4-git-send-email-thierry.reding@gmail.com>
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
 arch/arm/mach-pxa/ezx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index ab93441e596e..9a9c15bfcd34 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
@@ -49,11 +50,14 @@
 #define GPIO19_GEN1_CAM_RST		19
 #define GPIO28_GEN2_CAM_RST		28
 
+static struct pwm_lookup ezx_pwm_lookup[] = {
+	PWM_LOOKUP("pxa27x-pwm.0", 0, "pwm-backlight.0", NULL, 78700,
+		   PWM_POLARITY_NORMAL),
+};
+
 static struct platform_pwm_backlight_data ezx_backlight_data = {
-	.pwm_id		= 0,
 	.max_brightness	= 1023,
 	.dft_brightness	= 1023,
-	.pwm_period_ns	= 78770,
 	.enable_gpio	= -1,
 };
 
@@ -817,6 +821,7 @@ static void __init a780_init(void)
 		platform_device_register(&a780_camera);
 	}
 
+	pwm_add_table(ezx_pwm_lookup, ARRAY_SIZE(ezx_pwm_lookup));
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a780_devices));
 }
-- 
2.5.0
