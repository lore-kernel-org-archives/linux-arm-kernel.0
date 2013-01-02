From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:46 -0800
Subject: [PATCH 09/26] ARM: SAMSUNG: cleanup mach/gpio-fns.h gpio-track.h and
 gpio-nrs.h
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-10-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove <mach/gpio-fns.h>, <mach/gpio-track.h> and <plat/gpio-fns.h>

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c24xx/include/mach/gpio-fns.h   |    1 -
 arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h   |   97 -----------------------
 arch/arm/mach-s3c24xx/include/mach/gpio-track.h |   33 --------
 arch/arm/mach-s3c24xx/include/mach/gpio.h       |   87 +++++++++++++++++++-
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h  |    2 -
 arch/arm/mach-s3c24xx/mach-at2440evb.c          |    1 +
 arch/arm/mach-s3c24xx/mach-h1940.c              |    2 -
 arch/arm/plat-samsung/include/plat/gpio-core.h  |   13 ++-
 arch/arm/plat-samsung/include/plat/gpio-fns.h   |    1 -
 drivers/gpio/gpio-samsung.c                     |    1 -
 10 files changed, 96 insertions(+), 142 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/gpio-fns.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/gpio-track.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/gpio-fns.h

diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-fns.h b/arch/arm/mach-s3c24xx/include/mach/gpio-fns.h
deleted file mode 100644
index c53ad34..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/gpio-fns.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <plat/gpio-fns.h>
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h b/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
deleted file mode 100644
index 3890a05..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/gpio-nrs.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
- *
- * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C2410 - GPIO bank numbering
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __MACH_GPIONRS_H
-#define __MACH_GPIONRS_H
-
-#define S3C2410_GPIONO(bank,offset) ((bank) + (offset))
-
-#define S3C2410_GPIO_BANKG   (32*6)
-#define S3C2410_GPIO_BANKH   (32*7)
-
-/* GPIO sizes for various SoCs:
- *
- *             2442
- *   2410 2412 2440 2443 2416
- *   ---- ---- ---- ---- ----
- * A 23   22   25   16   25
- * B 11   11   11   11   9
- * C 16   15   16   16   16
- * D 16   16   16   16   16
- * E 16   16   16   16   16
- * F 8    8    8    8    8
- * G 16   16   16   16   8
- * H 11   11   9    15   15
- * J --   --   13   16   --
- * K --   --   --   --   16
- * L --   --   --   15   7
- * M --   --   --   2    2
- */
-
-/* GPIO bank sizes */
-#define S3C2410_GPIO_A_NR	(32)
-#define S3C2410_GPIO_B_NR	(32)
-#define S3C2410_GPIO_C_NR	(32)
-#define S3C2410_GPIO_D_NR	(32)
-#define S3C2410_GPIO_E_NR	(32)
-#define S3C2410_GPIO_F_NR	(32)
-#define S3C2410_GPIO_G_NR	(32)
-#define S3C2410_GPIO_H_NR	(32)
-#define S3C2410_GPIO_J_NR	(32)	/* technically 16. */
-#define S3C2410_GPIO_K_NR	(32)	/* technically 16. */
-#define S3C2410_GPIO_L_NR	(32)	/* technically 15. */
-#define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
-
-#if CONFIG_S3C_GPIO_SPACE != 0
-#error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
-#endif
-
-#define S3C2410_GPIO_NEXT(__gpio) \
-	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 0)
-
-#ifndef __ASSEMBLY__
-
-enum s3c_gpio_number {
-	S3C2410_GPIO_A_START = 0,
-	S3C2410_GPIO_B_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_A),
-	S3C2410_GPIO_C_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_B),
-	S3C2410_GPIO_D_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_C),
-	S3C2410_GPIO_E_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_D),
-	S3C2410_GPIO_F_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_E),
-	S3C2410_GPIO_G_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_F),
-	S3C2410_GPIO_H_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_G),
-	S3C2410_GPIO_J_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_H),
-	S3C2410_GPIO_K_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_J),
-	S3C2410_GPIO_L_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_K),
-	S3C2410_GPIO_M_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_L),
-};
-
-#endif /* __ASSEMBLY__ */
-
-/* S3C2410 GPIO number definitions. */
-
-#define S3C2410_GPA(_nr)	(S3C2410_GPIO_A_START + (_nr))
-#define S3C2410_GPB(_nr)	(S3C2410_GPIO_B_START + (_nr))
-#define S3C2410_GPC(_nr)	(S3C2410_GPIO_C_START + (_nr))
-#define S3C2410_GPD(_nr)	(S3C2410_GPIO_D_START + (_nr))
-#define S3C2410_GPE(_nr)	(S3C2410_GPIO_E_START + (_nr))
-#define S3C2410_GPF(_nr)	(S3C2410_GPIO_F_START + (_nr))
-#define S3C2410_GPG(_nr)	(S3C2410_GPIO_G_START + (_nr))
-#define S3C2410_GPH(_nr)	(S3C2410_GPIO_H_START + (_nr))
-#define S3C2410_GPJ(_nr)	(S3C2410_GPIO_J_START + (_nr))
-#define S3C2410_GPK(_nr)	(S3C2410_GPIO_K_START + (_nr))
-#define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
-#define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
-
-#endif /* __MACH_GPIONRS_H */
-
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-track.h b/arch/arm/mach-s3c24xx/include/mach/gpio-track.h
deleted file mode 100644
index c410a07..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/gpio-track.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* arch/arm/mach-s3c24100/include/mach/gpio-core.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C2410 - GPIO core support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_GPIO_CORE_H
-#define __ASM_ARCH_GPIO_CORE_H __FILE__
-
-#include <mach/regs-gpio.h>
-
-extern struct samsung_gpio_chip s3c24xx_gpios[];
-
-static inline struct samsung_gpio_chip *samsung_gpiolib_getchip(unsigned int pin)
-{
-	struct samsung_gpio_chip *chip;
-
-	if (pin > S3C_GPIO_END)
-		return NULL;
-
-	chip = &s3c24xx_gpios[pin/32];
-	return ((pin - chip->chip.base) < chip->chip.ngpio) ? chip : NULL;
-}
-
-#endif /* __ASM_ARCH_GPIO_CORE_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio.h b/arch/arm/mach-s3c24xx/include/mach/gpio.h
index 6fac70f..1459156 100644
--- a/arch/arm/mach-s3c24xx/include/mach/gpio.h
+++ b/arch/arm/mach-s3c24xx/include/mach/gpio.h
@@ -1,5 +1,4 @@
-/* arch/arm/mach-s3c2410/include/mach/gpio.h
- *
+/*
  * Copyright (c) 2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
@@ -15,6 +14,9 @@
  * devices that need GPIO.
  */
 
+#ifndef __MACH_GPIO_H
+#define __MACH_GPIO_H __FILE__
+
 #ifdef CONFIG_CPU_S3C244X
 #define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
 #elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
@@ -23,8 +25,83 @@
 #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
 #endif
 
-#include <mach/gpio-nrs.h>
-#include <mach/gpio-fns.h>
+/*
+ * GPIO sizes for various SoCs:
+ *
+ *   2410 2412 2440 2443 2416
+ *             2442
+ *   ---- ---- ---- ---- ----
+ * A  23   22   25   16   25
+ * B  11   11   11   11   9
+ * C  16   15   16   16   16
+ * D  16   16   16   16   16
+ * E  16   16   16   16   16
+ * F  8    8    8    8    8
+ * G  16   16   16   16   8
+ * H  11   11   9    15   15
+ * J  --   --   13   16   --
+ * K  --   --   --   --   16
+ * L  --   --   --   15   7
+ * M  --   --   --   2    2
+ */
+
+/* GPIO bank sizes */
+
+#define S3C2410_GPIO_A_NR	(32)
+#define S3C2410_GPIO_B_NR	(32)
+#define S3C2410_GPIO_C_NR	(32)
+#define S3C2410_GPIO_D_NR	(32)
+#define S3C2410_GPIO_E_NR	(32)
+#define S3C2410_GPIO_F_NR	(32)
+#define S3C2410_GPIO_G_NR	(32)
+#define S3C2410_GPIO_H_NR	(32)
+#define S3C2410_GPIO_J_NR	(32)	/* technically 16. */
+#define S3C2410_GPIO_K_NR	(32)	/* technically 16. */
+#define S3C2410_GPIO_L_NR	(32)	/* technically 15. */
+#define S3C2410_GPIO_M_NR	(32)	/* technically 2. */
+
+#if CONFIG_S3C_GPIO_SPACE != 0
+#error CONFIG_S3C_GPIO_SPACE cannot be nonzero at the moment
+#endif
+
+#define S3C2410_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 0)
+
+#ifndef __ASSEMBLY__
+
+enum s3c_gpio_number {
+	S3C2410_GPIO_A_START = 0,
+	S3C2410_GPIO_B_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_A),
+	S3C2410_GPIO_C_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_B),
+	S3C2410_GPIO_D_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_C),
+	S3C2410_GPIO_E_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_D),
+	S3C2410_GPIO_F_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_E),
+	S3C2410_GPIO_G_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_F),
+	S3C2410_GPIO_H_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_G),
+	S3C2410_GPIO_J_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_H),
+	S3C2410_GPIO_K_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_J),
+	S3C2410_GPIO_L_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_K),
+	S3C2410_GPIO_M_START = S3C2410_GPIO_NEXT(S3C2410_GPIO_L),
+};
+
+#endif /* __ASSEMBLY__ */
+
+/* S3C2410 GPIO number definitions. */
+
+#define S3C2410_GPA(_nr)	(S3C2410_GPIO_A_START + (_nr))
+#define S3C2410_GPB(_nr)	(S3C2410_GPIO_B_START + (_nr))
+#define S3C2410_GPC(_nr)	(S3C2410_GPIO_C_START + (_nr))
+#define S3C2410_GPD(_nr)	(S3C2410_GPIO_D_START + (_nr))
+#define S3C2410_GPE(_nr)	(S3C2410_GPIO_E_START + (_nr))
+#define S3C2410_GPF(_nr)	(S3C2410_GPIO_F_START + (_nr))
+#define S3C2410_GPG(_nr)	(S3C2410_GPIO_G_START + (_nr))
+#define S3C2410_GPH(_nr)	(S3C2410_GPIO_H_START + (_nr))
+#define S3C2410_GPJ(_nr)	(S3C2410_GPIO_J_START + (_nr))
+#define S3C2410_GPK(_nr)	(S3C2410_GPIO_K_START + (_nr))
+#define S3C2410_GPL(_nr)	(S3C2410_GPIO_L_START + (_nr))
+#define S3C2410_GPM(_nr)	(S3C2410_GPIO_M_START + (_nr))
+
+#include <plat/gpio-cfg.h>
 
 #ifdef CONFIG_CPU_S3C244X
 #define S3C_GPIO_END	(S3C2410_GPJ(0) + 32)
@@ -33,3 +110,5 @@
 #else
 #define S3C_GPIO_END	(S3C2410_GPH(0) + 32)
 #endif
+
+#endif /* __MACH_GPIO_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
index a11a638..c2ef016 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
@@ -14,8 +14,6 @@
 #ifndef __ASM_ARCH_REGS_GPIO_H
 #define __ASM_ARCH_REGS_GPIO_H
 
-#include <mach/gpio-nrs.h>
-
 #define S3C24XX_MISCCR		S3C24XX_GPIOREG2(0x80)
 
 /* general configuration options */
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 00381fe..f51bbcb 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/timer.h>
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index b23dd1b..e208dda 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -50,8 +50,6 @@
 #include <mach/regs-clock.h>
 
 #include <mach/regs-gpio.h>
-#include <mach/gpio-fns.h>
-#include <mach/gpio-nrs.h>
 
 #include <mach/h1940.h>
 #include <mach/h1940-latch.h>
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index f7a3ea2..cf5aae5 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -106,7 +106,18 @@ static inline struct samsung_gpio_chip *samsung_gpiolib_getchip(unsigned int chi
 #else
 /* machine specific code should provide samsung_gpiolib_getchip */
 
-#include <mach/gpio-track.h>
+extern struct samsung_gpio_chip s3c24xx_gpios[];
+
+static inline struct samsung_gpio_chip *samsung_gpiolib_getchip(unsigned int pin)
+{
+	struct samsung_gpio_chip *chip;
+
+	if (pin > S3C_GPIO_END)
+		return NULL;
+
+	chip = &s3c24xx_gpios[pin/32];
+	return ((pin - chip->chip.base) < chip->chip.ngpio) ? chip : NULL;
+}
 
 static inline void s3c_gpiolib_track(struct samsung_gpio_chip *chip) { }
 #endif
diff --git a/arch/arm/plat-samsung/include/plat/gpio-fns.h b/arch/arm/plat-samsung/include/plat/gpio-fns.h
deleted file mode 100644
index d1ecef0..0000000
--- a/arch/arm/plat-samsung/include/plat/gpio-fns.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <plat/gpio-cfg.h>
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 9070f86..2a42e2c 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -38,7 +38,6 @@
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <plat/gpio-fns.h>
 #include <plat/pm.h>
 
 int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
-- 
1.7.10.4
