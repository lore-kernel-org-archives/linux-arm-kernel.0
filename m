From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 19 Jul 2011 10:24:44 +0800
Subject: [PATCH 1/7] ARM: mmp: parse irq from DT
In-Reply-To: <1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse irq sepcifier from DT and translate it to Linux irq number.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 .../devicetree/bindings/arm/marvell/intc.txt       |  120 +++++++++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-mmp/Makefile                         |    2 +
 arch/arm/mach-mmp/common.h                         |    1 +
 arch/arm/mach-mmp/intc.c                           |  223 ++++++++++++++++++++
 5 files changed, 347 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/intc.txt
 create mode 100644 arch/arm/mach-mmp/intc.c

diff --git a/Documentation/devicetree/bindings/arm/marvell/intc.txt b/Documentation/devicetree/bindings/arm/marvell/intc.txt
new file mode 100644
index 0000000..e730a16
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/intc.txt
@@ -0,0 +1,120 @@
+* Interrupt Controller Binding for ARCH-MMP
+
+This binding specifies what properties must be available in device tree representation of an ARCH-MMP compliant interrupt controller.
+
+Required properties:
+
+	- compatible: Specifies the compatibility list of the interrupt
+	  controller. The type shall be <string> and the value shall be
+	  "mrvl,mmp-intc" or "mrvl,mux-intc".
+	  "mrvl,mmp-intc" is the base interrupt controller. It must be
+	  included. "mrvl,mux-intc" is the expanded interrupt controller,
+	  and it's optional.
+
+	- reg: Specified the base physical address(s) and size(s) of the
+	  interrupt controller's addressable register space. The type
+	  should be <prop-encoded-array>.
+
+	- interrupt-controller: The presence of this property identifies
+	  the node as interrupt controller. No property value should be
+	  defined.
+
+	- #interrupt-cells: Specifies the number of cells needed to encode
+	  an interrupt source. The type should be <u32> and the value should
+	  be 1.
+
+	- #address-cells: Specifies the number of cells needed to encode an
+	  address. The type should be <u32> and the value should be 1.
+
+	- #size-cells: Specifies the number of cells need to encode an
+	  size. The type should be <u32> and the value should be 1.
+
+	- intc-numbers: Specifies the number of interrupts is supported in
+	  this interrupt controller. The type should be <u32>.
+
+Optional properties:
+
+	- intc-enable-mask: Specifies the masking value of interrupt
+	  configuration register. The property is used in mmp-intc. The value
+	  should be <u32>.
+
+	- intc-status: Specifies the offset of status register. The property
+	  is used in mux-intc. The type should be <u32>.
+
+	- intc-mask: Specifies the offset of mask register. The property
+	  is used in mux-intc. The type should be <u32>.
+
+	- intc-mfp-edge: Specifies the address of mfp edge detection register.
+	  The property is used while acking specified interrupt. The type
+	  should be <prop-encoded-array>. The first cell indicates the address
+	  of mfp edge detection register. The second cell indicates the
+	  index of interrupt in current interrupt controller that should
+	  handle mfp edge detection.
+
+* Examples
+
+Example 1:
+
+	/*
+	 * base INTC
+	 */
+	mmp_intc: interrupt-controller at d4282000 {
+		/* Compatible with mmp-intc. */
+		compatible = "mrvl,mmp-intc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		/* Offset address of 0xd4282000 and size of 0x400. */
+		reg = <0xd4282000 0x400>;
+
+		#interrupt-cells = <1>;
+		interrupt-controller;
+
+		/* 64 interrupts are supported in this INTC. */
+		intc-numbers = <64>;
+
+		/* enable bits in configuration register */
+		intc-enable-mask = <0x20>;
+	};
+
+Example 2:
+
+	/*
+	 * mux INTC that is internal wired to base INTC
+	 */
+	mux_intc4: interrupt-controller at d4282150 {
+		compatible = "mrvl,mux-intc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xd4282000 0x400>;
+
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-parent = <&mmp_intc>;
+
+		/* interrupt source '4' of parent INTC. */
+		interrupts = <4>;
+
+		/* 2 interrupts are supported in this INTC. */
+		intc-numbers = <2>;
+
+		/* Status offset address of 0x150. */
+		intc-status = <0x150>;
+
+		/* Mask offset address of 0x168. */
+		intc-mask = <0x168>;
+
+		/* mfp register of 0xd401e2c4 & interrupt index of 1 */
+		intc-mfp-edge = <0xd401e2c4 1>;
+	};
+
+Example 3:
+	/*
+	 * An interrupt generating device that is wired to an INTC.
+	 */
+	uart0: uart at d4030000 {
+		/* parent's '#interrupt-cells' property. */
+		interrupts = <27>;
+
+		/* The INTC that this device is wired to. */
+		interrupt-parent = <&mmp_intc>;
+	};
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 17507b8..f18eb14 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -542,6 +542,7 @@ config ARCH_MMP
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
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
index 0000000..ac84c7b
--- /dev/null
+++ b/arch/arm/mach-mmp/intc.c
@@ -0,0 +1,223 @@
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
+	unsigned int		en_mask;
+	void __iomem		*virt_base;
+	void __iomem		*status;
+	void __iomem		*mfp_edge;
+	unsigned int		mfp_edge_index; /* index in irq domain */
+};
+
+static void mux_irq_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct;
+	struct mmp_intc_info *info;
+	unsigned int data, irq_offs;
+
+	ct = gc->chip_types;
+	info = (struct mmp_intc_info *)ct->regs.ack;
+	irq_offs = d->irq - gc->irq_base;
+	/* clear MFP edge-detect */
+	if (info->mfp_edge && (info->mfp_edge_index == irq_offs)) {
+		data = __raw_readl(info->mfp_edge);
+		__raw_writel(data | (1 << 6), info->mfp_edge);
+		__raw_writel(data, info->mfp_edge);
+	}
+}
+
+static void mmp_irq_demux_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_chip_generic *gc = irq_get_handler_data(irq);
+	struct irq_chip_type *ct;
+	struct mmp_intc_info *info;
+	unsigned long status, n;
+
+	ct = gc->chip_types;
+	info = (struct mmp_intc_info *)ct->regs.ack;
+	while (1) {
+		status = __raw_readl(info->status) & ~gc->mask_cache;
+		if (status == 0)
+			break;
+		n = find_first_bit(&status, BITS_PER_LONG);
+		while (n < BITS_PER_LONG) {
+			generic_handle_irq(gc->irq_base + n);
+			n = find_next_bit(&status, BITS_PER_LONG, n + 1);
+		}
+	}
+}
+
+static void mux_init_intc(struct mmp_intc_info *mmp_info)
+{
+	struct device_node *np;
+	struct mmp_intc_info *mux_info;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	const __be32 *edge;
+	unsigned int addr = 0, offs = 0;
+	unsigned int status, mask, irq_base, nr, data;
+	int cascade;
+
+	for_each_compatible_node(np, NULL, "mrvl,mux-intc") {
+		if (of_get_property(np, "interrupt-controller", NULL) == NULL)
+			continue;
+		if (of_property_read_u32(np, "intc-numbers", &nr) < 0) {
+			pr_warn("intc-numbers property is missed\n");
+			continue;
+		}
+		if (of_property_read_u32(np, "intc-status", &status) < 0) {
+			pr_warn("intc-status property is missed\n");
+			continue;
+		}
+		if (of_property_read_u32(np, "intc-mask", &mask) < 0) {
+			pr_warn("intc-mask property is missed\n");
+			continue;
+		}
+
+		mux_info = kzalloc(sizeof(*mux_info), GFP_KERNEL);
+		if (mux_info == NULL)
+			goto out;
+		status += (unsigned int)mmp_info->virt_base;
+		mux_info->status = (void __iomem *)status;
+
+		edge = of_get_property(np, "intc-mfp-edge", NULL);
+		if (edge) {
+			addr = be32_to_cpu(*edge) & PAGE_MASK;
+			offs = be32_to_cpu(*edge) - addr;
+			mux_info->mfp_edge = ioremap(addr, PAGE_SIZE) + offs;
+			mux_info->mfp_edge_index = be32_to_cpu(*++edge);
+			/* clear mfp edge detection for initialization */
+			data = __raw_readl(mux_info->mfp_edge);
+			__raw_writel(data | (1 << 6), mux_info->mfp_edge);
+			__raw_writel(data, mux_info->mfp_edge);
+		}
+
+		/* allocate new irq */
+		cascade = irq_of_parse_and_map(np, 0);
+		irq_base = irq_alloc_descs(-1, 0, nr, 0);
+		irq_domain_add_simple(np, irq_base);
+
+		gc = irq_alloc_generic_chip("mux-intc", 1, irq_base,
+					mmp_info->virt_base, handle_level_irq);
+		ct = gc->chip_types;
+		ct->regs.ack = (unsigned int)mux_info;
+		ct->regs.mask = mask;
+		ct->chip.irq_ack = mux_irq_ack;
+		ct->chip.irq_mask = irq_gc_mask_set_bit;
+		ct->chip.irq_unmask = irq_gc_mask_clr_bit;
+		irq_setup_generic_chip(gc, IRQ_MSK(nr), IRQ_GC_INIT_MASK_CACHE,
+					IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+
+		irq_set_handler_data(cascade, gc);
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
+	__raw_writel(info->en_mask, info->virt_base + (d->irq << 2));
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
+	struct resource rs;
+	unsigned int cells, nr, enable, irq_base;
+	int i;
+
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mmp-intc");
+
+	BUG_ON(!np);
+
+	of_node_get(np);
+	if (of_get_property(np, "interrupt-controller", NULL) == NULL)
+		goto out;
+	if (of_property_read_u32(np, "#interrupt-cells", &cells) < 0) {
+		pr_warn("mmp-intc: interrupt-cells property is missed\n");
+		goto out;
+	}
+	if (cells != 1) {
+		pr_warn("mmp-intc: interrupt-cells property is incorrect\n");
+		goto out;
+	}
+	if (of_property_read_u32(np, "intc-numbers", &nr) < 0) {
+		pr_warn("mmp-intc: intc-numbers property is missed\n");
+		goto out;
+	}
+	if (of_property_read_u32(np, "intc-enable-mask", &enable) < 0) {
+		pr_warn("mmp-intc: intc-enable-mask property is missed\n");
+		goto out;
+	}
+	if (of_address_to_resource(np, 0, &rs) < 0) {
+		pr_warn("mmp-intc: invalid reg property\n");
+		goto out;
+	}
+
+	info = kzalloc(sizeof(struct mmp_intc_info), GFP_KERNEL);
+	if (info == NULL)
+		goto out;
+	info->en_mask = enable;
+	info->virt_base = ioremap(rs.start, PAGE_SIZE);
+	if (info->virt_base == NULL) {
+		pr_warn("mmp-intc: failed to remap reg base\n");
+		goto out_mem;
+	}
+
+	/* allocate new irq */
+	irq_base = irq_alloc_descs(-1, 0, nr, 0);
+	irq_domain_add_simple(np, 0);
+
+	for (i = irq_base; i < irq_base + nr; i++) {
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
