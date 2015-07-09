From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu,  9 Jul 2015 16:00:36 +0800
Subject: [RFC Patch V1 01/12] PCI: Add helper function
 msi_desc_to_pci_sysdata()
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1436428847-8886-2-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add helper function msi_desc_to_pci_sysdata() to retrieve sysdata from
an MSI descriptor. To avoid pulling include/linux/pci.h into
include/linux/msi.h, msi_desc_to_pci_sysdata() is implemented as a normal
function instead of an inline function.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/msi.c   |    8 ++++++++
 include/linux/msi.h |    7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f66be868ad21..7b4c20c9f9ca 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1137,6 +1137,14 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
+void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
+{
+	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
+
+	return dev->bus->sysdata;
+}
+EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
+
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
 /**
  * pci_msi_domain_write_msg - Helper to write MSI message to PCI config space
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8ac4a68ffae2..cfbd2afeaf64 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -60,6 +60,13 @@ static inline struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return desc->dev;
 }
+
+void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
+#else /* CONFIG_PCI_MSI */
+static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
+{
+	return NULL;
+}
 #endif /* CONFIG_PCI_MSI */
 
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-- 
1.7.10.4
