From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 15 Oct 2015 16:05:15 +0200
Subject: [PATCH V1 06/10] irqchip/GICv3/ITS: Refator ITS dt init code to
 prepare for ACPI.
In-Reply-To: <1444917919-21152-1-git-send-email-tn@semihalf.com>
References: <1444917919-21152-1-git-send-email-tn@semihalf.com>
Message-ID: <1444917919-21152-7-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 78 +++++++++++++++++++++++---------------
 drivers/irqchip/irq-gic-v3.c       |  6 +--
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 3 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7a1a682..25926f2 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -810,7 +810,7 @@ static void its_free_tables(struct its_node *its)
 	}
 }
 
-static int its_alloc_tables(const char *node_name, struct its_node *its)
+static int its_alloc_tables(struct its_node *its)
 {
 	int err;
 	int i;
@@ -852,8 +852,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 				    order);
 			if (order >= MAX_ORDER) {
 				order = MAX_ORDER - 1;
-				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
-					node_name, order);
+				pr_warn("ITS at 0x%lx: Device Table too large, reduce its page order to %u\n",
+					its->phys_base, order);
 			}
 		}
 
@@ -924,8 +924,8 @@ retry_baser:
 		}
 
 		if (val != tmp) {
-			pr_err("ITS: %s: GITS_BASER%d doesn't stick: %lx %lx\n",
-			       node_name, i,
+			pr_err("ITS at 0x%lx: GITS_BASER%d doesn't stick: %lx %lx\n",
+			       its->phys_base, i,
 			       (unsigned long) val, (unsigned long) tmp);
 			err = -ENXIO;
 			goto out_free;
@@ -1373,10 +1373,11 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
-static int __init its_probe(struct device_node *node,
-			    struct irq_domain *parent)
+static int __init its_probe_one(phys_addr_t phys_base, unsigned long size,
+				struct irq_domain *parent,
+				bool is_msi_controller,
+				struct fwnode_handle *handler)
 {
-	struct resource res;
 	struct its_node *its;
 	void __iomem *its_base;
 	struct irq_domain *inner_domain;
@@ -1384,33 +1385,26 @@ static int __init its_probe(struct device_node *node,
 	u64 baser, tmp;
 	int err;
 
-	err = of_address_to_resource(node, 0, &res);
-	if (err) {
-		pr_warn("%s: no regs?\n", node->full_name);
-		return -ENXIO;
-	}
-
-	its_base = ioremap(res.start, resource_size(&res));
+	its_base = ioremap(phys_base, size);
 	if (!its_base) {
-		pr_warn("%s: unable to map registers\n", node->full_name);
+		pr_warn("Unable to map ITS registers\n");
 		return -ENOMEM;
 	}
 
 	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
 	if (val != 0x30 && val != 0x40) {
-		pr_warn("%s: no ITS detected, giving up\n", node->full_name);
+		pr_warn("No ITS detected, giving up\n");
 		err = -ENODEV;
 		goto out_unmap;
 	}
 
 	err = its_force_quiescent(its_base);
 	if (err) {
-		pr_warn("%s: failed to quiesce, giving up\n",
-			node->full_name);
+		pr_warn("Failed to quiesce, giving up\n");
 		goto out_unmap;
 	}
 
-	pr_info("ITS: %s\n", node->full_name);
+	pr_info("ITS at 0x%lx\n", (long)phys_base);
 
 	its = kzalloc(sizeof(*its), GFP_KERNEL);
 	if (!its) {
@@ -1422,7 +1416,7 @@ static int __init its_probe(struct device_node *node,
 	INIT_LIST_HEAD(&its->entry);
 	INIT_LIST_HEAD(&its->its_device_list);
 	its->base = its_base;
-	its->phys_base = res.start;
+	its->phys_base = phys_base;
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
 
 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
@@ -1432,7 +1426,7 @@ static int __init its_probe(struct device_node *node,
 	}
 	its->cmd_write = its->cmd_base;
 
-	err = its_alloc_tables(node->full_name, its);
+	err = its_alloc_tables(its);
 	if (err)
 		goto out_free_cmd;
 
@@ -1468,7 +1462,7 @@ static int __init its_probe(struct device_node *node,
 	writeq_relaxed(0, its->base + GITS_CWRITER);
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
-	if (of_property_read_bool(node, "msi-controller")) {
+	if (is_msi_controller) {
 		struct msi_domain_info *info;
 
 		info = kzalloc(sizeof(*info), GFP_KERNEL);
@@ -1477,7 +1471,8 @@ static int __init its_probe(struct device_node *node,
 			goto out_free_tables;
 		}
 
-		inner_domain = irq_domain_add_tree(node, &its_domain_ops, its);
+		inner_domain = irq_domain_create_tree(handler, &its_domain_ops,
+						      its);
 		if (!inner_domain) {
 			err = -ENOMEM;
 			kfree(info);
@@ -1505,10 +1500,28 @@ out_free_its:
 	kfree(its);
 out_unmap:
 	iounmap(its_base);
-	pr_err("ITS: failed probing %s (%d)\n", node->full_name, err);
+	pr_err("ITS at 0x%lx: failed probing (%d)\n", (long)phys_base, err);
 	return err;
 }
 
+static int __init
+its_of_probe(struct device_node *node, struct irq_domain *parent)
+{
+	struct resource res;
+	bool is_msi_controller = false;
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_warn("%s: no regs?\n", node->full_name);
+		return -ENXIO;
+	}
+
+	if (of_property_read_bool(node, "msi-controller"))
+		is_msi_controller = true;
+
+	return its_probe_one(res.start, resource_size(&res), parent,
+			    is_msi_controller, &node->fwnode);
+}
+
 static bool gic_rdists_supports_plpis(void)
 {
 	return !!(readl_relaxed(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
@@ -1533,14 +1546,17 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-int __init its_init(struct device_node *node, struct rdists *rdists,
-	     struct irq_domain *parent_domain)
+int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
+		    struct irq_domain *parent_domain)
 {
-	struct device_node *np;
+	struct device_node *np, *of_node;
 
-	for (np = of_find_matching_node(node, its_device_id); np;
-	     np = of_find_matching_node(np, its_device_id)) {
-		its_probe(np, parent_domain);
+	of_node = to_of_node(handle);
+	if (of_node) {
+		for (np = of_find_matching_node(of_node, its_device_id); np;
+		     np = of_find_matching_node(np, its_device_id)) {
+			its_of_probe(np, parent_domain);
+		}
 	}
 
 	if (list_empty(&its_nodes)) {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b27a543..27a6b79 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -857,7 +857,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 				 u64 redist_stride,
 				 struct fwnode_handle *handle)
 {
-	struct device_node *node;
 	u32 typer;
 	int gic_irqs;
 	int err;
@@ -895,10 +894,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	node = to_of_node(handle);
 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis() &&
-	    node) /* Temp hack to prevent ITS init for ACPI */
-		its_init(node, &gic_data.rdists, gic_data.domain);
+	    to_of_node(handle)) /* Temp hack to prevent ITS init for ACPI */
+		its_init(handle, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
 	gic_dist_init();
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9eeeb95..7541c11 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -399,7 +399,7 @@ static inline void gic_write_dir(u64 irq)
 
 struct irq_domain;
 int its_cpu_init(void);
-int its_init(struct device_node *node, struct rdists *rdists,
+int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
 
 #endif
-- 
1.9.1
