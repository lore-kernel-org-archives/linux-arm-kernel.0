From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 21 Sep 2010 00:00:52 +0200
Subject: [PATCH] ARM: s3c24xx: Set ARCH_NR_GPIOS according to the selected SoC
	types.
In-Reply-To: <1285020052-20020-1-git-send-email-lars@metafoo.de>
References: <1285020052-20020-1-git-send-email-lars@metafoo.de>
Message-ID: <1285020052-20020-2-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the code in gpiolib.c tries to register GPIO BANKA to BANKM.
ARCH_NR_GPIOS on the other hand is set only to 256, which would be the
equivalent of BANKA to BANKH. Thus the registration of all other banks will fail.

This patch fixes this by setting S3C_GPIO_END according to the selected SoC
types. S3C_GPIO_END is set to the maximum of the number of GPIOs over all
selected SoC types. Thus it is ensured that memory is not wasted if support for
SoCs with higher GPIO numbers is not built-in.
When registering the banks it is made sure that banks which are outside of that
range are not even tried to be registered. Otherwise there would a problem with
configs where CONFIG_S3C24XX_GPIO_EXTRA is set to a non zero value.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2410/include/mach/gpio.h |   25 ++++++++++++-------------
 arch/arm/plat-s3c24xx/gpiolib.c           |    2 ++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index b649bf2..80dfe25 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -16,22 +16,21 @@
 #define gpio_cansleep	__gpio_cansleep
 #define gpio_to_irq	__gpio_to_irq
 
-/* some boards require extra gpio capacity to support external
- * devices that need GPIO.
- */
+#include <mach/gpio-fns.h>
+#include <mach/gpio-nrs.h>
 
-#ifdef CONFIG_CPU_S3C244X
-#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
+#if defined(CPU_S3C2416) || defined(CPU_S3C2443)
+#define S3C_GPIO_END	S3C2410_GPM(S3C2410_GPIO_M_NR)
+#elif defined(CONFIG_CPU_S3C244X)
+#define S3C_GPIO_END	S3C2410_GPJ(S3C2410_GPIO_J_NR)
 #else
-#define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
+#define S3C_GPIO_END	S3C2410_GPH(S3C2410_GPIO_H_NR)
 #endif
 
+/* some boards require extra gpio capacity to support external
+ * devices that need GPIO.
+ */
+#define ARCH_NR_GPIOS (S3C_GPIO_END + CONFIG_S3C24XX_GPIO_EXTRA)
+
 #include <asm-generic/gpio.h>
-#include <mach/gpio-nrs.h>
-#include <mach/gpio-fns.h>
 
-#ifdef CONFIG_CPU_S3C24XX
-#define S3C_GPIO_END	(S3C2410_GPIO_BANKJ + 32)
-#else
-#define S3C_GPIO_END	(S3C2410_GPIO_BANKH + 32)
-#endif
diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 4c0896f..65b6126 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -221,6 +221,8 @@ static __init int s3c24xx_gpiolib_init(void)
 	int gpn;
 
 	for (gpn = 0; gpn < ARRAY_SIZE(s3c24xx_gpios); gpn++, chip++) {
+		if (chip->chip.base >= S3C_GPIO_END)
+			break;
 		if (!chip->config)
 			chip->config = &s3c24xx_gpiocfg_default;
 
-- 
1.5.6.5
