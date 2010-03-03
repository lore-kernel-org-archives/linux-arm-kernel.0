From: chripell@fsfe.org (Christian Pellegrin)
Date: Wed,  3 Mar 2010 08:00:14 +0100
Subject: [PATCH] Adds support for banks H and J on S3C244X CPUs
In-Reply-To: <cabda6421003022258j51258c56w99b0e75d2d2b088c@mail.gmail.com>
References: <cabda6421003022258j51258c56w99b0e75d2d2b088c@mail.gmail.com>
Message-ID: <1267599614-9257-1-git-send-email-chripell@fsfe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to gpiolib for GPIO bank J present on S3C244X
CPUs.

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h |    4 ++++
 arch/arm/mach-s3c2410/include/mach/gpio.h     |    8 ++++++++
 arch/arm/plat-s3c24xx/gpiolib.c               |   16 +++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
index 2edbb9c..f1f32e2 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
@@ -24,6 +24,7 @@
 #define S3C2410_GPIO_BANKF   (32*5)
 #define S3C2410_GPIO_BANKG   (32*6)
 #define S3C2410_GPIO_BANKH   (32*7)
+#define S3C2410_GPIO_BANKJ   (32*8)
 
 /* GPIO bank sizes */
 #define S3C2410_GPIO_A_NR	(32)
@@ -34,6 +35,7 @@
 #define S3C2410_GPIO_F_NR	(32)
 #define S3C2410_GPIO_G_NR	(32)
 #define S3C2410_GPIO_H_NR	(32)
+#define S3C2410_GPIO_J_NR	(32)
 
 #if CONFIG_S3C_GPIO_SPACE != 0
 #error CONFIG_S3C_GPIO_SPACE cannot be zero at the moment
@@ -53,6 +55,7 @@ enum s3c_gpio_number {
 	S3C2410_GPIO_F_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_E),
 	S3C2410_GPIO_G_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_F),
 	S3C2410_GPIO_H_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_G),
+	S3C2410_GPIO_J_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_H),
 };
 
 #endif /* __ASSEMBLY__ */
@@ -67,6 +70,7 @@ enum s3c_gpio_number {
 #define S3C2410_GPF(_nr)	(S3C2410_GPIO_F_START + (_nr))
 #define S3C2410_GPG(_nr)	(S3C2410_GPIO_G_START + (_nr))
 #define S3C2410_GPH(_nr)	(S3C2410_GPIO_H_START + (_nr))
+#define S3C2410_GPJ(_nr)	(S3C2410_GPIO_J_START + (_nr))
 
 /* compatibility until drivers can be modified */
 
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index 15f0b3e..1528fc7 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -20,10 +20,18 @@
  * devices that need GPIO.
  */
 
+#ifdef CONFIG_CPU_S3C244X
+#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
+#else
 #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
+#endif
 
 #include <asm-generic/gpio.h>
 #include <mach/gpio-nrs.h>
 #include <mach/gpio-fns.h>
 
+#ifdef CONFIG_CPU_S3C244X
+#define S3C_GPIO_END	(S3C2410_GPIO_BANKJ + 32)
+#else
 #define S3C_GPIO_END	(S3C2410_GPIO_BANKH + 32)
+#endif
diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 6d7a961..815b2b1 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -26,6 +26,7 @@
 #include <plat/pm.h>
 
 #include <mach/regs-gpio.h>
+#include <mach/regs-gpioj.h>
 
 static int s3c24xx_gpiolib_banka_input(struct gpio_chip *chip, unsigned offset)
 {
@@ -151,7 +152,8 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.ngpio			= 16,
 			.to_irq			= s3c24xx_gpiolib_bankg_toirq,
 		},
-	}, {
+	},
+	[7] = {
 		.base	= S3C2410_GPHCON,
 		.pm	= __gpio_pm(&s3c_gpio_pm_2bit),
 		.chip	= {
@@ -161,6 +163,18 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.ngpio			= 11,
 		},
 	},
+#ifdef CONFIG_CPU_S3C244X
+	[8] = {
+		.base	= S3C2440_GPJCON,
+		.pm	= __gpio_pm(&s3c_gpio_pm_2bit),
+		.chip	= {
+			.base			= S3C2410_GPJ(0),
+			.owner			= THIS_MODULE,
+			.label			= "GPIOJ",
+			.ngpio			= 13,
+		},
+	},
+#endif
 };
 
 static __init int s3c24xx_gpiolib_init(void)
-- 
1.5.6.5
