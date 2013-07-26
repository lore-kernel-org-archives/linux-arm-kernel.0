From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:24 +0800
Subject: [PATCH v6 02/11] irqchip: mmp: support irqchip
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support IRQCHIP on irq-mmp driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp-dt.c  |   8 +-
 arch/arm/mach-mmp/mmp2-dt.c |   8 +-
 drivers/irqchip/irq-mmp.c   | 238 +++++++++++++++++++++++---------------------
 3 files changed, 126 insertions(+), 128 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index b37915d..cca529c 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -9,17 +9,13 @@
  *  publishhed by the Free Software Foundation.
  */
 
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/irqs.h>
 
 #include "common.h"
 
-extern void __init mmp_dt_irq_init(void);
 extern void __init mmp_dt_init_timer(void);
 
 static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst = {
@@ -64,7 +60,6 @@ static const char *mmp_dt_board_compat[] __initdata = {
 
 DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_irq	= mmp_dt_irq_init,
 	.init_time	= mmp_dt_init_timer,
 	.init_machine	= pxa168_dt_init,
 	.dt_compat	= mmp_dt_board_compat,
@@ -72,7 +67,6 @@ MACHINE_END
 
 DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_irq	= mmp_dt_irq_init,
 	.init_time	= mmp_dt_init_timer,
 	.init_machine	= pxa910_dt_init,
 	.dt_compat	= mmp_dt_board_compat,
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 4ac2567..023cb45 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -10,18 +10,13 @@
  */
 
 #include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
+#include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <mach/irqs.h>
-#include <mach/regs-apbc.h>
 
 #include "common.h"
 
-extern void __init mmp_dt_irq_init(void);
 extern void __init mmp_dt_init_timer(void);
 
 static const struct of_dev_auxdata mmp2_auxdata_lookup[] __initconst = {
@@ -49,7 +44,6 @@ static const char *mmp2_dt_board_compat[] __initdata = {
 
 DT_MACHINE_START(MMP2_DT, "Marvell MMP2 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_irq	= mmp_dt_irq_init,
 	.init_time	= mmp_dt_init_timer,
 	.init_machine	= mmp2_dt_init,
 	.dt_compat	= mmp2_dt_board_compat,
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index dab6def..275709b 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -30,6 +30,8 @@
 #include <mach/pm-pxa910.h>
 #endif
 
+#include "irqchip.h"
+
 #define MAX_ICU_NR		16
 
 struct icu_chip_data {
@@ -324,138 +326,146 @@ void __init mmp2_init_icu(void)
 }
 
 #ifdef CONFIG_OF
-static const struct of_device_id intc_ids[] __initconst = {
-	{ .compatible = "mrvl,mmp-intc", .data = &mmp_conf },
-	{ .compatible = "mrvl,mmp2-intc", .data = &mmp2_conf },
-	{}
-};
-
-static const struct of_device_id mmp_mux_irq_match[] __initconst = {
-	{ .compatible = "mrvl,mmp2-mux-intc" },
-	{}
-};
-
-int __init mmp2_mux_init(struct device_node *parent)
+static int __init mmp_init_bases(struct device_node *node)
 {
-	struct device_node *node;
-	const struct of_device_id *of_id;
-	struct resource res;
-	int i, irq_base, ret, irq;
-	u32 nr_irqs, mfp_irq;
+	int ret, nr_irqs, irq, i = 0;
 
-	node = parent;
-	max_icu_nr = 1;
-	for (i = 1; i < MAX_ICU_NR; i++) {
-		node = of_find_matching_node(node, mmp_mux_irq_match);
-		if (!node)
-			break;
-		of_id = of_match_node(&mmp_mux_irq_match[0], node);
-		ret = of_property_read_u32(node, "mrvl,intc-nr-irqs",
-					   &nr_irqs);
-		if (ret) {
-			pr_err("Not found mrvl,intc-nr-irqs property\n");
-			ret = -EINVAL;
-			goto err;
-		}
-		ret = of_address_to_resource(node, 0, &res);
-		if (ret < 0) {
-			pr_err("Not found reg property\n");
-			ret = -EINVAL;
-			goto err;
-		}
-		icu_data[i].reg_status = mmp_icu_base + res.start;
-		ret = of_address_to_resource(node, 1, &res);
-		if (ret < 0) {
-			pr_err("Not found reg property\n");
-			ret = -EINVAL;
-			goto err;
-		}
-		icu_data[i].reg_mask = mmp_icu_base + res.start;
-		icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
-		if (!icu_data[i].cascade_irq) {
-			ret = -EINVAL;
-			goto err;
-		}
+	ret = of_property_read_u32(node, "mrvl,intc-nr-irqs", &nr_irqs);
+	if (ret) {
+		pr_err("Not found mrvl,intc-nr-irqs property\n");
+		return ret;
+	}
 
-		irq_base = irq_alloc_descs(-1, 0, nr_irqs, 0);
-		if (irq_base < 0) {
-			pr_err("Failed to allocate IRQ numbers for mux intc\n");
-			ret = irq_base;
+	mmp_icu_base = of_iomap(node, 0);
+	if (!mmp_icu_base) {
+		pr_err("Failed to get interrupt controller register\n");
+		return -ENOMEM;
+	}
+
+	icu_data[0].virq_base = 0;
+	icu_data[0].domain = irq_domain_add_linear(node, nr_irqs,
+						   &mmp_irq_domain_ops,
+						   &icu_data[0]);
+	for (irq = 0; irq < nr_irqs; irq++) {
+		ret = irq_create_mapping(icu_data[0].domain, irq);
+		if (!ret) {
+			pr_err("Failed to mapping hwirq\n");
 			goto err;
 		}
-		if (!of_property_read_u32(node, "mrvl,clr-mfp-irq",
-					  &mfp_irq)) {
-			icu_data[i].clr_mfp_irq_base = irq_base;
-			icu_data[i].clr_mfp_hwirq = mfp_irq;
-		}
-		irq_set_chained_handler(icu_data[i].cascade_irq,
-					icu_mux_irq_demux);
-		icu_data[i].nr_irqs = nr_irqs;
-		icu_data[i].virq_base = irq_base;
-		icu_data[i].domain = irq_domain_add_legacy(node, nr_irqs,
-							   irq_base, 0,
-							   &mmp_irq_domain_ops,
-							   &icu_data[i]);
-		for (irq = irq_base; irq < irq_base + nr_irqs; irq++)
-			icu_mask_irq(irq_get_irq_data(irq));
+		if (!irq)
+			icu_data[0].virq_base = ret;
 	}
-	max_icu_nr = i;
+	icu_data[0].nr_irqs = nr_irqs;
 	return 0;
 err:
-	of_node_put(node);
-	max_icu_nr = i;
-	return ret;
+	if (icu_data[0].virq_base) {
+		for (i = 0; i < irq; i++)
+			irq_dispose_mapping(icu_data[0].virq_base + i);
+	}
+	irq_domain_remove(icu_data[0].domain);
+	iounmap(mmp_icu_base);
+	return -EINVAL;
 }
 
-void __init mmp_dt_irq_init(void)
+static int __init mmp_of_init(struct device_node *node,
+			      struct device_node *parent)
 {
-	struct device_node *node;
-	const struct of_device_id *of_id;
-	struct mmp_intc_conf *conf;
-	int nr_irqs, irq_base, ret, irq;
-
-	node = of_find_matching_node(NULL, intc_ids);
-	if (!node) {
-		pr_err("Failed to find interrupt controller in arch-mmp\n");
-		return;
-	}
-	of_id = of_match_node(intc_ids, node);
-	conf = of_id->data;
+	int ret;
 
-	ret = of_property_read_u32(node, "mrvl,intc-nr-irqs", &nr_irqs);
+	ret = mmp_init_bases(node);
+	if (ret < 0)
+		return ret;
+
+	icu_data[0].conf_enable = mmp_conf.conf_enable;
+	icu_data[0].conf_disable = mmp_conf.conf_disable;
+	icu_data[0].conf_mask = mmp_conf.conf_mask;
+	irq_set_default_host(icu_data[0].domain);
+	max_icu_nr = 1;
+	return 0;
+}
+IRQCHIP_DECLARE(mmp_intc, "mrvl,mmp-intc", mmp_of_init);
+
+static int __init mmp2_of_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	int ret;
+
+	ret = mmp_init_bases(node);
+	if (ret < 0)
+		return ret;
+
+	icu_data[0].conf_enable = mmp2_conf.conf_enable;
+	icu_data[0].conf_disable = mmp2_conf.conf_disable;
+	icu_data[0].conf_mask = mmp2_conf.conf_mask;
+	irq_set_default_host(icu_data[0].domain);
+	max_icu_nr = 1;
+	return 0;
+}
+IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
+
+static int __init mmp2_mux_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	struct resource res;
+	int i, ret, irq, j = 0;
+	u32 nr_irqs, mfp_irq;
+
+	if (!parent)
+		return -ENODEV;
+
+	i = max_icu_nr;
+	ret = of_property_read_u32(node, "mrvl,intc-nr-irqs",
+				   &nr_irqs);
 	if (ret) {
 		pr_err("Not found mrvl,intc-nr-irqs property\n");
-		return;
+		return -EINVAL;
 	}
-
-	mmp_icu_base = of_iomap(node, 0);
-	if (!mmp_icu_base) {
-		pr_err("Failed to get interrupt controller register\n");
-		return;
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret < 0) {
+		pr_err("Not found reg property\n");
+		return -EINVAL;
 	}
-
-	irq_base = irq_alloc_descs(-1, 0, nr_irqs - NR_IRQS_LEGACY, 0);
-	if (irq_base < 0) {
-		pr_err("Failed to allocate IRQ numbers\n");
-		goto err;
-	} else if (irq_base != NR_IRQS_LEGACY) {
-		pr_err("ICU's irqbase should be started from 0\n");
-		goto err;
+	icu_data[i].reg_status = mmp_icu_base + res.start;
+	ret = of_address_to_resource(node, 1, &res);
+	if (ret < 0) {
+		pr_err("Not found reg property\n");
+		return -EINVAL;
 	}
-	icu_data[0].conf_enable = conf->conf_enable;
-	icu_data[0].conf_disable = conf->conf_disable;
-	icu_data[0].conf_mask = conf->conf_mask;
-	icu_data[0].nr_irqs = nr_irqs;
-	icu_data[0].virq_base = 0;
-	icu_data[0].domain = irq_domain_add_legacy(node, nr_irqs, 0, 0,
+	icu_data[i].reg_mask = mmp_icu_base + res.start;
+	icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
+	if (!icu_data[i].cascade_irq)
+		return -EINVAL;
+
+	icu_data[i].virq_base = 0;
+	icu_data[i].domain = irq_domain_add_linear(node, nr_irqs,
 						   &mmp_irq_domain_ops,
-						   &icu_data[0]);
-	irq_set_default_host(icu_data[0].domain);
-	for (irq = 0; irq < nr_irqs; irq++)
-		icu_mask_irq(irq_get_irq_data(irq));
-	mmp2_mux_init(node);
-	return;
+						   &icu_data[i]);
+	for (irq = 0; irq < nr_irqs; irq++) {
+		ret = irq_create_mapping(icu_data[i].domain, irq);
+		if (!ret) {
+			pr_err("Failed to mapping hwirq\n");
+			goto err;
+		}
+		if (!irq)
+			icu_data[i].virq_base = ret;
+	}
+	icu_data[i].nr_irqs = nr_irqs;
+	if (!of_property_read_u32(node, "mrvl,clr-mfp-irq",
+				  &mfp_irq)) {
+		icu_data[i].clr_mfp_irq_base = icu_data[i].virq_base;
+		icu_data[i].clr_mfp_hwirq = mfp_irq;
+	}
+	irq_set_chained_handler(icu_data[i].cascade_irq,
+				icu_mux_irq_demux);
+	max_icu_nr++;
+	return 0;
 err:
-	iounmap(mmp_icu_base);
+	if (icu_data[i].virq_base) {
+		for (j = 0; j < irq; j++)
+			irq_dispose_mapping(icu_data[i].virq_base + j);
+	}
+	irq_domain_remove(icu_data[i].domain);
+	return -EINVAL;
 }
+IRQCHIP_DECLARE(mmp2_mux_intc, "mrvl,mmp2-mux-intc", mmp2_mux_of_init);
 #endif
-- 
1.8.1.2
