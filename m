From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 16:54:20 +0100
Subject: [PATCH 5/9] lpc2k: gpiolib
In-Reply-To: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300377264-10843-6-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpiolib support, including gpio interrupts.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-lpc2k/Makefile                |    2 +-
 arch/arm/mach-lpc2k/gpio.c                  |  265 +++++++++++++++++++++++++++
 arch/arm/mach-lpc2k/include/mach/gpio.h     |   22 +++
 arch/arm/mach-lpc2k/include/mach/hardware.h |    2 +
 arch/arm/mach-lpc2k/include/mach/irqs.h     |   69 +++++++-
 6 files changed, 359 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/gpio.c
 create mode 100644 arch/arm/mach-lpc2k/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 35297f9..fce855d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -499,6 +499,7 @@ config ARCH_LPC2K
 	select CLKDEV_LOOKUP
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for NXP LPC2K family of SoCs. These SoCs are based on
 	  an ARM7TDMI-S core, and have optional on-chip flash and SRAM,
diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
index 267432c..89596a7 100644
--- a/arch/arm/mach-lpc2k/Makefile
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -1 +1 @@
-obj-y	:= clock.o irq.o time.o
+obj-y	:= clock.o irq.o gpio.o time.o
diff --git a/arch/arm/mach-lpc2k/gpio.c b/arch/arm/mach-lpc2k/gpio.c
new file mode 100644
index 0000000..44f0eb9
--- /dev/null
+++ b/arch/arm/mach-lpc2k/gpio.c
@@ -0,0 +1,265 @@
+/*
+ * Copyright (C) 2011 Team Embeded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
+#define LPC2K_GPIO_CHIP(name, base_gpio, nr_gpio, irqbase)		\
+	{								\
+		.chip = {						\
+			.label		  = name,			\
+			.direction_input  = lpc2k_dir_input,		\
+			.direction_output = lpc2k_dir_output,		\
+			.to_irq           = lpc2k_to_irq,		\
+			.get		  = lpc2k_gpio_get,		\
+			.set		  = lpc2k_gpio_set,		\
+			.base		  = base_gpio,			\
+			.ngpio		  = nr_gpio,			\
+		},							\
+		.irq_base = irqbase,					\
+	}
+
+#define to_lpc2k_gpio_chip(c) container_of(c, struct lpc2k_gpio_chip, chip)
+
+#define FIODIR	0x00
+#define FIOMASK	0x10
+#define FIOPIN	0x14
+#define FIOSET	0x18
+#define FIOCLR	0x1c
+
+struct lpc2k_gpio_chip {
+	struct gpio_chip chip;
+	void __iomem *regbase;
+	int irq_base;
+	spinlock_t gpio_lock;
+};
+
+static int lpc2k_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct lpc2k_gpio_chip *lpc2k_gpio = to_lpc2k_gpio_chip(chip);
+	if (lpc2k_gpio->irq_base < 0)
+		return -EINVAL;
+
+	return lpc2k_gpio->irq_base + offset;
+}
+
+static int lpc2k_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct lpc2k_gpio_chip *lpc2k_gpio = to_lpc2k_gpio_chip(chip);
+
+	return !!(readl(lpc2k_gpio->regbase + FIOPIN) & (1 << offset));
+}
+
+static void lpc2k_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
+{
+	struct lpc2k_gpio_chip *lpc2k_gpio = to_lpc2k_gpio_chip(chip);
+
+	writel(1 << offset, lpc2k_gpio->regbase + (val ? FIOSET : FIOCLR));
+}
+
+static int lpc2k_dir_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct lpc2k_gpio_chip *lpc2k_gpio = to_lpc2k_gpio_chip(chip);
+	void __iomem *pio = lpc2k_gpio->regbase + FIODIR;
+	unsigned int regval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lpc2k_gpio->gpio_lock, flags);
+
+	regval = readl(pio);
+	regval &= ~(1 << offset);
+	writel(regval, pio);
+
+	spin_unlock_irqrestore(&lpc2k_gpio->gpio_lock, flags);
+
+	return 0;
+}
+
+static int lpc2k_dir_output(struct gpio_chip *chip, unsigned offset, int val)
+{
+	struct lpc2k_gpio_chip *lpc2k_gpio = to_lpc2k_gpio_chip(chip);
+	unsigned int regval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lpc2k_gpio->gpio_lock, flags);
+
+	regval = readl(lpc2k_gpio->regbase + FIODIR);
+	regval |= (1 << offset);
+	writel(regval, lpc2k_gpio->regbase + FIODIR);
+
+	writel(1 << offset, lpc2k_gpio->regbase + (val ? FIOSET : FIOCLR));
+
+	spin_unlock_irqrestore(&lpc2k_gpio->gpio_lock, flags);
+
+	return 0;
+}
+
+static struct lpc2k_gpio_chip lpc2k_gpio[] = {
+	LPC2K_GPIO_CHIP("P0", 0, 32, IRQ_LPC2K_GPIO0),
+	LPC2K_GPIO_CHIP("P1", 32, 32, -1),
+	LPC2K_GPIO_CHIP("P2", 64, 32, IRQ_LPC2K_GPIO64),
+	LPC2K_GPIO_CHIP("P3", 96, 32, -1),
+	LPC2K_GPIO_CHIP("P4", 128, 32, -1),
+};
+
+#define IOINTSTAT	0x0080
+#define IO0INT		0x0084
+#define IO2INT		0x00a4
+
+#define IOINTSTATR	0x0000
+#define IOINTSTATF	0x0004
+#define IOINTCLR	0x0008
+#define IOINTENR	0x000c
+#define IOINTENF	0x0010
+
+static void lpc2k_gpio_enable_irq(struct irq_data *d)
+{
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned irq = d->irq & 31;
+	unsigned status = irq_to_desc(d->irq)->status;
+
+	status &= IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING;
+	if (!status)
+		status = IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING;
+
+	if (status & IRQ_TYPE_EDGE_RISING)
+		writel(readl(base + IOINTENR) | (1 << irq), base + IOINTENR);
+	else
+		writel(readl(base + IOINTENR) & ~(1 << irq), base + IOINTENR);
+
+	if (status & IRQ_TYPE_EDGE_FALLING)
+		writel(readl(base + IOINTENF) | (1 << irq), base + IOINTENF);
+	else
+		writel(readl(base + IOINTENF) & ~(1 << irq), base + IOINTENF);
+}
+
+static void lpc2k_gpio_disable_irq(struct irq_data *d)
+{
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	unsigned irq = d->irq & 31;
+
+	writel(readl(base + IOINTENR) & ~(1 << irq), base + IOINTENR);
+	writel(readl(base + IOINTENF) & ~(1 << irq), base + IOINTENF);
+}
+
+static int lpc2k_gpio_set_type(struct irq_data *d, unsigned trigger)
+{
+	void __iomem *base = irq_data_get_irq_chip_data(d);
+	struct irq_desc *desc = irq_to_desc(d->irq);
+	unsigned irq = d->irq & 31;
+
+	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
+		return -EINVAL;
+
+	desc->status &= ~IRQ_TYPE_SENSE_MASK;
+	desc->status |= trigger;
+
+	/* don't enable the IRQ if it's currently disabled */
+	if (desc->depth == 0) {
+		if (trigger & IRQ_TYPE_EDGE_RISING)
+			writel(readl(base + IOINTENR) | (1 << irq),
+			       base + IOINTENR);
+		else
+			writel(readl(base + IOINTENR) & ~(1 << irq),
+			       base + IOINTENR);
+
+		if (trigger & IRQ_TYPE_EDGE_FALLING)
+			writel(readl(base + IOINTENF) | (1 << irq),
+			       base + IOINTENF);
+		else
+			writel(readl(base + IOINTENF) & ~(1 << irq),
+			       base + IOINTENF);
+	}
+
+	return 0;
+}
+
+struct irq_chip gpio_irq_chip_p0 = {
+	.name = "GPIO-P0",
+	.irq_enable = lpc2k_gpio_enable_irq,
+	.irq_disable = lpc2k_gpio_disable_irq,
+	.irq_set_type = lpc2k_gpio_set_type,
+};
+
+struct irq_chip gpio_irq_chip_p2 = {
+	.name = "GPIO-P2",
+	.irq_enable = lpc2k_gpio_enable_irq,
+	.irq_disable = lpc2k_gpio_disable_irq,
+	.irq_set_type = lpc2k_gpio_set_type,
+};
+
+static void lpc2k_demux_gpio_irq(unsigned int irq, struct irq_desc *desc)
+{
+	u32 status = readl(APB_GPIO_BASE + IOINTSTAT);
+	if (status & 1) {
+		int i, stat = readl(APB_GPIO_BASE + IO0INT + IOINTSTATR) |
+		    readl(APB_GPIO_BASE + IO0INT + IOINTSTATF);
+
+		writel(stat, APB_GPIO_BASE + IO0INT + IOINTCLR);
+
+		for (i = 0; i < 32; i++)
+			if (stat & (1 << i))
+				generic_handle_irq(IRQ_LPC2K_GPIO0 + i);
+	}
+
+	if (status & 4) {
+		int i, stat = readl(APB_GPIO_BASE + IO2INT + IOINTSTATR) |
+		    readl(APB_GPIO_BASE + IO2INT + IOINTSTATF);
+
+		writel(stat, APB_GPIO_BASE + IO2INT + IOINTCLR);
+
+		for (i = 0; i < 32; i++)
+			if (stat & (1 << i))
+				generic_handle_irq(IRQ_LPC2K_GPIO64 + i);
+	}
+}
+
+static int __init lpc2k_init_gpio(void)
+{
+	struct lpc2k_gpio_chip *gpio_chip;
+	void __iomem *base;
+	unsigned i;
+
+	for (i = 0; i < ARRAY_SIZE(lpc2k_gpio); i++) {
+		gpio_chip = &lpc2k_gpio[i];
+		spin_lock_init(&gpio_chip->gpio_lock);
+		gpio_chip->regbase =
+		    (void __iomem *)(FAST_GPIO_BASE + i * 0x20);
+		gpiochip_add(&gpio_chip->chip);
+
+		writel(0, gpio_chip->regbase + FIOMASK);
+	}
+
+	base = (void __iomem *)(APB_GPIO_BASE + IO0INT);
+	for (i = IRQ_LPC2K_GPIO0; i <= IRQ_LPC2K_GPIO31; i++) {
+		set_irq_chip(i, &gpio_irq_chip_p0);
+		set_irq_chip_data(i, base);
+		set_irq_handler(i, handle_simple_irq);
+		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+	}
+
+	base = (void __iomem *)(APB_GPIO_BASE + IO2INT);
+	for (i = IRQ_LPC2K_GPIO64; i <= IRQ_LPC2K_GPIO95; i++) {
+		set_irq_chip(i, &gpio_irq_chip_p2);
+		set_irq_chip_data(i, base);
+		set_irq_handler(i, handle_simple_irq);
+		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
+	}
+
+	set_irq_chained_handler(IRQ_LPC2K_EINT3, lpc2k_demux_gpio_irq);
+
+	return 0;
+}
+
+postcore_initcall(lpc2k_init_gpio);
diff --git a/arch/arm/mach-lpc2k/include/mach/gpio.h b/arch/arm/mach-lpc2k/include/mach/gpio.h
new file mode 100644
index 0000000..efa970a
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/gpio.h
@@ -0,0 +1,22 @@
+/*
+ *  Copyright (C) 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef MACH_LPC2K_GPIO_H
+#define MACH_LPC2K_GPIO_H
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+#endif /* MACH_LPC2K_GPIO_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/hardware.h b/arch/arm/mach-lpc2k/include/mach/hardware.h
index ce19ff7..0d7c10c 100644
--- a/arch/arm/mach-lpc2k/include/mach/hardware.h
+++ b/arch/arm/mach-lpc2k/include/mach/hardware.h
@@ -15,9 +15,11 @@
 /* Default memory size if no ATAGS found */
 #define MEM_SIZE	(SZ_32M)
 
+#define FAST_GPIO_BASE		0x3fffc000
 #define APB_TIMER0_BASE		0xe0004000
 #define APB_TIMER1_BASE		0xe0008000
 #define APB_UART0_BASE		0xe000c000
+#define APB_GPIO_BASE		0xe0028000
 #define APB_SCB_BASE		0xe01fc000
 #define APH_VIC_BASE		0xfffff000
 
diff --git a/arch/arm/mach-lpc2k/include/mach/irqs.h b/arch/arm/mach-lpc2k/include/mach/irqs.h
index 87b80dd..b7b2410 100644
--- a/arch/arm/mach-lpc2k/include/mach/irqs.h
+++ b/arch/arm/mach-lpc2k/include/mach/irqs.h
@@ -44,6 +44,73 @@
 #define IRQ_LPC2K_I2C2		30
 #define IRQ_LPC2K_I2S		31
 
-#define NR_IRQS			32
+#define IRQ_LPC2K_GPIO0		32
+#define IRQ_LPC2K_GPIO1		33
+#define IRQ_LPC2K_GPIO2		34
+#define IRQ_LPC2K_GPIO3		35
+#define IRQ_LPC2K_GPIO4		36
+#define IRQ_LPC2K_GPIO5		37
+#define IRQ_LPC2K_GPIO6		38
+#define IRQ_LPC2K_GPIO7		39
+#define IRQ_LPC2K_GPIO8		40
+#define IRQ_LPC2K_GPIO9		41
+#define IRQ_LPC2K_GPIO10	42
+#define IRQ_LPC2K_GPIO11	43
+#define IRQ_LPC2K_GPIO12	44
+#define IRQ_LPC2K_GPIO13	45
+#define IRQ_LPC2K_GPIO14	46
+#define IRQ_LPC2K_GPIO15	47
+#define IRQ_LPC2K_GPIO16	48
+#define IRQ_LPC2K_GPIO17	49
+#define IRQ_LPC2K_GPIO18	50
+#define IRQ_LPC2K_GPIO19	51
+#define IRQ_LPC2K_GPIO20	52
+#define IRQ_LPC2K_GPIO21	53
+#define IRQ_LPC2K_GPIO22	54
+#define IRQ_LPC2K_GPIO23	55
+#define IRQ_LPC2K_GPIO24	56
+#define IRQ_LPC2K_GPIO25	57
+#define IRQ_LPC2K_GPIO26	58
+#define IRQ_LPC2K_GPIO27	59
+#define IRQ_LPC2K_GPIO28	60
+#define IRQ_LPC2K_GPIO29	61
+#define IRQ_LPC2K_GPIO30	62
+#define IRQ_LPC2K_GPIO31	63
+
+/* GPIO P2 */
+#define IRQ_LPC2K_GPIO64	64
+#define IRQ_LPC2K_GPIO65	65
+#define IRQ_LPC2K_GPIO66	66
+#define IRQ_LPC2K_GPIO67	67
+#define IRQ_LPC2K_GPIO68	68
+#define IRQ_LPC2K_GPIO69	69
+#define IRQ_LPC2K_GPIO70	70
+#define IRQ_LPC2K_GPIO71	71
+#define IRQ_LPC2K_GPIO72	72
+#define IRQ_LPC2K_GPIO73	73
+#define IRQ_LPC2K_GPIO74	74
+#define IRQ_LPC2K_GPIO75	75
+#define IRQ_LPC2K_GPIO76	76
+#define IRQ_LPC2K_GPIO77	77
+#define IRQ_LPC2K_GPIO78	78
+#define IRQ_LPC2K_GPIO79	79
+#define IRQ_LPC2K_GPIO80	80
+#define IRQ_LPC2K_GPIO81	81
+#define IRQ_LPC2K_GPIO82	82
+#define IRQ_LPC2K_GPIO83	83
+#define IRQ_LPC2K_GPIO84	84
+#define IRQ_LPC2K_GPIO85	85
+#define IRQ_LPC2K_GPIO86	86
+#define IRQ_LPC2K_GPIO87	87
+#define IRQ_LPC2K_GPIO88	88
+#define IRQ_LPC2K_GPIO89	89
+#define IRQ_LPC2K_GPIO90	90
+#define IRQ_LPC2K_GPIO91	91
+#define IRQ_LPC2K_GPIO92	92
+#define IRQ_LPC2K_GPIO93	93
+#define IRQ_LPC2K_GPIO94	94
+#define IRQ_LPC2K_GPIO95	95
+
+#define NR_IRQS			96
 
 #endif /* MACH_LPC2K_IRQS_H */
-- 
1.7.1
