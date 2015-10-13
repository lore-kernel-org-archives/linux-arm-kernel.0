From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Oct 2015 12:51:44 +0100
Subject: [PATCH v2 16/17] irqdomain/msi: Use fwnode instead of of_node
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444737105-31573-17-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we continue to push of_node towards the outskirts of irq domains,
let's start tackling the case of msi_create_irq_domain and its little
friends.

This has limited impact in both PCI/MSI, platform MSI, and a few
drivers.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/base/platform-msi.c                   |  6 +++---
 drivers/irqchip/irq-gic-v2m.c                 |  5 +++--
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      |  3 ++-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
 drivers/pci/host/pci-xgene-msi.c              |  2 +-
 drivers/pci/msi.c                             | 14 +++++++-------
 include/linux/msi.h                           |  9 +++++----
 kernel/irq/msi.c                              |  8 ++++----
 8 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 134483d..5df4575 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -152,7 +152,7 @@ static int platform_msi_alloc_descs(struct device *dev, int nvec,
 
 /**
  * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
- * @np:		Optional device-tree node of the interrupt controller
+ * @fwnode:		Optional fwnode of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
  *
@@ -162,7 +162,7 @@ static int platform_msi_alloc_descs(struct device *dev, int nvec,
  * Returns:
  * A domain pointer or NULL in case of failure.
  */
-struct irq_domain *platform_msi_create_irq_domain(struct device_node *np,
+struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 						  struct msi_domain_info *info,
 						  struct irq_domain *parent)
 {
@@ -173,7 +173,7 @@ struct irq_domain *platform_msi_create_irq_domain(struct device_node *np,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		platform_msi_update_chip_ops(info);
 
-	domain = msi_create_irq_domain(np, info, parent);
+	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (domain)
 		domain->bus_token = DOMAIN_BUS_PLATFORM_MSI;
 
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 3b88e17..bf9b3c0 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -308,9 +308,10 @@ static int __init gicv2m_init_one(struct device_node *node,
 
 	inner_domain->bus_token = DOMAIN_BUS_NEXUS;
 	inner_domain->parent = parent;
-	pci_domain = pci_msi_create_irq_domain(node, &gicv2m_msi_domain_info,
+	pci_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+					       &gicv2m_msi_domain_info,
 					       inner_domain);
-	plat_domain = platform_msi_create_irq_domain(node,
+	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
 						     &gicv2m_pmsi_domain_info,
 						     inner_domain);
 	if (!pci_domain || !plat_domain) {
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index a7c8c9f..693c2f9 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -125,7 +125,8 @@ static int __init its_pci_msi_init(void)
 			continue;
 		}
 
-		if (!pci_msi_create_irq_domain(np, &its_pci_msi_domain_info,
+		if (!pci_msi_create_irq_domain(of_node_to_fwnode(np),
+					       &its_pci_msi_domain_info,
 					       parent)) {
 			pr_err("%s: unable to create PCI domain\n",
 			       np->full_name);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index a865505..960a816 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -78,7 +78,8 @@ static int __init its_pmsi_init(void)
 			continue;
 		}
 
-		if (!platform_msi_create_irq_domain(np, &its_pmsi_domain_info,
+		if (!platform_msi_create_irq_domain(of_node_to_fwnode(np),
+						    &its_pmsi_domain_info,
 						    parent)) {
 			pr_err("%s: unable to create platform domain\n",
 			       np->full_name);
diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index e491681..a6456b5 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -256,7 +256,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
-	msi->msi_domain = pci_msi_create_irq_domain(msi->node,
+	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
 						    &xgene_msi_domain_info,
 						    msi->inner_domain);
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d449714..ddd59fe 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1246,8 +1246,8 @@ static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
 }
 
 /**
- * pci_msi_create_irq_domain - Creat a MSI interrupt domain
- * @node:	Optional device-tree node of the interrupt controller
+ * pci_msi_create_irq_domain - Create a MSI interrupt domain
+ * @fwnode:	Optional fwnode of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
  *
@@ -1256,7 +1256,7 @@ static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
  * Returns:
  * A domain pointer or NULL in case of failure.
  */
-struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
+struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent)
 {
@@ -1267,7 +1267,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	domain = msi_create_irq_domain(node, info, parent);
+	domain = msi_create_irq_domain(fwnode, info, parent);
 	if (!domain)
 		return NULL;
 
@@ -1303,14 +1303,14 @@ void pci_msi_domain_free_irqs(struct irq_domain *domain, struct pci_dev *dev)
 
 /**
  * pci_msi_create_default_irq_domain - Create a default MSI interrupt domain
- * @node:	Optional device-tree node of the interrupt controller
+ * @fwnode:	Optional fwnode of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
  *
  * Returns: A domain pointer or NULL in case of failure. If successful
  * the default PCI/MSI irqdomain pointer is updated.
  */
-struct irq_domain *pci_msi_create_default_irq_domain(struct device_node *node,
+struct irq_domain *pci_msi_create_default_irq_domain(struct fwnode_handle *fwnode,
 		struct msi_domain_info *info, struct irq_domain *parent)
 {
 	struct irq_domain *domain;
@@ -1320,7 +1320,7 @@ struct irq_domain *pci_msi_create_default_irq_domain(struct device_node *node,
 		pr_err("PCI: default irq domain for PCI MSI has already been created.\n");
 		domain = NULL;
 	} else {
-		domain = pci_msi_create_irq_domain(node, info, parent);
+		domain = pci_msi_create_irq_domain(fwnode, info, parent);
 		pci_msi_default_domain = domain;
 	}
 	mutex_unlock(&pci_msi_domain_lock);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index ad939d0..32a24b9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -174,6 +174,7 @@ struct msi_controller {
 struct irq_domain;
 struct irq_chip;
 struct device_node;
+struct fwnode_handle;
 struct msi_domain_info;
 
 /**
@@ -262,7 +263,7 @@ enum {
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			    bool force);
 
-struct irq_domain *msi_create_irq_domain(struct device_node *of_node,
+struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
@@ -270,7 +271,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
-struct irq_domain *platform_msi_create_irq_domain(struct device_node *np,
+struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 						  struct msi_domain_info *info,
 						  struct irq_domain *parent);
 int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
@@ -280,13 +281,13 @@ void platform_msi_domain_free_irqs(struct device *dev);
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
-struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
+struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
 int pci_msi_domain_alloc_irqs(struct irq_domain *domain, struct pci_dev *dev,
 			      int nvec, int type);
 void pci_msi_domain_free_irqs(struct irq_domain *domain, struct pci_dev *dev);
-struct irq_domain *pci_msi_create_default_irq_domain(struct device_node *node,
+struct irq_domain *pci_msi_create_default_irq_domain(struct fwnode_handle *fwnode,
 		 struct msi_domain_info *info, struct irq_domain *parent);
 
 irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7e6512b..95354bb 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -239,11 +239,11 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 
 /**
  * msi_create_irq_domain - Create a MSI interrupt domain
- * @of_node:	Optional device-tree node of the interrupt controller
+ * @fwnode:	Optional fwnode of the interrupt controller
  * @info:	MSI domain info
  * @parent:	Parent irq domain
  */
-struct irq_domain *msi_create_irq_domain(struct device_node *node,
+struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent)
 {
@@ -252,8 +252,8 @@ struct irq_domain *msi_create_irq_domain(struct device_node *node,
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		msi_domain_update_chip_ops(info);
 
-	return irq_domain_add_hierarchy(parent, 0, 0, node, &msi_domain_ops,
-					info);
+	return irq_domain_create_hierarchy(parent, 0, 0, fwnode,
+					   &msi_domain_ops, info);
 }
 
 /**
-- 
2.1.4
