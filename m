From: qnguyen@apm.com (Quan Nguyen)
Date: Thu,  7 Jan 2016 17:27:06 +0700
Subject: [PATCH v3 1/3] gpio: xgene: Enable X-Gene standby GPIO as interrupt
 controller
In-Reply-To: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
References: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
Message-ID: <1452162428-26839-2-git-send-email-qnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable X-Gene standby GPIO controller as interrupt controller to provide
its own resources. This avoids ambiguity where GIC interrupt resource is
use as X-Gene standby GPIO interrupt resource in user driver.

Signed-off-by: Y Vo <yvo@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
---
 drivers/gpio/gpio-xgene-sb.c | 289 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 247 insertions(+), 42 deletions(-)

diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index d57068b..a38c90a 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -2,8 +2,9 @@
  * AppliedMicro X-Gene SoC GPIO-Standby Driver
  *
  * Copyright (c) 2014, Applied Micro Circuits Corporation
- * Author: 	Tin Huynh <tnhuynh@apm.com>.
- * 		Y Vo <yvo@apm.com>.
+ * Author:	Tin Huynh <tnhuynh@apm.com>.
+ *		Y Vo <yvo@apm.com>.
+ *		Quan Nguyen <qnguyen@apm.com>.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -22,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
@@ -30,16 +32,22 @@
 
 #include "gpiolib.h"
 
-#define XGENE_MAX_GPIO_DS		22
-#define XGENE_MAX_GPIO_DS_IRQ		6
+#define XGENE_MAX_NGPIO		22
+#define XGENE_MAX_NIRQ		6
+#define XGENE_IRQ_START_PIN	8
+#define SBGPIO_XGENE		((XGENE_IRQ_START_PIN << 16) | \
+				(XGENE_MAX_NIRQ << 8) | XGENE_MAX_NGPIO)
 
-#define GPIO_MASK(x)			(1U << ((x) % 32))
+#define GPIO_MASK(x)		(1U << ((x) % 32))
 
-#define MPA_GPIO_INT_LVL		0x0290
-#define MPA_GPIO_OE_ADDR		0x029c
-#define MPA_GPIO_OUT_ADDR		0x02a0
-#define MPA_GPIO_IN_ADDR 		0x02a4
-#define MPA_GPIO_SEL_LO 		0x0294
+#define MPA_GPIO_INT_LVL	0x0290
+#define MPA_GPIO_OE_ADDR	0x029c
+#define MPA_GPIO_OUT_ADDR	0x02a0
+#define MPA_GPIO_IN_ADDR	0x02a4
+#define MPA_GPIO_SEL_LO		0x0294
+
+#define GPIO_INT_LEVEL_H	0x000001
+#define GPIO_INT_LEVEL_L	0x000000
 
 /**
  * struct xgene_gpio_sb - GPIO-Standby private data structure.
@@ -49,18 +57,30 @@
  */
 struct xgene_gpio_sb {
 	struct bgpio_chip	bgc;
-	u32 *irq;
+	void __iomem *regs;
+	u32    *gic_virq;
+	struct irq_domain *irq_domain;
 	u32 nirq;
+	u32 flags;
 };
 
-static inline struct xgene_gpio_sb *to_xgene_gpio_sb(struct gpio_chip *gc)
-{
-	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+#define NIRQ_MAX(priv) (((priv)->flags >> 8) & 0xff)
+#define NGPIO_MAX(priv) ((priv)->flags & 0xff)
+#define IRQ_START_PIN(priv) (((priv)->flags >> 16) & 0xff)
 
-	return container_of(bgc, struct xgene_gpio_sb, bgc);
+static const struct of_device_id xgene_gpio_sb_of_match[];
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xgene_gpio_sb_acpi_match[];
+#endif
+
+static unsigned long gic_irq_to_gpio_irq(struct xgene_gpio_sb *priv,
+							unsigned long hwirq)
+{
+	return hwirq - irq_get_irq_data(priv->gic_virq[0])->hwirq;
 }
 
-static void xgene_gpio_set_bit(struct bgpio_chip *bgc, void __iomem *reg, u32 gpio, int val)
+static void xgene_gpio_set_bit(struct bgpio_chip *bgc,
+				void __iomem *reg, u32 gpio, int val)
 {
 	u32 data;
 
@@ -72,23 +92,166 @@ static void xgene_gpio_set_bit(struct bgpio_chip *bgc, void __iomem *reg, u32 gp
 	bgc->write_reg(reg, data);
 }
 
-static int apm_gpio_sb_to_irq(struct gpio_chip *gc, u32 gpio)
+static void xgene_gpio_sb_irq_ack(struct irq_data *d)
+{
+	struct irq_data *irqdata;
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+
+	irqdata = irq_get_irq_data(priv->gic_virq[d->hwirq]);
+	if (!irqdata || !irqdata->chip)
+		return;
+
+	if (irqdata->chip->irq_ack)
+		irqdata->chip->irq_ack(irqdata);
+}
+
+static void xgene_gpio_sb_irq_mask(struct irq_data *d)
+{
+	struct irq_data *irqdata;
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+
+	irqdata = irq_get_irq_data(priv->gic_virq[d->hwirq]);
+	if (!irqdata || !irqdata->chip)
+		return;
+
+	if (irqdata->chip->irq_mask)
+		irqdata->chip->irq_mask(irqdata);
+}
+
+static void xgene_gpio_sb_irq_unmask(struct irq_data *d)
+{
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+	struct irq_data *irqdata;
+
+	irqdata = irq_get_irq_data(priv->gic_virq[d->hwirq]);
+	if (!irqdata || !irqdata->chip)
+		return;
+
+	if (irqdata->chip->irq_unmask)
+		irqdata->chip->irq_unmask(irqdata);
+}
+
+static int xgene_gpio_sb_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+	struct irq_data *irqdata;
+	int gpio = d->hwirq + IRQ_START_PIN(priv);
+	int lvl_type;
+	int ret;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		lvl_type = GPIO_INT_LEVEL_H;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		lvl_type = GPIO_INT_LEVEL_L;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = gpiochip_lock_as_irq(&priv->bgc.gc, gpio);
+	if (ret) {
+		dev_err(priv->bgc.gc.parent,
+		"Unable to configure XGene GPIO standby pin %d as IRQ\n",
+								gpio);
+		return ret;
+	}
+
+	if ((gpio >= IRQ_START_PIN(priv)) &&
+			(d->hwirq < NIRQ_MAX(priv))) {
+		xgene_gpio_set_bit(&priv->bgc, priv->regs + MPA_GPIO_SEL_LO,
+				gpio * 2, 1);
+		xgene_gpio_set_bit(&priv->bgc, priv->regs + MPA_GPIO_INT_LVL,
+				d->hwirq, lvl_type);
+	}
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(d, handle_edge_irq);
+	else
+		irq_set_handler_locked(d, handle_level_irq);
+
+	/* Propagate IRQ type setting to parent */
+	irqdata = irq_get_irq_data(priv->gic_virq[d->hwirq]);
+	if (!irqdata || !irqdata->chip || !!irqdata->chip->irq_set_type)
+		return 0;
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		irqdata->chip->irq_set_type(irqdata, IRQ_TYPE_EDGE_RISING);
+	else
+		irqdata->chip->irq_set_type(irqdata, IRQ_TYPE_LEVEL_HIGH);
+
+	return 0;
+}
+
+static void xgene_gpio_sb_irq_shutdown(struct irq_data *d)
+{
+	struct xgene_gpio_sb *priv = irq_data_get_irq_chip_data(d);
+
+	gpiochip_unlock_as_irq(&priv->bgc.gc, d->hwirq + IRQ_START_PIN(priv));
+}
+
+static void xgene_gpio_sb_irq_handler(struct irq_desc *desc)
+{
+	struct xgene_gpio_sb *priv = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	cascade_irq = irq_find_mapping(priv->irq_domain,
+		gic_irq_to_gpio_irq(priv, irq_desc_get_irq_data(desc)->hwirq));
+
+	if (cascade_irq)
+		generic_handle_irq(cascade_irq);
+
+	chained_irq_exit(chip, desc);
+}
+
+static struct irq_chip xgene_gpio_sb_irq_chip = {
+	.name           = "sbgpio",
+	.irq_ack        = xgene_gpio_sb_irq_ack,
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
+	if ((gpio < IRQ_START_PIN(priv)) ||
+	    (gpio > NIRQ_MAX(priv) + IRQ_START_PIN(priv)))
+		return -ENXIO;
 
-	return -ENXIO;
+	return irq_find_mapping(priv->irq_domain, gpio - IRQ_START_PIN(priv));
 }
 
+static int xgene_irq_to_line(struct xgene_gpio_sb *priv, u32 irq)
+{
+	u32 offset = gic_irq_to_gpio_irq(priv, irq_get_irq_data(irq)->hwirq);
+
+	return (offset < NIRQ_MAX(priv)) ?
+			(offset + IRQ_START_PIN(priv)) : -EINVAL;
+}
+
+
 static int xgene_gpio_sb_probe(struct platform_device *pdev)
 {
 	struct xgene_gpio_sb *priv;
 	u32 ret, i;
-	u32 default_lines[] = {0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D};
+	int virq, line;
 	struct resource *res;
 	void __iomem *regs;
+	const struct of_device_id *of_id;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -99,38 +262,79 @@ static int xgene_gpio_sb_probe(struct platform_device *pdev)
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
+	of_id = of_match_device(xgene_gpio_sb_of_match, &pdev->dev);
+	if (of_id)
+		priv->flags = (uintptr_t)of_id->data;
+#ifdef CONFIG_ACPI
+	else {
+		const struct acpi_device_id *acpi_id;
+
+		acpi_id = acpi_match_device(xgene_gpio_sb_acpi_match,
+								&pdev->dev);
+		if (acpi_id)
+			priv->flags = (uintptr_t)acpi_id->driver_data;
+	}
+#endif
+
+	priv->regs = regs;
 	ret = bgpio_init(&priv->bgc, &pdev->dev, 4,
 			regs + MPA_GPIO_IN_ADDR,
 			regs + MPA_GPIO_OUT_ADDR, NULL,
 			regs + MPA_GPIO_OE_ADDR, NULL, 0);
-        if (ret)
-                return ret;
-
-	priv->bgc.gc.to_irq = apm_gpio_sb_to_irq;
-	priv->bgc.gc.ngpio = XGENE_MAX_GPIO_DS;
+	if (ret)
+		return ret;
 
-	priv->nirq = XGENE_MAX_GPIO_DS_IRQ;
+	priv->bgc.gc.to_irq = xgene_gpio_sb_to_irq;
+	priv->bgc.gc.ngpio = NGPIO_MAX(priv);
 
-	priv->irq = devm_kzalloc(&pdev->dev, sizeof(u32) * XGENE_MAX_GPIO_DS,
-				   GFP_KERNEL);
-	if (!priv->irq)
+	priv->gic_virq = devm_kzalloc(&pdev->dev,
+			sizeof(u32) * NIRQ_MAX(priv),
+			GFP_KERNEL);
+	if (!priv->gic_virq)
 		return -ENOMEM;
 
-	for (i = 0; i < priv->nirq; i++) {
-		priv->irq[default_lines[i]] = platform_get_irq(pdev, i);
-		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_SEL_LO,
-                                   default_lines[i] * 2, 1);
-		xgene_gpio_set_bit(&priv->bgc, regs + MPA_GPIO_INT_LVL, i, 1);
+	/* Mapping and handling GIC irqs*/
+	for (i = 0; i < NIRQ_MAX(priv); i++) {
+		virq = platform_get_irq(pdev, i);
+		if (virq < 0)
+			break;
+		priv->gic_virq[i] = virq;
+		line = xgene_irq_to_line(priv, virq);
+		if (line < IRQ_START_PIN(priv))
+			break;
+
+		irq_set_chained_handler_and_data(virq,
+				&xgene_gpio_sb_irq_handler, priv);
 	}
 
+	priv->nirq = i;
+
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
@@ -143,22 +347,23 @@ static int xgene_gpio_sb_remove(struct platform_device *pdev)
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
 
 static const struct of_device_id xgene_gpio_sb_of_match[] = {
-	{.compatible = "apm,xgene-gpio-sb", },
+	{.compatible = "apm,xgene-gpio-sb", .data = (const void *)SBGPIO_XGENE},
 	{},
 };
 MODULE_DEVICE_TABLE(of, xgene_gpio_sb_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xgene_gpio_sb_acpi_match[] = {
-	{"APMC0D15", 0},
+	{"APMC0D15", SBGPIO_XGENE},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, xgene_gpio_sb_acpi_match);
-- 
2.2.0
