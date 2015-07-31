From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Fri, 31 Jul 2015 16:33:58 -0500
Subject: [PATCH v8 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup sources
In-Reply-To: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
References: <1438378439-11569-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <1438378439-11569-2-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IMX7D contains a new version of GPC IP block (GPCv2). It has two
major functions: power management and wakeup source management.
This patch adds a new irqchip driver to manage the interrupt wakeup
sources on IMX7D.
When the system is in WFI (wait for interrupt) mode, this GPC block
will be the first block on the platform to be activated and signaled.
Under normal wait mode during cpu idle, the system can be woke up
by any enabled interrupts. Under standby or suspend mode, the system
can only be woke up by the pre-defined wakeup sources.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/irqchip/Kconfig         |   7 ++
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-imx-gpcv2.c | 273 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-gpcv2.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 120d815..3fc0fac 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -177,3 +177,10 @@ config RENESAS_H8300H_INTC
 config RENESAS_H8S_INTC
         bool
 	select IRQ_DOMAIN
+
+config IMX_GPCV2
+	bool
+	select IRQ_DOMAIN
+	help
+	  Enables the wakeup IRQs for IMX platforms with GPCv2 block
+
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b8d4e96..8eb5f60 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
 obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o
 obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
+obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
new file mode 100644
index 0000000..c2728b0
--- /dev/null
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -0,0 +1,273 @@
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/irqchip.h>
+#include <linux/syscore_ops.h>
+
+#define IMR_NUM			4
+#define GPC_MAX_IRQS            (IMR_NUM * 32)
+
+#define GPC_IMR1_CORE0		0x30
+#define GPC_IMR1_CORE1		0x40
+
+struct gpcv2_irqchip_data {
+	struct raw_spinlock rlock;
+	void __iomem *gpc_base;
+	u32 wakeup_sources[IMR_NUM];
+	u32 enabled_irqs[IMR_NUM];
+	u32 cpu2wakeup;
+};
+
+static struct gpcv2_irqchip_data *imx_gpcv2_instance;
+
+u32 imx_gpcv2_get_wakeup_source(u32 **sources)
+{
+	if (!imx_gpcv2_instance)
+		return 0;
+
+	if (sources)
+		*sources = imx_gpcv2_instance->wakeup_sources;
+
+	return IMR_NUM;
+}
+
+static int gpcv2_wakeup_source_save(void)
+{
+	struct gpcv2_irqchip_data *cd;
+	void __iomem *reg;
+	int i;
+
+	cd = imx_gpcv2_instance;
+	if (!cd)
+		return 0;
+
+	for (i = 0; i < IMR_NUM; i++) {
+		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
+		cd->enabled_irqs[i] = readl_relaxed(reg);
+		writel_relaxed(cd->wakeup_sources[i], reg);
+	}
+
+	return 0;
+}
+
+static void gpcv2_wakeup_source_restore(void)
+{
+	struct gpcv2_irqchip_data *cd;
+	void __iomem *reg;
+	int i;
+
+	cd = imx_gpcv2_instance;
+	if (!cd)
+		return;
+
+	for (i = 0; i < IMR_NUM; i++) {
+		reg = cd->gpc_base + cd->cpu2wakeup + i * 4;
+		writel_relaxed(cd->enabled_irqs[i], reg);
+		cd->wakeup_sources[i] = ~0;
+	}
+}
+
+static struct syscore_ops imx_gpcv2_syscore_ops = {
+	.suspend	= gpcv2_wakeup_source_save,
+	.resume		= gpcv2_wakeup_source_restore,
+};
+
+static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct gpcv2_irqchip_data *cd = d->chip_data;
+	unsigned int idx = d->hwirq / 32;
+	unsigned long flags;
+	void __iomem *reg;
+	u32 mask, val;
+
+	raw_spin_lock_irqsave(&cd->rlock, flags);
+	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
+	mask = 1 << d->hwirq % 32;
+	val = cd->wakeup_sources[idx];
+
+	cd->wakeup_sources[idx] = on ? (val & ~mask) : (val | mask);
+	raw_spin_unlock_irqrestore(&cd->rlock, flags);
+
+	/*
+	 * Do *not* call into the parent, as the GIC doesn't have any
+	 * wake-up facility...
+	 */
+
+	return 0;
+}
+
+static void imx_gpcv2_irq_unmask(struct irq_data *d)
+{
+	struct gpcv2_irqchip_data *cd = d->chip_data;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock(&cd->rlock);
+	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	val = readl_relaxed(reg);
+	val &= ~(1 << d->hwirq % 32);
+	writel_relaxed(val, reg);
+	raw_spin_unlock(&cd->rlock);
+
+	irq_chip_unmask_parent(d);
+}
+
+static void imx_gpcv2_irq_mask(struct irq_data *d)
+{
+	struct gpcv2_irqchip_data *cd = d->chip_data;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock(&cd->rlock);
+	reg = cd->gpc_base + cd->cpu2wakeup + d->hwirq / 32 * 4;
+	val = readl_relaxed(reg);
+	val |= 1 << (d->hwirq % 32);
+	writel_relaxed(val, reg);
+	raw_spin_unlock(&cd->rlock);
+
+	irq_chip_mask_parent(d);
+}
+
+static struct irq_chip gpcv2_irqchip_data_chip = {
+	.name			= "GPCv2",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= imx_gpcv2_irq_mask,
+	.irq_unmask		= imx_gpcv2_irq_unmask,
+	.irq_set_wake		= imx_gpcv2_irq_set_wake,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+};
+
+static int imx_gpcv2_domain_xlate(struct irq_domain *domain,
+				struct device_node *controller,
+				const u32 *intspec,
+				unsigned int intsize,
+				unsigned long *out_hwirq,
+				unsigned int *out_type)
+{
+	/* Shouldn't happen, really... */
+	if (domain->of_node != controller)
+		return -EINVAL;
+
+	/* Not GIC compliant */
+	if (intsize != 3)
+		return -EINVAL;
+
+	/* No PPI should point to this domain */
+	if (intspec[0] != 0)
+		return -EINVAL;
+
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2];
+	return 0;
+}
+
+static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
+				  unsigned int irq, unsigned int nr_irqs,
+				  void *data)
+{
+	struct of_phandle_args *args = data;
+	struct of_phandle_args parent_args;
+	irq_hw_number_t hwirq;
+	int i;
+
+	/* Not GIC compliant */
+	if (args->args_count != 3)
+		return -EINVAL;
+
+	/* No PPI should point to this domain */
+	if (args->args[0] != 0)
+		return -EINVAL;
+
+	/* Can't deal with this */
+	hwirq = args->args[1];
+	if (hwirq >= GPC_MAX_IRQS)
+		return -EINVAL;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
+				&gpcv2_irqchip_data_chip, domain->host_data);
+	}
+
+	parent_args = *args;
+	parent_args.np = domain->parent->of_node;
+	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs, &parent_args);
+}
+
+static struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
+	.xlate	= imx_gpcv2_domain_xlate,
+	.alloc	= imx_gpcv2_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int __init imx_gpcv2_irqchip_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct gpcv2_irqchip_data *cd;
+	int i;
+
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to get parent domain\n", node->full_name);
+		return -ENXIO;
+	}
+
+	cd = kzalloc(sizeof(struct gpcv2_irqchip_data), GFP_KERNEL);
+	BUG_ON(!cd);
+
+	cd->gpc_base = of_iomap(node, 0);
+	if (!cd->gpc_base) {
+		pr_err("fsl-gpcv2: unable to map gpc registers\n");
+		kfree(cd);
+		return -ENOMEM;
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
+				node, &gpcv2_irqchip_data_domain_ops, cd);
+	if (!domain) {
+		iounmap(cd->gpc_base);
+		kfree(cd);
+		return -ENOMEM;
+	}
+	irq_set_default_host(domain);
+
+	/* Initially mask all interrupts */
+	for (i = 0; i < IMR_NUM; i++) {
+		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE0 + i * 4);
+		writel_relaxed(~0, cd->gpc_base + GPC_IMR1_CORE1 + i * 4);
+		cd->wakeup_sources[i] = ~0;
+	}
+
+	/* Let CORE0 as the default CPU to wake up by GPC */
+	cd->cpu2wakeup = GPC_IMR1_CORE0;
+
+	/*
+	 * Due to hardware design failure, need to make sure GPR
+	 * interrupt(#32) is unmasked during RUN mode to avoid entering
+	 * DSM by mistake.
+	 */
+	writel_relaxed(~0x1, cd->gpc_base + cd->cpu2wakeup);
+
+	imx_gpcv2_instance = cd;
+	register_syscore_ops(&imx_gpcv2_syscore_ops);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(imx_gpcv2, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
-- 
2.5.0.rc2
