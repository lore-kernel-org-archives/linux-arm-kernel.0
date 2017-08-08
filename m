From: rrichter@cavium.com (Robert Richter)
Date: Tue,  8 Aug 2017 14:22:53 +0200
Subject: [PATCH v3 3/8] irqchip/gic-v3-its: Split probing from its node
 initialization
In-Reply-To: <20170808122259.6299-1-rrichter@cavium.com>
References: <20170808122259.6299-1-rrichter@cavium.com>
Message-ID: <20170808122259.6299-4-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To initialize the its nodes at a later point during boot, we need to
split probing from initialization. Collect all information required
for initialization in struct its_node. We can then use the its node
list for initialization.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 95 ++++++++++++++++++++++++++------------
 drivers/irqchip/irq-gic-v3.c       |  2 +-
 include/linux/irqchip/arm-gic-v3.h |  4 +-
 3 files changed, 68 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 92c66c86a63f..b51a1208588b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -75,10 +75,12 @@ struct its_baser {
  * list of devices writing to it.
  */
 struct its_node {
+	struct fwnode_handle	*fwnode;
 	raw_spinlock_t		lock;
 	struct list_head	entry;
 	void __iomem		*base;
 	phys_addr_t		phys_base;
+	phys_addr_t		phys_size;
 	struct its_cmd_block	*cmd_base;
 	struct its_cmd_block	*cmd_write;
 	struct its_baser	tables[GITS_BASER_NR_REGS];
@@ -1647,7 +1649,7 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
-static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
+static int its_init_domain(struct its_node *its)
 {
 	struct irq_domain *inner_domain;
 	struct msi_domain_info *info;
@@ -1656,7 +1658,7 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 	if (!info)
 		return -ENOMEM;
 
-	inner_domain = irq_domain_create_tree(handle, &its_domain_ops, its);
+	inner_domain = irq_domain_create_tree(its->fwnode, &its_domain_ops, its);
 	if (!inner_domain) {
 		kfree(info);
 		return -ENOMEM;
@@ -1672,55 +1674,83 @@ static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 	return 0;
 }
 
+static void its_free(struct its_node *its)
+{
+	spin_lock(&its_lock);
+	list_del(&its->entry);
+	spin_unlock(&its_lock);
+
+	kfree(its);
+}
+
+static int __init its_init_one(struct its_node *its);
+
 static int __init its_probe_one(struct resource *res,
 				struct fwnode_handle *handle, int numa_node)
 {
 	struct its_node *its;
+	int err;
+
+	its = kzalloc(sizeof(*its), GFP_KERNEL);
+	if (!its)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&its->lock);
+	INIT_LIST_HEAD(&its->entry);
+	INIT_LIST_HEAD(&its->its_device_list);
+	its->fwnode = handle;
+	its->phys_base = res->start;
+	its->phys_size = resource_size(res);
+	its->numa_node = numa_node;
+
+	spin_lock(&its_lock);
+	list_add_tail(&its->entry, &its_nodes);
+	spin_unlock(&its_lock);
+
+	pr_info("ITS %pR\n", res);
+
+	err = its_init_one(its);
+	if (err)
+		its_free(its);
+
+	return err;
+}
+
+static int __init its_init_one(struct its_node *its)
+{
 	void __iomem *its_base;
 	u32 val;
 	u64 baser, tmp;
 	int err;
 
-	its_base = ioremap(res->start, resource_size(res));
+	its_base = ioremap(its->phys_base, its->phys_size);
 	if (!its_base) {
-		pr_warn("ITS@%pa: Unable to map ITS registers\n", &res->start);
-		return -ENOMEM;
+		pr_warn("ITS@%pa: Unable to map ITS registers\n", &its->phys_base);
+		err = -ENOMEM;
+		goto fail;
 	}
 
 	val = readl_relaxed(its_base + GITS_PIDR2) & GIC_PIDR2_ARCH_MASK;
 	if (val != 0x30 && val != 0x40) {
-		pr_warn("ITS@%pa: No ITS detected, giving up\n", &res->start);
+		pr_warn("ITS@%pa: No ITS detected, giving up\n", &its->phys_base);
 		err = -ENODEV;
 		goto out_unmap;
 	}
 
 	err = its_force_quiescent(its_base);
 	if (err) {
-		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &res->start);
-		goto out_unmap;
-	}
-
-	pr_info("ITS %pR\n", res);
-
-	its = kzalloc(sizeof(*its), GFP_KERNEL);
-	if (!its) {
-		err = -ENOMEM;
+		pr_warn("ITS@%pa: Failed to quiesce, giving up\n", &its->phys_base);
 		goto out_unmap;
 	}
 
-	raw_spin_lock_init(&its->lock);
-	INIT_LIST_HEAD(&its->entry);
-	INIT_LIST_HEAD(&its->its_device_list);
 	its->base = its_base;
-	its->phys_base = res->start;
 	its->ite_size = ((gic_read_typer(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
-	its->numa_node = numa_node;
 
 	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 						get_order(ITS_CMD_QUEUE_SZ));
 	if (!its->cmd_base) {
 		err = -ENOMEM;
-		goto out_free_its;
+		goto out_unmap;
 	}
 	its->cmd_write = its->cmd_base;
 
@@ -1762,13 +1792,11 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cwriter(0, its->base + GITS_CWRITER);
 	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
-	err = its_init_domain(handle, its);
+	err = its_init_domain(its);
 	if (err)
 		goto out_free_tables;
 
-	spin_lock(&its_lock);
-	list_add_tail(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	pr_info("ITS@%pa: ITS node added\n", &its->phys_base);
 
 	return 0;
 
@@ -1776,11 +1804,10 @@ static int __init its_probe_one(struct resource *res,
 	its_free_tables(its);
 out_free_cmd:
 	free_pages((unsigned long)its->cmd_base, get_order(ITS_CMD_QUEUE_SZ));
-out_free_its:
-	kfree(its);
 out_unmap:
 	iounmap(its_base);
-	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
+fail:
+	pr_err("ITS@%pa: failed probing (%d)\n", &its->phys_base, err);
 	return err;
 }
 
@@ -1956,8 +1983,10 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
 
-int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
-		    struct irq_domain *parent_domain)
+static int __init its_init(void);
+
+int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
+		     struct irq_domain *parent_domain)
 {
 	struct device_node *of_node;
 
@@ -1974,5 +2003,11 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
+
+	return its_init();
+}
+
+static int __init its_init(void)
+{
 	return its_alloc_lpi_tables();
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbffb7ab6203..886e70ab2159 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -952,7 +952,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	set_handle_irq(gic_handle_irq);
 
 	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_init(handle, &gic_data.rdists, gic_data.domain);
+		its_probe(handle, &gic_data.rdists, gic_data.domain);
 
 	gic_smp_init();
 	gic_dist_init();
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 6a1f87ff94e2..c4f9c968728f 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -492,8 +492,8 @@ struct rdists {
 struct irq_domain;
 struct fwnode_handle;
 int its_cpu_init(void);
-int its_init(struct fwnode_handle *handle, struct rdists *rdists,
-	     struct irq_domain *domain);
+int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
+	      struct irq_domain *domain);
 
 static inline bool gic_enable_sre(void)
 {
-- 
2.11.0
