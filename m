From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:19 +0800
Subject: [PATCH] ARM: mmp: parse irq from DT
In-Reply-To: <1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse irq sepcifier from DT and translate it to Linux irq number.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Makefile |    2 +
 arch/arm/mach-mmp/common.h |    1 +
 arch/arm/mach-mmp/intc.c   |  245 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/intc.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 5c68382..e7862ea 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -4,6 +4,8 @@
 
 obj-y				+= common.o clock.o devices.o time.o
 
+obj-$(CONFIG_OF_IRQ)		+= intc.o
+
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o irq-pxa168.o
 obj-$(CONFIG_CPU_PXA910)	+= pxa910.o irq-pxa168.o
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index ec8d65d..1c563c2 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -6,3 +6,4 @@ extern void timer_init(int irq);
 
 extern void __init icu_init_irq(void);
 extern void __init mmp_map_io(void);
+extern void __init mmp_init_intc(void);
diff --git a/arch/arm/mach-mmp/intc.c b/arch/arm/mach-mmp/intc.c
new file mode 100644
index 0000000..48ad84b
--- /dev/null
+++ b/arch/arm/mach-mmp/intc.c
@@ -0,0 +1,245 @@
+/*
+ *  linux/arch/arm/mach-mmp/intc.c
+ *
+ *  Generic IRQ handling
+ *
+ *  Author:	Haojian Zhuang <haojian.zhuang@marvell.com>
+ *  Copyright:	Marvell International Ltd. 2011
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+
+struct mmp_intc_info {
+	unsigned int		mask;
+	unsigned int		phy_base;
+	void __iomem		*virt_base;
+	void __iomem		*mux_status;
+	void __iomem		*mux_mask;
+	void __iomem		*mfp_edge;
+	unsigned int		mfp_edge_index;	/* index in irq domain */
+	unsigned int		irq_base;
+};
+
+static void mux_irq_unmask(struct irq_data *d)
+{
+	struct mmp_intc_info *info = irq_data_get_irq_chip_data(d);
+	unsigned int data, irq_offs;
+
+	irq_offs = d->irq - info->irq_base;
+	if (info->mfp_edge && (info->mfp_edge_index == irq_offs)) {
+		data = __raw_readl(info->mfp_edge);
+		__raw_writel(data | (1 << 6), info->mfp_edge);
+		__raw_writel(data, info->mfp_edge);
+	}
+	data = __raw_readl(info->mux_mask) & ~(1 << (d->irq - info->irq_base));
+	__raw_writel(data, info->mux_mask);
+}
+
+static void mux_irq_mask(struct irq_data *d)
+{
+	struct mmp_intc_info *info = irq_data_get_irq_chip_data(d);
+	unsigned int data;
+
+	data = __raw_readl(info->mux_mask) | (1 << (d->irq - info->irq_base));
+	__raw_writel(data, info->mux_mask);
+}
+
+static struct irq_chip mux_irq_chip = {
+	.name		= "mmp mux intc",
+	.irq_unmask	= mux_irq_unmask,
+	.irq_mask	= mux_irq_mask,
+	.irq_ack	= mux_irq_mask,
+};
+
+static void mmp_irq_demux_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct mmp_intc_info *info = irq_get_handler_data(irq);
+	unsigned long status, mask, n;
+
+	mask = __raw_readl(info->mux_mask);
+	while (1) {
+		status = __raw_readl(info->mux_status) & ~mask;
+		if (status == 0)
+			break;
+		n = find_first_bit(&status, BITS_PER_LONG);
+		while (n < BITS_PER_LONG) {
+			generic_handle_irq(info->irq_base + n);
+			n = find_next_bit(&status, BITS_PER_LONG, n + 1);
+		}
+	}
+}
+
+static void mux_init_intc(struct mmp_intc_info *mmp_info)
+{
+	struct device_node *np;
+	struct mmp_intc_info *mux_info;
+	const __be32 *nr, *status, *edge;
+	unsigned int addr = 0, offs = 0;
+	int cascade, irq_nr, i;
+
+	if (mmp_info->virt_base == NULL)
+		goto out;
+
+	for (np = NULL; (np = of_find_all_nodes(np)) != NULL;) {
+		if (!of_device_is_compatible(np, "mrvl,mux-intc"))
+			continue;
+		if (of_get_property(np, "interrupt-controller", NULL) == NULL)
+			continue;
+		nr = of_get_property(np, "sub-interrupts", NULL);
+		if (nr == NULL) {
+			printk(KERN_WARNING "sub-interrupts property "
+				"is missed\n");
+			continue;
+		}
+		irq_nr = be32_to_cpu(*nr);
+		status = of_get_property(np, "status-mask", NULL);
+		if (status == NULL) {
+			printk(KERN_WARNING "status-mask property is missed\n");
+			continue;
+		}
+		edge = of_get_property(np, "mfp-edge-interrupt", NULL);
+
+		mux_info = kzalloc(sizeof(struct mmp_intc_info), GFP_KERNEL);
+		if (mux_info == NULL)
+			goto out;
+		mux_info->virt_base = mmp_info->virt_base;
+		mux_info->mux_status = be32_to_cpu(*status++)
+					+ mux_info->virt_base;
+		mux_info->mux_mask = be32_to_cpu(*status)
+					+ mux_info->virt_base;
+		if (edge) {
+			addr = be32_to_cpu(*edge) & PAGE_MASK;
+			offs = be32_to_cpu(*edge) - addr;
+			mux_info->mfp_edge = ioremap(addr, PAGE_SIZE) + offs;
+			mux_info->mfp_edge_index = be32_to_cpu(*++edge);
+		}
+
+		/* allocate new irq */
+		cascade = irq_of_parse_and_map(np, 0);
+		mux_info->irq_base = irq_alloc_descs(-1, 0, irq_nr, 0);
+		irq_domain_add_simple(np, mux_info->irq_base);
+
+		i = mux_info->irq_base;
+		for (; i < mux_info->irq_base + irq_nr; i++) {
+			irq_set_chip_data(i, mux_info);
+			mux_irq_mask(irq_get_irq_data(i));
+			irq_set_chip_and_handler(i, &mux_irq_chip,
+					handle_level_irq);
+			set_irq_flags(i, IRQF_VALID);
+		}
+
+		irq_set_handler_data(cascade, mux_info);
+		irq_set_chained_handler(cascade, mmp_irq_demux_handler);
+	}
+out:
+	return;
+}
+
+static void mmp_irq_unmask(struct irq_data *d)
+{
+	struct mmp_intc_info *info = irq_data_get_irq_chip_data(d);
+
+	/* ICU_INT_CONF */
+	__raw_writel(info->mask, info->virt_base + (d->irq << 2));
+}
+
+static void mmp_irq_mask(struct irq_data *d)
+{
+	struct mmp_intc_info *info = irq_data_get_irq_chip_data(d);
+
+	__raw_writel(0, info->virt_base + (d->irq << 2));
+}
+
+static struct irq_chip mmp_irq_chip = {
+	.name		= "mmp-intc",
+	.irq_unmask	= mmp_irq_unmask,
+	.irq_mask	= mmp_irq_mask,
+	.irq_ack	= mmp_irq_mask,
+};
+
+void __init mmp_init_intc(void)
+{
+	struct mmp_intc_info *info;
+	struct device_node *np;
+	const __be32 *enable_mask, *base, *cell, *nr;
+	int i, irq_nr, phy_base;
+
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mmp-intc");
+
+	BUG_ON(!np);
+
+	of_node_get(np);
+	if (of_get_property(np, "interrupt-controller", NULL) == NULL)
+		goto out;
+	cell = of_get_property(np, "#interrupt-cells", NULL);
+	if (cell == NULL) {
+		printk(KERN_ERR "mmp-intc: Device node %s missing "
+			"interrupt-cells property\n", np->full_name);
+		goto out;
+	}
+	if (be32_to_cpu(*cell) != 1) {
+		printk(KERN_ERR "mmp-intc: interrupt-cells property is "
+			"incorrect:%d\n", be32_to_cpu(*cell));
+		goto out;
+	}
+
+	nr = of_get_property(np, "sub-interrupts", NULL);
+	if (nr == NULL) {
+		printk(KERN_ERR "mmp-intc: interrupts property is missed\n");
+		goto out;
+	}
+	irq_nr = be32_to_cpu(*nr);
+
+	base = of_get_property(np, "reg", NULL);
+	if (base == NULL) {
+		printk(KERN_ERR "intc: Device node %s missing reg property\n",
+			np->full_name);
+		goto out;
+	}
+	phy_base = of_translate_address(np, base);
+
+	info = kzalloc(sizeof(struct mmp_intc_info), GFP_KERNEL);
+	if (info == NULL)
+		goto out;
+
+	enable_mask = of_get_property(np, "enable_mask", NULL);
+	if (enable_mask == NULL) {
+		printk(KERN_ERR "interrupt controller: Device node %s "
+			"missing interrupt property\n", np->full_name);
+		goto out_mem;
+	}
+	info->mask = be32_to_cpu(*enable_mask);
+
+	/* phy_base: 0, phy_size:64 */
+	info->phy_base = phy_base;
+	info->virt_base = ioremap(info->phy_base, PAGE_SIZE);
+
+	/* allocate new irq */
+	info->irq_base = irq_alloc_descs(-1, 0, irq_nr, 0);
+	irq_domain_add_simple(np, 0);
+
+	for (i = info->irq_base; i < info->irq_base + irq_nr; i++) {
+		irq_set_chip_data(i, info);
+		mmp_irq_mask(irq_get_irq_data(i));
+		irq_set_chip_and_handler(i, &mmp_irq_chip, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+	mux_init_intc(info);
+	of_node_put(np);
+	return;
+out_mem:
+	kfree(info);
+out:
+	of_node_put(np);
+	return;
+}
-- 
1.5.6.5
