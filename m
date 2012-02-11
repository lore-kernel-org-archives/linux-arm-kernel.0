From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 15:14:40 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Support I2C{4/5} for EXYNOS{4212/4412} SoC
Message-ID: <018c01cce884$707ed870$517c8950$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixup gpio configuration related to i2c4/i2c5 for exynos{4212/4412}
as below table.
------------------------------------
|    SoC     |   i2c4   |   i2c5   |
----------------------------------
| exynos4210 | GPB(2,3) | GPB(6,7) |
----------------------------------
| exynos4x12 | GPB(0,1) | GPB(2,3) |
------------------------------------

Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/mach-exynos/setup-i2c4.c |   10 ++++++++--
 arch/arm/mach-exynos/setup-i2c5.c |    9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/setup-i2c4.c b/arch/arm/mach-exynos/setup-i2c4.c
index 9f3c048..9df73e8 100644
--- a/arch/arm/mach-exynos/setup-i2c4.c
+++ b/arch/arm/mach-exynos/setup-i2c4.c
@@ -15,9 +15,15 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c4_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	if (soc_is_exynos4210())
+		s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS4_GPB(0), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+
 }
diff --git a/arch/arm/mach-exynos/setup-i2c5.c b/arch/arm/mach-exynos/setup-i2c5.c
index 77e1a1e..2380d10 100644
--- a/arch/arm/mach-exynos/setup-i2c5.c
+++ b/arch/arm/mach-exynos/setup-i2c5.c
@@ -15,9 +15,14 @@ struct platform_device; /* don't need the contents */
 #include <linux/gpio.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
+#include <plat/cpu.h>
 
 void s3c_i2c5_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	if (soc_is_exynos4210())
+		s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
+	else
+		s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_UP);
 }
-- 
1.7.1
