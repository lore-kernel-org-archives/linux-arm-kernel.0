From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 04 Jul 2011 19:28:27 +0900
Subject: [PATCH] GPIO: SAMSUNG: Consolidate GPIO library for SAMSUNG SoC
Message-ID: <4E1195CB.3000603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch consolidates duplicate GPIO library for SAMSUNG SoC
to control GPIO on the whole SAMSUNG SoC(S3C series, S5P series)
through consolidated GPIO library file.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c64xx/gpiolib.c                |   27 +---
 arch/arm/mach-s5p64x0/gpiolib.c                |    2 +-
 arch/arm/plat-s3c24xx/gpiolib.c                |    2 +-
 arch/arm/plat-samsung/Makefile                 |    1 -
 arch/arm/plat-samsung/gpio.c                   |  167 ----------------------
 arch/arm/plat-samsung/include/plat/gpio-core.h |   18 +--
 drivers/gpio/gpio-plat-samsung.c               |  182 +++++++++++++++++++++++-
 7 files changed, 183 insertions(+), 216 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/gpio.c

diff --git a/arch/arm/mach-s3c64xx/gpiolib.c b/arch/arm/mach-s3c64xx/gpiolib.c
index 92b0908..75f32f6 100644
--- a/arch/arm/mach-s3c64xx/gpiolib.c
+++ b/arch/arm/mach-s3c64xx/gpiolib.c
@@ -257,32 +257,11 @@ static struct s3c_gpio_chip gpio_2bit[] = {
 	},
 };
 
-static __init void s3c64xx_gpiolib_add_2bit(struct s3c_gpio_chip *chip)
-{
-	chip->pm = __gpio_pm(&s3c_gpio_pm_2bit);
-}
-
-static __init void s3c64xx_gpiolib_add(struct s3c_gpio_chip *chips,
-				       int nr_chips,
-				       void (*fn)(struct s3c_gpio_chip *))
-{
-	for (; nr_chips > 0; nr_chips--, chips++) {
-		if (fn)
-			(fn)(chips);
-		s3c_gpiolib_add(chips);
-	}
-}
-
 static __init int s3c64xx_gpiolib_init(void)
 {
-	s3c64xx_gpiolib_add(gpio_4bit, ARRAY_SIZE(gpio_4bit),
-			    samsung_gpiolib_add_4bit);
-
-	s3c64xx_gpiolib_add(gpio_4bit2, ARRAY_SIZE(gpio_4bit2),
-			    samsung_gpiolib_add_4bit2);
-
-	s3c64xx_gpiolib_add(gpio_2bit, ARRAY_SIZE(gpio_2bit),
-			    s3c64xx_gpiolib_add_2bit);
+	samsung_gpiolib_add_4bit_chips(gpio_4bit, ARRAY_SIZE(gpio_4bit));
+	samsung_gpiolib_add_4bit2_chips(gpio_4bit2, ARRAY_SIZE(gpio_4bit2));
+	samsung_gpiolib_add_2bit_chips(gpio_2bit, ARRAY_SIZE(gpio_2bit));
 
 	return 0;
 }
diff --git a/arch/arm/mach-s5p64x0/gpiolib.c b/arch/arm/mach-s5p64x0/gpiolib.c
index e7fb3b0..a770735 100644
--- a/arch/arm/mach-s5p64x0/gpiolib.c
+++ b/arch/arm/mach-s5p64x0/gpiolib.c
@@ -467,7 +467,7 @@ static void __init s5p64x0_gpio_add_rbank_4bit2(struct s3c_gpio_chip *chip,
 		chip->chip.direction_input = s5p64x0_gpiolib_rbank_4bit2_input;
 		chip->chip.direction_output =
 					s5p64x0_gpiolib_rbank_4bit2_output;
-		s3c_gpiolib_add(chip);
+		samsung_gpiolib_add_chips(chip);
 	}
 }
 
diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 243b641..de2b4e2 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -220,7 +220,7 @@ static __init int s3c24xx_gpiolib_init(void)
 		if (!chip->config)
 			chip->config = &s3c24xx_gpiocfg_default;
 
-		s3c_gpiolib_add(chip);
+		samsung_gpiolib_add_2bit_chips(chip, ARRAY_SIZE(chip));
 	}
 
 	return 0;
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 53eb15b..b9deba4 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -15,7 +15,6 @@ obj-y				+= init.o
 obj-$(CONFIG_ARCH_USES_GETTIMEOFFSET)   += time.o
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
-obj-y				+= gpio.o
 obj-y				+= gpio-config.o
 obj-y				+= dev-asocdma.o
 
diff --git a/arch/arm/plat-samsung/gpio.c b/arch/arm/plat-samsung/gpio.c
deleted file mode 100644
index 7743c4b..0000000
--- a/arch/arm/plat-samsung/gpio.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/* linux/arch/arm/plat-s3c/gpio.c
- *
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series GPIO core
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/spinlock.h>
-
-#include <plat/gpio-core.h>
-
-#ifdef CONFIG_S3C_GPIO_TRACK
-struct s3c_gpio_chip *s3c_gpios[S3C_GPIO_END];
-
-static __init void s3c_gpiolib_track(struct s3c_gpio_chip *chip)
-{
-	unsigned int gpn;
-	int i;
-
-	gpn = chip->chip.base;
-	for (i = 0; i < chip->chip.ngpio; i++, gpn++) {
-		BUG_ON(gpn >= ARRAY_SIZE(s3c_gpios));
-		s3c_gpios[gpn] = chip;
-	}
-}
-#endif /* CONFIG_S3C_GPIO_TRACK */
-
-/* Default routines for controlling GPIO, based on the original S3C24XX
- * GPIO functions which deal with the case where each gpio bank of the
- * chip is as following:
- *
- * base + 0x00: Control register, 2 bits per gpio
- *	        gpio n: 2 bits starting at (2*n)
- *		00 = input, 01 = output, others mean special-function
- * base + 0x04: Data register, 1 bit per gpio
- *		bit n: data bit n
-*/
-
-static int s3c_gpiolib_input(struct gpio_chip *chip, unsigned offset)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long flags;
-	unsigned long con;
-
-	s3c_gpio_lock(ourchip, flags);
-
-	con = __raw_readl(base + 0x00);
-	con &= ~(3 << (offset * 2));
-
-	__raw_writel(con, base + 0x00);
-
-	s3c_gpio_unlock(ourchip, flags);
-	return 0;
-}
-
-static int s3c_gpiolib_output(struct gpio_chip *chip,
-			      unsigned offset, int value)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long flags;
-	unsigned long dat;
-	unsigned long con;
-
-	s3c_gpio_lock(ourchip, flags);
-
-	dat = __raw_readl(base + 0x04);
-	dat &= ~(1 << offset);
-	if (value)
-		dat |= 1 << offset;
-	__raw_writel(dat, base + 0x04);
-
-	con = __raw_readl(base + 0x00);
-	con &= ~(3 << (offset * 2));
-	con |= 1 << (offset * 2);
-
-	__raw_writel(con, base + 0x00);
-	__raw_writel(dat, base + 0x04);
-
-	s3c_gpio_unlock(ourchip, flags);
-	return 0;
-}
-
-static void s3c_gpiolib_set(struct gpio_chip *chip,
-			    unsigned offset, int value)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long flags;
-	unsigned long dat;
-
-	s3c_gpio_lock(ourchip, flags);
-
-	dat = __raw_readl(base + 0x04);
-	dat &= ~(1 << offset);
-	if (value)
-		dat |= 1 << offset;
-	__raw_writel(dat, base + 0x04);
-
-	s3c_gpio_unlock(ourchip, flags);
-}
-
-static int s3c_gpiolib_get(struct gpio_chip *chip, unsigned offset)
-{
-	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
-	unsigned long val;
-
-	val = __raw_readl(ourchip->base + 0x04);
-	val >>= offset;
-	val &= 1;
-
-	return val;
-}
-
-__init void s3c_gpiolib_add(struct s3c_gpio_chip *chip)
-{
-	struct gpio_chip *gc = &chip->chip;
-	int ret;
-
-	BUG_ON(!chip->base);
-	BUG_ON(!gc->label);
-	BUG_ON(!gc->ngpio);
-
-	spin_lock_init(&chip->lock);
-
-	if (!gc->direction_input)
-		gc->direction_input = s3c_gpiolib_input;
-	if (!gc->direction_output)
-		gc->direction_output = s3c_gpiolib_output;
-	if (!gc->set)
-		gc->set = s3c_gpiolib_set;
-	if (!gc->get)
-		gc->get = s3c_gpiolib_get;
-
-#ifdef CONFIG_PM
-	if (chip->pm != NULL) {
-		if (!chip->pm->save || !chip->pm->resume)
-			printk(KERN_ERR "gpio: %s has missing PM functions\n",
-			       gc->label);
-	} else
-		printk(KERN_ERR "gpio: %s has no PM function\n", gc->label);
-#endif
-
-	/* gpiochip_add() prints own failure message on error. */
-	ret = gpiochip_add(gc);
-	if (ret >= 0)
-		s3c_gpiolib_track(chip);
-}
-
-int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
-{
-	struct s3c_gpio_chip *s3c_chip = container_of(chip,
-			struct s3c_gpio_chip, chip);
-
-	return s3c_chip->irq_base + offset;
-}
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index 8cad4cf..f76c3e3 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -78,16 +78,6 @@ static inline struct s3c_gpio_chip *to_s3c_gpio(struct gpio_chip *gpc)
 	return container_of(gpc, struct s3c_gpio_chip, chip);
 }
 
-/** s3c_gpiolib_add() - add the s3c specific version of a gpio_chip.
- * @chip: The chip to register
- *
- * This is a wrapper to gpiochip_add() that takes our specific gpio chip
- * information and makes the necessary alterations for the platform and
- * notes the information for use with the configuration systems and any
- * other parts of the system.
- */
-extern void s3c_gpiolib_add(struct s3c_gpio_chip *chip);
-
 /* CONFIG_S3C_GPIO_TRACK enables the tracking of the s3c specific gpios
  * for use with the configuration calls, and other parts of the s3c gpiolib
  * support code.
@@ -120,10 +110,8 @@ extern void samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 					    int nr_chips);
 extern void samsung_gpiolib_add_2bit_chips(struct s3c_gpio_chip *chip,
 					   int nr_chips);
-
-extern void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip);
-extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
-
+extern void samsung_gpiolib_add_chips(struct s3c_gpio_chip *chip,
+					   int nr_chips);
 
 /**
  * samsung_gpiolib_to_irq - convert gpio pin to irq number
@@ -150,7 +138,7 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int chip)
 
 #include <mach/gpio-track.h>
 
-static inline void s3c_gpiolib_track(struct s3c_gpio_chip *chip) { }
+static inline void samsung_gpiolib_track(struct s3c_gpio_chip *chip) { }
 #endif
 
 #ifdef CONFIG_PM
diff --git a/drivers/gpio/gpio-plat-samsung.c b/drivers/gpio/gpio-plat-samsung.c
index ea37c04..a2fc6f3 100644
--- a/drivers/gpio/gpio-plat-samsung.c
+++ b/drivers/gpio/gpio-plat-samsung.c
@@ -7,6 +7,9 @@
  *
  * Copyright (c) 2009 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
+ 
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
  *
  * SAMSUNG - GPIOlib support
  *
@@ -29,6 +32,63 @@
 #define gpio_dbg(x...) printk(KERN_DEBUG x)
 #endif
 
+/* Default routines for controlling GPIO, based on the original S3C24XX
+ * GPIO functions which deal with the case where each gpio bank of the
+ * chip is as following:
+ *
+ * base + 0x00: Control register, 2 bits per gpio
+ *	        gpio n: 2 bits starting at (2*n)
+ *		00 = input, 01 = output, others mean special-function
+ * base + 0x04: Data register, 1 bit per gpio
+ *		bit n: data bit n
+*/
+
+static int samsung_gpiolib_2bit_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	unsigned long flags;
+	unsigned long con;
+
+	s3c_gpio_lock(ourchip, flags);
+
+	con = __raw_readl(base + GPIOCON_OFF);
+	con &= ~(3 << (offset * 2));
+
+	__raw_writel(con, base + GPIOCON_OFF);
+
+	s3c_gpio_unlock(ourchip, flags);
+	return 0;
+}
+
+static int samsung_gpiolib_2bit_output(struct gpio_chip *chip,
+			      unsigned offset, int value)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	unsigned long flags;
+	unsigned long dat;
+	unsigned long con;
+
+	s3c_gpio_lock(ourchip, flags);
+
+	dat = __raw_readl(base + GPIODAT_OFF);
+	dat &= ~(1 << offset);
+	if (value)
+		dat |= 1 << offset;
+	__raw_writel(dat, base + GPIODAT_OFF);
+
+	con = __raw_readl(base + GPIOCON_OFF);
+	con &= ~(3 << (offset * 2));
+	con |= 1 << (offset * 2);
+
+	__raw_writel(con, base + GPIOCON_OFF);
+	__raw_writel(dat, base + GPIODAT_OFF);
+
+	s3c_gpio_unlock(ourchip, flags);
+	return 0;
+}
+
 /* The samsung_gpiolib_4bit routines are to control the gpio banks where
  * the gpio configuration register (GPxCON) has 4 bits per GPIO, as the
  * following example:
@@ -166,26 +226,134 @@ static int samsung_gpiolib_4bit2_output(struct gpio_chip *chip,
 	return 0;
 }
 
-void __init samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip)
+static void samsung_gpiolib_set(struct gpio_chip *chip,
+			    unsigned offset, int value)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	unsigned long flags;
+	unsigned long dat;
+
+	s3c_gpio_lock(ourchip, flags);
+
+	dat = __raw_readl(base + 0x04);
+	dat &= ~(1 << offset);
+	if (value)
+		dat |= 1 << offset;
+	__raw_writel(dat, base + 0x04);
+
+	s3c_gpio_unlock(ourchip, flags);
+}
+
+static int samsung_gpiolib_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	unsigned long val;
+
+	val = __raw_readl(ourchip->base + 0x04);
+	val >>= offset;
+	val &= 1;
+
+	return val;
+}
+
+#ifdef CONFIG_S3C_GPIO_TRACK
+struct s3c_gpio_chip *s3c_gpios[S3C_GPIO_END];
+
+static __init void samsung_gpiolib_track(struct s3c_gpio_chip *chip)
+{
+	unsigned int gpn;
+	int i;
+
+	gpn = chip->chip.base;
+	for (i = 0; i < chip->chip.ngpio; i++, gpn++) {
+		BUG_ON(gpn >= ARRAY_SIZE(s3c_gpios));
+		s3c_gpios[gpn] = chip;
+	}
+}
+#endif
+
+static void samsung_gpiolib_add_2bit(struct s3c_gpio_chip *chip)
+{
+	chip->chip.direction_input = samsung_gpiolib_2bit_input;
+	chip->chip.direction_output = samsung_gpiolib_2bit_output;
+
+#ifdef CONFIG_ARCH_S3C64XX
+	chip->pm = __gpio_pm(&s3c_gpio_pm_2bit);
+#endif
+}
+
+static void samsung_gpiolib_add_4bit(struct s3c_gpio_chip *chip)
 {
 	chip->chip.direction_input = samsung_gpiolib_4bit_input;
 	chip->chip.direction_output = samsung_gpiolib_4bit_output;
 	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
 }
 
-void __init samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip)
+static void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip)
 {
 	chip->chip.direction_input = samsung_gpiolib_4bit2_input;
 	chip->chip.direction_output = samsung_gpiolib_4bit2_output;
 	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
 }
 
+static void samsung_gpiolib_add(struct s3c_gpio_chip *chip)
+{
+	struct gpio_chip *gc = &chip->chip;
+	int ret;
+
+	BUG_ON(!chip->base);
+	BUG_ON(!gc->label);
+	BUG_ON(!gc->ngpio);
+
+	spin_lock_init(&chip->lock);
+
+	if (!gc->direction_input)
+		gc->direction_input = samsung_gpiolib_2bit_input;
+	if (!gc->direction_output)
+		gc->direction_output = samsung_gpiolib_2bit_output;
+	if (!gc->set)
+		gc->set = samsung_gpiolib_set;
+	if (!gc->get)
+		gc->get = samsung_gpiolib_get;
+
+#ifdef CONFIG_PM
+	if (chip->pm != NULL) {
+		if (!chip->pm->save || !chip->pm->resume)
+			printk(KERN_ERR "gpio: %s has missing PM functions\n",
+			       gc->label);
+	} else
+		printk(KERN_ERR "gpio: %s has no PM function\n", gc->label);
+#endif
+
+	/* gpiochip_add() prints own failure message on error. */
+	ret = gpiochip_add(gc);
+	if (ret >= 0)
+		samsung_gpiolib_track(chip);
+}
+
+int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct s3c_gpio_chip *s3c_chip = container_of(chip,
+			struct s3c_gpio_chip, chip);
+	return s3c_chip->irq_base + offset;
+}
+
+void __init samsung_gpiolib_add_2bit_chips(struct s3c_gpio_chip *chip,
+					   int nr_chips)
+{
+	for (; nr_chips > 0; nr_chips--, chip++) {
+		samsung_gpiolib_add_2bit(chip);
+		samsung_gpiolib_add(chip);
+	}
+}
+
 void __init samsung_gpiolib_add_4bit_chips(struct s3c_gpio_chip *chip,
 					   int nr_chips)
 {
 	for (; nr_chips > 0; nr_chips--, chip++) {
 		samsung_gpiolib_add_4bit(chip);
-		s3c_gpiolib_add(chip);
+		samsung_gpiolib_add(chip);
 	}
 }
 
@@ -194,13 +362,13 @@ void __init samsung_gpiolib_add_4bit2_chips(struct s3c_gpio_chip *chip,
 {
 	for (; nr_chips > 0; nr_chips--, chip++) {
 		samsung_gpiolib_add_4bit2(chip);
-		s3c_gpiolib_add(chip);
+		samsung_gpiolib_add(chip);
 	}
 }
 
-void __init samsung_gpiolib_add_2bit_chips(struct s3c_gpio_chip *chip,
-					   int nr_chips)
+void __init samsung_gpiolib_add_chips(struct s3c_gpio_chip *chip,
+					    int nr_chips)
 {
 	for (; nr_chips > 0; nr_chips--, chip++)
-		s3c_gpiolib_add(chip);
+		samsung_gpiolib_add(chip);
 }
