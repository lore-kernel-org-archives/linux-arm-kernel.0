From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  7 Jul 2015 18:17:52 +0100
Subject: [PATCH v3 02/15] PCI: MSI: Register irq domain with specific token
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436289485-28230-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating a PCI/MSI domain, tag it with DOMAIN_BUS_PCI_MSI so
that it can be looked-up using irq_find_matching_host().

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/msi.c         | 8 +++++++-
 include/linux/irqdomain.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f66be86..1e55935 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1269,12 +1269,18 @@ struct irq_domain *pci_msi_create_irq_domain(struct device_node *node,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent)
 {
+	struct irq_domain *domain;
+
 	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
 		pci_msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
-	return msi_create_irq_domain(node, info, parent);
+	domain = msi_create_irq_domain(node, info, parent);
+	if (domain)
+		domain->bus_token = DOMAIN_BUS_PCI_MSI;
+
+	return domain;
 }
 
 /**
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 91a83ad..25e9e66 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -54,6 +54,7 @@ struct irq_data;
  */
 enum irq_domain_bus_token {
 	DOMAIN_BUS_ANY		= 0,
+	DOMAIN_BUS_PCI_MSI,
 };
 
 /**
-- 
2.1.4
