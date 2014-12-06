From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  6 Dec 2014 13:46:13 +0000
Subject: [PATCH 2/5] irqchip: crossbar: convert dra7 crossbar to stacked
 domains
In-Reply-To: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417873576-10463-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support for the TI crossbar used on the DRA7 family of chips
is implemented as an ugly hack on the side of the GIC.

Converting it to stacked domains makes it slightly more
palatable, as it results in a cleanup.

Unfortunately, as the DT bindings failed to acknoledge the fact
that this is actually yet another interrupt controller (the
third, actually), we have yet another breakage. Oh well.

Full untested, will crash and burn, blah blah blah.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/boot/dts/dra7.dtsi          |  10 +-
 arch/arm/boot/dts/dra72x.dtsi        |   3 +-
 arch/arm/boot/dts/dra74x.dtsi        |   5 +-
 arch/arm/mach-omap2/omap4-common.c   |   4 -
 drivers/irqchip/irq-crossbar.c       | 202 ++++++++++++++++++++---------------
 include/linux/irqchip/irq-crossbar.h |  11 --
 6 files changed, 126 insertions(+), 109 deletions(-)
 delete mode 100644 include/linux/irqchip/irq-crossbar.h

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 49ad4b3..43509e9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -13,7 +13,6 @@
 #include "skeleton.dtsi"
 
 #define MAX_SOURCES 400
-#define DIRECT_IRQ(irq) (MAX_SOURCES + irq)
 
 / {
 	#address-cells = <1>;
@@ -49,7 +48,6 @@
 		compatible = "arm,cortex-a15-gic";
 		interrupt-controller;
 		#interrupt-cells = <3>;
-		arm,routable-irqs = <192>;
 		reg = <0x48211000 0x1000>,
 		      <0x48212000 0x1000>,
 		      <0x48214000 0x2000>,
@@ -93,8 +91,8 @@
 		ti,hwmods = "l3_main_1", "l3_main_2";
 		reg = <0x44000000 0x1000000>,
 		      <0x45000000 0x1000>;
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI DIRECT_IRQ(10) IRQ_TYPE_LEVEL_HIGH>;
+		interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
 		prm: prm at 4ae06000 {
 			compatible = "ti,dra7-prm";
@@ -1265,9 +1263,11 @@
 			status = "disabled";
 		};
 
-		crossbar_mpu: crossbar at 4a020000 {
+		crossbar_mpu: crossbar at 4a002a48 {
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
+			interrupt-controller;
+			interrupt-parent = <&wakeupgen>;
 			ti,max-irqs = <160>;
 			ti,max-crossbar-sources = <MAX_SOURCES>;
 			ti,reg-size = <2>;
diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index e5a3d23..f7fb0d0 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -25,6 +25,7 @@
 
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
-		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&wakeupgen>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 3be544c..7e0d3a6 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -41,7 +41,8 @@
 
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
-		interrupts = <GIC_SPI DIRECT_IRQ(131) IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI DIRECT_IRQ(132) IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&wakeupgen>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 	};
 };
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 0465448..021ceb5 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -22,7 +22,6 @@
 #include <linux/of_platform.h>
 #include <linux/export.h>
 #include <linux/irqchip/arm-gic.h>
-#include <linux/irqchip/irq-crossbar.h>
 #include <linux/of_address.h>
 #include <linux/reboot.h>
 #include <linux/genalloc.h>
@@ -274,8 +273,5 @@ void __init omap_gic_of_init(void)
 	WARN_ON(!twd_base);
 
 skip_errata_init:
-#ifdef CONFIG_IRQ_CROSSBAR
-	irqcrossbar_init();
-#endif
 	irqchip_init();
 }
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index bbbaf5d..b44915a 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -11,11 +11,12 @@
  */
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
-#include <linux/irqchip/arm-gic.h>
-#include <linux/irqchip/irq-crossbar.h>
+
+#include "irqchip.h"
 
 #define IRQ_FREE	-1
 #define IRQ_RESERVED	-2
@@ -33,6 +34,7 @@
  * @write: register write function pointer
  */
 struct crossbar_device {
+	raw_spinlock_t lock;
 	uint int_max;
 	uint safe_map;
 	uint max_crossbar_sources;
@@ -44,72 +46,97 @@ struct crossbar_device {
 
 static struct crossbar_device *cb;
 
-static inline void crossbar_writel(int irq_no, int cb_no)
+static void crossbar_writel(int irq_no, int cb_no)
 {
 	writel(cb_no, cb->crossbar_base + cb->register_offsets[irq_no]);
 }
 
-static inline void crossbar_writew(int irq_no, int cb_no)
+static void crossbar_writew(int irq_no, int cb_no)
 {
 	writew(cb_no, cb->crossbar_base + cb->register_offsets[irq_no]);
 }
 
-static inline void crossbar_writeb(int irq_no, int cb_no)
+static void crossbar_writeb(int irq_no, int cb_no)
 {
 	writeb(cb_no, cb->crossbar_base + cb->register_offsets[irq_no]);
 }
 
-static inline int get_prev_map_irq(int cb_no)
-{
-	int i;
-
-	for (i = cb->int_max - 1; i >= 0; i--)
-		if (cb->irq_map[i] == cb_no)
-			return i;
-
-	return -ENODEV;
-}
+static struct irq_chip crossbar_chip = {
+	.name		= "CBAR",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+	.irq_set_wake	= irq_chip_set_wake_parent,
+};
 
-static inline int allocate_free_irq(int cb_no)
+static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
+			    irq_hw_number_t hwirq)
 {
+	struct of_phandle_args args;
 	int i;
+	int err;
 
+	raw_spin_lock(&cb->lock);
 	for (i = cb->int_max - 1; i >= 0; i--) {
 		if (cb->irq_map[i] == IRQ_FREE) {
-			cb->irq_map[i] = cb_no;
-			return i;
+			cb->irq_map[i] = hwirq;
+			break;
 		}
 	}
+	raw_spin_unlock(&cb->lock);
 
-	return -ENODEV;
-}
+	if (i < 0)
+		return -ENODEV;
 
-static inline bool needs_crossbar_write(irq_hw_number_t hw)
-{
-	int cb_no;
+	args.np = domain->parent->of_node;
+	args.args_count = 3;
+	args.args[0] = 0;	/* SPI */
+	args.args[1] = i;
+	args.args[2] = IRQ_TYPE_LEVEL_HIGH;
 
-	if (hw > GIC_IRQ_START) {
-		cb_no = cb->irq_map[hw - GIC_IRQ_START];
-		if (cb_no != IRQ_RESERVED && cb_no != IRQ_SKIP)
-			return true;
-	}
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &args);
+	if (err)
+		cb->irq_map[i] = IRQ_FREE;
+	else
+		cb->write(hwirq, i);
 
-	return false;
+	return err;
 }
 
-static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
-			       irq_hw_number_t hw)
+static int crossbar_domain_alloc(struct irq_domain *d, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
 {
-	if (needs_crossbar_write(hw))
-		cb->write(hw - GIC_IRQ_START, cb->irq_map[hw - GIC_IRQ_START]);
+	struct of_phandle_args *args = data;
+	irq_hw_number_t hwirq;
+	int i;
+
+	if (args->args_count != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (args->args[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	hwirq = args->args[1];
+	if ((hwirq + nr_irqs) > cb->max_crossbar_sources)
+		return -EINVAL;	/* Can't deal with this */
+
+	for (i = 0; i < nr_irqs; i++) {
+		int err = allocate_gic_irq(d, virq + i, hwirq + i);
+		if (err)
+			return err;
+
+		irq_domain_set_hwirq_and_chip(d, virq + i, hwirq + i,
+					      &crossbar_chip, NULL);
+	}
 
 	return 0;
 }
 
 /**
- * crossbar_domain_unmap - unmap a crossbar<->irq connection
+ * crossbar_domain_free - unmap/free a crossbar<->irq connection
  * @d: domain of irq to unmap
- * @irq: virq number
+ * @virq: virq number
+ * @nr_irqs: number of irqs to free
  *
  * We do not maintain a use count of total number of map/unmap
  * calls for a particular irq to find out if a irq can be really
@@ -117,14 +144,19 @@ static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
  * after which irq is anyways unusable. So an explicit map has to be called
  * after that.
  */
-static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
+static void crossbar_domain_free(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs)
 {
-	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
+	int i;
 
-	if (needs_crossbar_write(hw)) {
-		cb->irq_map[hw - GIC_IRQ_START] = IRQ_FREE;
-		cb->write(hw - GIC_IRQ_START, cb->safe_map);
+	raw_spin_lock(&cb->lock);
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+		irq_domain_reset_irq_data(d);
+		cb->irq_map[d->hwirq] = IRQ_FREE;
+		cb->write(d->hwirq, cb->safe_map);
 	}
+	raw_spin_unlock(&cb->lock);
 }
 
 static int crossbar_domain_xlate(struct irq_domain *d,
@@ -133,44 +165,22 @@ static int crossbar_domain_xlate(struct irq_domain *d,
 				 unsigned long *out_hwirq,
 				 unsigned int *out_type)
 {
-	int ret;
-	int req_num = intspec[1];
-	int direct_map_num;
-
-	if (req_num >= cb->max_crossbar_sources) {
-		direct_map_num = req_num - cb->max_crossbar_sources;
-		if (direct_map_num < cb->int_max) {
-			ret = cb->irq_map[direct_map_num];
-			if (ret == IRQ_RESERVED || ret == IRQ_SKIP) {
-				/* We use the interrupt num as h/w irq num */
-				ret = direct_map_num;
-				goto found;
-			}
-		}
-
-		pr_err("%s: requested crossbar number %d > max %d\n",
-		       __func__, req_num, cb->max_crossbar_sources);
-		return -EINVAL;
-	}
-
-	ret = get_prev_map_irq(req_num);
-	if (ret >= 0)
-		goto found;
-
-	ret = allocate_free_irq(req_num);
-
-	if (ret < 0)
-		return ret;
-
-found:
-	*out_hwirq = ret + GIC_IRQ_START;
+	if (d->of_node != controller)
+		return -EINVAL;	/* Shouldn't happen, really... */
+	if (intsize != 3)
+		return -EINVAL;	/* Not GIC compliant */
+	if (intspec[0] != 0)
+		return -EINVAL;	/* No PPI should point to this domain */
+
+	*out_hwirq = intspec[1];
+	*out_type = intspec[2];
 	return 0;
 }
 
-static const struct irq_domain_ops routable_irq_domain_ops = {
-	.map = crossbar_domain_map,
-	.unmap = crossbar_domain_unmap,
-	.xlate = crossbar_domain_xlate
+static const struct irq_domain_ops crossbar_domain_ops = {
+	.alloc	= crossbar_domain_alloc,
+	.free	= crossbar_domain_free,
+	.xlate	= crossbar_domain_xlate,
 };
 
 static int __init crossbar_of_init(struct device_node *node)
@@ -293,7 +303,8 @@ static int __init crossbar_of_init(struct device_node *node)
 		cb->write(i, cb->safe_map);
 	}
 
-	register_routable_domain_ops(&routable_irq_domain_ops);
+	raw_spin_lock_init(&cb->lock);
+
 	return 0;
 
 err_reg_offset:
@@ -309,18 +320,37 @@ err_cb:
 	return ret;
 }
 
-static const struct of_device_id crossbar_match[] __initconst = {
-	{ .compatible = "ti,irq-crossbar" },
-	{}
-};
-
-int __init irqcrossbar_init(void)
+static int __init irqcrossbar_init(struct device_node *node,
+				   struct device_node *parent)
 {
-	struct device_node *np;
-	np = of_find_matching_node(NULL, crossbar_match);
-	if (!np)
+	struct irq_domain *parent_domain, *domain;
+	int err;
+
+	if (!parent) {
+		pr_err("%s: no parent, giving up\n", node->full_name);
 		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%s: unable to obtain parent domain\n", node->full_name);
+		return -ENXIO;
+	}
+
+	err = crossbar_of_init(node);
+	if (err)
+		return err;
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0,
+					  cb->max_crossbar_sources,
+					  node, &crossbar_domain_ops,
+					  NULL);
+	if (!domain) {
+		pr_err("%s: failed to allocated domain\n", node->full_name);
+		return -ENOMEM;
+	}
 
-	crossbar_of_init(np);
 	return 0;
 }
+
+IRQCHIP_DECLARE(ti_irqcrossbar, "ti,irqcrossbar", irqcrossbar_init);
diff --git a/include/linux/irqchip/irq-crossbar.h b/include/linux/irqchip/irq-crossbar.h
deleted file mode 100644
index e5537b8..0000000
--- a/include/linux/irqchip/irq-crossbar.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- *  drivers/irqchip/irq-crossbar.h
- *
- *  Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-int irqcrossbar_init(void);
-- 
2.1.3
