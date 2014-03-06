From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 6 Mar 2014 17:19:54 +0800
Subject: [PATCH 3/7] of: introduce of_dma_is_coherent() helper
In-Reply-To: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>
References: <1394097598-17622-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1394097598-17622-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_dma_is_coherent() helper parses the given DT device
node to see if the "dma-coherent" property is supported and
returns true or false accordingly.

For the architectures which are fully dma coherent and don't need per device
property, it can enable CONFIG_ARCH_IS_DMA_COHERENT config option which
enables DMA coherent for all devices by default.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/of/platform.c       |   31 +++++++++++++++++++++++++++++++
 include/linux/of_platform.h |    6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 2265a55..bd080db 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -570,4 +570,35 @@ out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(of_dma_get_range);
+
+/**
+ * of_dma_is_coherent - Check if device is coherent
+ * @np:	device node
+ *
+ * It returns true if "dma-coherent" property was found
+ * for this device in DT.
+ */
+#ifndef CONFIG_ARCH_IS_DMA_COHERENT
+bool of_dma_is_coherent(struct device_node *np)
+{
+	struct device_node *node = np;
+
+	while (node) {
+		if (of_property_read_bool(node, "dma-coherent")) {
+			of_node_put(node);
+			return true;
+		}
+		node = of_get_next_parent(node);
+	}
+	return false;
+}
+EXPORT_SYMBOL_GPL(of_dma_is_coherent);
+#else
+inline bool of_dma_is_coherent(struct device_node *np)
+{
+	/* ARCH is fully dma coherent and don't need per device control */
+	return true;
+}
+EXPORT_SYMBOL_GPL(of_dma_is_coherent);
+#endif
 #endif /* CONFIG_OF_ADDRESS */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index ba7d3dc..48e0748 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -74,6 +74,7 @@ extern int of_platform_populate(struct device_node *root,
 				struct device *parent);
 extern int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
 				phys_addr_t *paddr, phys_addr_t *size);
+extern bool of_dma_is_coherent(struct device_node *np);
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
@@ -88,6 +89,11 @@ static inline int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
 {
 	return -ENODEV;
 }
+
+static inline bool of_dma_is_coherent(struct device_node *np)
+{
+	return false;
+}
 #endif
 
 #endif	/* _LINUX_OF_PLATFORM_H */
-- 
1.7.9.5
