From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Thu, 28 May 2015 19:14:06 -0700
Subject: [PATCH v2 2/6] gpio: brcmstb: Add interrupt support
In-Reply-To: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1432865650-4062-3-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create an irq_chip for each GIO block.  Uses chained IRQ handling since
known uses of this block have a BCM7120 L2 interrupt controller as a
parent.  Supports interrupts for all GPIOs.

In the IRQ handler, we check for raised IRQs for invalid GPIOs and warn
(ratelimited) if they're encountered.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
v2:
- since imask member of bank struct was removed, just read and write from mask
  reg and don't maintain a shadow
- warn on invalid IRQs
- move some irq setup to a separate function since probe is getting unwieldy

 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-brcmstb.c | 276 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d86de6a..7249dba 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -131,6 +131,7 @@ config GPIO_BRCMSTB
 	default y if ARCH_BRCMSTB
 	depends on OF_GPIO && (ARCH_BRCMSTB || COMPILE_TEST)
 	select GPIO_GENERIC
+	select IRQ_DOMAIN
 	help
 	  Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) SoCs.
 
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 7a3cb1f..b9962ff 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -17,6 +17,8 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 #include <linux/basic_mmio_gpio.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
 
 #define GIO_BANK_SIZE           0x20
 #define GIO_ODEN(bank)          (((bank) * GIO_BANK_SIZE) + 0x00)
@@ -40,7 +42,11 @@ struct brcmstb_gpio_priv {
 	struct list_head bank_list;
 	void __iomem *reg_base;
 	int num_banks;
+	int num_gpios;
 	struct platform_device *pdev;
+	struct irq_chip irq_chip;
+	struct irq_domain *irq_domain;
+	int parent_irq;
 	int gpio_base;
 };
 
@@ -63,6 +69,231 @@ brcmstb_gpio_gc_to_priv(struct gpio_chip *gc)
 	return bank->parent_priv;
 }
 
+static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
+		unsigned int offset, bool enable)
+{
+	struct bgpio_chip *bgc = &bank->bgc;
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	u32 mask = bgc->pin2mask(bgc, offset);
+	u32 imask;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bgc->lock, flags);
+	imask = bgc->read_reg(priv->reg_base + GIO_MASK(bank->id));
+	if (enable)
+		imask |= mask;
+	else
+		imask &= ~mask;
+	bgc->write_reg(priv->reg_base + GIO_MASK(bank->id), imask);
+	spin_unlock_irqrestore(&bgc->lock, flags);
+}
+
+static int brcmstb_gpio_to_irq(struct gpio_chip *gc, unsigned gc_offset)
+{
+	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
+	/* gc_offset is relative to this gpio_chip; want real offset */
+	int offset = gc_offset + (gc->base - priv->gpio_base);
+
+	if (offset >= priv->num_gpios)
+		return -ENXIO;
+	return irq_create_mapping(priv->irq_domain, offset);
+}
+
+/* -------------------- IRQ chip functions -------------------- */
+
+static int brcmstb_gpio_hwirq_to_offset(irq_hw_number_t hwirq,
+		struct brcmstb_gpio_bank *bank)
+{
+	return hwirq - (bank->bgc.gc.base - bank->parent_priv->gpio_base);
+}
+
+static void brcmstb_gpio_irq_mask(struct irq_data *d)
+{
+	struct brcmstb_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	int offset = brcmstb_gpio_hwirq_to_offset(d->hwirq, bank);
+
+	brcmstb_gpio_set_imask(bank, offset, false);
+}
+
+static void brcmstb_gpio_irq_unmask(struct irq_data *d)
+{
+	struct brcmstb_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	int offset = brcmstb_gpio_hwirq_to_offset(d->hwirq, bank);
+
+	brcmstb_gpio_set_imask(bank, offset, true);
+}
+
+static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct brcmstb_gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	u32 mask = BIT(brcmstb_gpio_hwirq_to_offset(d->hwirq, bank));
+	u32 edge_insensitive, iedge_insensitive;
+	u32 edge_config, iedge_config;
+	u32 level, ilevel;
+	unsigned long flags;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		level = 0;
+		edge_config = 0;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		level = mask;
+		edge_config = 0;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		level = 0;
+		edge_config = 0;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		level = 0;
+		edge_config = mask;
+		edge_insensitive = 0;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		level = 0;
+		edge_config = 0;  /* don't care, but want known value */
+		edge_insensitive = mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&bank->bgc.lock, flags);
+
+	iedge_config = bank->bgc.read_reg(priv->reg_base +
+			GIO_EC(bank->id)) & ~mask;
+	iedge_insensitive = bank->bgc.read_reg(priv->reg_base +
+			GIO_EI(bank->id)) & ~mask;
+	ilevel = bank->bgc.read_reg(priv->reg_base +
+			GIO_LEVEL(bank->id)) & ~mask;
+
+	bank->bgc.write_reg(priv->reg_base + GIO_EC(bank->id),
+			iedge_config | edge_config);
+	bank->bgc.write_reg(priv->reg_base + GIO_EI(bank->id),
+			iedge_insensitive | edge_insensitive);
+	bank->bgc.write_reg(priv->reg_base + GIO_LEVEL(bank->id),
+			ilevel | level);
+
+	spin_unlock_irqrestore(&bank->bgc.lock, flags);
+	return 0;
+}
+
+static void brcmstb_gpio_irq_bank_handler(int irq,
+		struct brcmstb_gpio_bank *bank)
+{
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	void __iomem *reg_base = priv->reg_base;
+	unsigned long status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->bgc.lock, flags);
+	while ((status = bank->bgc.read_reg(reg_base + GIO_STAT(bank->id)) &
+			 bank->bgc.read_reg(reg_base + GIO_MASK(bank->id)))) {
+		int bit;
+		for_each_set_bit(bit, &status, 32) {
+			int hwirq = bank->bgc.gc.base -
+				priv->gpio_base + bit;
+			int child_irq =
+				irq_find_mapping(priv->irq_domain,
+						 hwirq);
+			u32 stat = bank->bgc.read_reg(reg_base +
+						      GIO_STAT(bank->id));
+			if (bit >= bank->width)
+				dev_warn(&priv->pdev->dev,
+					 "IRQ for invalid GPIO (bank=%d, offset=%d)\n",
+					 bank->id, bit);
+			bank->bgc.write_reg(reg_base + GIO_STAT(bank->id),
+					    stat | BIT(bit));
+			generic_handle_irq(child_irq);
+		}
+	}
+	spin_unlock_irqrestore(&bank->bgc.lock, flags);
+}
+
+/* Each UPG GIO block has one IRQ for all banks */
+static void brcmstb_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct brcmstb_gpio_priv *priv = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct list_head *pos;
+
+	chained_irq_enter(chip, desc);
+	list_for_each(pos, &priv->bank_list) {
+		struct brcmstb_gpio_bank *bank =
+			list_entry(pos, struct brcmstb_gpio_bank, node);
+		brcmstb_gpio_irq_bank_handler(irq, bank);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static struct brcmstb_gpio_bank *brcmstb_gpio_hwirq_to_bank(
+		struct brcmstb_gpio_priv *priv, irq_hw_number_t hwirq)
+{
+	struct list_head *pos;
+	int i = 0;
+
+	/* banks are in descending order */
+	list_for_each_prev(pos, &priv->bank_list) {
+		struct brcmstb_gpio_bank *bank =
+			list_entry(pos, struct brcmstb_gpio_bank, node);
+		i += bank->bgc.gc.ngpio;
+		if (hwirq < i)
+			return bank;
+	}
+	return NULL;
+}
+
+/*
+ * This lock class tells lockdep that GPIO irqs are in a different
+ * category than their parents, so it won't report false recursion.
+ */
+static struct lock_class_key brcmstb_gpio_irq_lock_class;
+
+
+static int brcmstb_gpio_irq_map(struct irq_domain *d, unsigned int irq,
+		irq_hw_number_t hwirq)
+{
+	struct brcmstb_gpio_priv *priv = d->host_data;
+	struct brcmstb_gpio_bank *bank =
+		brcmstb_gpio_hwirq_to_bank(priv, hwirq);
+	struct platform_device *pdev = priv->pdev;
+	int ret;
+
+	if (!bank)
+		return -EINVAL;
+
+	dev_dbg(&pdev->dev, "Mapping irq %d for gpio line %d (bank %d)\n",
+		irq, (int)hwirq, bank->id);
+	ret = irq_set_chip_data(irq, bank);
+	if (ret < 0)
+		return ret;
+	irq_set_lockdep_class(irq, &brcmstb_gpio_irq_lock_class);
+	irq_set_chip_and_handler(irq, &priv->irq_chip, handle_simple_irq);
+#ifdef CONFIG_ARM
+	set_irq_flags(irq, IRQF_VALID);
+#else
+	irq_set_noprobe(irq);
+#endif
+	return 0;
+}
+
+static void brcmstb_gpio_irq_unmap(struct irq_domain *d, unsigned int irq)
+{
+	irq_set_chip_and_handler(irq, NULL, NULL);
+	irq_set_chip_data(irq, NULL);
+}
+
+static struct irq_domain_ops brcmstb_gpio_irq_domain_ops = {
+	.map = brcmstb_gpio_irq_map,
+	.unmap = brcmstb_gpio_irq_unmap,
+	.xlate = irq_domain_xlate_twocell,
+};
+
 /* Make sure that the number of banks matches up between properties */
 static int brcmstb_gpio_sanity_check_banks(struct device *dev,
 		struct device_node *np, struct resource *res)
@@ -127,6 +358,32 @@ static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
 	return offset;
 }
 
+/* priv->parent_irq and priv->num_gpios must be set before calling */
+static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
+		struct brcmstb_gpio_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	priv->irq_chip.name = dev_name(dev);
+	priv->irq_chip.irq_mask = brcmstb_gpio_irq_mask;
+	priv->irq_chip.irq_unmask = brcmstb_gpio_irq_unmask;
+	priv->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
+	priv->irq_domain =
+		irq_domain_add_linear(np, priv->num_gpios,
+				      &brcmstb_gpio_irq_domain_ops,
+				      priv);
+	if (!priv->irq_domain) {
+		dev_err(dev, "Couldn't allocate IRQ domain\n");
+		return -ENXIO;
+	}
+	irq_set_chained_handler(priv->parent_irq,
+				brcmstb_gpio_irq_handler);
+	irq_set_handler_data(priv->parent_irq, priv);
+
+	return 0;
+}
+
 static int brcmstb_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -153,6 +410,16 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	priv->reg_base = reg_base;
 	priv->pdev = pdev;
 
+	if (of_find_property(np, "interrupt-controller", NULL)) {
+		priv->parent_irq = platform_get_irq(pdev, 0);
+		if (priv->parent_irq < 0) {
+			dev_err(dev, "Couldn't get IRQ");
+			return -ENOENT;
+		}
+	} else {
+		priv->parent_irq = -ENOENT;
+	}
+
 	INIT_LIST_HEAD(&priv->bank_list);
 	if (brcmstb_gpio_sanity_check_banks(dev, np, res))
 		return -EINVAL;
@@ -201,6 +468,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		gc->of_xlate = brcmstb_gpio_of_xlate;
 		/* not all ngpio lines are valid, will use bank width later */
 		gc->ngpio = MAX_GPIO_PER_BANK;
+		if (priv->parent_irq >= 0)
+			gc->to_irq = brcmstb_gpio_to_irq;
 
 		err = gpiochip_add(gc);
 		if (err) {
@@ -218,6 +487,13 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		priv->num_banks++;
 	}
 
+	priv->num_gpios = gpio_base - priv->gpio_base;
+	if (priv->parent_irq >= 0) {
+		err = brcmstb_gpio_irq_setup(pdev, priv);
+		if (err)
+			goto fail;
+	}
+
 	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
 			priv->num_banks, priv->gpio_base, gpio_base - 1);
 
-- 
1.9.1
