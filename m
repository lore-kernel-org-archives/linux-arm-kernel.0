From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  3 Aug 2017 20:15:10 +0900
Subject: [PATCH] irqchip: uniphier-aidet: add UniPhier AIDET irqchip driver
Message-ID: <1501758910-3488-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UniPhier SoCs contain AIDET (ARM Interrupt Detector).  This is intended
to provide additional features that are not covered by GIC.  The main
purpose is to provide logic inverter to support low level and falling
edge trigger type for interrupt lines from on-board devices.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../socionext,uniphier-aidet.txt                   |  32 +++
 MAINTAINERS                                        |   1 +
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-uniphier-aidet.c               | 252 +++++++++++++++++++++
 5 files changed, 291 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
 create mode 100644 drivers/irqchip/irq-uniphier-aidet.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
new file mode 100644
index 000000000000..af57fbccd234
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
@@ -0,0 +1,32 @@
+UniPhier AIDET
+
+UniPhier AIDET (ARM Interrupt Detector) is an add-on block for ARM GIC (Generic
+Interrupt Controller).  GIC itself can handle only high level and rising edge
+interrupts.  The AIDET provides logic inverter to support low level and falling
+edge interrupts.
+
+Required properties:
+- compatible: Should be one of the following:
+    "socionext,uniphier-ld4-aidet"  - for LD4 SoC
+    "socionext,uniphier-pro4-aidet" - for Pro4 SoC
+    "socionext,uniphier-sld8-aidet" - for sLD8 SoC
+    "socionext,uniphier-pro5-aidet" - for Pro5 SoC
+    "socionext,uniphier-pxs2-aidet" - for PXs2/LD6b SoC
+    "socionext,uniphier-ld11-aidet" - for LD11 SoC
+    "socionext,uniphier-ld20-aidet" - for LD20 SoC
+    "socionext,uniphier-pxs3-aidet" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- interrupt-controller: Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an interrupt
+  source.  The value should be 2.  The first cell defines the interrupt number.
+  The second cell specifies the trigger type as defined in interrupts.txt in
+  this directory.
+
+Example:
+
+	aidet: aidet at 5fc20000 {
+		compatible = "socionext,uniphier-pro4-aidet";
+		reg = <0x5fc20000 0x200>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 567343b8ffaa..26b3d10b7344 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1993,6 +1993,7 @@ F:	arch/arm64/boot/dts/socionext/
 F:	drivers/bus/uniphier-system-bus.c
 F:	drivers/clk/uniphier/
 F:	drivers/i2c/busses/i2c-uniphier*
+F:	drivers/irqchip/irq-uniphier-aidet.c
 F:	drivers/pinctrl/uniphier/
 F:	drivers/reset/reset-uniphier.c
 F:	drivers/tty/serial/8250/8250_uniphier.c
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f1fd5f44d1d4..a0d7218a1677 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -306,3 +306,8 @@ config QCOM_IRQ_COMBINER
 	help
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Qualcomm Technologies chips.
+
+config IRQ_UNIPHIER_AIDET
+	def_bool y
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e88d856cc09c..2c630574986f 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
+obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
new file mode 100644
index 000000000000..8ceed5070e77
--- /dev/null
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -0,0 +1,252 @@
+/*
+ * Driver for UniPhier AIDET (ARM Interrupt Detector)
+ *
+ * Copyright (C) 2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#define UNIPHIER_AIDET_NR_IRQS		256
+
+#define UNIPHIER_AIDET_DETCONF		0x00
+
+struct uniphier_aidet_priv {
+	struct irq_chip chip;
+	struct irq_domain *domain;
+	void __iomem *reg_base;
+	spinlock_t lock;
+	u32 saved_vals[UNIPHIER_AIDET_NR_IRQS / 32];
+};
+
+static void uniphier_aidet_reg_update(struct uniphier_aidet_priv *priv,
+				      unsigned int reg, u32 mask, u32 val)
+{
+	unsigned long flags;
+	u32 tmp;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	tmp = readl(priv->reg_base + reg);
+	tmp &= ~mask;
+	tmp |= mask & val;
+	writel(tmp, priv->reg_base + reg);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void uniphier_aidet_detconf_update(struct uniphier_aidet_priv *priv,
+					  unsigned long index, unsigned int val)
+{
+	unsigned int reg;
+	u32 mask;
+
+	reg = UNIPHIER_AIDET_DETCONF + index / 32 * 4;
+	mask = BIT(index % 32);
+
+	uniphier_aidet_reg_update(priv, reg, mask, val ? mask : 0);
+}
+
+static int uniphier_aidet_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct uniphier_aidet_priv *priv = data->chip_data;
+	unsigned int val = 0;
+
+	/* enable inverter for active low triggers */
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val = 1;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		val = 1;
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	uniphier_aidet_detconf_update(priv, data->hwirq, val);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static int uniphier_aidet_domain_translate(struct irq_domain *domain,
+					   struct irq_fwspec *fwspec,
+					   unsigned long *out_hwirq,
+					   unsigned int *out_type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+
+	*out_hwirq = fwspec->param[0];
+	*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int uniphier_aidet_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq, unsigned int nr_irqs,
+				       void *arg)
+{
+	struct uniphier_aidet_priv *priv = domain->host_data;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int i, ret;
+
+	ret = uniphier_aidet_domain_translate(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	if (hwirq >= UNIPHIER_AIDET_NR_IRQS)
+		return -ENXIO;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_fwspec parent_fwspec;
+
+		ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+						    &priv->chip, priv);
+		if (ret)
+			return ret;
+
+		/* parent is GIC */
+		parent_fwspec.fwnode = domain->parent->fwnode;
+		parent_fwspec.param_count = 3;
+		parent_fwspec.param[0] = 0;		/* SPI */
+		parent_fwspec.param[1] = hwirq - 32;
+		parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+
+		ret = irq_domain_alloc_irqs_parent(domain, virq, 1,
+						   &parent_fwspec);
+		if (ret)
+			return ret;
+
+		virq++;
+		hwirq++;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops uniphier_aidet_domain_ops = {
+	.alloc = uniphier_aidet_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = uniphier_aidet_domain_translate,
+};
+
+static int uniphier_aidet_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *parent_np;
+	struct irq_domain *parent_domain;
+	struct uniphier_aidet_priv *priv;
+	struct resource *res;
+
+	parent_np = of_irq_find_parent(dev->of_node);
+	if (!parent_np)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_np);
+	of_node_put(parent_np);
+	if (!parent_domain)
+		return -EPROBE_DEFER;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->reg_base))
+		return PTR_ERR(priv->reg_base);
+
+	spin_lock_init(&priv->lock);
+
+	priv->chip.name = dev_name(dev);
+	priv->chip.irq_mask = irq_chip_mask_parent;
+	priv->chip.irq_unmask = irq_chip_unmask_parent;
+	priv->chip.irq_eoi = irq_chip_eoi_parent;
+	priv->chip.irq_set_type = uniphier_aidet_irq_set_type;
+
+	priv->domain = irq_domain_add_hierarchy(parent_domain, 0,
+						UNIPHIER_AIDET_NR_IRQS,
+						dev->of_node,
+						&uniphier_aidet_domain_ops,
+						priv);
+	if (!priv->domain)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int __maybe_unused uniphier_aidet_suspend(struct device *dev)
+{
+	struct uniphier_aidet_priv *priv = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(priv->saved_vals); i++)
+		priv->saved_vals[i] = readl(priv->reg_base +
+					    UNIPHIER_AIDET_DETCONF + i * 4);
+
+	return 0;
+}
+
+static int __maybe_unused uniphier_aidet_resume(struct device *dev)
+{
+	struct uniphier_aidet_priv *priv = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(priv->saved_vals); i++)
+		writel(priv->saved_vals[i],
+		       priv->reg_base + UNIPHIER_AIDET_DETCONF + i * 4);
+
+	return 0;
+}
+
+static const struct dev_pm_ops uniphier_aidet_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(uniphier_aidet_suspend,
+				      uniphier_aidet_resume)
+};
+
+static const struct of_device_id uniphier_aidet_match[] = {
+	{ .compatible = "socionext,uniphier-ld4-aidet" },
+	{ .compatible = "socionext,uniphier-pro4-aidet" },
+	{ .compatible = "socionext,uniphier-sld8-aidet" },
+	{ .compatible = "socionext,uniphier-pro5-aidet" },
+	{ .compatible = "socionext,uniphier-pxs2-aidet" },
+	{ .compatible = "socionext,uniphier-ld11-aidet" },
+	{ .compatible = "socionext,uniphier-ld20-aidet" },
+	{ .compatible = "socionext,uniphier-pxs3-aidet" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver uniphier_aidet_driver = {
+	.probe = uniphier_aidet_probe,
+	.driver = {
+		.name = "uniphier-aidet",
+		.of_match_table = uniphier_aidet_match,
+		.pm = &uniphier_aidet_pm_ops,
+	},
+};
+builtin_platform_driver(uniphier_aidet_driver);
-- 
2.7.4
