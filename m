From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 14:47:17 +0200
Subject: [PATCH 6/6] ARM: s3c64xx: smartq: Use PWM lookup table
In-Reply-To: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1444049237-29878-7-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a PWM lookup table to provide the PWM to the pwm-backlight device.
The driver has a legacy code path that is required only because boards
still use the legacy method of requesting PWMs by global ID. Replacing
these usages allows that legacy fallback to be removed.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-smartq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index b3d13537a7f0..7b8a3699795c 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -14,6 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/serial_core.h>
 #include <linux/serial_s3c.h>
@@ -139,6 +140,11 @@ static struct platform_device smartq_usb_otg_vbus_dev = {
 	.dev.platform_data	= &smartq_usb_otg_vbus_pdata,
 };
 
+static struct pwm_lookup smartq_pwm_lookup[] = {
+	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", NULL,
+		   1000000000 / (1000 * 20), PWM_POLARITY_NORMAL),
+};
+
 static int smartq_bl_init(struct device *dev)
 {
     s3c_gpio_cfgpin(S3C64XX_GPF(15), S3C_GPIO_SFN(2));
@@ -147,10 +153,8 @@ static int smartq_bl_init(struct device *dev)
 }
 
 static struct platform_pwm_backlight_data smartq_backlight_data = {
-	.pwm_id		= 1,
 	.max_brightness	= 1000,
 	.dft_brightness	= 600,
-	.pwm_period_ns	= 1000000000 / (1000 * 20),
 	.enable_gpio	= -1,
 	.init		= smartq_bl_init,
 };
@@ -396,5 +400,6 @@ void __init smartq_machine_init(void)
 	WARN_ON(smartq_usb_host_init());
 	WARN_ON(smartq_wifi_init());
 
+	pwm_add_table(smartq_pwm_lookup, ARRAY_SIZE(smartq_pwm_lookup));
 	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
 }
-- 
2.5.0
