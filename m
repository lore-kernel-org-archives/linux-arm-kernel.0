From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 11 Jun 2010 17:33:17 +0900
Subject: [PATCH v2 1/4] ARM: S5PV210: Add gpio interrupt support
Message-ID: <1276245200-18052-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to support gpio interrupts on s5pv210.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/gpiolib.c                |    8 +-
 arch/arm/mach-s5pv210/include/mach/irqs.h      |   16 ++-
 arch/arm/plat-s5p/Makefile                     |    2 +-
 arch/arm/plat-s5p/irq-gpioint.c                |  208 ++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/gpio-core.h |    2 +
 5 files changed, 233 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-s5p/irq-gpioint.c

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 9ea8972..16d6747 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -150,6 +150,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "GPG3",
 		},
 	}, {
+		.config	= &gpio_cfg_noint,
 		.chip	= {
 			.base	= S5PV210_GPI(0),
 			.ngpio	= S5PV210_GPIO_I_NR,
@@ -245,11 +246,16 @@ static __init int s5pv210_gpiolib_init(void)
 {
 	struct s3c_gpio_chip *chip = s5pv210_gpio_4bit;
 	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
+	int gpioint_group = 0;
 	int i = 0;
 
 	for (i = 0; i < nr_chips; i++, chip++) {
-		if (chip->config == NULL)
+		if (chip->config == NULL) {
 			chip->config = &gpio_cfg;
+
+			/* gpio interrupts */
+			s5p_gpioint_add(chip, gpioint_group++);
+		}
 		if (chip->base == NULL)
 			chip->base = S5PV210_BANK_BASE(i);
 	}
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 9689537..43baacc 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -121,8 +121,22 @@
 #define S5P_EINT_BASE1		(S5P_IRQ_VIC0(0))
 #define S5P_EINT_BASE2		(IRQ_VIC_END + 1)
 
+/* GPIO interrupt */
+#define S5P_GPIOINT_GROUP_NR	22
+#define S5P_GPIOINT_BASE	(IRQ_EINT(31) + 1)
+#define S5P_IRQ_GPIOINT(x)	(S5P_GPIOINT_BASE + (x))
+
 /* Set the default NR_IRQS */
-#define NR_IRQS			(IRQ_EINT(31) + 1)
+
+/*
+ * GPIO groups is 27. Each GPIO group can have max 8 GPIO interrupts.
+ *
+ * We should include gpios of all gpio groups from GPIO_A0 until GPIO_J4 to
+ * NR_IRQS because 22 gpio groups having gpio interrupts aren't in order and
+ * are mixed with no interrupt gpio groups, then it can give simple irq
+ * computation of gpio interrupts.
+ */
+#define NR_IRQS			(S5P_IRQ_GPIOINT(27 * 8) + 1)
 
 /* Compatibility */
 #define IRQ_LCD_FIFO		IRQ_LCD0
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 39c242b..b56b4d3 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -15,6 +15,6 @@ obj-				:=
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
-obj-y				+= irq.o
+obj-y				+= irq.o irq-gpioint.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 
diff --git a/arch/arm/plat-s5p/irq-gpioint.c b/arch/arm/plat-s5p/irq-gpioint.c
new file mode 100644
index 0000000..c172e37
--- /dev/null
+++ b/arch/arm/plat-s5p/irq-gpioint.c
@@ -0,0 +1,208 @@
+/*
+ * linux/arch/arm/plat-s5p/irq-gpioint.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Kyungmin Park <kyungmin.park@samsung.com>
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <mach/map.h>
+#include <plat/gpio-core.h>
+#include <plat/gpio-cfg.h>
+
+#define S5P_GPIOREG(x)			(S5P_VA_GPIO + (x))
+
+#define GPIOINT_CON_OFFSET		0x700
+#define GPIOINT_MASK_OFFSET		0x900
+#define GPIOINT_PEND_OFFSET		0xA00
+
+#define GPIOINT_LEVEL_LOW		0x0
+#define GPIOINT_LEVEL_HIGH		0x1
+#define GPIOINT_EDGE_FALLING		0x2
+#define GPIOINT_EDGE_RISING		0x3
+#define GPIOINT_EDGE_BOTH		0x4
+
+static struct s3c_gpio_chip *s3c_chips[S5P_GPIOINT_GROUP_NR];
+
+static int s5p_gpioint_get_group(unsigned int irq)
+{
+	struct gpio_chip *chip = get_irq_data(irq);
+	struct s3c_gpio_chip *s3c_chip = container_of(chip,
+			struct s3c_gpio_chip, chip);
+	int group;
+
+	for (group = 0; group < S5P_GPIOINT_GROUP_NR; group++)
+		if (s3c_chip == s3c_chips[group])
+			break;
+
+	return group;
+}
+
+static int s5p_gpioint_get_offset(unsigned int irq)
+{
+	struct gpio_chip *chip = get_irq_data(irq);
+	return irq - S5P_IRQ_GPIOINT(chip->base);
+}
+
+static void s5p_gpioint_ack(unsigned int irq)
+{
+	int group, offset, pend_offset;
+	unsigned int value;
+
+	group = s5p_gpioint_get_group(irq);
+	offset = s5p_gpioint_get_offset(irq);
+	pend_offset = group << 2;
+
+	value = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
+	value |= 1 << offset;
+	__raw_writel(value, S5P_GPIOREG(GPIOINT_PEND_OFFSET) + pend_offset);
+}
+
+static void s5p_gpioint_mask(unsigned int irq)
+{
+	int group, offset, mask_offset;
+	unsigned int value;
+
+	group = s5p_gpioint_get_group(irq);
+	offset = s5p_gpioint_get_offset(irq);
+	mask_offset = group << 2;
+
+	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
+	value |= 1 << offset;
+	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
+}
+
+static void s5p_gpioint_unmask(unsigned int irq)
+{
+	int group, offset, mask_offset;
+	unsigned int value;
+
+	group = s5p_gpioint_get_group(irq);
+	offset = s5p_gpioint_get_offset(irq);
+	mask_offset = group << 2;
+
+	value = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
+	value &= ~(1 << offset);
+	__raw_writel(value, S5P_GPIOREG(GPIOINT_MASK_OFFSET) + mask_offset);
+}
+
+static void s5p_gpioint_mask_ack(unsigned int irq)
+{
+	s5p_gpioint_mask(irq);
+	s5p_gpioint_ack(irq);
+}
+
+static int s5p_gpioint_set_type(unsigned int irq, unsigned int type)
+{
+	int group, offset, con_offset;
+	unsigned int value;
+
+	group = s5p_gpioint_get_group(irq);
+	offset = s5p_gpioint_get_offset(irq);
+	con_offset = group << 2;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		printk(KERN_WARNING "No irq type\n");
+		return -EINVAL;
+	case IRQ_TYPE_EDGE_RISING:
+		type = GPIOINT_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = GPIOINT_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		type = GPIOINT_EDGE_BOTH;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		type = GPIOINT_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type = GPIOINT_LEVEL_LOW;
+		break;
+	default:
+		BUG();
+	}
+
+	value = __raw_readl(S5P_GPIOREG(GPIOINT_CON_OFFSET) + con_offset);
+	value &= ~(0xf << (offset * 0x4));
+	value |= (type << (offset * 0x4));
+	__raw_writel(value, S5P_GPIOREG(GPIOINT_CON_OFFSET) + con_offset);
+
+	return 0;
+}
+
+struct irq_chip s5p_gpioint = {
+	.name		= "GPIO",
+	.ack		= s5p_gpioint_ack,
+	.mask		= s5p_gpioint_mask,
+	.mask_ack	= s5p_gpioint_mask_ack,
+	.unmask		= s5p_gpioint_unmask,
+	.set_type	= s5p_gpioint_set_type,
+};
+
+static void s5p_gpioint_handler(unsigned int irq, struct irq_desc *desc)
+{
+	int group, offset, pend_offset, mask_offset;
+	int real_irq;
+	unsigned int pend, mask;
+
+	for (group = 0; group < S5P_GPIOINT_GROUP_NR; group++) {
+		pend_offset = group << 2;
+		pend = __raw_readl(S5P_GPIOREG(GPIOINT_PEND_OFFSET) +
+				pend_offset);
+		if (!pend)
+			continue;
+
+		mask_offset = group << 2;
+		mask = __raw_readl(S5P_GPIOREG(GPIOINT_MASK_OFFSET) +
+				mask_offset);
+		pend &= ~mask;
+
+		for (offset = 0; offset < 8; offset++) {
+			if (pend & (1 << offset)) {
+				real_irq = s3c_chips[group]->chip.base +
+					   offset;
+				generic_handle_irq(S5P_IRQ_GPIOINT(real_irq));
+			}
+		}
+	}
+}
+
+void s5p_gpioint_add(struct s3c_gpio_chip *chip, int group)
+{
+	int irq;
+	int i;
+
+	s3c_chips[group] = chip;
+
+	for (i = 0; i < chip->chip.ngpio; i++) {
+		irq = S5P_GPIOINT_BASE + chip->chip.base + i;
+		set_irq_chip(irq, &s5p_gpioint);
+		set_irq_data(irq, &chip->chip);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+}
+
+int __init s5p_gpioint_init(void)
+{
+	/* register gpio interrupt handler */
+	set_irq_chained_handler(IRQ_GPIOINT, s5p_gpioint_handler);
+
+	return 0;
+}
+
+arch_initcall(s5p_gpioint_init);
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index e358c7d..12ec82c 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -121,6 +121,8 @@ extern void samsung_gpiolib_add_4bit2(struct s3c_gpio_chip *chip);
 /* exported for core SoC support to change */
 extern struct s3c_gpio_cfg s3c24xx_gpiocfg_default;
 
+extern void s5p_gpioint_add(struct s3c_gpio_chip *chip, int group);
+
 #ifdef CONFIG_S3C_GPIO_TRACK
 extern struct s3c_gpio_chip *s3c_gpios[S3C_GPIO_END];
 
-- 
1.7.0.4
