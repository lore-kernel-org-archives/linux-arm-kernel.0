From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Thu, 17 Sep 2015 17:28:47 +0800
Subject: [PATCH 2/2] irqchip/Layerscape: Add Layerscape MSI controller support
In-Reply-To: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1442482127-32674-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <1442482127-32674-2-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoC of Freescale Layerscape provide a kind of MSI controller
which uses two registers MSIIR and MSIR to support 32 MSI
interrupts for each PCIe controller. The patch is to support it.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 .../bindings/interrupt-controller/fsl,ls1-msi.txt  |  26 +++
 arch/arm/mach-imx/Kconfig                          |   1 +
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-ls1-msi.c                      | 247 +++++++++++++++++++++
 5 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-msi.txt
 create mode 100644 drivers/irqchip/irq-ls1-msi.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-msi.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-msi.txt
new file mode 100644
index 0000000..29296c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls1-msi.txt
@@ -0,0 +1,26 @@
+* Freescale Layerscape PCIe MSI controller
+
+Required properties:
+
+- compatible: should be "fsl,<chip>-msi" to identify
+	      Layerscape PCIe MSI controller block.
+- msi-controller: indicates that this is a PCIe MSI controller node
+- reg: Should contain msiir and msir registers location and length.
+       MSIIR is a MSI index register to trigger interrupts.
+       MSIR indicates which of the 32 interrupt sources have pending interrupt.
+- reg-names: should be "msiir" and "msir".
+- interrupts: A interrupt of the controller.
+
+Each PCIe node needs to have property msi-parent that points to
+MSI controller node
+
+Examples:
+
+	msi1: msi-controller1 at 1571000 {
+		compatible = "fsl,1s1043a-msi";
+		reg = <0x0 0x1571000 0x0 0x4>,
+		      <0x0 0x1571004 0x0 0x4>;
+		reg-names = "msiir", "msir";
+		msi-controller;
+		interrupts = <0 116 0x4>;
+	};
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8ceda28..fe64598 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -570,6 +570,7 @@ config SOC_LS1021A
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select PCI_DOMAINS if PCI
+	select LS1_MSI if PCI_MSI
 	select ZONE_DMA if ARM_LPAE
 	help
 	  This enables support for Freescale LS1021A processor.
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 27b52c8..1da26b1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -187,3 +187,8 @@ config IMX_GPCV2
 	select IRQ_DOMAIN
 	help
 	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
+
+config LS1_MSI
+	bool
+	depends on PCI && PCI_MSI
+	select PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index bb3048f..5241aa7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
 obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
+obj-$(CONFIG_LS1_MSI)			+= irq-ls1-msi.o
diff --git a/drivers/irqchip/irq-ls1-msi.c b/drivers/irqchip/irq-ls1-msi.c
new file mode 100644
index 0000000..cf836b6
--- /dev/null
+++ b/drivers/irqchip/irq-ls1-msi.c
@@ -0,0 +1,247 @@
+/*
+ * Layerscape MSI(-X) support
+ *
+ * Copyright (C) 2015 Freescale Semiconductor.
+ *
+ * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+
+#define MSI_MAX_IRQS	32
+#define MSI_IBS_SHIFT	3
+
+struct ls1_msi {
+	spinlock_t		lock;
+	struct platform_device	*pdev;
+	struct irq_domain	*parent;
+	struct irq_domain	*msi_domain;
+	void __iomem		*msir;
+	phys_addr_t		msiir_addr;
+	u32			nr_irqs;
+	int			irq;
+	DECLARE_BITMAP(used, MSI_MAX_IRQS);
+};
+
+static struct irq_chip ls1_msi_irq_chip = {
+	.name = "MSI",
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info ls1_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS |
+		   MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX),
+	.chip	= &ls1_msi_irq_chip,
+};
+
+static void ls1_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct ls1_msi *msi_data = irq_data_get_irq_chip_data(data);
+
+	msg->address_hi = upper_32_bits(msi_data->msiir_addr);
+	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
+	msg->data = data->hwirq << MSI_IBS_SHIFT;
+}
+
+static int ls1_msi_set_affinity(struct irq_data *irq_data,
+				    const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip ls1_msi_parent_chip = {
+	.name			= "LS1 MSI",
+	.irq_compose_msi_msg	= ls1_msi_compose_msg,
+	.irq_set_affinity	= ls1_msi_set_affinity,
+};
+
+static int ls1_msi_domain_irq_alloc(struct irq_domain *domain,
+				    unsigned int virq,
+				    unsigned int nr_irqs,
+				    void *args)
+{
+	struct ls1_msi *msi_data = domain->host_data;
+	int pos, err = 0;
+
+	WARN_ON(nr_irqs != 1);
+
+	spin_lock(&msi_data->lock);
+	pos = find_first_zero_bit(msi_data->used, msi_data->nr_irqs);
+	if (pos < msi_data->nr_irqs)
+		__set_bit(pos, msi_data->used);
+	else
+		err = -ENOSPC;
+	spin_unlock(&msi_data->lock);
+
+	if (err)
+		return err;
+
+	irq_domain_set_info(domain, virq, pos,
+			    &ls1_msi_parent_chip, msi_data,
+			    handle_simple_irq, NULL, NULL);
+	set_irq_flags(virq, IRQF_VALID);
+
+	return 0;
+}
+
+static void ls1_msi_domain_irq_free(struct irq_domain *domain,
+				   unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct ls1_msi *msi_data = irq_data_get_irq_chip_data(d);
+	int pos;
+
+	pos = d->hwirq;
+	if (pos < 0 || pos >= msi_data->nr_irqs) {
+		pr_err("failed to teardown msi. Invalid hwirq %d\n", pos);
+		return;
+	}
+
+	spin_lock(&msi_data->lock);
+	__clear_bit(pos, msi_data->used);
+	spin_unlock(&msi_data->lock);
+}
+
+static const struct irq_domain_ops ls1_msi_domain_ops = {
+	.alloc	= ls1_msi_domain_irq_alloc,
+	.free	= ls1_msi_domain_irq_free,
+};
+
+static void ls1_msi_irq_handler(unsigned int __irq, struct irq_desc *desc)
+{
+	struct ls1_msi *msi_data = irq_desc_get_handler_data(desc);
+	unsigned long val;
+	int pos, virq;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	val = ioread32be(msi_data->msir);
+	for_each_set_bit(pos, &val, msi_data->nr_irqs) {
+		virq = irq_find_mapping(msi_data->parent, (31 - pos));
+		if (virq)
+			generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int ls1_msi_domains_init(struct ls1_msi *msi_data)
+{
+	/* Initialize MSI domain parent */
+	msi_data->parent = irq_domain_add_linear(NULL,
+						 msi_data->nr_irqs,
+						 &ls1_msi_domain_ops,
+						 msi_data);
+	if (!msi_data->parent) {
+		dev_err(&msi_data->pdev->dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi_data->msi_domain =
+		pci_msi_create_irq_domain(msi_data->pdev->dev.of_node,
+					  &ls1_msi_domain_info,
+					  msi_data->parent);
+	if (!msi_data->msi_domain) {
+		dev_err(&msi_data->pdev->dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi_data->parent);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int ls1_msi_probe(struct platform_device *pdev)
+{
+	struct ls1_msi *msi_data;
+	struct resource *res;
+	int ret;
+
+	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msiir");
+	if (!res) {
+		dev_err(&pdev->dev, "missed msiir.\n");
+		return -ENODEV;
+	}
+	msi_data->msiir_addr = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msir");
+	msi_data->msir = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(msi_data->msir)) {
+		dev_err(&pdev->dev, "failed to initialize MSIR.\n");
+		return PTR_ERR(msi_data->msir);
+	}
+
+	msi_data->irq = platform_get_irq(pdev, 0);
+	if (msi_data->irq <= 0) {
+		dev_err(&pdev->dev, "failed to get MSI irq\n");
+		return -ENODEV;
+	}
+
+	msi_data->pdev = pdev;
+	msi_data->nr_irqs = MSI_MAX_IRQS;
+	spin_lock_init(&msi_data->lock);
+
+	ret = ls1_msi_domains_init(msi_data);
+	if (ret)
+		return ret;
+
+	irq_set_chained_handler_and_data(msi_data->irq,
+					 ls1_msi_irq_handler,
+					 msi_data);
+
+	platform_set_drvdata(pdev, msi_data);
+
+	return 0;
+}
+
+static int ls1_msi_remove(struct platform_device *pdev)
+{
+	struct ls1_msi *msi_data = platform_get_drvdata(pdev);
+
+	irq_set_chained_handler_and_data(msi_data->irq, NULL, NULL);
+
+	irq_domain_remove(msi_data->msi_domain);
+	irq_domain_remove(msi_data->parent);
+
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static const struct of_device_id ls1_msi_id[] = {
+	{ .compatible = "fsl,1s1021a-msi", },
+	{ .compatible = "fsl,1s1043a-msi", },
+	{},
+};
+
+static struct platform_driver ls1_msi_driver = {
+	.driver = {
+		.name = "ls1-msi",
+		.of_match_table = ls1_msi_id,
+	},
+	.probe = ls1_msi_probe,
+	.remove = ls1_msi_remove,
+};
+
+module_platform_driver(ls1_msi_driver);
+
+MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
+MODULE_DESCRIPTION("Freescale Layerscape1 MSI controller driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
