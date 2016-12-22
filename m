From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Dec 2016 18:24:59 +0100
Subject: [PATCH 4/6] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <20161222172501.16121-1-gregory.clement@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
Message-ID: <20161222172501.16121-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 37xx SoCs can handle interrupt through GPIO. However it can
only manage the edge ones.

The way the interrupt are managed are classical so we can use the generic
interrupt chip model.

The only unusual "feature" is that many interrupts are connected to the
parent interrupt controller. But we do not take advantage of this and use
the chained irq with all of them.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 159 ++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 4d9571b49ad1..4c714d0beb88 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -13,7 +13,9 @@
 #include <linux/gpio/driver.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -30,6 +32,11 @@
 #define OUTPUT_CTL	0x20
 #define SELECTION	0x30
 
+#define IRQ_EN		0x0
+#define IRQ_POL		0x08
+#define IRQ_STATUS	0x10
+#define IRQ_WKUP	0x18
+
 static int global_pin;
 
 #define NB_FUNCS 2
@@ -64,6 +71,8 @@ struct armada_37xx_pinctrl {
 	struct armada_37xx_pin_data	*data;
 	struct device			*dev;
 	struct gpio_chip		gpio_chip;
+	struct irq_chip			irq_chip;
+	struct irq_domain		*domain;
 	struct pinctrl_desc		pctl;
 	struct pinctrl_dev		*pctl_dev;
 	struct armada_37xx_pin_group	*groups;
@@ -385,6 +394,14 @@ static void armada_37xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	regmap_update_bits(info->regmap, reg, mask, val);
 }
 
+static int armada_37xx_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+
+	return irq_create_mapping(info->domain, offset);
+}
+
+
 static int armada_37xx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					      struct pinctrl_gpio_range *range,
 					      unsigned int offset, bool input)
@@ -436,9 +453,148 @@ static const struct gpio_chip armada_37xx_gpiolib_chip = {
 	.get_direction	= armada_37xx_gpio_get_direction,
 	.direction_input = armada_37xx_gpio_direction_input,
 	.direction_output = armada_37xx_gpio_direction_output,
+	.to_irq = armada_37xx_gpio_to_irq,
 	.owner = THIS_MODULE,
 };
 
+static int armada_37xx_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 reg, mask = d->mask;
+
+	irq_gc_lock(gc);
+	reg  = irq_reg_readl(gc, IRQ_WKUP);
+	if (on)
+		reg |= mask;
+	else
+		reg &= ~mask;
+	irq_reg_writel(gc, reg, IRQ_WKUP);
+	irq_gc_unlock(gc);
+
+	return 0;
+}
+
+static int armada_37xx_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 reg, mask = d->mask;
+
+	irq_gc_lock(gc);
+	reg  = irq_reg_readl(gc, IRQ_POL);
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		reg &= ~mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		reg |= mask;
+		break;
+	default:
+		irq_gc_unlock(gc);
+		return -EINVAL;
+	}
+	irq_reg_writel(gc, reg, IRQ_POL);
+	irq_gc_unlock(gc);
+
+	return 0;
+}
+
+
+static void armada_37xx_irq_handler(struct irq_desc *desc)
+{
+	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int n;
+
+	chained_irq_enter(chip, desc);
+
+	for (n = 0; n < d->revmap_size; n += 32) {
+		struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, n);
+		u32 stat = readl_relaxed(gc->reg_base + IRQ_STATUS);
+
+		while (stat) {
+			u32 hwirq = ffs(stat) - 1;
+			u32 virq = irq_find_mapping(d, gc->irq_base + hwirq);
+
+			generic_handle_irq(virq);
+			stat &= ~(1 << hwirq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int armada_37xx_irqchip_register(struct platform_device *pdev,
+					struct armada_37xx_pinctrl *info)
+{
+	struct device_node *np = info->dev->of_node;
+	int nrirqs = info->data->nr_pins;
+	struct irq_domain *domain;
+	struct resource res;
+	void __iomem *base;
+	int ret, i, nr_irq_parent;
+
+	nr_irq_parent = of_irq_count(np);
+
+	if (!nr_irq_parent) {
+		dev_err(&pdev->dev, "Invalid or no IRQ\n");
+		return 0;
+	}
+
+	if (of_address_to_resource(np, 1, &res)) {
+		dev_err(info->dev, "cannot find IO resource\n");
+		return -ENOENT;
+	}
+
+	base = devm_ioremap_resource(info->dev, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	domain = irq_domain_add_linear(np, nrirqs,
+				       &irq_generic_chip_ops, NULL);
+	if (!domain)
+		return -ENOMEM;
+	info->domain = domain;
+
+	ret = irq_alloc_domain_generic_chips(domain, GPIO_PER_REG, 1,
+			     np->name, handle_level_irq,
+			     IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0,
+			     IRQ_GC_INIT_MASK_CACHE);
+	if (ret) {
+		dev_err(info->dev, "%s: could not alloc generic chips\n",
+			np->full_name);
+		irq_domain_remove(domain);
+	}
+
+	for (i = 0; i < DIV_ROUND_UP(nrirqs, GPIO_PER_REG); i++) {
+		struct irq_chip_generic *gc;
+
+		gc = irq_get_domain_generic_chip(domain, i * GPIO_PER_REG);
+		gc->reg_base = base + i *  sizeof(u32);
+		gc->chip_types[0].regs.mask = IRQ_EN;
+		gc->chip_types[0].regs.ack = IRQ_STATUS;
+		gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_mask_set_bit;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_clr_bit;
+		gc->chip_types[0].chip.irq_set_wake = armada_37xx_irq_set_wake;
+		gc->chip_types[0].chip.irq_set_type = armada_37xx_irq_set_type;
+	}
+
+	for (i = 0; i < nr_irq_parent; i++) {
+		int irq = platform_get_irq(pdev, i);
+
+		if (irq < 0)
+			continue;
+
+		irq_set_chained_handler_and_data(irq, armada_37xx_irq_handler,
+						 domain);
+	}
+
+	for (i = 0 ; i < nrirqs ; i++)
+		irq_create_mapping(domain, i);
+
+	return 0;
+}
+
 static int armada_37xx_gpiolib_register(struct platform_device *pdev,
 					struct armada_37xx_pinctrl *info)
 {
@@ -457,6 +613,9 @@ static int armada_37xx_gpiolib_register(struct platform_device *pdev,
 	ret = gpiochip_add_data(gc, info);
 	if (ret)
 		return ret;
+	ret = armada_37xx_irqchip_register(pdev, info);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.11.0
