From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 25 Feb 2016 23:04:46 +0100
Subject: [PATCH 1/2] irqchip: add lpc18xx gpio pin interrupt driver
In-Reply-To: <1456437887-24432-1-git-send-email-manabian@gmail.com>
References: <1456437887-24432-1-git-send-email-manabian@gmail.com>
Message-ID: <1456437887-24432-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC18xx has an interrupt controller called 'gpio pin interrupt'
or just PINT. The PINT can handle up to 8 interrupts and these have
a one-to-one relationship with the main interrupt controller (NVIC).
The interrupts on PINT can be either level or edge trigger and
supports any polarity.

Selection of which GPIOs that are connected to the PINT is done by
the lpc18xx pinctrl driver (SCU).

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/irqchip/Kconfig                 |   5 +
 drivers/irqchip/Makefile                |   1 +
 drivers/irqchip/irq-lpc18xx-gpio-pint.c | 238 ++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/irqchip/irq-lpc18xx-gpio-pint.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 715923d5236c..4d26b2e82e0c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -190,6 +190,11 @@ config KEYSTONE_IRQ
 		Support for Texas Instruments Keystone 2 IRQ controller IP which
 		is part of the Keystone 2 IPC mechanism
 
+config LPC18XX_GPIO_PINT
+	bool
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+
 config MIPS_GIC
 	bool
 	select MIPS_CM
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 18caacb60d58..ae6e05e4347d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_BCM7038_L1_IRQ)		+= irq-bcm7038-l1.o
 obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
 obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
 obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
+obj-$(CONFIG_LPC18XX_GPIO_PINT)		+= irq-lpc18xx-gpio-pint.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
diff --git a/drivers/irqchip/irq-lpc18xx-gpio-pint.c b/drivers/irqchip/irq-lpc18xx-gpio-pint.c
new file mode 100644
index 000000000000..4dc791681016
--- /dev/null
+++ b/drivers/irqchip/irq-lpc18xx-gpio-pint.c
@@ -0,0 +1,238 @@
+/*
+ * Irqchip driver for GPIO Pin Interrupt (PINT) on NXP LPC18xx/43xx.
+ *
+ * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+/* LPC18xx GPIO pin interrupt register offsets */
+#define LPC18XX_GPIO_PINT_ISEL		0x000
+#define LPC18XX_GPIO_PINT_SIENR		0x008
+#define LPC18XX_GPIO_PINT_CIENR		0x00c
+#define LPC18XX_GPIO_PINT_SIENF		0x014
+#define LPC18XX_GPIO_PINT_CIENF		0x018
+#define LPC18XX_GPIO_PINT_IST		0x024
+
+struct lpc18xx_gpio_pint_chip {
+	struct irq_domain *domain;
+	void __iomem	  *base;
+	struct clk	  *clk;
+	int		  *irqmap;
+	int		  nrirqs;
+};
+
+static void lpc18xx_gpio_pint_handler(struct irq_desc *desc)
+{
+	struct lpc18xx_gpio_pint_chip *pint = irq_desc_get_handler_data(desc);
+	unsigned int irq = irq_desc_get_irq(desc);
+	int irq_no, i;
+
+	/* Find the interrupt */
+	for (i = 0; i < pint->nrirqs; i++) {
+		if (pint->irqmap[i] == irq) {
+			irq_no = irq_find_mapping(pint->domain, i);
+			generic_handle_irq(irq_no);
+		}
+	}
+}
+
+static void lpc18xx_gpio_pint_edge_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_IST);
+	irq_gc_unlock(gc);
+}
+
+static void lpc18xx_gpio_pint_edge_mask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENR);
+	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENF);
+	irq_gc_unlock(gc);
+}
+
+static void lpc18xx_gpio_pint_edge_unmask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 type, mask = d->mask;
+
+	irq_gc_lock(gc);
+	type = irqd_get_trigger_type(d);
+	if (type & IRQ_TYPE_EDGE_RISING)
+		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENR);
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENF);
+	irq_gc_unlock(gc);
+}
+
+static void lpc18xx_gpio_pint_level_mask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENR);
+	irq_gc_unlock(gc);
+}
+
+static void lpc18xx_gpio_pint_level_unmask(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	u32 mask = d->mask;
+
+	irq_gc_lock(gc);
+	irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENR);
+	irq_gc_unlock(gc);
+}
+
+static int lpc18xx_gpio_pint_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	u32 mask = data->mask;
+
+	irq_gc_lock(gc);
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		gc->type_cache |= mask;
+	else
+		gc->type_cache &= ~mask;
+	irq_reg_writel(gc, gc->type_cache, LPC18XX_GPIO_PINT_ISEL);
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_SIENF);
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_reg_writel(gc, mask, LPC18XX_GPIO_PINT_CIENF);
+		break;
+
+	/* IRQ_TYPE_EDGE_* is set in lpc18xx_gpio_pint_edge_unmask */
+	}
+
+	irqd_set_trigger_type(data, type);
+	irq_setup_alt_chip(data, type);
+	irq_gc_unlock(gc);
+
+	return 0;
+}
+
+static int lpc18xx_gpio_pint_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct lpc18xx_gpio_pint_chip *pint;
+	struct irq_chip_generic *gc;
+	struct resource *regs;
+	int i, ret;
+
+	pint = devm_kzalloc(&pdev->dev, sizeof(*pint), GFP_KERNEL);
+	if (!pint)
+		return -ENOMEM;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pint->base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(pint->base))
+		return PTR_ERR(pint->base);
+
+	pint->nrirqs = of_irq_count(np);
+	pint->irqmap = devm_kcalloc(&pdev->dev, pint->nrirqs, sizeof(int),
+				    GFP_KERNEL);
+	if (!pint->irqmap)
+		return -ENOMEM;
+
+	pint->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pint->clk)) {
+		dev_err(&pdev->dev, "input clock not found\n");
+		return PTR_ERR(pint->clk);
+	}
+
+	ret = clk_prepare_enable(pint->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable clock\n");
+		return ret;
+	}
+
+	pint->domain = irq_domain_add_linear(np, pint->nrirqs,
+					     &irq_generic_chip_ops, pint);
+	if (!pint->domain) {
+		dev_err(&pdev->dev, "unable setup irq domain\n");
+		ret = -EINVAL;
+		goto err_domain_add;
+	}
+
+	ret = irq_alloc_domain_generic_chips(pint->domain, pint->nrirqs, 2,
+					     "gpio_pint", handle_edge_irq,
+					     0, 0, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "unable alloc irq domain chips\n");
+		goto err_alloc_domain_gc;
+	}
+
+	gc = irq_get_domain_generic_chip(pint->domain, 0);
+	gc->reg_base = pint->base;
+
+	gc->chip_types[0].type		    = IRQ_TYPE_EDGE_BOTH;
+	gc->chip_types[0].handler	    = handle_edge_irq;
+	gc->chip_types[0].chip.irq_ack	    = lpc18xx_gpio_pint_edge_ack;
+	gc->chip_types[0].chip.irq_mask	    = lpc18xx_gpio_pint_edge_mask;
+	gc->chip_types[0].chip.irq_unmask   = lpc18xx_gpio_pint_edge_unmask;
+	gc->chip_types[0].chip.irq_set_type = lpc18xx_gpio_pint_type;
+
+	gc->chip_types[1].type		    = IRQ_TYPE_LEVEL_MASK;
+	gc->chip_types[1].handler	    = handle_level_irq;
+	gc->chip_types[1].chip.irq_mask	    = lpc18xx_gpio_pint_level_mask;
+	gc->chip_types[1].chip.irq_unmask   = lpc18xx_gpio_pint_level_unmask;
+	gc->chip_types[1].chip.irq_set_type = lpc18xx_gpio_pint_type;
+
+	/* Disable and clear all interrupts */
+	writel(~0, pint->base + LPC18XX_GPIO_PINT_CIENR);
+	writel(~0, pint->base + LPC18XX_GPIO_PINT_CIENF);
+	writel(0,  pint->base + LPC18XX_GPIO_PINT_ISEL);
+	writel(~0, pint->base + LPC18XX_GPIO_PINT_IST);
+
+	for (i = 0; i < pint->nrirqs; i++) {
+		pint->irqmap[i] = platform_get_irq(pdev, i);
+		irq_set_chained_handler_and_data(pint->irqmap[i],
+						 lpc18xx_gpio_pint_handler,
+						 pint);
+	}
+
+	return 0;
+
+err_alloc_domain_gc:
+	irq_domain_remove(pint->domain);
+err_domain_add:
+	clk_disable_unprepare(pint->clk);
+	return ret;
+}
+
+static const struct of_device_id lpc18xx_gpio_pint_match[] = {
+	{ .compatible = "nxp,lpc1850-gpio-pint" },
+	{ }
+};
+
+static struct platform_driver lpc18xx_gpio_pint_driver = {
+	.probe	= lpc18xx_gpio_pint_probe,
+	.driver	= {
+		.name = "lpc18xx-gpio-pint",
+		.of_match_table = lpc18xx_gpio_pint_match,
+	},
+};
+builtin_platform_driver(lpc18xx_gpio_pint_driver);
-- 
1.8.0
