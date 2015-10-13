From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 13 Oct 2015 13:46:22 -0700
Subject: [PATCH 3/4] gicv2m: Refactor to prepare for ACPI support
In-Reply-To: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1444769183-12374-4-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch refactors gicv2m_init_one() to prepare for ACPI support.
It also replaces the irq_domain_add_tree() w/ irq_domain_create_tree()
since we will need to pass the struct fwnode_handle, instead of
struct device_node, when adding ACPI support later.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic-v2m.c | 51 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index bf9b3c0..97d1bf4 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -239,8 +239,10 @@ static struct msi_domain_info gicv2m_pmsi_domain_info = {
 	.chip	= &gicv2m_pmsi_irq_chip,
 };
 
-static int __init gicv2m_init_one(struct device_node *node,
-				  struct irq_domain *parent)
+static int __init gicv2m_init_one(struct irq_domain *parent,
+				  u32 spi_start, u32 nr_spis,
+				  struct resource *res,
+				  struct fwnode_handle *fwnode)
 {
 	int ret;
 	struct v2m_data *v2m;
@@ -252,23 +254,17 @@ static int __init gicv2m_init_one(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	ret = of_address_to_resource(node, 0, &v2m->res);
-	if (ret) {
-		pr_err("Failed to allocate v2m resource.\n");
-		goto err_free_v2m;
-	}
-
-	v2m->base = ioremap(v2m->res.start, resource_size(&v2m->res));
+	v2m->base = ioremap(res->start, resource_size(res));
 	if (!v2m->base) {
 		pr_err("Failed to map GICv2m resource\n");
 		ret = -ENOMEM;
 		goto err_free_v2m;
 	}
+	memcpy(&v2m->res, res, sizeof(struct resource));
 
-	if (!of_property_read_u32(node, "arm,msi-base-spi", &v2m->spi_start) &&
-	    !of_property_read_u32(node, "arm,msi-num-spis", &v2m->nr_spis)) {
-		pr_info("Overriding V2M MSI_TYPER (base:%u, num:%u)\n",
-			v2m->spi_start, v2m->nr_spis);
+	if (spi_start && nr_spis) {
+		v2m->spi_start = spi_start;
+		v2m->nr_spis = nr_spis;
 	} else {
 		u32 typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
 
@@ -299,7 +295,7 @@ static int __init gicv2m_init_one(struct device_node *node,
 		goto err_iounmap;
 	}
 
-	inner_domain = irq_domain_add_tree(node, &gicv2m_domain_ops, v2m);
+	inner_domain = irq_domain_create_tree(fwnode, &gicv2m_domain_ops, v2m);
 	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		ret = -ENOMEM;
@@ -308,10 +304,10 @@ static int __init gicv2m_init_one(struct device_node *node,
 
 	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
 	inner_domain->parent = parent;
-	pci_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	pci_domain = pci_msi_create_irq_domain(fwnode,
 					       &gicv2m_msi_domain_info,
 					       inner_domain);
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
+	plat_domain = platform_msi_create_irq_domain(fwnode,
 						     &gicv2m_pmsi_domain_info,
 						     inner_domain);
 	if (!pci_domain || !plat_domain) {
@@ -322,10 +318,9 @@ static int __init gicv2m_init_one(struct device_node *node,
 
 	spin_lock_init(&v2m->msi_cnt_lock);
 
-	pr_info("Node %s: range[%#lx:%#lx], SPI[%d:%d]\n", node->name,
-		(unsigned long)v2m->res.start, (unsigned long)v2m->res.end,
+	pr_info("range[%#lx:%#lx], SPI[%d:%d]\n",
+		(unsigned long)res->start, (unsigned long)res->end,
 		v2m->spi_start, (v2m->spi_start + v2m->nr_spis));
-
 	return 0;
 
 err_free_domains:
@@ -356,10 +351,26 @@ int __init gicv2m_of_init(struct device_node *node, struct irq_domain *parent)
 
 	for (child = of_find_matching_node(node, gicv2m_device_id); child;
 	     child = of_find_matching_node(child, gicv2m_device_id)) {
+		u32 spi_start = 0, nr_spis = 0;
+		struct resource res;
+
 		if (!of_find_property(child, "msi-controller", NULL))
 			continue;
 
-		ret = gicv2m_init_one(child, parent);
+		ret = of_address_to_resource(child, 0, &res);
+		if (ret) {
+			pr_err("Failed to allocate v2m resource.\n");
+			break;
+		}
+
+		if (!of_property_read_u32(child, "arm,msi-base-spi",
+					  &spi_start) &&
+		    !of_property_read_u32(child, "arm,msi-num-spis", &nr_spis))
+			pr_info("Overriding V2M MSI_TYPER (base:%u, num:%u)\n",
+				spi_start, nr_spis);
+
+		ret = gicv2m_init_one(parent, spi_start, nr_spis, &res,
+				      &child->fwnode);
 		if (ret) {
 			of_node_put(node);
 			break;
-- 
2.1.0
