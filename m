From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Mar 2017 19:28:34 +0100
Subject: [PATCH v2 5/7] pinctrl: aramda-37xx: Add irqchip support
In-Reply-To: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
Message-ID: <0e60fccd7913b83ee53d2921ce8f297927e8b6f3.1490120798.git-series.gregory.clement@free-electrons.com>
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
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 223 ++++++++++++++++++++-
 1 file changed, 216 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index e41e2d02aca7..5d3af27f1ba9 100644
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
@@ -76,9 +83,12 @@ struct armada_37xx_pmx_func {
 
 struct armada_37xx_pinctrl {
 	struct regmap			*regmap;
+	void __iomem			*base;
 	struct armada_37xx_pin_data	*data;
 	struct device			*dev;
 	struct gpio_chip		gpio_chip;
+	struct irq_chip			irq_chip;
+	spinlock_t			irq_lock;
 	struct pinctrl_desc		pctl;
 	struct pinctrl_dev		*pctl_dev;
 	struct armada_37xx_pin_group	*groups;
@@ -316,7 +326,7 @@ static int armada_37xx_pmx_set(struct pinctrl_dev *pctldev,
 	return armada_37xx_pmx_set_by_name(pctldev, name, grp);
 }
 
-static inline void aramda_37xx_update_reg(unsigned int *reg,
+static inline void armada_37xx_update_reg(unsigned int *reg,
 					  unsigned int offset)
 {
 	/* We never have more than 2 registers */
@@ -326,6 +336,14 @@ static inline void aramda_37xx_update_reg(unsigned int *reg,
 	}
 }
 
+static inline void armada_37xx_irq_update_reg(unsigned int *reg,
+					  struct irq_data *d)
+{
+	int offset = irqd_to_hwirq(d);
+
+	armada_37xx_update_reg(reg, offset);
+}
+
 static int armada_37xx_gpio_direction_input(struct gpio_chip *chip,
 					    unsigned int offset)
 {
@@ -333,7 +351,7 @@ static int armada_37xx_gpio_direction_input(struct gpio_chip *chip,
 	unsigned int reg = OUTPUT_EN;
 	unsigned int mask;
 
-	aramda_37xx_update_reg(&reg, offset);
+	armada_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 
 	return regmap_update_bits(info->regmap, reg, mask, 0);
@@ -346,7 +364,7 @@ static int armada_37xx_gpio_get_direction(struct gpio_chip *chip,
 	unsigned int reg = OUTPUT_EN;
 	unsigned int val, mask;
 
-	aramda_37xx_update_reg(&reg, offset);
+	armada_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 
 	regmap_read(info->regmap, reg, &val);
@@ -361,7 +379,7 @@ static int armada_37xx_gpio_direction_output(struct gpio_chip *chip,
 	unsigned int reg = OUTPUT_EN;
 	unsigned int mask;
 
-	aramda_37xx_update_reg(&reg, offset);
+	armada_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 
 	return regmap_update_bits(info->regmap, reg, mask, mask);
@@ -373,7 +391,7 @@ static int armada_37xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	unsigned int reg = INPUT_VAL;
 	unsigned int val, mask;
 
-	aramda_37xx_update_reg(&reg, offset);
+	armada_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 
 	regmap_read(info->regmap, reg, &val);
@@ -388,7 +406,7 @@ static void armada_37xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned int reg = OUTPUT_VAL;
 	unsigned int mask, val;
 
-	aramda_37xx_update_reg(&reg, offset);
+	armada_37xx_update_reg(&reg, offset);
 	mask = BIT(offset);
 	val = value ? mask : 0;
 
@@ -449,6 +467,194 @@ static const struct gpio_chip armada_37xx_gpiolib_chip = {
 	.owner = THIS_MODULE,
 };
 
+void armada_37xx_irq_ack(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	u32 reg = IRQ_STATUS, mask = d->mask;
+	unsigned long flags;
+
+	armada_37xx_irq_update_reg(&reg, d);
+	spin_lock_irqsave(&info->irq_lock, flags);
+	writel(mask, info->base + reg);
+	spin_unlock_irqrestore(&info->irq_lock, flags);
+}
+
+void armada_37xx_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	u32 val, reg = IRQ_EN, mask = d->mask;
+	unsigned long flags;
+
+	armada_37xx_irq_update_reg(&reg, d);
+	spin_lock_irqsave(&info->irq_lock, flags);
+	val = readl(info->base + reg);
+	writel(val & ~mask, info->base + reg);
+	spin_unlock_irqrestore(&info->irq_lock, flags);
+}
+
+void armada_37xx_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	u32 val, reg = IRQ_EN, mask = d->mask;
+	unsigned long flags;
+
+	armada_37xx_irq_update_reg(&reg, d);
+	spin_lock_irqsave(&info->irq_lock, flags);
+	val = readl(info->base + reg);
+	writel(val | mask, info->base + reg);
+	spin_unlock_irqrestore(&info->irq_lock, flags);
+}
+
+static int armada_37xx_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	u32 val, reg = IRQ_WKUP, mask = d->mask;
+	unsigned long flags;
+
+	armada_37xx_irq_update_reg(&reg, d);
+	spin_lock_irqsave(&info->irq_lock, flags);
+	val = readl(info->base + reg);
+	if (on)
+		val |= mask;
+	else
+		val &= ~mask;
+	writel(val, info->base + reg);
+	spin_unlock_irqrestore(&info->irq_lock, flags);
+
+	return 0;
+}
+
+static int armada_37xx_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(chip);
+	u32 val, reg = IRQ_POL, mask = d->mask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&info->irq_lock, flags);
+	armada_37xx_irq_update_reg(&reg, d);
+	val = readl(info->base + reg);
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		val &= ~mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val |= mask;
+		break;
+	default:
+		spin_unlock_irqrestore(&info->irq_lock, flags);
+		return -EINVAL;
+	}
+	writel(val, info->base + reg);
+	spin_unlock_irqrestore(&info->irq_lock, flags);
+
+	return 0;
+}
+
+
+static void armada_37xx_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct armada_37xx_pinctrl *info = gpiochip_get_data(gc);
+	struct irq_domain *d = gc->irqdomain;
+	int i;
+
+	chained_irq_enter(chip, desc);
+	for (i = 0; i <= d->revmap_size / GPIO_PER_REG; i++) {
+		u32 status;
+		unsigned long flags;
+
+		spin_lock_irqsave(&info->irq_lock, flags);
+		status = readl_relaxed(info->base + IRQ_STATUS + 4 * i);
+		/* Manage only the interrupt that was enabled */
+		status &= readl_relaxed(info->base + IRQ_EN + 4 * i);
+		spin_unlock_irqrestore(&info->irq_lock, flags);
+		while (status) {
+			u32 hwirq = ffs(status) - 1;
+			u32 virq = irq_linear_revmap(d, hwirq +
+						     i * GPIO_PER_REG);
+
+			generic_handle_irq(virq);
+			status &= ~(1 << hwirq);
+		}
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int armada_37xx_irqchip_register(struct platform_device *pdev,
+					struct armada_37xx_pinctrl *info)
+{
+	struct device_node *np = info->dev->of_node;
+	int nrirqs = info->data->nr_pins;
+	struct gpio_chip *gc = &info->gpio_chip;
+	struct irq_chip *irqchip = &info->irq_chip;
+	struct resource res;
+	int ret, i, nr_irq_parent;
+
+	for_each_child_of_node(info->dev->of_node, np) {
+		if (of_find_property(np, "gpio-controller", NULL)) {
+			ret = 0;
+			break;
+		}
+	};
+	if (ret)
+		return ret;
+
+	nr_irq_parent = of_irq_count(np);
+	spin_lock_init(&info->irq_lock);
+
+	if (!nr_irq_parent) {
+		dev_err(&pdev->dev, "Invalid or no IRQ\n");
+		return 0;
+	}
+
+	if (of_address_to_resource(info->dev->of_node, 1, &res)) {
+		dev_err(info->dev, "cannot find IO resource\n");
+		return -ENOENT;
+	}
+
+	info->base = devm_ioremap_resource(info->dev, &res);
+	if (IS_ERR(info->base))
+		return PTR_ERR(info->base);
+
+	irqchip->irq_ack = armada_37xx_irq_ack;
+	irqchip->irq_mask = armada_37xx_irq_mask;
+	irqchip->irq_unmask = armada_37xx_irq_unmask;
+	irqchip->irq_set_wake = armada_37xx_irq_set_wake;
+	irqchip->irq_set_type = armada_37xx_irq_set_type;
+	irqchip->name = info->data->name;
+
+	ret = gpiochip_irqchip_add(gc, irqchip, 0,
+				   handle_level_irq, IRQ_TYPE_NONE);
+	if (ret) {
+		dev_info(&pdev->dev, "could not add irqchip\n");
+		return ret;
+	}
+
+	for (i = 0; i < nrirqs; i++) {
+		struct irq_data *d = irq_get_irq_data(gc->irq_base + i);
+
+		d->mask = 1 << (i % GPIO_PER_REG);
+	}
+
+	for (i = 0; i < nr_irq_parent; i++) {
+		int irq = irq_of_parse_and_map(np, i);
+
+		if (irq < 0)
+			continue;
+
+		gpiochip_set_chained_irqchip(gc, irqchip, irq,
+					     armada_37xx_irq_handler);
+	}
+
+	return 0;
+}
+
 static int armada_37xx_gpiochip_register(struct platform_device *pdev,
 					struct armada_37xx_pinctrl *info)
 {
@@ -477,6 +683,9 @@ static int armada_37xx_gpiochip_register(struct platform_device *pdev,
 	ret = gpiochip_add_data(gc, info);
 	if (ret)
 		return ret;
+	ret = armada_37xx_irqchip_register(pdev, info);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -518,7 +727,7 @@ static int armada_37xx_fill_group(struct armada_37xx_pinctrl *info, int base)
 
 		grp->pins = devm_kzalloc(info->dev,
 					 (grp->npins + grp->extra_npins) *
-					 sizeof(*grp->pins), GFP_KERNEL);
+				 sizeof(*grp->pins), GFP_KERNEL);
 		if (!grp->pins)
 			return -ENOMEM;
 
-- 
git-series 0.9.1
