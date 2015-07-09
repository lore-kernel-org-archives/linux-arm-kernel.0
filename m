From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Thu,  9 Jul 2015 16:00:45 +0800
Subject: [RFC Patch V1 10/12] genirq,
 PCI: Store 'struct device *' instead 'struct pci_dev *' in struct
 msi_desc
In-Reply-To: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1436428847-8886-11-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Store 'struct device *' instead 'struct pci_dev *' in struct msi_desc,
so struct msi_desc may be reused by generic MSI drivers.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/msi.c   |    7 ++++++-
 include/linux/msi.h |   11 ++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0050ad436718..260c1653701d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -413,7 +413,7 @@ static struct msi_desc *alloc_msi_entry(struct pci_dev *dev)
 		return NULL;
 
 	INIT_LIST_HEAD(&desc->list);
-	desc->dev = dev;
+	desc->dev = &dev->dev;
 
 	return desc;
 }
@@ -1140,6 +1140,11 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
+struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
+{
+	return to_pci_dev(desc->dev);
+}
+
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 57fe766a14bf..5f77e231f515 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -14,6 +14,7 @@ extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct irq_data;
 struct msi_desc;
+struct pci_dev;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 
@@ -37,14 +38,14 @@ struct msi_desc {
 		void __iomem *mask_base;
 		u8 mask_pos;
 	};
-	struct pci_dev *dev;
+	struct device *dev;
 
 	/* Last set MSI message */
 	struct msi_msg msg;
 };
 
 /* Helpers to hide struct msi_desc implementation details */
-#define msi_desc_to_dev(desc)		(&(desc)->dev.dev)
+#define msi_desc_to_dev(desc)		((desc)->dev)
 #define dev_to_msi_list(dev)		(&(dev)->msi_list)
 #define first_msi_entry(dev)		\
 	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
@@ -56,11 +57,7 @@ struct msi_desc {
 #define for_each_pci_msi_entry(desc, pdev)	\
 	for_each_msi_entry((desc), &(pdev)->dev)
 
-static inline struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
-{
-	return desc->dev;
-}
-
+struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
 #else /* CONFIG_PCI_MSI */
 static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
-- 
1.7.10.4
