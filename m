From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Oct 2015 11:09:19 +0100
Subject: [PATCH 2/2] irqchip/gic-v2m: Add support for multiple MSI frames
In-Reply-To: <1444817359-15696-1-git-send-email-marc.zyngier@arm.com>
References: <1444817359-15696-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444817359-15696-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GICv2m driver is so far limited to a single MSI frame, but
nothing prevents an implementation from having several of them.

This patch expands the driver to enumerate all frames, keeping
the first one as the canonical identifier for the MSI domains.

Tested-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c | 124 ++++++++++++++++++++++++++----------------
 1 file changed, 78 insertions(+), 46 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index bf9b3c0..3120ee2 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -50,8 +50,12 @@
 /* List of flags for specific v2m implementation */
 #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
 
+static LIST_HEAD(v2m_nodes);
+static DEFINE_SPINLOCK(v2m_lock);
+
 struct v2m_data {
-	spinlock_t msi_cnt_lock;
+	struct list_head entry;
+	struct device_node *node;
 	struct resource res;	/* GICv2m resource */
 	void __iomem *base;	/* GICv2m virt address */
 	u32 spi_start;		/* The SPI number that MSIs start */
@@ -158,27 +162,30 @@ static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq)
 		return;
 	}
 
-	spin_lock(&v2m->msi_cnt_lock);
+	spin_lock(&v2m_lock);
 	__clear_bit(pos, v2m->bm);
-	spin_unlock(&v2m->msi_cnt_lock);
+	spin_unlock(&v2m_lock);
 }
 
 static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
-	struct v2m_data *v2m = domain->host_data;
+	struct v2m_data *v2m = NULL, *tmp;
 	int hwirq, offset, err = 0;
 
-	spin_lock(&v2m->msi_cnt_lock);
-	offset = find_first_zero_bit(v2m->bm, v2m->nr_spis);
-	if (offset < v2m->nr_spis)
-		__set_bit(offset, v2m->bm);
-	else
-		err = -ENOSPC;
-	spin_unlock(&v2m->msi_cnt_lock);
+	spin_lock(&v2m_lock);
+	list_for_each_entry(tmp, &v2m_nodes, entry) {
+		offset = find_first_zero_bit(tmp->bm, tmp->nr_spis);
+		if (offset < tmp->nr_spis) {
+			__set_bit(offset, tmp->bm);
+			v2m = tmp;
+			break;
+		}
+	}
+	spin_unlock(&v2m_lock);
 
-	if (err)
-		return err;
+	if (!v2m)
+		return -ENOSPC;
 
 	hwirq = v2m->spi_start + offset;
 
@@ -239,12 +246,61 @@ static struct msi_domain_info gicv2m_pmsi_domain_info = {
 	.chip	= &gicv2m_pmsi_irq_chip,
 };
 
+static void gicv2m_teardown(void)
+{
+	struct v2m_data *v2m, *tmp;
+
+	list_for_each_entry_safe(v2m, tmp, &v2m_nodes, entry) {
+		list_del(&v2m->entry);
+		kfree(v2m->bm);
+		iounmap(v2m->base);
+		of_node_put(v2m->node);
+		kfree(v2m);
+	}
+}
+
+static int gicv2m_allocate_domains(struct irq_domain *parent)
+{
+	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
+	struct v2m_data *v2m;
+
+	v2m = list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
+	if (!v2m)
+		return 0;
+
+	inner_domain = irq_domain_add_tree(of_node_to_fwnode(v2m->node),
+					   &gicv2m_domain_ops, v2m);
+	if (!inner_domain) {
+		pr_err("Failed to create GICv2m domain\n");
+		return -ENOMEM;
+	}
+
+	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
+	inner_domain->parent = parent;
+	pci_domain = pci_msi_create_irq_domain(of_node_to_fwnode(v2m->node),
+					       &gicv2m_msi_domain_info,
+					       inner_domain);
+	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(v2m->node),
+						     &gicv2m_pmsi_domain_info,
+						     inner_domain);
+	if (!pci_domain || !plat_domain) {
+		pr_err("Failed to create MSI domains\n");
+		if (plat_domain)
+			irq_domain_remove(plat_domain);
+		if (pci_domain)
+			irq_domain_remove(pci_domain);
+		irq_domain_remove(inner_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int __init gicv2m_init_one(struct device_node *node,
 				  struct irq_domain *parent)
 {
 	int ret;
 	struct v2m_data *v2m;
-	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 
 	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
 	if (!v2m) {
@@ -252,6 +308,9 @@ static int __init gicv2m_init_one(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	INIT_LIST_HEAD(&v2m->entry);
+	v2m->node = node;
+
 	ret = of_address_to_resource(node, 0, &v2m->res);
 	if (ret) {
 		pr_err("Failed to allocate v2m resource.\n");
@@ -299,44 +358,13 @@ static int __init gicv2m_init_one(struct device_node *node,
 		goto err_iounmap;
 	}
 
-	inner_domain = irq_domain_add_tree(node, &gicv2m_domain_ops, v2m);
-	if (!inner_domain) {
-		pr_err("Failed to create GICv2m domain\n");
-		ret = -ENOMEM;
-		goto err_free_bm;
-	}
-
-	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
-	inner_domain->parent = parent;
-	pci_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
-					       &gicv2m_msi_domain_info,
-					       inner_domain);
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &gicv2m_pmsi_domain_info,
-						     inner_domain);
-	if (!pci_domain || !plat_domain) {
-		pr_err("Failed to create MSI domains\n");
-		ret = -ENOMEM;
-		goto err_free_domains;
-	}
-
-	spin_lock_init(&v2m->msi_cnt_lock);
-
+	list_add_tail(&v2m->entry, &v2m_nodes);
 	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
 		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
 		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
 
 	return 0;
 
-err_free_domains:
-	if (plat_domain)
-		irq_domain_remove(plat_domain);
-	if (pci_domain)
-		irq_domain_remove(pci_domain);
-	if (inner_domain)
-		irq_domain_remove(inner_domain);
-err_free_bm:
-	kfree(v2m->bm);
 err_iounmap:
 	iounmap(v2m->base);
 err_free_v2m:
@@ -366,5 +394,9 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
 		}
 	}
 
+	if (!ret)
+		ret = gicv2m_allocate_domains(parent);
+	if (ret)
+		gicv2m_teardown();
 	return ret;
 }
-- 
2.1.4
