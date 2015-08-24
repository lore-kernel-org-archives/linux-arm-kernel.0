From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 11:18:10 +0900
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for UniPhier outer cache controller.
All the UniPhier SoCs are equipped with the L2 cache, while the L3
cache is currently only integrated on PH1-Pro5 SoC.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../bindings/arm/uniphier/cache-uniphier.txt       |  30 ++
 MAINTAINERS                                        |   2 +
 arch/arm/include/asm/hardware/cache-uniphier.h     |  40 ++
 arch/arm/mach-uniphier/uniphier.c                  |  11 +
 arch/arm/mm/Kconfig                                |  10 +
 arch/arm/mm/Makefile                               |   1 +
 arch/arm/mm/cache-uniphier.c                       | 518 +++++++++++++++++++++
 7 files changed, 612 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
 create mode 100644 arch/arm/include/asm/hardware/cache-uniphier.h
 create mode 100644 arch/arm/mm/cache-uniphier.c

diff --git a/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt b/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
new file mode 100644
index 0000000..6428289
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
@@ -0,0 +1,30 @@
+UniPhier outer cache controller
+
+UniPhier SoCs are integrated with a level 2 cache controller that resides
+outside of the ARM cores, some of them also have a level 3 cache controller.
+
+Required properties:
+- compatible: should be one of the followings:
+	"socionext,uniphier-l2-cache"	(L2 cache)
+	"socionext,uniphier-l3-cache"	(L3 cache)
+- reg: offsets and lengths of the register sets for the device.  It should
+  contain 3 regions: control registers, revision registers, operation
+  registers, in this order.
+
+The L2 cache must exist to use the L3 cache; adding only an L3 cache device
+node to the device tree causes the initialization failure of the whole outer
+cache system.
+
+Example:
+	l2-cache at 500c0000 {
+		compatible = "socionext,uniphier-l2-cache";
+		reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
+		      <0x506c0000 0x400>;
+	};
+
+	/* Not all of UniPhier SoCs have L3 cache */
+	l3-cache at 500c8000 {
+		compatible = "socionext,uniphier-l3-cache";
+		reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
+		      <0x506c8000 0x400>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index a4fbfc8..62e0784 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1578,7 +1578,9 @@ M:	Masahiro Yamada <yamada.masahiro@socionext.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/uniphier*
+F:	arch/arm/include/asm/hardware/cache-uniphier.h
 F:	arch/arm/mach-uniphier/
+F:	arch/arm/mm/cache-uniphier.c
 F:	drivers/pinctrl/uniphier/
 F:	drivers/tty/serial/8250/8250_uniphier.c
 N:	uniphier
diff --git a/arch/arm/include/asm/hardware/cache-uniphier.h b/arch/arm/include/asm/hardware/cache-uniphier.h
new file mode 100644
index 0000000..641d32f
--- /dev/null
+++ b/arch/arm/include/asm/hardware/cache-uniphier.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __CACHE_UNIPHIER_H
+#define __CACHE_UNIPHIER_H
+
+#ifdef CONFIG_CACHE_UNIPHIER
+int uniphier_cache_init(void);
+int uniphier_cache_init_locked(void);
+void uniphier_cache_touch_range(unsigned long start, unsigned long end);
+#else
+static inline int uniphier_cache_init(void)
+{
+	return -ENODEV;
+}
+
+static inline int uniphier_cache_init_locked(void)
+{
+	return -ENODEV;
+}
+
+static inline void uniphier_cache_touch_range(unsigned long start,
+					      unsigned long end)
+{
+}
+
+#endif
+
+#endif /* __CACHE_UNIPHIER_H */
diff --git a/arch/arm/mach-uniphier/uniphier.c b/arch/arm/mach-uniphier/uniphier.c
index 9be10ef..6aed136 100644
--- a/arch/arm/mach-uniphier/uniphier.c
+++ b/arch/arm/mach-uniphier/uniphier.c
@@ -12,6 +12,8 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/of_platform.h>
+#include <asm/hardware/cache-uniphier.h>
 #include <asm/mach/arch.h>
 
 static const char * const uniphier_dt_compat[] __initconst = {
@@ -25,6 +27,15 @@ static const char * const uniphier_dt_compat[] __initconst = {
 	NULL,
 };
 
+static void __init uniphier_init_machine(void)
+{
+	if (uniphier_cache_init())
+		pr_warn("outer cache was not enabled");
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 DT_MACHINE_START(UNIPHIER, "Socionext UniPhier")
 	.dt_compat	= uniphier_dt_compat,
+	.init_machine	= uniphier_init_machine,
 MACHINE_END
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7c6b976..7b33ff3 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -985,6 +985,16 @@ config CACHE_TAUROS2
 	  This option enables the Tauros2 L2 cache controller (as
 	  found on PJ1/PJ4).
 
+config CACHE_UNIPHIER
+	bool "Enable the UniPhier outer cache controller"
+	depends on ARCH_UNIPHIER
+	default y
+	select OUTER_CACHE
+	select OUTER_CACHE_SYNC
+	help
+	  This option enables the UniPhier outer cache (system cache)
+	  controller.
+
 config CACHE_XSC3L2
 	bool "Enable the L2 cache on XScale3"
 	depends on CPU_XSC3
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 57c8df5..7f76d96 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -103,3 +103,4 @@ obj-$(CONFIG_CACHE_FEROCEON_L2)	+= cache-feroceon-l2.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o l2c-l2x0-resume.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
 obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
+obj-$(CONFIG_CACHE_UNIPHIER)	+= cache-uniphier.o
diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
new file mode 100644
index 0000000..9eb0665
--- /dev/null
+++ b/arch/arm/mm/cache-uniphier.c
@@ -0,0 +1,518 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <asm/hardware/cache-uniphier.h>
+#include <asm/outercache.h>
+
+/* control registers */
+#define UNIPHIER_SSCC		0x0	/* Control Register */
+#define    UNIPHIER_SSCC_BST			BIT(20)	/* UCWG burst read */
+#define    UNIPHIER_SSCC_ACT			BIT(19)	/* Inst-Data separate */
+#define    UNIPHIER_SSCC_WTG			BIT(18)	/* WT gathering on */
+#define    UNIPHIER_SSCC_PRD			BIT(17)	/* enable pre-fetch */
+#define    UNIPHIER_SSCC_ON			BIT(0)	/* enable cache */
+#define UNIPHIER_SSCLPDAWCR	0x30	/* Unified/Data Active Way Control */
+#define UNIPHIER_SSCLPIAWCR	0x34	/* Instruction Active Way Control */
+
+/* revision registers */
+#define UNIPHIER_SSCID		0x0	/* ID Register */
+
+/* operation registers */
+#define UNIPHIER_SSCOPE		0x244	/* Cache Operation Primitive Entry */
+#define    UNIPHIER_SSCOPE_CM_INV		0x0	/* invalidate */
+#define    UNIPHIER_SSCOPE_CM_CLEAN		0x1	/* clean */
+#define    UNIPHIER_SSCOPE_CM_FLUSH		0x2	/* flush */
+#define    UNIPHIER_SSCOPE_CM_SYNC		0x8	/* sync (drain bufs) */
+#define    UNIPHIER_SSCOPE_CM_FLUSH_PREFETCH	0x9	/* flush p-fetch buf */
+#define UNIPHIER_SSCOQM		0x248	/* Cache Operation Queue Mode */
+#define    UNIPHIER_SSCOQM_TID_MASK		(0x3 << 21)
+#define    UNIPHIER_SSCOQM_TID_LRU_DATA		(0x0 << 21)
+#define    UNIPHIER_SSCOQM_TID_LRU_INST		(0x1 << 21)
+#define    UNIPHIER_SSCOQM_TID_WAY		(0x2 << 21)
+#define    UNIPHIER_SSCOQM_S_MASK		(0x3 << 17)
+#define    UNIPHIER_SSCOQM_S_RANGE		(0x0 << 17)
+#define    UNIPHIER_SSCOQM_S_ALL		(0x1 << 17)
+#define    UNIPHIER_SSCOQM_S_WAY		(0x2 << 17)
+#define    UNIPHIER_SSCOQM_CE			BIT(15)	/* notify completion */
+#define    UNIPHIER_SSCOQM_CM_INV		0x0	/* invalidate */
+#define    UNIPHIER_SSCOQM_CM_CLEAN		0x1	/* clean */
+#define    UNIPHIER_SSCOQM_CM_FLUSH		0x2	/* flush */
+#define    UNIPHIER_SSCOQM_CM_PREFETCH		0x3	/* prefetch to cache */
+#define    UNIPHIER_SSCOQM_CM_PREFETCH_BUF	0x4	/* prefetch to pf-buf */
+#define    UNIPHIER_SSCOQM_CM_TOUCH		0x5	/* touch */
+#define    UNIPHIER_SSCOQM_CM_TOUCH_ZERO	0x6	/* touch to zero */
+#define    UNIPHIER_SSCOQM_CM_TOUCH_DIRTY	0x7	/* touch with dirty */
+#define UNIPHIER_SSCOQAD	0x24c	/* Cache Operation Queue Address */
+#define UNIPHIER_SSCOQSZ	0x250	/* Cache Operation Queue Size */
+#define UNIPHIER_SSCOQMASK	0x254	/* Cache Operation Queue Address Mask */
+#define UNIPHIER_SSCOQWN	0x258	/* Cache Operation Queue Way Number */
+#define UNIPHIER_SSCOPPQSEF	0x25c	/* Cache Operation Queue Set Complete*/
+#define    UNIPHIER_SSCOPPQSEF_FE		BIT(1)
+#define    UNIPHIER_SSCOPPQSEF_OE		BIT(0)
+#define UNIPHIER_SSCOLPQS	0x260	/* Cache Operation Queue Status */
+#define    UNIPHIER_SSCOLPQS_EF			BIT(2)
+#define    UNIPHIER_SSCOLPQS_EST		BIT(1)
+#define    UNIPHIER_SSCOLPQS_QST		BIT(0)
+
+/* Is the touch/pre-fetch destination specified by ways? */
+#define UNIPHIER_SSCOQM_TID_IS_WAY(op) \
+		((op & UNIPHIER_SSCOQM_TID_MASK) == UNIPHIER_SSCOQM_TID_WAY)
+/* Is the operation region specified by address range? */
+#define UNIPHIER_SSCOQM_S_IS_RANGE(op) \
+		((op & UNIPHIER_SSCOQM_S_MASK) == UNIPHIER_SSCOQM_S_RANGE)
+/* Is the operation region specified by ways? */
+#define UNIPHIER_SSCOQM_S_IS_WAY(op) \
+		((op & UNIPHIER_SSCOQM_S_MASK) == UNIPHIER_SSCOQM_S_WAY)
+
+#define UNIPHIER_L2_CACHE_LINE_SIZE		128
+#define UNIPHIER_L3_CACHE_LINE_SIZE		256
+
+/**
+ * uniphier_cache_data - UniPhier outer cache specific data
+ *
+ * @ctrl_base: virtual base address of control registers
+ * @rev_base: virtual base address of revision registers
+ * @op_base: virtual base address of operation registers
+ * @line_size: line size, which range operations must be aligned to
+ * @range_op_max_size: max data size for a single range operation can handle
+ */
+static struct uniphier_cache_data {
+	void __iomem *ctrl_base;
+	void __iomem *rev_base;
+	void __iomem *op_base;
+	unsigned int line_size;
+	unsigned long range_op_max_size;
+} uniphier_cache_data[];
+
+/* the number of detected outer cache levels (0: none, 1: L2, 2: L2&L3) */
+static int uniphier_outer_levels;
+
+/**
+ * __uniphier_cache_sync - perform a sync point for a particular cache level
+ *
+ * @data: cache controller specific data
+ */
+static void __uniphier_cache_sync(struct uniphier_cache_data *data)
+{
+	/* This sequence need not be atomic.  Do not disable IRQ. */
+	writel_relaxed(UNIPHIER_SSCOPE_CM_SYNC,
+		       data->op_base + UNIPHIER_SSCOPE);
+	/* need a read back to confirm */
+	readl_relaxed(data->op_base + UNIPHIER_SSCOPE);
+}
+
+/**
+ * __uniphier_cache_maint_common - run a queue operation for a particular level
+ *
+ * @data: cache controller specific data
+ * @start: start address of range operation (don't care for "all" operation)
+ * @size: data size of range operation (don't care for "all" operation)
+ * @operation: flags to specify the desired cache operation
+ */
+static void __uniphier_cache_maint_common(struct uniphier_cache_data *data,
+					  unsigned long start,
+					  unsigned long size,
+					  u32 operation)
+{
+	unsigned long flags;
+
+	/*
+	 * The IRQ must be disable during this sequence because the accessor
+	 * holds the access right of the operation queue registers.
+	 * Restore the IRQ after releasing the register access right.
+	 */
+	local_irq_save(flags);
+
+	/* clear the complete notification flag */
+	writel_relaxed(UNIPHIER_SSCOLPQS_EF, data->op_base + UNIPHIER_SSCOLPQS);
+
+	/*
+	 * We do not need a spin lock here because the hardware guarantees
+	 * this sequence is atomic, i.e. the write access is arbitrated
+	 * and only the winner's write accesses take effect.
+	 * After register settings, we need to check the UNIPHIER_SSCOPPQSEF to
+	 * see if we won the arbitration or not.
+	 * If the command was not successfully set, just try again.
+	 */
+	do {
+		/* set cache operation */
+		writel_relaxed(UNIPHIER_SSCOQM_CE | operation,
+			       data->op_base + UNIPHIER_SSCOQM);
+
+		/* set address range if needed */
+		if (likely(UNIPHIER_SSCOQM_S_IS_RANGE(operation))) {
+			writel_relaxed(start, data->op_base + UNIPHIER_SSCOQAD);
+			writel_relaxed(size, data->op_base + UNIPHIER_SSCOQSZ);
+		}
+
+		/* set target ways if needed */
+		if (unlikely(UNIPHIER_SSCOQM_S_IS_WAY(operation) ||
+			     UNIPHIER_SSCOQM_TID_IS_WAY(operation)))
+			/* set all the locked ways as destination */
+			writel_relaxed(~readl_relaxed(data->ctrl_base +
+						      UNIPHIER_SSCLPDAWCR),
+				       data->op_base + UNIPHIER_SSCOQWN);
+	} while (unlikely(readl_relaxed(data->op_base + UNIPHIER_SSCOPPQSEF) &
+			  (UNIPHIER_SSCOPPQSEF_FE | UNIPHIER_SSCOPPQSEF_OE)));
+
+	/* wait until the operation is completed */
+	while (likely(readl_relaxed(data->op_base + UNIPHIER_SSCOLPQS) !=
+		      UNIPHIER_SSCOLPQS_EF))
+		cpu_relax();
+
+	local_irq_restore(flags);
+}
+
+static void __uniphier_cache_maint_all(struct uniphier_cache_data *data,
+				       u32 operation)
+{
+	__uniphier_cache_maint_common(data, 0, 0,
+				      UNIPHIER_SSCOQM_S_ALL | operation);
+
+	__uniphier_cache_sync(data);
+}
+
+static void __uniphier_cache_maint_range(struct uniphier_cache_data *data,
+					 unsigned long start, unsigned long end,
+					 u32 operation)
+{
+	unsigned long size;
+
+	/*
+	 * If the start address is not aligned,
+	 * perform a cache operation for the first cache-line
+	 */
+	start = start & ~(data->line_size - 1);
+
+	size = end - start;
+
+	if (unlikely(size >= (unsigned long)(-data->line_size))) {
+		/* this means cache operation for all range */
+		__uniphier_cache_maint_all(data, operation);
+		return;
+	}
+
+	/*
+	 * If the end address is not aligned,
+	 * perform a cache operation for the last cache-line
+	 */
+	size = ALIGN(size, data->line_size);
+
+	while (size) {
+		u32 chunk_size = min(size, data->range_op_max_size);
+
+		__uniphier_cache_maint_common(data, start, chunk_size,
+					UNIPHIER_SSCOQM_S_RANGE | operation);
+
+		start += chunk_size;
+		size -= chunk_size;
+	}
+
+	__uniphier_cache_sync(data);
+}
+
+static void __uniphier_cache_enable(struct uniphier_cache_data *data, bool on)
+{
+	u32 val = 0;
+
+	if (on)
+		val = UNIPHIER_SSCC_WTG | UNIPHIER_SSCC_PRD | UNIPHIER_SSCC_ON;
+
+	writel_relaxed(val, data->ctrl_base + UNIPHIER_SSCC);
+}
+
+static void __uniphier_cache_set_active_ways(struct uniphier_cache_data *data,
+					     u32 ways)
+{
+	writel_relaxed(ways, data->ctrl_base + UNIPHIER_SSCLPDAWCR);
+}
+
+static void uniphier_cache_maint_all(u32 operation)
+{
+	int i;
+
+	for (i = 0; i < uniphier_outer_levels; i++)
+		__uniphier_cache_maint_all(&uniphier_cache_data[i], operation);
+}
+
+static void uniphier_cache_maint_range(unsigned long start, unsigned long end,
+				       u32 operation)
+{
+	int i;
+
+	for (i = 0; i < uniphier_outer_levels; i++)
+		__uniphier_cache_maint_range(&uniphier_cache_data[i],
+					     start, end, operation);
+}
+
+static void uniphier_cache_inv_range(unsigned long start, unsigned long end)
+{
+	uniphier_cache_maint_range(start, end, UNIPHIER_SSCOQM_CM_INV);
+}
+
+static void uniphier_cache_clean_range(unsigned long start, unsigned long end)
+{
+	uniphier_cache_maint_range(start, end, UNIPHIER_SSCOQM_CM_CLEAN);
+}
+
+static void uniphier_cache_flush_range(unsigned long start, unsigned long end)
+{
+	uniphier_cache_maint_range(start, end, UNIPHIER_SSCOQM_CM_FLUSH);
+}
+
+void __init uniphier_cache_touch_range(unsigned long start, unsigned long end)
+{
+	uniphier_cache_maint_range(start, end, UNIPHIER_SSCOQM_TID_WAY |
+				   UNIPHIER_SSCOQM_CM_TOUCH);
+}
+
+static void __init uniphier_cache_inv_all(void)
+{
+	uniphier_cache_maint_all(UNIPHIER_SSCOQM_CM_INV);
+}
+
+static void uniphier_cache_flush_all(void)
+{
+	uniphier_cache_maint_all(UNIPHIER_SSCOQM_CM_FLUSH);
+}
+
+static void uniphier_cache_disable(void)
+{
+	int i;
+
+	for (i = uniphier_outer_levels - 1; i >= 0; i--)
+		__uniphier_cache_enable(&uniphier_cache_data[i], false);
+
+	uniphier_cache_flush_all();
+}
+
+static void __init uniphier_cache_enable(void)
+{
+	int i;
+
+	uniphier_cache_inv_all();
+
+	for (i = 0; i < uniphier_outer_levels; i++)
+		__uniphier_cache_enable(&uniphier_cache_data[i], true);
+}
+
+static void uniphier_cache_sync(void)
+{
+	int i;
+
+	for (i = 0; i < uniphier_outer_levels; i++)
+		__uniphier_cache_sync(&uniphier_cache_data[i]);
+}
+
+static void __init uniphier_cache_set_active_ways(u32 ways)
+{
+	int i;
+
+	for (i = 0; i < uniphier_outer_levels; i++)
+		__uniphier_cache_set_active_ways(&uniphier_cache_data[i],
+						 ways);
+}
+
+static int __init uniphier_cache_common_init(struct device_node *np,
+					     struct uniphier_cache_data *data)
+{
+	data->ctrl_base = of_iomap(np, 0);
+	if (!data->ctrl_base)
+		return -ENOMEM;
+
+	data->rev_base = of_iomap(np, 1);
+	if (!data->rev_base)
+		goto err;
+
+	data->op_base = of_iomap(np, 2);
+	if (!data->op_base)
+		goto err;
+
+	return 0;
+err:
+	iounmap(data->rev_base);
+	iounmap(data->ctrl_base);
+
+	return -ENOMEM;
+}
+
+static int __init uniphier_l2_cache_init(struct device_node *np,
+					 struct uniphier_cache_data *data)
+{
+	int ret;
+	u32 revision;
+
+	ret = uniphier_cache_common_init(np, data);
+	if (ret)
+		return ret;
+
+	data->line_size = UNIPHIER_L2_CACHE_LINE_SIZE;
+
+	revision = readl(data->rev_base + UNIPHIER_SSCID);
+
+	if (revision >= 0x17) /* PH1-Pro5 or later */
+		data->range_op_max_size = (u32)-data->line_size;
+	else
+		data->range_op_max_size = (1UL << 22) - data->line_size;
+
+	writel_relaxed(0, data->ctrl_base + UNIPHIER_SSCC);
+
+	return 0;
+}
+
+static int __init uniphier_l3_cache_init(struct device_node *np,
+					 struct uniphier_cache_data *data)
+{
+	int ret;
+
+	ret = uniphier_cache_common_init(np, data);
+	if (ret)
+		return ret;
+
+	data->line_size = UNIPHIER_L3_CACHE_LINE_SIZE;
+
+	data->range_op_max_size = (u32)-data->line_size;
+
+	return 0;
+}
+
+static const struct of_device_id uniphier_l2_cache_match[] __initconst = {
+	{
+		.compatible = "socionext,uniphier-l2-cache",
+		.data = uniphier_l2_cache_init,
+	},
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id uniphier_l3_cache_match[] __initconst = {
+	{
+		.compatible = "socionext,uniphier-l3-cache",
+		.data = uniphier_l3_cache_init,
+	},
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id *const uniphier_cache_matches[] __initconst = {
+	uniphier_l2_cache_match,
+	uniphier_l3_cache_match,
+};
+
+#define UNIPHIER_CACHE_LEVELS		(ARRAY_SIZE(uniphier_cache_matches))
+
+static struct uniphier_cache_data uniphier_cache_data[UNIPHIER_CACHE_LEVELS];
+
+static int __init __uniphier_cache_init(void)
+{
+	int (*initf)(struct device_node *np, struct uniphier_cache_data *data);
+	static int done;
+	static int ret;
+	struct device_node *np;
+	const struct of_device_id *match;
+	int i;
+
+	if (done)
+		return ret;
+
+	for (i = 0; ARRAY_SIZE(uniphier_cache_matches); i++) {
+		np = of_find_matching_node_and_match(NULL,
+						     uniphier_cache_matches[i],
+						     &match);
+		if (!np) {
+			ret = -ENODEV;
+			break;
+		}
+
+		initf = match->data;
+		ret = initf(np, &uniphier_cache_data[i]);
+		if (ret)
+			break;
+	}
+
+	uniphier_outer_levels = i;
+
+	/*
+	 * Error out iif L2 initialization fails.
+	 * Continue with any error on L3 because it is optional.
+	 */
+	if (uniphier_outer_levels == 0) {
+		ret = ret ?: -ENODEV;
+		pr_err("uniphier: failed to initialize outer cache\n");
+		goto out;
+	} else {
+		ret = 0;
+	}
+
+	outer_cache.inv_range = uniphier_cache_inv_range;
+	outer_cache.clean_range = uniphier_cache_clean_range;
+	outer_cache.flush_range = uniphier_cache_flush_range;
+	outer_cache.flush_all = uniphier_cache_flush_all;
+	outer_cache.disable = uniphier_cache_disable;
+	outer_cache.sync = uniphier_cache_sync;
+
+	uniphier_cache_enable();
+
+out:
+	done = 1;
+
+	return ret;
+}
+
+/**
+ * uniphier_cache_init - initialize outer cache and set all the ways active
+ *
+ * This enables the outer cache for the normal operation.
+ */
+int __init uniphier_cache_init(void)
+{
+	int ret;
+
+	ret = __uniphier_cache_init();
+	if (ret)
+		return ret;
+
+	uniphier_cache_set_active_ways(U32_MAX);
+
+	pr_info("uniphier: enabled outer cache (%s)\n",
+		uniphier_outer_levels >= 2 ? "L2 and L3" : "L2");
+
+	return 0;
+}
+
+/**
+ * uniphier_cache_init_locked - initialize outer cache and lock all the ways
+ *
+ * This enables the outer cache, but never performs the refill operations.
+ * If the data at the accessed address is found in the cache (cache-hit), the
+ * data is transferred to the CPU.  If not (cache-miss), the desired data is
+ * fetched from the main memory, but the contents in the cache are _not_
+ * replaced.  This is generally used to keep particular data in the cache.
+ */
+int __init uniphier_cache_init_locked(void)
+{
+	int ret;
+
+	ret = __uniphier_cache_init();
+	if (ret)
+		return ret;
+
+	uniphier_cache_set_active_ways(0);
+
+	pr_info("uniphier: set up outer cache (%s) as locked cache\n",
+		uniphier_outer_levels >= 2 ? "L2 and L3" : "L2");
+
+	return 0;
+}
-- 
1.9.1
