From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Tue, 13 Oct 2015 13:46:20 -0700
Subject: [PATCH 1/4] pci: msi: Add support to query MSI domain for pci device
In-Reply-To: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1444769183-12374-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1444769183-12374-2-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces an interface for irqchip to register a callback,
to provide a way to determine appropriate MSI domain for a pci device.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/msi.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/msi.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ddd59fe..2c87843 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1327,4 +1327,34 @@ struct irq_domain *pci_msi_create_default_irq_domain(struct fwnode_handle *fwnod
 
 	return domain;
 }
+
+static struct fwnode_handle *(*pci_msi_get_fwnode_cb)(struct device *dev);
+
+/**
+ * pci_msi_register_fwnode_provider - Register callback to retrieve fwnode
+ * @fn:		The interrupt domain to retrieve
+ *
+ * This should be called by irqchip driver, which is the parent of
+ * the MSI domain to provide callback interface to query fwnode.
+ */
+void
+pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *))
+{
+	pci_msi_get_fwnode_cb = fn;
+}
+
+/**
+ * pci_msi_get_fwnode - Query fwnode for MSI controller of the @dev
+ * @dev:	The device that we try to query MSI domain token for
+ *
+ * This is used to query MSI domain token when setting up MSI domain
+ * for a device. Returns fwnode_handle * if token found / NULL if not found
+ */
+struct fwnode_handle *pci_msi_get_fwnode(struct device *dev)
+{
+	if (pci_msi_get_fwnode_cb)
+		return pci_msi_get_fwnode_cb(dev);
+
+	return NULL;
+}
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 32a24b9..ceaebf6 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -3,6 +3,7 @@
 
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/fwnode.h>
 
 struct msi_msg {
 	u32	address_lo;	/* low 32 bits of msi message address */
@@ -294,6 +295,12 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
 					  struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
+
+void
+pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+
+struct fwnode_handle *pci_msi_get_fwnode(struct device *dev);
+
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
 
 #endif /* LINUX_MSI_H */
-- 
2.1.0
