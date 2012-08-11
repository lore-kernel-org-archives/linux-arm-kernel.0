From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 11 Aug 2012 15:31:42 +0200
Subject: [PATCH 1/5] gpio: introduce gpio-mvebu driver for Marvell SoCs
In-Reply-To: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1344691906-15985-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver aims at replacing the arch/arm/plat-orion/gpio.c driver,
and is designed to be compatible with all Marvell EBU SoCs: Orion,
Kirkwood, Dove, Armada 370/XP and Discovery.

It has been successfully tested on Dove and Armada XP at the moment.

Compared to the plat-orion driver, this new driver has the following
added benefits:

 *) Support for Armada 370 and Armada XP
 *) It is integrated with the mvebu pinctrl driver so that GPIO pins
    are properly muxed, and the GPIO driver knows which GPIO pins are
    output-only or input-only.
 *) Properly placed in drivers/gpio
 *) More extensible mechanism to support platform differences. The
    plat-orion driver uses a simple mask-offset DT property, which
    works fine for Discovery MV78200 but not for Armada XP. The new
    driver uses different compatible strings to identify the different
    variants of the GPIO controllers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 drivers/gpio/Kconfig      |    6 +
 drivers/gpio/Makefile     |    1 +
 drivers/gpio/gpio-mvebu.c |  650 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 657 insertions(+)
 create mode 100644 drivers/gpio/gpio-mvebu.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b16c8a7..993b0c4 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -150,6 +150,12 @@ config GPIO_MSM_V2
 	  Qualcomm MSM chips.  Most of the pins on the MSM can be
 	  selected for GPIO, and are controlled by this driver.
 
+config GPIO_MVEBU
+	def_bool y
+	depends on ARCH_MVEBU
+	select GPIO_GENERIC
+	select GENERIC_IRQ_CHIP
+
 config GPIO_MXC
 	def_bool y
 	depends on ARCH_MXC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 153cace..1a33e67 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
 obj-$(CONFIG_GPIO_MSM_V1)	+= gpio-msm-v1.o
 obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
+obj-$(CONFIG_GPIO_MVEBU)        += gpio-mvebu.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)		+= gpio-mxs.o
 obj-$(CONFIG_ARCH_OMAP)		+= gpio-omap.o
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
new file mode 100644
index 0000000..d008e55
--- /dev/null
+++ b/drivers/gpio/gpio-mvebu.c
@@ -0,0 +1,650 @@
+/*
+ * GPIO driver for Marvell SoCs
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ * Andrew Lunn <andrew@lunn.ch>
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This driver is a fairly straightforward GPIO driver for the
+ * complete family of Marvell EBU SoC platforms (Orion, Dove,
+ * Kirkwood, Discovery, Armada 370/XP). The only complexity of this
+ * driver is the different register layout that exists between the
+ * non-SMP platforms (Orion, Dove, Kirkwood, Armada 370) and the SMP
+ * platforms (MV78200 from the Discovery family and the Armada
+ * XP). Therefore, this driver handles three variants of the GPIO
+ * block:
+ * - the basic variant, called "orion-gpio", with the simplest
+ *   register set. Used on Orion, Dove, Kirkwoord, Armada 370 and
+ *   non-SMP Discovery systems
+ * - the mv78200 variant for MV78200 Discovery systems. This variant
+ *   turns the edge mask and level mask registers into CPU0 edge
+ *   mask/level mask registers, and adds CPU1 edge mask/level mask
+ *   registers.
+ * - the armadaxp variant for Armada XP systems. This variant keeps
+ *   the normal cause/edge mask/level mask registers when the global
+ *   interrupts are used, but adds per-CPU cause/edge mask/level mask
+ *   registers n a separate memory area for the per-CPU GPIO
+ *   interrupts.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+
+/*
+ * GPIO unit register offsets.
+ */
+#define GPIO_OUT_OFF		0x0000
+#define GPIO_IO_CONF_OFF	0x0004
+#define GPIO_BLINK_EN_OFF	0x0008
+#define GPIO_IN_POL_OFF		0x000c
+#define GPIO_DATA_IN_OFF	0x0010
+#define GPIO_EDGE_CAUSE_OFF	0x0014
+#define GPIO_EDGE_MASK_OFF	0x0018
+#define GPIO_LEVEL_MASK_OFF	0x001c
+
+/* The MV78200 has per-CPU registers for edge mask and level mask */
+#define GPIO_EDGE_MASK_MV78200_OFF(cpu)   ((cpu) ? 0x30 : 0x18)
+#define GPIO_LEVEL_MASK_MV78200_OFF(cpu)  ((cpu) ? 0x34 : 0x1C)
+
+/* The Armada XP has per-CPU registers for interrupt cause, interrupt
+ * mask and interrupt level mask. Those are relative to the
+ * percpu_membase. */
+#define GPIO_EDGE_CAUSE_ARMADAXP_OFF(cpu) ((cpu) * 0x4)
+#define GPIO_EDGE_MASK_ARMADAXP_OFF(cpu)  (0x10 + (cpu) * 0x4)
+#define GPIO_LEVEL_MASK_ARMADAXP_OFF(cpu) (0x20 + (cpu) * 0x4)
+
+#define MVEBU_GPIO_SOC_VARIANT_ORION    0x1
+#define MVEBU_GPIO_SOC_VARIANT_MV78200  0x2
+#define MVEBU_GPIO_SOC_VARIANT_ARMADAXP 0x3
+
+struct mvebu_gpio_chip {
+	struct gpio_chip   chip;
+	spinlock_t	   lock;
+	void __iomem	  *membase;
+	void __iomem	  *percpu_membase;
+	unsigned int       irqbase;
+	struct irq_domain *domain;
+	int                soc_variant;
+};
+
+/*
+ * Common functions to all SoCs
+ */
+static void __iomem *GPIO_OUT(struct mvebu_gpio_chip *mvchip)
+{
+	return mvchip->membase + GPIO_OUT_OFF;
+}
+
+static void __iomem *GPIO_IO_CONF(struct mvebu_gpio_chip *mvchip)
+{
+	return mvchip->membase + GPIO_IO_CONF_OFF;
+}
+
+static void __iomem *GPIO_IN_POL(struct mvebu_gpio_chip *mvchip)
+{
+	return mvchip->membase + GPIO_IN_POL_OFF;
+}
+
+static void __iomem *GPIO_DATA_IN(struct mvebu_gpio_chip *mvchip)
+{
+	return mvchip->membase + GPIO_DATA_IN_OFF;
+}
+
+static void __iomem *GPIO_EDGE_CAUSE(struct mvebu_gpio_chip *mvchip)
+{
+	int cpu;
+
+	switch(mvchip->soc_variant) {
+	case MVEBU_GPIO_SOC_VARIANT_ORION:
+	case MVEBU_GPIO_SOC_VARIANT_MV78200:
+		return mvchip->membase + GPIO_EDGE_CAUSE_OFF;
+	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
+		cpu = smp_processor_id();
+		return mvchip->percpu_membase + GPIO_EDGE_CAUSE_ARMADAXP_OFF(cpu);
+	default:
+		BUG();
+	}
+}
+
+static void __iomem *GPIO_EDGE_MASK(struct mvebu_gpio_chip *mvchip)
+{
+	int cpu;
+
+	switch(mvchip->soc_variant) {
+	case MVEBU_GPIO_SOC_VARIANT_ORION:
+		return mvchip->membase + GPIO_EDGE_MASK_OFF;
+	case MVEBU_GPIO_SOC_VARIANT_MV78200:
+		cpu = smp_processor_id();
+		return mvchip->membase + GPIO_EDGE_MASK_MV78200_OFF(cpu);
+	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
+		cpu = smp_processor_id();
+		return mvchip->percpu_membase + GPIO_EDGE_MASK_ARMADAXP_OFF(cpu);
+	default:
+		BUG();
+	}
+}
+
+static void __iomem *GPIO_LEVEL_MASK(struct mvebu_gpio_chip *mvchip)
+{
+	int cpu;
+
+	switch(mvchip->soc_variant) {
+	case MVEBU_GPIO_SOC_VARIANT_ORION:
+		return mvchip->membase + GPIO_LEVEL_MASK_OFF;
+	case MVEBU_GPIO_SOC_VARIANT_MV78200:
+		cpu = smp_processor_id();
+		return mvchip->membase + GPIO_LEVEL_MASK_MV78200_OFF(cpu);
+	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
+		cpu = smp_processor_id();
+		return mvchip->percpu_membase + GPIO_LEVEL_MASK_ARMADAXP_OFF(cpu);
+	default:
+		BUG();
+	}
+}
+
+int mvebu_gpio_request(struct gpio_chip *chip, unsigned pin)
+{
+	return pinctrl_request_gpio(chip->base + pin);
+}
+
+void mvebu_gpio_free(struct gpio_chip *chip, unsigned pin)
+{
+	pinctrl_free_gpio(chip->base + pin);
+}
+
+static void mvebu_gpio_set(struct gpio_chip *chip, unsigned pin, int value)
+{
+	struct mvebu_gpio_chip *mvchip =
+		container_of(chip, struct mvebu_gpio_chip, chip);
+	unsigned long flags;
+	u32 u;
+
+	spin_lock_irqsave(&mvchip->lock, flags);
+	u = readl(GPIO_OUT(mvchip));
+	if (value)
+		u |= 1 << pin;
+	else
+		u &= ~(1 << pin);
+	writel(u, GPIO_OUT(mvchip));
+	spin_unlock_irqrestore(&mvchip->lock, flags);
+}
+
+static int mvebu_gpio_get(struct gpio_chip *chip, unsigned pin)
+{
+	struct mvebu_gpio_chip *mvchip =
+		container_of(chip, struct mvebu_gpio_chip, chip);
+	u32 u;
+
+	if (readl(GPIO_IO_CONF(mvchip)) & (1 << pin)) {
+		u = readl(GPIO_DATA_IN(mvchip)) ^ readl(GPIO_IN_POL(mvchip));
+	} else {
+		u = readl(GPIO_OUT(mvchip));
+	}
+
+	return (u >> pin) & 1;
+}
+
+static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned pin)
+{
+	struct mvebu_gpio_chip *mvchip =
+		container_of(chip, struct mvebu_gpio_chip, chip);
+	unsigned long flags;
+	int ret;
+	u32 u;
+
+	/* Check with the pinctrl driver whether this pin is usable as
+	 * an input GPIO */
+	ret = pinctrl_gpio_direction_input(chip->base + pin);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&mvchip->lock, flags);
+	u = readl(GPIO_IO_CONF(mvchip));
+	u |= 1 << pin;
+	writel(u, GPIO_IO_CONF(mvchip));
+	spin_unlock_irqrestore(&mvchip->lock, flags);
+
+	return 0;
+}
+
+static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned pin,
+				       int value)
+{
+	struct mvebu_gpio_chip *mvchip =
+		container_of(chip, struct mvebu_gpio_chip, chip);
+	unsigned long flags;
+	int ret;
+	u32 u;
+
+	/* Check with the pinctrl driver whether this pin is usable as
+	 * an output GPIO */
+	ret = pinctrl_gpio_direction_output(chip->base + pin);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&mvchip->lock, flags);
+	u = readl(GPIO_IO_CONF(mvchip));
+	u &= ~(1 << pin);
+	writel(u, GPIO_IO_CONF(mvchip));
+	spin_unlock_irqrestore(&mvchip->lock, flags);
+
+	return 0;
+}
+
+static int mvebu_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
+{
+	struct mvebu_gpio_chip *mvchip =
+		container_of(chip, struct mvebu_gpio_chip, chip);
+	return irq_create_mapping(mvchip->domain, pin);
+}
+
+static void mvebu_gpio_irq_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mvebu_gpio_chip *mvchip = gc->private;
+	u32 mask = ~(1 << (d->irq - gc->irq_base));
+
+	irq_gc_lock(gc);
+	writel(mask, GPIO_EDGE_CAUSE(mvchip));
+	irq_gc_unlock(gc);
+}
+
+static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mvebu_gpio_chip *mvchip = gc->private;
+	u32 mask = 1 << (d->irq - gc->irq_base);
+
+	irq_gc_lock(gc);
+	gc->mask_cache &= ~mask;
+	writel(gc->mask_cache, GPIO_EDGE_MASK(mvchip));
+	irq_gc_unlock(gc);
+}
+
+static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mvebu_gpio_chip *mvchip = gc->private;
+	u32 mask = 1 << (d->irq - gc->irq_base);
+
+	irq_gc_lock(gc);
+	gc->mask_cache |= mask;
+	writel(gc->mask_cache, GPIO_EDGE_MASK(mvchip));
+	irq_gc_unlock(gc);
+}
+
+static void mvebu_gpio_level_irq_mask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mvebu_gpio_chip *mvchip = gc->private;
+	u32 mask = 1 << (d->irq - gc->irq_base);
+
+	irq_gc_lock(gc);
+	gc->mask_cache &= ~mask;
+	writel(gc->mask_cache, GPIO_LEVEL_MASK(mvchip));
+	irq_gc_unlock(gc);
+}
+
+static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mvebu_gpio_chip *mvchip = gc->private;
+	u32 mask = 1 << (d->irq - gc->irq_base);
+
+	irq_gc_lock(gc);
+	gc->mask_cache |= mask;
+	writel(gc->mask_cache, GPIO_LEVEL_MASK(mvchip));
+	irq_gc_unlock(gc);
+}
+
+/*****************************************************************************
+ * MVEBU GPIO IRQ
+ *
+ * GPIO_IN_POL register controls whether GPIO_DATA_IN will hold the same
+ * value of the line or the opposite value.
+ *
+ * Level IRQ handlers: DATA_IN is used directly as cause register.
+ *                     Interrupt are masked by LEVEL_MASK registers.
+ * Edge IRQ handlers:  Change in DATA_IN are latched in EDGE_CAUSE.
+ *                     Interrupt are masked by EDGE_MASK registers.
+ * Both-edge handlers: Similar to regular Edge handlers, but also swaps
+ *                     the polarity to catch the next line transaction.
+ *                     This is a race condition that might not perfectly
+ *                     work on some use cases.
+ *
+ * Every eight GPIO lines are grouped (OR'ed) before going up to main
+ * cause register.
+ *
+ *                    EDGE  cause    mask
+ *        data-in   /--------| |-----| |----\
+ *     -----| |-----                         ---- to main cause reg
+ *           X      \----------------| |----/
+ *        polarity    LEVEL          mask
+ *
+ ****************************************************************************/
+
+static int mvebu_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct mvebu_gpio_chip *mvchip = gc->private;
+	int pin;
+	u32 u;
+
+	pin = d->hwirq - mvchip->irqbase;
+
+	u = readl(GPIO_IO_CONF(mvchip)) & (1 << pin);
+	if (!u) {
+		return -EINVAL;
+	}
+
+	type &= IRQ_TYPE_SENSE_MASK;
+	if (type == IRQ_TYPE_NONE)
+		return -EINVAL;
+
+	/* Check if we need to change chip and handler */
+	if (!(ct->type & type))
+		if (irq_setup_alt_chip(d, type))
+			return -EINVAL;
+
+	/*
+	 * Configure interrupt polarity.
+	 */
+	if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH) {
+		u = readl(GPIO_IN_POL(mvchip));
+		u &= ~(1 << pin);
+		writel(u, GPIO_IN_POL(mvchip));
+	} else if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW) {
+		u = readl(GPIO_IN_POL(mvchip));
+		u |= 1 << pin;
+		writel(u, GPIO_IN_POL(mvchip));
+	} else if (type == IRQ_TYPE_EDGE_BOTH) {
+		u32 v;
+
+		v = readl(GPIO_IN_POL(mvchip)) ^ readl(GPIO_DATA_IN(mvchip));
+
+		/*
+		 * set initial polarity based on current input level
+		 */
+		u = readl(GPIO_IN_POL(mvchip));
+		if (v & (1 << pin))
+			u |= 1 << pin;		/* falling */
+		else
+			u &= ~(1 << pin);	/* rising */
+		writel(u, GPIO_IN_POL(mvchip));
+	}
+	return 0;
+}
+
+static void mvebu_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct mvebu_gpio_chip *mvchip = irq_get_handler_data(irq);
+	u32 cause, type;
+	int i;
+
+	if (mvchip == NULL)
+		return;
+
+	cause = readl(GPIO_DATA_IN(mvchip)) & readl(GPIO_LEVEL_MASK(mvchip));
+	cause |= readl(GPIO_EDGE_CAUSE(mvchip)) & readl(GPIO_EDGE_MASK(mvchip));
+
+	for (i = 0; i < mvchip->chip.ngpio; i++) {
+		int irq;
+
+		irq = mvchip->irqbase + i;
+
+		if (!(cause & (1 << i)))
+			continue;
+
+		type = irqd_get_trigger_type(irq_get_irq_data(irq));
+		if ((type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
+			/* Swap polarity (race with GPIO line) */
+			u32 polarity;
+
+			polarity = readl(GPIO_IN_POL(mvchip));
+			polarity ^= 1 << i;
+			writel(polarity, GPIO_IN_POL(mvchip));
+		}
+		generic_handle_irq(irq);
+	}
+}
+
+static struct platform_device_id mvebu_gpio_ids[] = {
+	{
+		.name = "orion-gpio",
+	}, {
+		.name = "mv78200-gpio",
+	}, {
+		.name = "armadaxp-gpio",
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(platform, mvebu_gpio_ids);
+
+static struct of_device_id mvebu_gpio_of_match[] __devinitdata = {
+	{
+		.compatible = "marvell,orion-gpio",
+		.data       = (void*) MVEBU_GPIO_SOC_VARIANT_ORION,
+	},
+	{
+		.compatible = "marvell,mv78200-gpio",
+		.data       = (void*) MVEBU_GPIO_SOC_VARIANT_MV78200,
+	},
+	{
+		.compatible = "marvell,armadaxp-gpio",
+		.data       = (void*) MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
+	},
+	{
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, mvebu_gpio_of_match);
+
+static unsigned int mvebu_gpio_chip_count;
+
+static int __devinit mvebu_gpio_probe(struct platform_device *pdev)
+{
+	struct mvebu_gpio_chip *mvchip;
+	const struct of_device_id *match;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	unsigned int ngpios;
+	int soc_variant;
+	int irqbase;
+	int i, cpu;
+
+	match = of_match_device(mvebu_gpio_of_match, &pdev->dev);
+	if (match)
+		soc_variant = (int) match->data;
+	else
+		soc_variant = MVEBU_GPIO_SOC_VARIANT_ORION;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (! res) {
+		dev_err(&pdev->dev, "Cannot get memory resource\n");
+		return -ENODEV;
+	}
+
+	mvchip = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_gpio_chip), GFP_KERNEL);
+	if (! mvchip){
+		dev_err(&pdev->dev, "Cannot allocate memory\n");
+		return -ENOMEM;
+	}
+
+	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
+		dev_err(&pdev->dev, "Missing ngpios OF property\n");
+		return -ENODEV;
+	}
+
+	mvchip->soc_variant = soc_variant;
+	mvchip->chip.label = kasprintf(GFP_KERNEL, "mvebu-gpio%d", mvebu_gpio_chip_count);
+	mvchip->chip.dev = &pdev->dev;
+	mvchip->chip.request = mvebu_gpio_request;
+	mvchip->chip.direction_input = mvebu_gpio_direction_input;
+	mvchip->chip.get = mvebu_gpio_get;
+	mvchip->chip.direction_output = mvebu_gpio_direction_output;
+	mvchip->chip.set = mvebu_gpio_set;
+	mvchip->chip.to_irq = mvebu_gpio_to_irq;
+	mvchip->chip.base = mvebu_gpio_chip_count * 32;
+	mvchip->chip.ngpio = ngpios;
+	mvchip->chip.can_sleep = 0;
+#ifdef CONFIG_OF
+	mvchip->chip.of_node = np;
+#endif
+
+	spin_lock_init(&mvchip->lock);
+	mvchip->membase = devm_request_and_ioremap(&pdev->dev, res);
+	if (! mvchip->membase) {
+		dev_err(&pdev->dev, "Cannot ioremap\n");
+		kfree(mvchip->chip.label);
+		return -ENOMEM;
+	}
+
+	/* The Armada XP has a second range of registers for the
+	 * per-CPU registers */
+	if (soc_variant == MVEBU_GPIO_SOC_VARIANT_ARMADAXP) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (! res) {
+			dev_err(&pdev->dev, "Cannot get memory resource\n");
+			kfree(mvchip->chip.label);
+			return -ENODEV;
+		}
+
+		mvchip->percpu_membase = devm_request_and_ioremap(&pdev->dev, res);
+		if (! mvchip->percpu_membase) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			kfree(mvchip->chip.label);
+			return -ENOMEM;
+		}
+	}
+
+	/*
+	 * Mask and clear GPIO interrupts.
+	 */
+	switch(soc_variant) {
+	case MVEBU_GPIO_SOC_VARIANT_ORION:
+		writel(0, mvchip->membase + GPIO_EDGE_CAUSE_OFF);
+		writel(0, mvchip->membase + GPIO_EDGE_MASK_OFF);
+		writel(0, mvchip->membase + GPIO_LEVEL_MASK_OFF);
+		break;
+	case MVEBU_GPIO_SOC_VARIANT_MV78200:
+		writel(0, GPIO_EDGE_CAUSE(mvchip));
+		for (cpu = 0; cpu < 2; cpu++) {
+			writel(0, mvchip->membase + GPIO_EDGE_MASK_MV78200_OFF(cpu));
+			writel(0, mvchip->membase + GPIO_LEVEL_MASK_MV78200_OFF(cpu));
+		}
+		break;
+	case MVEBU_GPIO_SOC_VARIANT_ARMADAXP:
+		writel(0, mvchip->membase + GPIO_EDGE_CAUSE_OFF);
+		writel(0, mvchip->membase + GPIO_EDGE_MASK_OFF);
+		writel(0, mvchip->membase + GPIO_LEVEL_MASK_OFF);
+		for (cpu = 0; cpu < 4; cpu++) {
+			writel(0, mvchip->percpu_membase + GPIO_EDGE_CAUSE_ARMADAXP_OFF(cpu));
+			writel(0, mvchip->percpu_membase + GPIO_EDGE_MASK_ARMADAXP_OFF(cpu));
+			writel(0, mvchip->percpu_membase + GPIO_LEVEL_MASK_ARMADAXP_OFF(cpu));
+		}
+		break;
+	default:
+		BUG();
+	}
+
+	gpiochip_add(&mvchip->chip);
+
+	/* Setup the interrupt handlers. Each chip can have up to 4
+	 * interrupt handlers, with each handler dealing with 8 GPIO
+	 * pins. */
+	for (i = 0; i < 4; i++) {
+		int irq;
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			continue;
+		irq_set_handler_data(irq, mvchip);
+		irq_set_chained_handler(irq, mvebu_gpio_irq_handler);
+	}
+
+	irqbase = irq_alloc_descs(-1, 0, ngpios, -1);
+	if (irqbase < 0) {
+		dev_err(&pdev->dev, "no irqs\n");
+		kfree(mvchip->chip.label);
+		return -ENOMEM;
+	}
+
+	gc = irq_alloc_generic_chip("mvebu_gpio_irq", 2, mvchip->irqbase,
+				    mvchip->membase, handle_level_irq);
+	if (! gc) {
+		dev_err(&pdev->dev, "Cannot allocate generic irq_chip\n");
+		kfree(mvchip->chip.label);
+		return -ENOMEM;
+	}
+
+	gc->private = mvchip;
+	ct = &gc->chip_types[0];
+	ct->type = IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW;
+	ct->chip.irq_mask = mvebu_gpio_level_irq_mask;
+	ct->chip.irq_unmask = mvebu_gpio_level_irq_unmask;
+	ct->chip.irq_set_type = mvebu_gpio_irq_set_type;
+	ct->chip.name = mvchip->chip.label;
+
+	ct = &gc->chip_types[1];
+	ct->type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	ct->chip.irq_ack = mvebu_gpio_irq_ack;
+	ct->chip.irq_mask = mvebu_gpio_edge_irq_mask;
+	ct->chip.irq_unmask = mvebu_gpio_edge_irq_unmask;
+	ct->chip.irq_set_type = mvebu_gpio_irq_set_type;
+	ct->handler = handle_edge_irq;
+	ct->chip.name = mvchip->chip.label;
+
+	irq_setup_generic_chip(gc, IRQ_MSK(ngpios), IRQ_GC_INIT_MASK_CACHE,
+			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
+
+	/* Setup irq domain on top of the generic chip. */
+	mvchip->domain = irq_domain_add_legacy(np, mvchip->chip.ngpio,
+					       mvchip->irqbase, 0,
+					       &irq_domain_simple_ops,
+					       mvchip);
+	if (!mvchip->domain) {
+		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
+			mvchip->chip.label);
+		irq_remove_generic_chip(gc, IRQ_MSK(ngpios), IRQ_NOREQUEST,
+					IRQ_LEVEL | IRQ_NOPROBE);
+		kfree(gc);
+		kfree(mvchip->chip.label);
+		return -ENODEV;
+	}
+
+	mvebu_gpio_chip_count++;
+
+	return 0;
+}
+
+static struct platform_driver mvebu_gpio_driver = {
+	.driver		= {
+		.name	        = "mvebu-gpio",
+		.owner	        = THIS_MODULE,
+		.of_match_table = mvebu_gpio_of_match,
+	},
+	.probe		= mvebu_gpio_probe,
+	.id_table	= mvebu_gpio_ids,
+};
+
+static int __init mvebu_gpio_init(void)
+{
+	return platform_driver_register(&mvebu_gpio_driver);
+}
+postcore_initcall(mvebu_gpio_init);
-- 
1.7.9.5
