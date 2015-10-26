From: yvo@apm.com (Y Vo)
Date: Mon, 26 Oct 2015 13:49:33 +0700
Subject: [PATCH v2 1/3] gpio: xgene: add support to configure GPIO line as
 input, output or external IRQ pin
In-Reply-To: <1445842175-11446-1-git-send-email-yvo@apm.com>
References: <1445842175-11446-1-git-send-email-yvo@apm.com>
Message-ID: <1445842175-11446-2-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to configure GPIO line as input, output or external IRQ pin.

Signed-off-by: Y Vo <yvo@apm.com>
---
 drivers/gpio/gpio-xgene-sb.c |  234 +++++++++++++++++++++++++++++++++++------
 1 files changed, 199 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index d57068b..e67ab4c 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2014, Applied Micro Circuits Corporation
  * Author: 	Tin Huynh <tnhuynh@apm.com>.
  * 		Y Vo <yvo@apm.com>.
+ * 		Quan Nguyen <qnguyen@apm.com>.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -32,14 +33,24 @@
 
 #define XGENE_MAX_GPIO_DS		22
 #define XGENE_MAX_GPIO_DS_IRQ		6
+#define XGENE_GPIO8_HWIRQ		0x48
+#define XGENE_GPIO8_IDX			8
 
 #define GPIO_MASK(x)			(1U << ((x) % 32))
 
 #define MPA_GPIO_INT_LVL		0x0290
 #define MPA_GPIO_OE_ADDR		0x029c
 #define MPA_GPIO_OUT_ADDR		0x02a0
-#define MPA_GPIO_IN_ADDR 		0x02a4
-#define MPA_GPIO_SEL_LO 		0x0294
+#define MPA_GPIO_IN_ADDR		0x02a4
+#define MPA_GPIO_SEL_LO			0x0294
+
+#define GPIO_INT_LVL_LEVEL_HIGH         0x000001
+#define GPIO_INT_LVL_LEVEL_LOW          0x000000
+
+#define XGENE_HWIRQ_TO_GPIO(hwirq)	((hwirq) + XGENE_GPIO8_IDX)
+#define XGENE_GPIO_TO_HWIRQ(gpio)	((gpio) - XGENE_GPIO8_IDX)
+#define GIC_IRQ_TO_GPIO_IRQ(hwirq)	((hwirq) - XGENE_GPIO8_HWIRQ)
+#define GPIO_IRQ_TO_GIC_IRQ(hwirq)	((hwirq) + XGENE_GPIO8_HWIRQ)
 
 /**
  * struct xgene_gpio_sb - GPIO-Standby private data structure.
@@ -49,18 +60,14 @@
  */
 struct xgene_gpio_sb {
 	struct bgpio_chip	bgc;
-	u32 *irq;
+	void __iomem *regs;
+	struct irq_domain *gic_domain;
+	struct irq_domain *irq_domain;
 	u32 nirq;
 };
 
-static inline struct xgene_gpio_sb *to_xgene_gpio_sb(struct gpio_chip *gc)
-{
-	struct bgpio_chip *bgc = to_bgpio_chip(gc);
-
-	return container_of(bgc, struct xgene_gpio_sb, bgc);
-}
-
-static void xgene_gpio_set_bit(struct bgpio_chip *bgc, void __iomem *reg, u32 gpio, int val)
+static void xgene_gpio_set_bit(struct bgpio_chip *bgc,
+				void __iomem *reg, u32 gpio, int val)
 {
 	u32 data;
 
@@ -72,21 +79,152 @@ static void xgene_gpio_set_bit(struct bgpio_chip *bgc, void __iomem *reg, u32 gp
 	bgc->write_reg(reg, data);
 }
 
-static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
+/*
+ * NOP functions
+ */
+static void xgene_gpio_sb_nop(struct irq_data *data) { }
+
+static void xgene_gpio_sb_irq_mask(struct irq_data *d)
+{
+	unsigned int gic_irq;
+	struct irq_data *irqdata;
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+
+	gic_irq = irq_find_mapping(priv->gic_domain,
+			GPIO_IRQ_TO_GIC_IRQ(d->hwirq));
+	irqdata = irq_get_irq_data(gic_irq);
+	if (!irqdata || !irqdata->chip)
+		return;
+
+	if (irqdata->chip->irq_mask)
+		irqdata->chip->irq_mask(irqdata);
+}
+
+static void xgene_gpio_sb_irq_unmask(struct irq_data *d)
+{
+	unsigned int gic_irq;
+	struct irq_data *irqdata;
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+
+	gic_irq = irq_find_mapping(priv->gic_domain,
+			GPIO_IRQ_TO_GIC_IRQ(d->hwirq));
+	irqdata = irq_get_irq_data(gic_irq);
+	if (!irqdata || !irqdata->chip)
+		return;
+
+	if (irqdata->chip->irq_unmask)
+		irqdata->chip->irq_unmask(irqdata);
+}
+
+static int xgene_gpio_sb_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	int hwirq = d->hwirq;
+	int gpio = XGENE_HWIRQ_TO_GPIO(hwirq);
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+	int lvl_type;
+	int ret;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		lvl_type = GPIO_INT_LVL_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		lvl_type = GPIO_INT_LVL_LEVEL_LOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = gpiochip_lock_as_irq(&priv->bgc.gc, gpio);
+	if (ret) {
+		dev_err(priv->bgc.gc.dev,
+		"Unable to configure XGene GPIO standby pin %d as IRQ\n",
+								gpio);
+		return ret;
+	}
+
+	if ((gpio >= XGENE_GPIO8_IDX) &&
+			(hwirq < XGENE_MAX_GPIO_DS_IRQ)) {
+		xgene_gpio_set_bit(&priv->bgc, priv->regs + MPA_GPIO_SEL_LO,
+				gpio * 2, 1);
+		xgene_gpio_set_bit(&priv->bgc, priv->regs + MPA_GPIO_INT_LVL,
+				hwirq, lvl_type);
+	}
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+		irq_set_handler_locked(d, handle_edge_irq);
+	else
+		irq_set_handler_locked(d, handle_level_irq);
+
+	return 0;
+}
+
+static void xgene_gpio_sb_irq_shutdown(struct irq_data *d)
+{
+	int gpio = XGENE_HWIRQ_TO_GPIO(d->hwirq);
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+
+	gpiochip_unlock_as_irq(&priv->bgc.gc, gpio);
+}
+
+static void xgene_gpio_sb_irq_handler(struct irq_desc *desc)
+{
+	unsigned int cascade_irq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct xgene_gpio_sb *priv = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	cascade_irq = irq_find_mapping(priv->irq_domain,
+		GIC_IRQ_TO_GPIO_IRQ(irq_desc_get_irq_data(desc)->hwirq));
+
+	if (cascade_irq)
+		generic_handle_irq(cascade_irq);
+
+	chained_irq_exit(chip, desc);
+}
+
+static struct irq_chip xgene_gpio_sb_irq_chip = {
+	.name           = "sbgpio",
+	.irq_ack        = xgene_gpio_sb_nop,
+	.irq_mask       = xgene_gpio_sb_irq_mask,
+	.irq_unmask     = xgene_gpio_sb_irq_unmask,
+	.irq_set_type   = xgene_gpio_sb_irq_set_type,
+	.irq_shutdown   = xgene_gpio_sb_irq_shutdown,
+};
+
+static inline struct xgene_gpio_sb *to_xgene_gpio_sb(struct gpio_chip *gc)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+
+	return container_of(bgc, struct xgene_gpio_sb, bgc);
+}
+
+static int xgene_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
 {
 	struct xgene_gpio_sb *priv = to_xgene_gpio_sb(gc);
 
-	if (priv->irq[gpio])
-		return priv->irq[gpio];
+	if ((gpio < XGENE_GPIO8_IDX) ||
+	    (gpio > XGENE_MAX_GPIO_DS_IRQ + XGENE_GPIO8_IDX))
+		return -ENXIO;
 
-	return -ENXIO;
+	return irq_find_mapping(priv->irq_domain, XGENE_GPIO_TO_HWIRQ(gpio));
+}
+
+static int xgene_irq_to_line(u32 irq)
+{
+	u32 offset = GIC_IRQ_TO_GPIO_IRQ(irq_get_irq_data(irq)->hwirq);
+
+	return (offset < XGENE_MAX_GPIO_DS_IRQ) ?
+			(offset + XGENE_GPIO8_IDX) : -EINVAL;
 }
 
 static int xgene_gpio_sb_probe(struct platform_device *pdev)
 {
 	struct xgene_gpio_sb *priv;
 	u32 ret, i;
-	u32 default_lines[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};
+	int virq, line;
 	struct resource *res;
 	void __iomem *regs;
 
@@ -99,38 +237,63 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
+	priv->regs = regs;
+
 	ret = bgpio_init(&priv->bgc, &pdev->dev, 4,
 			regs + MPA_GPIO_IN_ADDR,
 			regs + MPA_GPIO_OUT_ADDR, NULL,
 			regs + MPA_GPIO_OE_ADDR, NULL, 0);
-        if (ret)
-                return ret;
+	if (ret)
+		return ret;
 
-	priv->bgc.gc.to_irq = apm_gpio_sb_to_irq;
+	priv->bgc.gc.to_irq = xgene_gpio_sb_to_irq;
 	priv->bgc.gc.ngpio = XGENE_MAX_GPIO_DS;
 
-	priv->nirq = XGENE_MAX_GPIO_DS_IRQ;
-
-	priv->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
-				   GFP_KERNEL);
-	if (!priv->irq)
-		return -ENOMEM;
+	/* Mapping and handling GIC irqs*/
+	for (i = 0; i < XGENE_MAX_GPIO_DS_IRQ; i++) {
+		virq = platform_get_irq(pdev, i);
+		if (virq < 0)
+			break;
+		line = xgene_irq_to_line(virq);
+		if (line < XGENE_GPIO8_IDX)
+			break;
+
+		irq_set_chained_handler_and_data(virq,
+					&xgene_gpio_sb_irq_handler, priv);
+	}
 
-	for (i = 0; i < priv->nirq; i++) {
-		priv->irq[default_lines[i]] = platform_get_irq(pdev, i);
-		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_SEL_LO,
-                                   default_lines[i] * 2, 1);
-		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_INT_LVL, i, 1);
+	priv->nirq = i;
+	if (priv->nirq > 0) {
+		virq = platform_get_irq(pdev, 0);
+		priv->gic_domain = irq_get_irq_data(virq)->domain;
 	}
 
 	platform_set_drvdata(pdev, priv);
 
+	priv->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
+			priv->nirq,
+			&irq_domain_simple_ops, priv);
+	if (!priv->irq_domain)
+		return -ENODEV;
+
 	ret = gpiochip_add(&priv->bgc.gc);
-	if (ret)
-		dev_err(&pdev->dev, "failed to register X-Gene GPIO Standby driver\n");
-	else
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register X-Gene GPIO Standby driver\n");
+		irq_domain_remove(priv->irq_domain);
+	} else
 		dev_info(&pdev->dev, "X-Gene GPIO Standby driver registered\n");
 
+	priv->bgc.gc.irqdomain = priv->irq_domain;
+
+	/* Init for new mapped irqs*/
+	for (i = 0; i < priv->nirq; i++) {
+		int irq = irq_create_mapping(priv->irq_domain, i);
+
+		irq_set_chip_data(irq, priv);
+		irq_set_chip(irq, &xgene_gpio_sb_irq_chip);
+	}
+
 	if (priv->nirq > 0) {
 		/* Register interrupt handlers for gpio signaled acpi events */
 		acpi_gpiochip_request_interrupts(&priv->bgc.gc);
@@ -143,9 +306,10 @@ static int xgene_gpio_sb_remove(struct platform_device *pdev)
 {
 	struct xgene_gpio_sb *priv = platform_get_drvdata(pdev);
 
-	if (priv->nirq > 0) {
+	if (priv->nirq > 0)
 		acpi_gpiochip_free_interrupts(&priv->bgc.gc);
-	}
+
+	irq_domain_remove(priv->irq_domain);
 
 	return bgpio_remove(&priv->bgc);
 }
-- 
1.7.1
