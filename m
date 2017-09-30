From: opendmb@gmail.com (Doug Berger)
Date: Fri, 29 Sep 2017 20:40:56 -0700
Subject: [PATCH 6/7] gpio: brcmstb: consolidate interrupt domains
In-Reply-To: <20170930034057.15166-1-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
Message-ID: <20170930034057.15166-7-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIOLIB IRQ chip helpers were very appealing, but badly broke
the 1:1 mapping between a GPIO controller's device_node and its
interrupt domain.

This commit consolidates the per bank irq domains to a version
where we have one larger interrupt domain per GPIO controller
instance spanning multiple GPIO banks.

Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/gpio/Kconfig        |   2 +-
 drivers/gpio/gpio-brcmstb.c | 188 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 145 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 796b11c489ae..28dd05aaa408 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -139,7 +139,7 @@ config GPIO_BRCMSTB
 	default y if (ARCH_BRCMSTB || BMIPS_GENERIC)
 	depends on OF_GPIO && (ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST)
 	select GPIO_GENERIC
-	select GPIOLIB_IRQCHIP
+	select IRQ_DOMAIN
 	help
 	  Say yes here to enable GPIO support for Broadcom STB (BCM7XXX) SoCs.
 
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index e2fff559c1ca..752a46ce3589 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -37,20 +37,22 @@ struct brcmstb_gpio_bank {
 	struct gpio_chip gc;
 	struct brcmstb_gpio_priv *parent_priv;
 	u32 width;
-	struct irq_chip irq_chip;
 };
 
 struct brcmstb_gpio_priv {
 	struct list_head bank_list;
 	void __iomem *reg_base;
 	struct platform_device *pdev;
+	struct irq_domain *irq_domain;
+	struct irq_chip irq_chip;
 	int parent_irq;
 	int gpio_base;
+	int num_gpios;
 	int parent_wake_irq;
 	struct notifier_block reboot_notifier;
 };
 
-#define MAX_GPIO_PER_BANK           32
+#define MAX_GPIO_PER_BANK       32
 #define GPIO_BANK(gpio)         ((gpio) >> 5)
 /* assumes MAX_GPIO_PER_BANK is a multiple of 2 */
 #define GPIO_BIT(gpio)          ((gpio) & (MAX_GPIO_PER_BANK - 1))
@@ -77,12 +79,18 @@ brcmstb_gpio_get_active_irqs(struct brcmstb_gpio_bank *bank)
 	return status;
 }
 
+static int brcmstb_gpio_hwirq_to_offset(irq_hw_number_t hwirq,
+					struct brcmstb_gpio_bank *bank)
+{
+	return hwirq - (bank->gc.base - bank->parent_priv->gpio_base);
+}
+
 static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
 		unsigned int offset, bool enable)
 {
 	struct gpio_chip *gc = &bank->gc;
 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
-	u32 mask = gc->pin2mask(gc, offset);
+	u32 mask = BIT(brcmstb_gpio_hwirq_to_offset(offset, bank));
 	u32 imask;
 	unsigned long flags;
 
@@ -96,6 +104,17 @@ static void brcmstb_gpio_set_imask(struct brcmstb_gpio_bank *bank,
 	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
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
 /* -------------------- IRQ chip functions -------------------- */
 
 static void brcmstb_gpio_irq_mask(struct irq_data *d)
@@ -119,7 +138,7 @@ static void brcmstb_gpio_irq_ack(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct brcmstb_gpio_bank *bank = gpiochip_get_data(gc);
 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
-	u32 mask = BIT(d->hwirq);
+	u32 mask = BIT(brcmstb_gpio_hwirq_to_offset(d->hwirq, bank));
 
 	gc->write_reg(priv->reg_base + GIO_STAT(bank->id), mask);
 }
@@ -129,7 +148,7 @@ static int brcmstb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct brcmstb_gpio_bank *bank = gpiochip_get_data(gc);
 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
-	u32 mask = BIT(d->hwirq);
+	u32 mask = BIT(brcmstb_gpio_hwirq_to_offset(d->hwirq, bank));
 	u32 edge_insensitive, iedge_insensitive;
 	u32 edge_config, iedge_config;
 	u32 level, ilevel;
@@ -226,18 +245,19 @@ static irqreturn_t brcmstb_gpio_wake_irq_handler(int irq, void *data)
 static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 {
 	struct brcmstb_gpio_priv *priv = bank->parent_priv;
-	struct irq_domain *irq_domain = bank->gc.irqdomain;
+	struct irq_domain *domain = priv->irq_domain;
+	int hwbase = bank->gc.base - priv->gpio_base;
 	unsigned long status;
+	unsigned int irq;
 
 	while ((status = brcmstb_gpio_get_active_irqs(bank))) {
-		int bit;
-
-		for_each_set_bit(bit, &status, 32) {
-			if (bit >= bank->width)
+		for_each_set_bit(irq, &status, 32) {
+			if (irq >= bank->width)
 				dev_warn(&priv->pdev->dev,
 					 "IRQ for invalid GPIO (bank=%d, offset=%d)\n",
-					 bank->id, bit);
-			generic_handle_irq(irq_find_mapping(irq_domain, bit));
+					 bank->id, irq);
+			irq = irq_linear_revmap(domain, irq + hwbase);
+			generic_handle_irq(irq);
 		}
 	}
 }
@@ -245,8 +265,7 @@ static void brcmstb_gpio_irq_bank_handler(struct brcmstb_gpio_bank *bank)
 /* Each UPG GIO block has one IRQ for all banks */
 static void brcmstb_gpio_irq_handler(struct irq_desc *desc)
 {
-	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
-	struct brcmstb_gpio_priv *priv = brcmstb_gpio_gc_to_priv(gc);
+	struct brcmstb_gpio_priv *priv = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct brcmstb_gpio_bank *bank;
 
@@ -272,6 +291,63 @@ static int brcmstb_gpio_reboot(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static struct brcmstb_gpio_bank *brcmstb_gpio_hwirq_to_bank(
+		struct brcmstb_gpio_priv *priv, irq_hw_number_t hwirq)
+{
+	struct brcmstb_gpio_bank *bank;
+	int i = 0;
+
+	/* banks are in descending order */
+	list_for_each_entry_reverse(bank, &priv->bank_list, node) {
+		i += bank->gc.ngpio;
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
+	ret = irq_set_chip_data(irq, &bank->gc);
+	if (ret < 0)
+		return ret;
+	irq_set_lockdep_class(irq, &brcmstb_gpio_irq_lock_class);
+	irq_set_chip_and_handler(irq, &priv->irq_chip, handle_level_irq);
+	irq_set_noprobe(irq);
+	return 0;
+}
+
+static void brcmstb_gpio_irq_unmap(struct irq_domain *d, unsigned int irq)
+{
+	irq_set_chip_and_handler(irq, NULL, NULL);
+	irq_set_chip_data(irq, NULL);
+}
+
+static const struct irq_domain_ops brcmstb_gpio_irq_domain_ops = {
+	.map = brcmstb_gpio_irq_map,
+	.unmap = brcmstb_gpio_irq_unmap,
+	.xlate = irq_domain_xlate_twocell,
+};
+
 /* Make sure that the number of banks matches up between properties */
 static int brcmstb_gpio_sanity_check_banks(struct device *dev,
 		struct device_node *np, struct resource *res)
@@ -293,13 +369,25 @@ static int brcmstb_gpio_remove(struct platform_device *pdev)
 {
 	struct brcmstb_gpio_priv *priv = platform_get_drvdata(pdev);
 	struct brcmstb_gpio_bank *bank;
-	int ret = 0;
+	int offset, ret = 0, virq;
 
 	if (!priv) {
 		dev_err(&pdev->dev, "called %s without drvdata!\n", __func__);
 		return -EFAULT;
 	}
 
+	if (priv->parent_irq > 0)
+		irq_set_chained_handler_and_data(priv->parent_irq, NULL, NULL);
+
+	/* Remove all IRQ mappings and delete the domain */
+	if (priv->irq_domain) {
+		for (offset = 0; offset < priv->num_gpios; offset++) {
+			virq = irq_find_mapping(priv->irq_domain, offset);
+			irq_dispose_mapping(virq);
+		}
+		irq_domain_remove(priv->irq_domain);
+	}
+
 	/*
 	 * You can lose return values below, but we report all errors, and it's
 	 * more important to actually perform all of the steps.
@@ -347,28 +435,24 @@ static int brcmstb_gpio_of_xlate(struct gpio_chip *gc,
 	return offset;
 }
 
-/* Before calling, must have bank->parent_irq set and gpiochip registered */
+/* priv->parent_irq and priv->num_gpios must be set before calling */
 static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
-		struct brcmstb_gpio_bank *bank)
+		struct brcmstb_gpio_priv *priv)
 {
-	struct brcmstb_gpio_priv *priv = bank->parent_priv;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int err;
 
-	bank->irq_chip.name = dev_name(dev);
-	bank->irq_chip.irq_mask = brcmstb_gpio_irq_mask;
-	bank->irq_chip.irq_unmask = brcmstb_gpio_irq_unmask;
-	bank->irq_chip.irq_ack = brcmstb_gpio_irq_ack;
-	bank->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
-
-	/* Ensures that all non-wakeup IRQs are disabled at suspend */
-	/* and that interrupts are masked when changing their type  */
-	bank->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
-			       IRQCHIP_SET_TYPE_MASKED;
+	priv->irq_domain =
+		irq_domain_add_linear(np, priv->num_gpios,
+				      &brcmstb_gpio_irq_domain_ops,
+				      priv);
+	if (!priv->irq_domain) {
+		dev_err(dev, "Couldn't allocate IRQ domain\n");
+		return -ENXIO;
+	}
 
-	if (IS_ENABLED(CONFIG_PM_SLEEP) && !priv->parent_wake_irq &&
-			of_property_read_bool(np, "wakeup-source")) {
+	if (of_property_read_bool(np, "wakeup-source")) {
 		priv->parent_wake_irq = platform_get_irq(pdev, 1);
 		if (priv->parent_wake_irq < 0) {
 			priv->parent_wake_irq = 0;
@@ -389,7 +473,7 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 
 			if (err < 0) {
 				dev_err(dev, "Couldn't request wake IRQ");
-				return err;
+				goto out_free_domain;
 			}
 
 			priv->reboot_notifier.notifier_call =
@@ -398,17 +482,30 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 		}
 	}
 
+	priv->irq_chip.name = dev_name(dev);
+	priv->irq_chip.irq_disable = brcmstb_gpio_irq_mask;
+	priv->irq_chip.irq_mask = brcmstb_gpio_irq_mask;
+	priv->irq_chip.irq_unmask = brcmstb_gpio_irq_unmask;
+	priv->irq_chip.irq_ack = brcmstb_gpio_irq_ack;
+	priv->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
+
+	/* Ensures that all non-wakeup IRQs are disabled at suspend */
+	/* and that interrupts are masked when changing their type  */
+	priv->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
+			       IRQCHIP_SET_TYPE_MASKED;
+
 	if (priv->parent_wake_irq)
-		bank->irq_chip.irq_set_wake = brcmstb_gpio_irq_set_wake;
+		priv->irq_chip.irq_set_wake = brcmstb_gpio_irq_set_wake;
 
-	err = gpiochip_irqchip_add(&bank->gc, &bank->irq_chip, 0,
-				   handle_level_irq, IRQ_TYPE_NONE);
-	if (err)
-		return err;
-	gpiochip_set_chained_irqchip(&bank->gc, &bank->irq_chip,
-			priv->parent_irq, brcmstb_gpio_irq_handler);
+	irq_set_chained_handler_and_data(priv->parent_irq,
+					 brcmstb_gpio_irq_handler, priv);
 
 	return 0;
+
+out_free_domain:
+	irq_domain_remove(priv->irq_domain);
+
+	return err;
 }
 
 static int brcmstb_gpio_probe(struct platform_device *pdev)
@@ -513,6 +610,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		gc->of_xlate = brcmstb_gpio_of_xlate;
 		/* not all ngpio lines are valid, will use bank width later */
 		gc->ngpio = MAX_GPIO_PER_BANK;
+		if (priv->parent_irq > 0)
+			gc->to_irq = brcmstb_gpio_to_irq;
 
 		/*
 		 * Mask all interrupts by default, since wakeup interrupts may
@@ -528,12 +627,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		}
 		gpio_base += gc->ngpio;
 
-		if (priv->parent_irq > 0) {
-			err = brcmstb_gpio_irq_setup(pdev, bank);
-			if (err)
-				goto fail;
-		}
-
 		dev_dbg(dev, "bank=%d, base=%d, ngpio=%d, width=%d\n", bank->id,
 			gc->base, gc->ngpio, bank->width);
 
@@ -543,6 +636,13 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		num_banks++;
 	}
 
+	priv->num_gpios = gpio_base - priv->gpio_base;
+	if (priv->parent_irq > 0) {
+		err = brcmstb_gpio_irq_setup(pdev, priv);
+		if (err)
+			goto fail;
+	}
+
 	dev_info(dev, "Registered %d banks (GPIO(s): %d-%d)\n",
 			num_banks, priv->gpio_base, gpio_base - 1);
 
-- 
2.14.1
