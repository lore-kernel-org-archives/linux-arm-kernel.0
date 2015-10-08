From: dhdang@apm.com (Duc Dang)
Date: Thu,  8 Oct 2015 00:48:38 -0700
Subject: [PATCH RFC 1/1] irqchip/GICv2m: Add support for multiple v2m frames
Message-ID: <1444290518-18527-1-git-send-email-dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GICv2m driver currently only supports single v2m frame. This
patch extend this driver to support multiple v2m frames. All of
the v2m frames will be own by a single MSI domain. Each PCIe node
can specify msi-parent as the first frame of the v2m frame list
to be able to use all available v2m frames for MSI interrupts.

This patch should be applied on top of patch 
(irqchip/GICv2m: Add workaround for APM X-Gene GICv2m erratum):
https://lkml.org/lkml/2015/10/6/922

Signed-off-by: Duc Dang <dhdang@apm.com>
---
 drivers/irqchip/irq-gic-v2m.c | 221 ++++++++++++++++++++++++++++++------------
 1 file changed, 159 insertions(+), 62 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 4c17c18..8ecaf9e 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -51,13 +51,19 @@
 #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
 
 struct v2m_data {
-	spinlock_t msi_cnt_lock;
 	struct resource res;	/* GICv2m resource */
 	void __iomem *base;	/* GICv2m virt address */
 	u32 spi_start;		/* The SPI number that MSIs start */
 	u32 nr_spis;		/* The number of SPIs for MSIs */
-	unsigned long *bm;	/* MSI vector bitmap */
 	u32 flags;		/* v2m flags for specific implementation */
+	struct list_head list;  /* Link to other v2m frames */
+};
+
+struct gicv2m_ctrlr {
+	spinlock_t v2m_ctrlr_lock;      /* Lock for all v2m frames */
+	u32 nr_vecs;                    /* Total MSI vectors */
+	unsigned long *bm;              /* MSI vector bitmap */
+	struct list_head v2m_frms;      /* List of v2m frames */
 };
 
 static void gicv2m_mask_msi_irq(struct irq_data *d)
@@ -98,11 +104,29 @@ static int gicv2m_set_affinity(struct irq_data *irq_data,
 	return ret;
 }
 
+static struct v2m_data *irq_data_to_v2m_frm(struct irq_data *data,
+					    struct gicv2m_ctrlr *v2m_ctrlr)
+{
+	struct v2m_data *v2m;
+
+	list_for_each_entry(v2m, &v2m_ctrlr->v2m_frms, list) {
+		if ((data->hwirq >= v2m->spi_start) &&
+		    (data->hwirq < (v2m->spi_start + v2m->nr_spis)))
+			return v2m;
+	}
+
+	return NULL;
+}
+
 static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
-	phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
+	struct gicv2m_ctrlr *v2m_ctrlr = irq_data_get_irq_chip_data(data);
+	struct v2m_data *v2m;
+	phys_addr_t addr;
 
+	v2m = irq_data_to_v2m_frm(data, v2m_ctrlr);
+	WARN_ON(!v2m);
+	addr = v2m->res.start + V2M_MSI_SETSPI_NS;
 	msg->address_hi = (u32) (addr >> 32);
 	msg->address_lo = (u32) (addr);
 	msg->data = data->hwirq;
@@ -144,48 +168,85 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
-static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq)
+static int hwirq_to_bm_pos(struct gicv2m_ctrlr *v2m_ctrlr, unsigned int hwirq)
+{
+	struct v2m_data *v2m;
+	int pos = 0;
+
+	list_for_each_entry(v2m, &v2m_ctrlr->v2m_frms, list) {
+		if ((hwirq >= v2m->spi_start) &&
+		    (hwirq < (v2m->spi_start + v2m->nr_spis))) {
+			pos += hwirq - v2m->spi_start;
+			break;
+		}
+		pos += v2m->nr_spis;
+	}
+
+	return pos;
+}
+
+static void gicv2m_unalloc_msi(struct gicv2m_ctrlr *v2m_ctrlr,
+			       unsigned int hwirq)
 {
 	int pos;
 
-	pos = hwirq - v2m->spi_start;
-	if (pos < 0 || pos >= v2m->nr_spis) {
+	pos = hwirq_to_bm_pos(v2m_ctrlr, hwirq);
+	if (pos >= v2m_ctrlr->nr_vecs) {
 		pr_err("Failed to teardown msi. Invalid hwirq %d\n", hwirq);
 		return;
 	}
 
-	spin_lock(&v2m->msi_cnt_lock);
-	__clear_bit(pos, v2m->bm);
-	spin_unlock(&v2m->msi_cnt_lock);
+	spin_lock(&v2m_ctrlr->v2m_ctrlr_lock);
+	__clear_bit(pos, v2m_ctrlr->bm);
+	spin_unlock(&v2m_ctrlr->v2m_ctrlr_lock);
+}
+
+static int bm_pos_to_hwirq(struct gicv2m_ctrlr *v2m_ctrlr, int pos)
+{
+	struct v2m_data *v2m;
+	int hwirq = -1;
+	int offset = 0;
+
+	list_for_each_entry(v2m, &v2m_ctrlr->v2m_frms, list) {
+		if ((pos >= offset) && (pos < (offset + v2m->nr_spis))) {
+			hwirq = v2m->spi_start + pos - offset;
+			break;
+		}
+		offset += v2m->nr_spis;
+	}
+
+	return hwirq;
 }
 
 static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
-	struct v2m_data *v2m = domain->host_data;
-	int hwirq, offset, err = 0;
+	struct gicv2m_ctrlr *v2m_ctrlr = domain->host_data;
+	int hwirq, pos, err = 0;
 
-	spin_lock(&v2m->msi_cnt_lock);
-	offset = find_first_zero_bit(v2m->bm, v2m->nr_spis);
-	if (offset < v2m->nr_spis)
-		__set_bit(offset, v2m->bm);
+	spin_lock(&v2m_ctrlr->v2m_ctrlr_lock);
+	pos = find_first_zero_bit(v2m_ctrlr->bm, v2m_ctrlr->nr_vecs);
+	if (pos < v2m_ctrlr->nr_vecs)
+		__set_bit(pos, v2m_ctrlr->bm);
 	else
 		err = -ENOSPC;
-	spin_unlock(&v2m->msi_cnt_lock);
+	spin_unlock(&v2m_ctrlr->v2m_ctrlr_lock);
 
 	if (err)
 		return err;
 
-	hwirq = v2m->spi_start + offset;
+	hwirq = bm_pos_to_hwirq(v2m_ctrlr, pos);
+	if (WARN_ON(hwirq < 0))
+		return -EINVAL;
 
 	err = gicv2m_irq_gic_domain_alloc(domain, virq, hwirq);
 	if (err) {
-		gicv2m_unalloc_msi(v2m, hwirq);
+		gicv2m_unalloc_msi(v2m_ctrlr, hwirq);
 		return err;
 	}
 
 	irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-				      &gicv2m_irq_chip, v2m);
+				      &gicv2m_irq_chip, v2m_ctrlr);
 
 	return 0;
 }
@@ -194,10 +255,10 @@ static void gicv2m_irq_domain_free(struct irq_domain *domain,
 				   unsigned int virq, unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct v2m_data *v2m = irq_data_get_irq_chip_data(d);
+	struct gicv2m_ctrlr *v2m_ctrlr = irq_data_get_irq_chip_data(d);
 
 	BUG_ON(nr_irqs != 1);
-	gicv2m_unalloc_msi(v2m, d->hwirq);
+	gicv2m_unalloc_msi(v2m_ctrlr, d->hwirq);
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
@@ -236,11 +297,10 @@ static struct msi_domain_info gicv2m_pmsi_domain_info = {
 };
 
 static int __init gicv2m_init_one(struct device_node *node,
-				  struct irq_domain *parent)
+				  struct gicv2m_ctrlr  *gicv2m_ctrlr)
 {
 	int ret;
 	struct v2m_data *v2m;
-	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 
 	v2m = kzalloc(sizeof(struct v2m_data), GFP_KERNEL);
 	if (!v2m) {
@@ -248,6 +308,8 @@ static int __init gicv2m_init_one(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	INIT_LIST_HEAD(&v2m->list);
+
 	ret = of_address_to_resource(node, 0, &v2m->res);
 	if (ret) {
 		pr_err("Failed to allocate v2m resource.\n");
@@ -288,34 +350,10 @@ static int __init gicv2m_init_one(struct device_node *node,
 	if (readl_relaxed(v2m->base + V2M_MSI_IIDR) == XGENE_GICV2M_MSI_IIDR)
 		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
 
-	v2m->bm = kzalloc(sizeof(long) * BITS_TO_LONGS(v2m->nr_spis),
-			  GFP_KERNEL);
-	if (!v2m->bm) {
-		ret = -ENOMEM;
-		goto err_iounmap;
-	}
-
-	inner_domain = irq_domain_add_tree(node, &gicv2m_domain_ops, v2m);
-	if (!inner_domain) {
-		pr_err("Failed to create GICv2m domain\n");
-		ret = -ENOMEM;
-		goto err_free_bm;
-	}
-
-	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
-	inner_domain->parent = parent;
-	pci_domain = pci_msi_create_irq_domain(node, &gicv2m_msi_domain_info,
-					       inner_domain);
-	plat_domain = platform_msi_create_irq_domain(node,
-						     &gicv2m_pmsi_domain_info,
-						     inner_domain);
-	if (!pci_domain || !plat_domain) {
-		pr_err("Failed to create MSI domains\n");
-		ret = -ENOMEM;
-		goto err_free_domains;
-	}
-
-	spin_lock_init(&v2m->msi_cnt_lock);
+	/* Add v2m frame into GICv2m controller's frame list */
+	list_add_tail(&v2m->list, &gicv2m_ctrlr->v2m_frms);
+	/* Update total MSI vectors */
+	gicv2m_ctrlr->nr_vecs += v2m->nr_spis;
 
 	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
 		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
@@ -323,19 +361,11 @@ static int __init gicv2m_init_one(struct device_node *node,
 
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
 	kfree(v2m);
+
 	return ret;
 }
 
@@ -348,18 +378,85 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
 {
 	int ret = 0;
 	struct device_node *child;
+	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
+	struct gicv2m_ctrlr  *gicv2m_ctrlr;
+	struct device_node *first_v2m_node = NULL;
+
+	gicv2m_ctrlr = kzalloc(sizeof(struct gicv2m_ctrlr), GFP_KERNEL);
+	if (!gicv2m_ctrlr) {
+		pr_err("Failed to allocate struct gicv2m_ctrlr.\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&gicv2m_ctrlr->v2m_frms);
 
 	for (child = of_find_matching_node(node, gicv2m_device_id); child;
 	     child = of_find_matching_node(child, gicv2m_device_id)) {
 		if (!of_find_property(child, "msi-controller", NULL))
 			continue;
 
-		ret = gicv2m_init_one(child, parent);
+		ret = gicv2m_init_one(child, gicv2m_ctrlr);
 		if (ret) {
 			of_node_put(node);
 			break;
 		}
+		if (!first_v2m_node)
+			first_v2m_node = child;
+	}
+
+	/* Return if no v2m frame is found */
+	if (!first_v2m_node)
+		goto err_free_ctrlr;
+
+	/* Allocate bitmap for all MSI vectors on all frames */
+	gicv2m_ctrlr->bm = kzalloc(sizeof(long) *
+				   BITS_TO_LONGS(gicv2m_ctrlr->nr_vecs),
+				   GFP_KERNEL);
+	if (!gicv2m_ctrlr->bm) {
+		ret = -ENOMEM;
+		goto err_free_ctrlr;
+	}
+
+	inner_domain = irq_domain_add_tree(first_v2m_node, &gicv2m_domain_ops,
+					   gicv2m_ctrlr);
+	if (!inner_domain) {
+		pr_err("Failed to create GICv2m domain\n");
+		ret = -ENOMEM;
+		goto err_free_bm;
 	}
 
+	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
+	inner_domain->parent = parent;
+	pci_domain = pci_msi_create_irq_domain(first_v2m_node,
+					       &gicv2m_msi_domain_info,
+					       inner_domain);
+	plat_domain = platform_msi_create_irq_domain(first_v2m_node,
+						     &gicv2m_pmsi_domain_info,
+						     inner_domain);
+	if (!pci_domain || !plat_domain) {
+		pr_err("Failed to create MSI domains\n");
+		ret = -ENOMEM;
+		goto err_free_domains;
+	}
+
+	spin_lock_init(&gicv2m_ctrlr->v2m_ctrlr_lock);
+
+	pr_info("MSI IRQ domain created with %d vectors\n",
+		gicv2m_ctrlr->nr_vecs);
+
+	return 0;
+
+err_free_domains:
+	if (plat_domain)
+		irq_domain_remove(plat_domain);
+	if (pci_domain)
+		irq_domain_remove(pci_domain);
+	if (inner_domain)
+		irq_domain_remove(inner_domain);
+err_free_bm:
+	kfree(gicv2m_ctrlr->bm);
+err_free_ctrlr:
+	kfree(gicv2m_ctrlr);
+
 	return ret;
 }
-- 
1.9.1
