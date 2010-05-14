From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 08:19:05 +0200
Subject: [PATCH 14/15] ARM: S5PC100: Add support for gpio interrupt
In-Reply-To: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1273817946-29404-15-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves support for gpio interrupts from plat-s5pc1xx to
mach-s5pc100 directory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/Makefile                     |    2 +-
 arch/arm/mach-s5pc100/gpio.c                       |   10 +--
 arch/arm/{plat-s5pc1xx => mach-s5pc100}/irq-gpio.c |   78 ++++++++++----------
 3 files changed, 44 insertions(+), 46 deletions(-)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/irq-gpio.c (72%)

diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index c51b580..9976269 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -11,7 +11,7 @@ obj-				:=
 
 # Core support for S5PC100 system
 
-obj-$(CONFIG_CPU_S5PC100)	+= cpu.o init.o clock.o gpio.o
+obj-$(CONFIG_CPU_S5PC100)	+= cpu.o init.o clock.o gpio.o irq-gpio.o
 obj-$(CONFIG_CPU_S5PC100)	+= setup-i2c0.o
 
 # Helper and device support
diff --git a/arch/arm/mach-s5pc100/gpio.c b/arch/arm/mach-s5pc100/gpio.c
index df539f6..0fab7f2 100644
--- a/arch/arm/mach-s5pc100/gpio.c
+++ b/arch/arm/mach-s5pc100/gpio.c
@@ -386,7 +386,6 @@ extern void s5pc100_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 
 static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 {
-#if 0
 	/* Interrupt */
 	if (chip->config == &gpio_cfg) {
 		int i, irq;
@@ -400,10 +399,9 @@ static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 			set_irq_handler(irq, handle_level_irq);
 			set_irq_flags(irq, IRQF_VALID);
 		}
-	} else
-#endif
-	if (chip->config == &gpio_cfg_eint)
+	} else if (chip->config == &gpio_cfg_eint) {
 		chip->chip.to_irq = s5pc100_gpiolib_to_eint;
+	}
 }
 
 static __init int s5pc100_gpiolib_init(void)
@@ -419,10 +417,10 @@ static __init int s5pc100_gpiolib_init(void)
 
 	samsung_gpiolib_add_4bit_chips(s5pc100_gpio_chips,
 				       ARRAY_SIZE(s5pc100_gpio_chips));
-#if 0
+
 	/* Interrupt */
 	set_irq_chained_handler(IRQ_GPIOINT, s5pc100_irq_gpioint_handler);
-#endif
+
 	return 0;
 }
 core_initcall(s5pc100_gpiolib_init);
diff --git a/arch/arm/plat-s5pc1xx/irq-gpio.c b/arch/arm/mach-s5pc100/irq-gpio.c
similarity index 72%
rename from arch/arm/plat-s5pc1xx/irq-gpio.c
rename to arch/arm/mach-s5pc100/irq-gpio.c
index fecca7a..2bf86c1 100644
--- a/arch/arm/plat-s5pc1xx/irq-gpio.c
+++ b/arch/arm/mach-s5pc100/irq-gpio.c
@@ -1,9 +1,9 @@
 /*
- * arch/arm/plat-s5pc1xx/irq-gpio.c
+ * arch/arm/mach-s5pc100/irq-gpio.c
  *
  * Copyright (C) 2009 Samsung Electronics
  *
- * S5PC1XX - Interrupt handling for IRQ_GPIO${group}(x)
+ * S5PC100 - Interrupt handling for IRQ_GPIO${group}(x)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -19,7 +19,7 @@
 #include <mach/map.h>
 #include <plat/gpio-cfg.h>
 
-#define S5PC1XX_GPIOREG(x)		(S5PC1XX_VA_GPIO + (x))
+#define S5P_GPIOREG(x)		(S5P_VA_GPIO + (x))
 
 #define CON_OFFSET			0x700
 #define MASK_OFFSET			0x900
@@ -49,7 +49,7 @@ static int group_to_pend_offset(int group)
 	return group << 2;
 }
 
-static int s5pc1xx_get_start(unsigned int group)
+static int s5pc100_get_start(unsigned int group)
 {
 	switch (group) {
 	case 0: return S5PC100_GPIO_A0_START;
@@ -80,7 +80,7 @@ static int s5pc1xx_get_start(unsigned int group)
 	return -EINVAL;
 }
 
-static int s5pc1xx_get_group(unsigned int irq)
+static int s5pc100_get_group(unsigned int irq)
 {
 	irq -= S3C_IRQ_GPIO(0);
 
@@ -134,67 +134,67 @@ static int s5pc1xx_get_group(unsigned int irq)
 	return -EINVAL;
 }
 
-static int s5pc1xx_get_offset(unsigned int irq)
+static int s5pc100_get_offset(unsigned int irq)
 {
 	struct gpio_chip *chip = get_irq_data(irq);
 	return irq - S3C_IRQ_GPIO(chip->base);
 }
 
-static void s5pc1xx_gpioint_ack(unsigned int irq)
+static void s5pc100_gpioint_ack(unsigned int irq)
 {
 	int group, offset, pend_offset;
 	unsigned int value;
 
-	group = s5pc1xx_get_group(irq);
-	offset = s5pc1xx_get_offset(irq);
+	group = s5pc100_get_group(irq);
+	offset = s5pc100_get_offset(irq);
 	pend_offset = group_to_pend_offset(group);
 
-	value = __raw_readl(S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
+	value = __raw_readl(S5P_GPIOREG(PEND_OFFSET) + pend_offset);
 	value |= 1 << offset;
-	__raw_writel(value, S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
+	__raw_writel(value, S5P_GPIOREG(PEND_OFFSET) + pend_offset);
 }
 
-static void s5pc1xx_gpioint_mask(unsigned int irq)
+static void s5pc100_gpioint_mask(unsigned int irq)
 {
 	int group, offset, mask_offset;
 	unsigned int value;
 
-	group = s5pc1xx_get_group(irq);
-	offset = s5pc1xx_get_offset(irq);
+	group = s5pc100_get_group(irq);
+	offset = s5pc100_get_offset(irq);
 	mask_offset = group_to_mask_offset(group);
 
-	value = __raw_readl(S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+	value = __raw_readl(S5P_GPIOREG(MASK_OFFSET) + mask_offset);
 	value |= 1 << offset;
-	__raw_writel(value, S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+	__raw_writel(value, S5P_GPIOREG(MASK_OFFSET) + mask_offset);
 }
 
-static void s5pc1xx_gpioint_unmask(unsigned int irq)
+static void s5pc100_gpioint_unmask(unsigned int irq)
 {
 	int group, offset, mask_offset;
 	unsigned int value;
 
-	group = s5pc1xx_get_group(irq);
-	offset = s5pc1xx_get_offset(irq);
+	group = s5pc100_get_group(irq);
+	offset = s5pc100_get_offset(irq);
 	mask_offset = group_to_mask_offset(group);
 
-	value = __raw_readl(S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+	value = __raw_readl(S5P_GPIOREG(MASK_OFFSET) + mask_offset);
 	value &= ~(1 << offset);
-	__raw_writel(value, S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+	__raw_writel(value, S5P_GPIOREG(MASK_OFFSET) + mask_offset);
 }
 
-static void s5pc1xx_gpioint_mask_ack(unsigned int irq)
+static void s5pc100_gpioint_mask_ack(unsigned int irq)
 {
-	s5pc1xx_gpioint_mask(irq);
-	s5pc1xx_gpioint_ack(irq);
+	s5pc100_gpioint_mask(irq);
+	s5pc100_gpioint_ack(irq);
 }
 
-static int s5pc1xx_gpioint_set_type(unsigned int irq, unsigned int type)
+static int s5pc100_gpioint_set_type(unsigned int irq, unsigned int type)
 {
 	int group, offset, con_offset;
 	unsigned int value;
 
-	group = s5pc1xx_get_group(irq);
-	offset = s5pc1xx_get_offset(irq);
+	group = s5pc100_get_group(irq);
+	offset = s5pc100_get_offset(irq);
 	con_offset = group_to_con_offset(group);
 
 	switch (type) {
@@ -221,24 +221,24 @@ static int s5pc1xx_gpioint_set_type(unsigned int irq, unsigned int type)
 	}
 
 
-	value = __raw_readl(S5PC1XX_GPIOREG(CON_OFFSET) + con_offset);
+	value = __raw_readl(S5P_GPIOREG(CON_OFFSET) + con_offset);
 	value &= ~(0xf << (offset * 0x4));
 	value |= (type << (offset * 0x4));
-	__raw_writel(value, S5PC1XX_GPIOREG(CON_OFFSET) + con_offset);
+	__raw_writel(value, S5P_GPIOREG(CON_OFFSET) + con_offset);
 
 	return 0;
 }
 
-struct irq_chip s5pc1xx_gpioint = {
+struct irq_chip s5pc100_gpioint = {
 	.name		= "GPIO",
-	.ack		= s5pc1xx_gpioint_ack,
-	.mask		= s5pc1xx_gpioint_mask,
-	.mask_ack	= s5pc1xx_gpioint_mask_ack,
-	.unmask		= s5pc1xx_gpioint_unmask,
-	.set_type	= s5pc1xx_gpioint_set_type,
+	.ack		= s5pc100_gpioint_ack,
+	.mask		= s5pc100_gpioint_mask,
+	.mask_ack	= s5pc100_gpioint_mask_ack,
+	.unmask		= s5pc100_gpioint_unmask,
+	.set_type	= s5pc100_gpioint_set_type,
 };
 
-void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
+void s5pc100_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 {
 	int group, offset, pend_offset, mask_offset;
 	int real_irq, group_end;
@@ -248,17 +248,17 @@ void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 
 	for (group = 0; group < group_end; group++) {
 		pend_offset = group_to_pend_offset(group);
-		pend = __raw_readl(S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
+		pend = __raw_readl(S5P_GPIOREG(PEND_OFFSET) + pend_offset);
 		if (!pend)
 			continue;
 
 		mask_offset = group_to_mask_offset(group);
-		mask = __raw_readl(S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+		mask = __raw_readl(S5P_GPIOREG(MASK_OFFSET) + mask_offset);
 		pend &= ~mask;
 
 		for (offset = 0; offset < 8; offset++) {
 			if (pend & (1 << offset)) {
-				real_irq = s5pc1xx_get_start(group) + offset;
+				real_irq = s5pc100_get_start(group) + offset;
 				generic_handle_irq(S3C_IRQ_GPIO(real_irq));
 			}
 		}
-- 
1.6.4
