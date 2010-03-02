From: chripell@fsfe.org (Christian Pellegrin)
Date: Tue,  2 Mar 2010 17:05:37 +0100
Subject: [PATCH] This patch adds support for GPIO bank J present on S3C244X
	CPUs. It
Message-ID: <1267545937-20557-1-git-send-email-chripell@fsfe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 arch/arm/mach-s3c2410/include/mach/gpio-core.h |    5 +++++
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h  |    4 ++++
 arch/arm/mach-s3c2410/include/mach/gpio.h      |    8 ++++++++
 arch/arm/plat-s3c/pm-gpio.c                    |    5 +++--
 arch/arm/plat-s3c24xx/gpiolib.c                |   16 +++++++++++++++-
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-core.h b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
index f8b879a..de9697c 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-core.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
@@ -24,8 +24,13 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
 {
 	struct s3c_gpio_chip *chip;
 
+#ifdef CONFIG_CPU_S3C244X
+	if (pin > S3C2410_GPJ(15))
+		return NULL;
+#else
 	if (pin > S3C2410_GPG(10))
 		return NULL;
+#endif
 
 	chip = &s3c24xx_gpios[pin/32];
 	return (S3C2410_GPIO_OFFSET(pin) < chip->chip.ngpio) ? chip : NULL;
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
diff --git a/arch/arm/plat-s3c/pm-gpio.c b/arch/arm/plat-s3c/pm-gpio.c
index cfd326a..8ef2c9d 100644
--- a/arch/arm/plat-s3c/pm-gpio.c
+++ b/arch/arm/plat-s3c/pm-gpio.c
@@ -20,6 +20,7 @@
 #include <linux/gpio.h>
 
 #include <mach/gpio-core.h>
+#include <mach/regs-gpioj.h>
 #include <plat/pm.h>
 
 /* PM GPIO helpers */
@@ -343,7 +344,7 @@ void s3c_pm_save_gpios(void)
 			  ourchip->pm_save[2],
 			  ourchip->pm_save[3]);
 
-		gpio_nr += ourchip->chip.ngpio;
+		gpio_nr += ourchip->chip.ngpio - 1;
 		gpio_nr += CONFIG_S3C_GPIO_SPACE;
 	}
 }
@@ -374,7 +375,7 @@ void s3c_pm_restore_gpios(void)
 
 		s3c_pm_resume_gpio(ourchip);
 
-		gpio_nr += ourchip->chip.ngpio;
+		gpio_nr += ourchip->chip.ngpio - 1;
 		gpio_nr += CONFIG_S3C_GPIO_SPACE;
 	}
 }
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
