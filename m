From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed,  6 May 2015 01:37:57 -0700
Subject: [PATCH 3/3] gpio: brcmstb: Add interrupt support
In-Reply-To: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <1430901477-10678-4-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create an irq_chip for each GIO block.  Uses chained IRQ handling since
known uses of this block have a BCM7120 L2 interrupt controller as a
parent.  Supports interrupts for all GPIOs.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 drivers/gpio/Kconfig        |    1 +
 drivers/gpio/gpio-brcmstb.c |  249 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5f79b7f..2f9b913 100644
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
index c8f9014..6195838 100644
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
 
@@ -59,6 +65,226 @@ brcmstb_gpio_gc_to_priv(struct gpio_chip *gc)
 	return bank->parent_priv;
 }
 
+static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
+		unsigned int offset, bool enable)
+{
+	struct bgpio_chip *bgc = &bank->bgc;
+	struct brcmstb_gpio_priv *priv = bank->parent_priv;
+	unsigned long mask = bgc->pin2mask(bgc, offset);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bgc->lock, flags);
+
+	if (enable)
+		bank->imask |= mask;
+	else
+		bank->imask &= ~mask;
+	bgc->write_reg(priv->reg_base + GIO_MASK(bank->id), bank->imask);
+
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
+	void __iomem *reg_base = bank->parent_priv->reg_base;
+	unsigned long status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->bgc.lock, flags);
+	while ((status = bank->bgc.read_reg(reg_base + GIO_STAT(bank->id)) &
+			 bank->imask)) {
+		int bit;
+		for_each_set_bit(bit, &status, 32) {
+			int hwirq = bank->bgc.gc.base -
+				bank->parent_priv->gpio_base + bit;
+			int child_irq =
+				irq_find_mapping(bank->parent_priv->irq_domain,
+						 hwirq);
+			u32 stat = bank->bgc.read_reg(reg_base +
+						      GIO_STAT(bank->id));
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
@@ -140,6 +366,11 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	priv->gpio_base = gpio_base;
 	priv->reg_base = reg_base;
 	priv->pdev = pdev;
+	priv->parent_irq = platform_get_irq(pdev, 0);
+	if (priv->parent_irq < 0) {
+		dev_err(dev, "Couldn't get IRQ");
+		return -ENOENT;
+	}
 
 	INIT_LIST_HEAD(&priv->bank_list);
 	if (brcmstb_gpio_sanity_check_banks(dev, np, res))
@@ -181,6 +412,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		gc->base = gpio_base;
 		gc->of_gpio_n_cells = 2;
 		gc->of_xlate = brcmstb_gpio_of_xlate;
+		gc->to_irq = brcmstb_gpio_to_irq;
 
 		if (bank_width <= 0 || bank_width > GPIO_PER_BANK) {
 			gc->ngpio = GPIO_PER_BANK;
@@ -209,6 +441,23 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		priv->num_banks++;
 	}
 
+	priv->num_gpios = gpio_base - priv->gpio_base;
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
+		err = -ENXIO;
+		goto fail;
+	}
+	irq_set_chained_handler(priv->parent_irq, brcmstb_gpio_irq_handler);
+	irq_set_handler_data(priv->parent_irq, priv);
+
 	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
 			priv->num_banks, priv->gpio_base, gpio_base - 1);
 
-- 
1.7.9.5
