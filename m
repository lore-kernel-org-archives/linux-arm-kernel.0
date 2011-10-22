From: paul.s.schilling@gmail.com (Paul Schilling)
Date: Fri, 21 Oct 2011 23:08:12 -0500
Subject: [PATCH 05/14] ARM : SAMSUNG : Add GPIO_EXTRA for S3C2416.
In-Reply-To: <GPIO_extra>
References: <GPIO_extra>
Message-ID: <1319256492-4975-1-git-send-email-paul.s.schilling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C2416 has more GPIO than other S3C24XX processors.

Signed-off-by: Paul Schilling <paul.s.schilling@gmail.com>
---
 arch/arm/mach-s3c2410/include/mach/gpio.h |   15 ++++++++++-----
 arch/arm/plat-s3c24xx/gpiolib.c           |   10 ++++++++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index f7f6b07..65a0bce 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -20,22 +20,27 @@
  * devices that need GPIO.
  */
 
+#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
+#define ARCH_NR_GPIOS	(32 * 12 + CONFIG_S3C24XX_GPIO_EXTRA)
+#else
 #ifdef CONFIG_CPU_S3C244X
 #define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
-#define ARCH_NR_GPIOS	(32 * 12 + CONFIG_S3C24XX_GPIO_EXTRA)
 #else
 #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
 #endif
+#endif
 
 #include <asm-generic/gpio.h>
 #include <mach/gpio-nrs.h>
 #include <mach/gpio-fns.h>
 
-#ifdef CONFIG_CPU_S3C244X
-#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
-#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
+
+#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
 #define S3C_GPIO_END	(S3C2410_GPM(0) + 32)
 #else
+#ifdef CONFIG_CPU_S3C244X
+#define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
+else
 #define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
 #endif
+#endif
diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 243b641..93d4734 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -34,6 +34,11 @@ static int s3c24xx_gpiolib_banka_input(struct gpio_chip *chip, unsigned offset)
 	return -EINVAL;
 }
 
+static int s3c24xx_gpiolib_bankm_output(struct gpio_chip *chip, unsigned offset, int value)
+{
+	return -EINVAL;
+}
+
 static int s3c24xx_gpiolib_banka_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
@@ -93,7 +98,7 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.base			= S3C2410_GPA(0),
 			.owner			= THIS_MODULE,
 			.label			= "GPIOA",
-			.ngpio			= 24,
+			.ngpio			= 27,
 			.direction_input	= s3c24xx_gpiolib_banka_input,
 			.direction_output	= s3c24xx_gpiolib_banka_output,
 		},
@@ -167,7 +172,7 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.base			= S3C2410_GPH(0),
 			.owner			= THIS_MODULE,
 			.label			= "GPIOH",
-			.ngpio			= 11,
+			.ngpio			= 15,
 		},
 	},
 		/* GPIOS for the S3C2443 and later devices. */
@@ -206,6 +211,7 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.owner			= THIS_MODULE,
 			.label			= "GPIOM",
 			.ngpio			= 2,
+			.direction_output	= s3c24xx_gpiolib_bankm_output,
 		},
 	},
 };
-- 
1.7.6.4
