From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Sat, 15 Nov 2014 22:24:03 +0800
Subject: [Patch V2 5/9] PCI,
 MSI: Introduce helpers to hide struct msi_desc implementation details
In-Reply-To: <1416061447-9472-1-git-send-email-jiang.liu@linux.intel.com>
References: <1416061447-9472-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1416061447-9472-6-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce helpers to hide struct msi_desc implementation details,
so we could easily support non-PCI-compliant MSI devices later by
moving msi_list into struct device.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/msi.h |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 190c7abbec84..714716a3ffdd 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -44,6 +44,25 @@ struct msi_desc {
 	struct msi_msg msg;
 };
 
+/* Helpers to hide struct msi_desc implementation details */
+#define msi_desc_to_dev(desc)		(&(desc)->dev.dev)
+#define dev_to_msi_list(dev)		(&to_pci_dev((dev))->msi_list)
+#define first_msi_entry(dev)		\
+	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
+#define for_each_msi_entry(desc, dev)	\
+	list_for_each_entry((desc), dev_to_msi_list((dev)), list)
+
+#ifdef CONFIG_PCI_MSI
+#define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)
+#define for_each_pci_msi_entry(desc, pdev)	\
+	for_each_msi_entry((desc), &(pdev)->dev)
+
+static inline struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
+{
+	return desc->dev;
+}
+#endif /* CONFIG_PCI_MSI */
+
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
-- 
1.7.10.4
