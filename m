From: achew@nvidia.com (Andrew Chew)
Date: Mon, 1 Apr 2013 14:53:23 -0700
Subject: [PATCH V6 4/9] ARM: EXYNOS: Provide regulator to pwm-backlight
In-Reply-To: <1364853208-32503-1-git-send-email-achew@nvidia.com>
References: <1364853208-32503-1-git-send-email-achew@nvidia.com>
Message-ID: <1364853208-32503-5-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/mach-exynos/mach-nuri.c      | 7 +++++++
 arch/arm/plat-samsung/dev-backlight.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 1ea7973..0223863 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -294,6 +294,10 @@ static void nuri_bl_exit(struct device *dev)
 	gpio_free(EXYNOS4_GPE2(3));
 }
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 /* nuri pwm backlight */
 static struct platform_pwm_backlight_data nuri_backlight_data = {
 	.pwm_id			= 0,
@@ -1368,6 +1372,9 @@ static void __init nuri_machine_init(void)
 	nuri_ehci_init();
 	s3c_hsotg_set_platdata(&nuri_hsotg_pdata);
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	/* Last */
 	platform_add_devices(nuri_devices, ARRAY_SIZE(nuri_devices));
 }
diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index 5f197dc..23ce16b 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -14,12 +14,18 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/pwm_backlight.h>
 
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 #include <plat/backlight.h>
 
+/* Dummy regulator for pwm-backlight driver */
+static struct regulator_consumer_supply backlight_supply =
+	REGULATOR_SUPPLY("power", "pwm-backlight");
+
 static int samsung_bl_init(struct device *dev)
 {
 	int ret = 0;
@@ -37,6 +43,9 @@ static int samsung_bl_init(struct device *dev)
 	/* Configure GPIO pin with specific GPIO function for PWM timer */
 	s3c_gpio_cfgpin(bl_gpio_info->no, bl_gpio_info->func);
 
+	regulator_register_always_on(-1, "backlight-power",
+				     &backlight_supply, 1, 0);
+
 	return 0;
 }
 
-- 
1.8.1.5
