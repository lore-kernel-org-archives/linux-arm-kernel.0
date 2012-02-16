From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 16 Feb 2012 02:09:14 -0700
Subject: [PATCH v5 13/27] of/address: add empty static inlines for !CONFIG_OF
In-Reply-To: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
Message-ID: <1329383368-12122-14-git-send-email-grant.likely@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the title says, this patch adds empty implementations for the address
translation functions so that they can be used when CONFIG_OF is disabled.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/of_address.h |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 3118623..01b925a 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -4,6 +4,7 @@
 #include <linux/errno.h>
 #include <linux/of.h>
 
+#ifdef CONFIG_OF_ADDRESS
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
@@ -25,12 +26,37 @@ static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 #define pci_address_to_pio pci_address_to_pio
 #endif
 
-#ifdef CONFIG_PCI
+#else /* CONFIG_OF_ADDRESS */
+static inline int of_address_to_resource(struct device_node *dev, int index,
+					 struct resource *r)
+{
+	return -EINVAL;
+}
+static inline struct device_node *of_find_matching_node_by_address(
+					struct device_node *from,
+					const struct of_device_id *matches,
+					u64 base_address)
+{
+	return NULL;
+}
+static inline void __iomem *of_iomap(struct device_node *device, int index)
+{
+	return NULL;
+}
+static inline const u32 *of_get_address(struct device_node *dev, int index,
+					u64 *size, unsigned int *flags)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF_ADDRESS */
+
+
+#if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
 extern const __be32 *of_get_pci_address(struct device_node *dev, int bar_no,
 			       u64 *size, unsigned int *flags);
 extern int of_pci_address_to_resource(struct device_node *dev, int bar,
 				      struct resource *r);
-#else /* CONFIG_PCI */
+#else /* CONFIG_OF_ADDRESS && CONFIG_PCI */
 static inline int of_pci_address_to_resource(struct device_node *dev, int bar,
 				             struct resource *r)
 {
@@ -42,8 +68,7 @@ static inline const __be32 *of_get_pci_address(struct device_node *dev,
 {
 	return NULL;
 }
-#endif /* CONFIG_PCI */
-
+#endif /* CONFIG_OF_ADDRESS && CONFIG_PCI */
 
 #endif /* __OF_ADDRESS_H */
 
-- 
1.7.9
