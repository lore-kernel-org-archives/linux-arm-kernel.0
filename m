From: dron0gus@gmail.com (Gusakov Andrey)
Date: Sun,  8 Jan 2012 19:04:09 +0400
Subject: [PATCH v2] S3C: fix ARCH_NR_GPIOS define for S3C2XXX SoCs
Message-ID: <1326035049-1931-1-git-send-email-dron0gus@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Differnt S3C24XX SoC have different number of GPIO. When building
kernel for many S3C24XX SoCs GPIO number defined to minimun possible.
This patch fix it and define GPIO number to muximum possible for SoCs
compiled in.

Signed-off-by: Gusakov Andrey <dron0gus@gmail.com>
---
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h |    6 ++++
 arch/arm/mach-s3c2410/include/mach/gpio.h     |   38 +++++++++++++------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
index 019ea86..3e52d92 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
@@ -52,6 +52,12 @@
 #define S3C2410_GPIO_L_NR	(32)	/* technically 15. */
 #define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
 
+/* Total GPIO count */
+#define S3C2443_NR_GPIOS	(32 * 12)
+#define S3C2416_NR_GPIOS	(32 * 12)
+#define S3C244X_NR_GPIOS	(32 * 9)
+#define S3C241X_NR_GPIOS	(32 * 8)
+
 #if CONFIG_S3C_GPIO_SPACE != 0
 #error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
 #endif
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index 6fac70f..3ab7f89 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -11,25 +11,27 @@
  * published by the Free Software Foundation.
 */
 
-/* some boards require extra gpio capacity to support external
- * devices that need GPIO.
- */
-
-#ifdef CONFIG_CPU_S3C244X
-#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
-#define ARCH_NR_GPIOS	(32 * 12 + CONFIG_S3C24XX_GPIO_EXTRA)
-#else
-#define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
-#endif
-
 #include <mach/gpio-nrs.h>
 #include <mach/gpio-fns.h>
 
-#ifdef CONFIG_CPU_S3C244X
-#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
-#define S3C_GPIO_END	(S3C2410_GPM(0) + 32)
-#else
-#define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
+#define SAMSUNG_NR_GPIOS	S3C241X_NR_GPIOS
+#if defined(CONFIG_CPU_S3C244X) && S3C244X_NR_GPIOS > SAMSUNG_NR_GPIOS
+#undef SAMSUNG_NR_GPIOS
+#define SAMSUNG_NR_GPIOS	S3C244X_NR_GPIOS
+#endif
+#if defined(CONFIG_CPU_S3C2416) && S3C2416_NR_GPIOS > SAMSUNG_NR_GPIOS
+#undef SAMSUNG_NR_GPIOS
+#define SAMSUNG_NR_GPIOS	S3C2416_NR_GPIOS
 #endif
+#if defined(CONFIG_CPU_S3C2443) && S3C2443_NR_GPIOS > SAMSUNG_NR_GPIOS
+#undef SAMSUNG_NR_GPIOS
+#define SAMSUNG_NR_GPIOS	S3C2443_NR_GPIOS
+#endif
+
+#define S3C_GPIO_END		SAMSUNG_NR_GPIOS
+
+/* some boards require extra gpio capacity to support external
+ * devices that need GPIO.
+ */
+
+#define ARCH_NR_GPIOS		(SAMSUNG_NR_GPIOS + CONFIG_S3C24XX_GPIO_EXTRA)
-- 
1.7.0.4
