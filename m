From: achew@nvidia.com (Andrew Chew)
Date: Mon, 1 Apr 2013 14:53:24 -0700
Subject: [PATCH V6 5/9] unicore32: Provide regulator to pwm-backlight
In-Reply-To: <1364853208-32503-1-git-send-email-achew@nvidia.com>
References: <1364853208-32503-1-git-send-email-achew@nvidia.com>
Message-ID: <1364853208-32503-6-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/unicore32/kernel/puv3-nb0916.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 181108b..839b536 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -19,6 +19,8 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
@@ -49,6 +51,10 @@ static struct resource puv3_i2c_resources[] = {
 	}
 };
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 static struct platform_pwm_backlight_data nb0916_backlight_data = {
 	.pwm_id		= 0,
 	.max_brightness	= 100,
@@ -111,6 +117,9 @@ int __init mach_nb0916_init(void)
 	platform_device_register_simple("PKUnity-v3-I2C", -1,
 			puv3_i2c_resources, ARRAY_SIZE(puv3_i2c_resources));
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	platform_device_register_data(&platform_bus, "pwm-backlight", -1,
 			&nb0916_backlight_data, sizeof(nb0916_backlight_data));
 
-- 
1.8.1.5
