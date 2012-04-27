From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 16:39:11 +0800
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1335515957-1798-4-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Append new interrupt driver that could support both pxa168 and mmp2
silicon. And this driver supports device tree.

Since CONFIG_SPARSE_IRQ is enabled in arch-mmp, irq driver should
handle reserved NR_IRQS_LEGACY in irq domain.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/Makefile                   |    2 +-
 arch/arm/mach-mmp/include/mach/entry-macro.S |    9 +
 arch/arm/mach-mmp/irq.c                      |  287 ++++++++++++++++++++++++++
 3 files changed, 297 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mmp/irq.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 4fc0ff5..4e73a15 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -18,6 +18,6 @@ obj-$(CONFIG_MACH_TTC_DKB)	+= ttc_dkb.o
 obj-$(CONFIG_MACH_BROWNSTONE)	+= brownstone.o
 obj-$(CONFIG_MACH_FLINT)	+= flint.o
 obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
-obj-$(CONFIG_MACH_MMP_DT)	+= mmp-dt.o
+obj-$(CONFIG_MACH_MMP_DT)	+= mmp-dt.o irq.o
 obj-$(CONFIG_MACH_TETON_BGA)	+= teton_bga.o
 obj-$(CONFIG_MACH_GPLUGD)	+= gplugd.o
diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S b/arch/arm/mach-mmp/include/mach/entry-macro.S
index 9cff9e7..6b9d925 100644
--- a/arch/arm/mach-mmp/include/mach/entry-macro.S
+++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
@@ -6,13 +6,19 @@
  * published by the Free Software Foundation.
  */
 
+#include <asm/irq.h>
 #include <mach/regs-icu.h>
 
 	.macro	get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
 	and	\tmp, \tmp, #0xff00
 	cmp	\tmp, #0x5800
+#ifdef CONFIG_OF
+	ldr	\base, =mmp_icu_base
+	ldr	\base, [\base, #0]
+#else
 	ldr	\base, =ICU_VIRT_BASE
+#endif
 	addne	\base, \base, #0x10c		@ PJ1 AP INT SEL register
 	addeq	\base, \base, #0x104		@ PJ4 IRQ SEL register
 	.endm
@@ -20,5 +26,8 @@
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	ldr	\tmp, [\base, #0]
 	and	\irqnr, \tmp, #0x3f
+#ifdef CONFIG_OF
+	add	\irqnr, \irqnr, #NR_IRQS_LEGACY
+#endif
 	tst	\tmp, #(1 << 6)
 	.endm
diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
new file mode 100644
index 0000000..8d0890f
--- /dev/null
+++ b/arch/arm/mach-mmp/irq.c
@@ -0,0 +1,287 @@
+/*
+ *  linux/arch/arm/mach-mmp/irq.c
+ *
+ *  Generic IRQ handling, GPIO IRQ demultiplexing, etc.
+ *  Copyright (C) 2008 - 2012 Marvell Technology Group Ltd.
+ *
+ *  Author:	Bin Yang <bin.yang@marvell.com>
+ *              Haojian Zhuang <haojian.zhuang@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include "common.h"
+
+#define MAX_ICU_NR		16
+
+struct icu_chip_data {
+	int			nr_irqs;
+	unsigned int		virq_base;
+	unsigned int		cascade_irq;
+	void __iomem		*reg_status;
+	void __iomem		*reg_mask;
+	unsigned int		conf_enable;
+	unsigned int		conf_disable;
+	unsigned int		conf_mask;
+	struct irq_domain	*domain;
+};
+
+struct mmp_intc_conf {
+	unsigned int	conf_enable;
+	unsigned int	conf_disable;
+	unsigned int	conf_mask;
+};
+
+void __iomem *mmp_icu_base;
+static struct icu_chip_data icu_data[MAX_ICU_NR];
+static int max_icu_nr;
+
+static void icu_mask_irq(struct irq_data *d)
+{
+	struct irq_domain *domain = d->domain;
+	struct icu_chip_data *data = (struct icu_chip_data *)domain->host_data;
+	int hwirq;
+	u32 r;
+
+	hwirq = d->irq - data->virq_base;
+	if (data == &icu_data[0]) {
+		r = readl_relaxed(mmp_icu_base + (hwirq << 2));
+		r &= ~data->conf_mask;
+		r |= data->conf_disable;
+		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
+	} else {
+		r = readl_relaxed(data->reg_mask) | (1 << hwirq);
+		writel_relaxed(r, data->reg_mask);
+	}
+}
+
+static void icu_unmask_irq(struct irq_data *d)
+{
+	struct irq_domain *domain = d->domain;
+	struct icu_chip_data *data = (struct icu_chip_data *)domain->host_data;
+	int hwirq;
+	u32 r;
+
+	hwirq = d->irq - data->virq_base;
+	if (data == &icu_data[0]) {
+		r = readl_relaxed(mmp_icu_base + (hwirq << 2));
+		r &= ~data->conf_mask;
+		r |= data->conf_enable;
+		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
+	} else {
+		r = readl_relaxed(data->reg_mask) & ~(1 << hwirq);
+		writel_relaxed(r, data->reg_mask);
+	}
+}
+
+static struct irq_chip icu_irq_chip = {
+	.name		= "icu_irq",
+	.irq_ack	= icu_mask_irq,
+	.irq_mask	= icu_mask_irq,
+	.irq_unmask	= icu_unmask_irq,
+};
+
+static void icu_mux_irq_demux(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_domain *domain;
+	struct icu_chip_data *data;
+	int i;
+	unsigned long mask, status, n;
+
+	for (i = 1; i < max_icu_nr; i++) {
+		if (irq == icu_data[i].cascade_irq) {
+			domain = icu_data[i].domain;
+			data = (struct icu_chip_data *)domain->host_data;
+			break;
+		}
+	}
+	if (i >= max_icu_nr) {
+		pr_err("Spurious irq %d in MMP INTC\n", irq);
+		return;
+	}
+
+	mask = readl_relaxed(data->reg_mask);
+	while (1) {
+		status = readl_relaxed(data->reg_status) & ~mask;
+		if (status == 0)
+			break;
+		n = find_first_bit(&status, BITS_PER_LONG);
+		while (n < BITS_PER_LONG) {
+			generic_handle_irq(icu_data[i].virq_base + n);
+			n = find_next_bit(&status, BITS_PER_LONG, n + 1);
+		}
+	}
+}
+
+static int mmp_irq_domain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &icu_irq_chip, handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
+	return 0;
+}
+
+static int mmp_irq_domain_xlate(struct irq_domain *d, struct device_node *node,
+				const u32 *intspec, unsigned int intsize,
+				unsigned long *out_hwirq,
+				unsigned int *out_type)
+{
+	*out_hwirq = intspec[0];
+	return 0;
+}
+
+const struct irq_domain_ops mmp_irq_domain_ops = {
+	.map		= mmp_irq_domain_map,
+	.xlate		= mmp_irq_domain_xlate,
+};
+
+static struct mmp_intc_conf mmp_conf = {
+	.conf_enable	= 0x51,
+	.conf_disable	= 0x0,
+	.conf_mask	= 0x7f,
+};
+
+static struct mmp_intc_conf mmp2_conf = {
+	.conf_enable	= 0x20,
+	.conf_disable	= 0x0,
+	.conf_mask	= 0x7f,
+};
+
+static const struct of_device_id intc_ids[] __initconst = {
+	{ .compatible = "mrvl,mmp-intc", .data = &mmp_conf },
+	{ .compatible = "mrvl,mmp2-intc", .data = &mmp2_conf },
+	{}
+};
+
+static const struct of_device_id mmp_mux_irq_match[] __initconst = {
+	{ .compatible = "mrvl,mmp2-mux-intc" },
+	{}
+};
+
+int __init mmp_mux_init(struct device_node *parent)
+{
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	struct resource res;
+	int i, irq_base, ret, irq;
+	u32 nr_irqs;
+
+	node = parent;
+	max_icu_nr = 1;
+	for (i = 1; i < MAX_ICU_NR; i++) {
+		node = of_find_matching_node(node, mmp_mux_irq_match);
+		if (!node)
+			break;
+		of_id = of_match_node(&mmp_mux_irq_match[0], node);
+		ret = of_property_read_u32(node, "mrvl,intc-nr-irqs",
+					   &nr_irqs);
+		if (ret) {
+			pr_err("Not found mrvl,intc-nr-irqs property\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		ret = of_address_to_resource(node, 0, &res);
+		if (ret < 0) {
+			pr_err("Not found reg property\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		icu_data[i].reg_status = mmp_icu_base + res.start;
+		ret = of_address_to_resource(node, 1, &res);
+		if (ret < 0) {
+			pr_err("Not found reg property\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		icu_data[i].reg_mask = mmp_icu_base + res.start;
+		icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
+		if (!icu_data[i].cascade_irq) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+		if (irq_base < 0) {
+			pr_err("Failed to allocate IRQ numbers for mux intc\n");
+			ret = irq_base;
+			goto err;
+		}
+		irq_set_chained_handler(icu_data[i].cascade_irq,
+					icu_mux_irq_demux);
+		icu_data[i].nr_irqs = nr_irqs;
+		icu_data[i].virq_base = irq_base;
+		icu_data[i].domain = irq_domain_add_legacy(node, nr_irqs,
+							   irq_base, 0,
+							   &mmp_irq_domain_ops,
+							   &icu_data[i]);
+		for (irq = irq_base; irq < irq_base + nr_irqs; irq++)
+			icu_mask_irq(irq_get_irq_data(irq));
+	}
+	max_icu_nr = i;
+	return 0;
+err:
+	of_node_put(node);
+	max_icu_nr = i;
+	return ret;
+}
+
+void __init mmp_dt_irq_init(void)
+{
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	struct mmp_intc_conf *conf;
+	int nr_irqs, irq_base, ret, irq;
+
+	node = of_find_matching_node(NULL, intc_ids);
+	if (!node) {
+		pr_err("Failed to find interrupt controller in arch-mmp\n");
+		return;
+	}
+	of_id = of_match_node(intc_ids, node);
+	conf = of_id->data;
+
+	ret = of_property_read_u32(node, "mrvl,intc-nr-irqs", &nr_irqs);
+	if (ret) {
+		pr_err("Not found mrvl,intc-nr-irqs property\n");
+		return;
+	}
+
+	mmp_icu_base = of_iomap(node, 0);
+	if (!mmp_icu_base) {
+		pr_err("Failed to get interrupt controller register\n");
+		return;
+	}
+
+	irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
+	if (irq_base < 0) {
+		pr_err("Failed to allocate IRQ numbers\n");
+		goto err;
+	}
+	icu_data[0].conf_enable = conf->conf_enable;
+	icu_data[0].conf_disable = conf->conf_disable;
+	icu_data[0].conf_mask = conf->conf_mask;
+	icu_data[0].nr_irqs = nr_irqs;
+	icu_data[0].virq_base = irq_base;
+	icu_data[0].domain = irq_domain_add_legacy(node, nr_irqs,
+						   irq_base, 0,
+						   &mmp_irq_domain_ops,
+						   &icu_data[0]);
+	irq_set_default_host(icu_data[0].domain);
+	for (irq = irq_base; irq < irq_base + nr_irqs; irq++)
+		icu_mask_irq(irq_get_irq_data(irq));
+	mmp_mux_init(node);
+	return;
+err:
+	iounmap(mmp_icu_base);
+}
-- 
1.7.5.4
