From: thomas.ab@samsung.com (Thomas Abraham)
Date: Tue, 07 Jun 2011 14:04:49 +0530
Subject: [PATCH] ARM: EXYNOS4: Fix incorrect mapping of gpio pull-up macro to
	register setting
Message-ID: <1307435689-15954-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C_GPIO_PULL_UP macro value incorrectly maps to a reserved setting of GPIO
pull up/down registers on Exynos4 platform. Fix this incorrect mapping by adding
wrappers to the s3c_gpio_setpull_updown and s3c_gpio_getpull_updown functions.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/gpio/gpio-exynos4.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-exynos4.c b/drivers/gpio/gpio-exynos4.c
index d54ca6a..9029835 100644
--- a/drivers/gpio/gpio-exynos4.c
+++ b/drivers/gpio/gpio-exynos4.c
@@ -21,16 +21,37 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
+int s3c_gpio_setpull_exynos4(struct s3c_gpio_chip *chip,
+				unsigned int off, s3c_gpio_pull_t pull)
+{
+	if (pull == S3C_GPIO_PULL_UP)
+		pull = 3;
+
+	return s3c_gpio_setpull_updown(chip, off, pull);
+}
+
+s3c_gpio_pull_t s3c_gpio_getpull_exynos4(struct s3c_gpio_chip *chip,
+						unsigned int off)
+{
+	s3c_gpio_pull_t pull;
+
+	pull = s3c_gpio_getpull_updown(chip, off);
+	if (pull == 3)
+		pull = S3C_GPIO_PULL_UP;
+
+	return pull;
+}
+
 static struct s3c_gpio_cfg gpio_cfg = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
-	.set_pull	= s3c_gpio_setpull_updown,
-	.get_pull	= s3c_gpio_getpull_updown,
+	.set_pull	= s3c_gpio_setpull_exynos4,
+	.get_pull	= s3c_gpio_getpull_exynos4,
 };
 
 static struct s3c_gpio_cfg gpio_cfg_noint = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
-	.set_pull	= s3c_gpio_setpull_updown,
-	.get_pull	= s3c_gpio_getpull_updown,
+	.set_pull	= s3c_gpio_setpull_exynos4,
+	.get_pull	= s3c_gpio_getpull_exynos4,
 };
 
 /*
-- 
1.6.6.rc2
