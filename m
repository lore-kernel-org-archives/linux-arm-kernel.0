From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 22:34:27 +0100
Subject: [PATCH] pci: stub out some MSI functions
Message-ID: <1456436095-607394-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bug fix to the MSIx handling in vfio added references
to functions that may not be defined if MSI is disabled in the kernel,
resulting in this link error:

drivers/built-in.o: In function `vfio_msi_set_vector_signal':
:(.text+0x450808): undefined reference to `get_cached_msi_msg'
:(.text+0x45080c): undefined reference to `write_msi_msg'

When MSI is disabled, we should never get into this code path,
so by adding stub implementations we can avoid the link error
without causing any other changes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b8f02af096b1 ("vfio/pci: Restore MSIx message prior to enabling")
Link: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/294293.html
---
 include/linux/msi.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8b425c66305a..ae9a65cd6d43 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -17,7 +17,15 @@ struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+
+#ifdef CONFIG_PCI_MSI
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
+#else
+static inline void get_cached_msi_msg(unsigned int irq,
+				      struct msi_msg *msg)
+{
+}
+#endif
 
 typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
 				    struct msi_msg *msg);
@@ -125,7 +133,14 @@ struct msi_desc *alloc_msi_entry(struct device *dev);
 void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+
+#ifdef CONFIG_PCI_MSI
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
+#else
+static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
+{
+}
+#endif
 
 u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
 u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
-- 
2.7.0
