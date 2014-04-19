From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 19 Apr 2014 10:32:48 -0400
Subject: [PATCH v2 3/7] of: introduce of_dma_is_coherent() helper
In-Reply-To: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1397917972-6293-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_dma_is_coherent() helper parses the given DT device
node to see if the "dma-coherent" property is supported and
returns true or false accordingly.

If the arch is always coherent or always noncoherent, then the default
DMA ops has to be specified accordingly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/of/platform.c       |   23 +++++++++++++++++++++++
 include/linux/of_platform.h |    7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 2265a55..573db15 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -570,4 +570,27 @@ out:
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
+bool of_dma_is_coherent(struct device_node *np)
+{
+	struct device_node *node = of_node_get(np);
+
+	while (node) {
+		if (of_property_read_bool(node, "dma-coherent")) {
+			of_node_put(node);
+			return true;
+		}
+		node = of_get_next_parent(node);
+	}
+	of_node_put(node);
+	return false;
+}
+EXPORT_SYMBOL_GPL(of_dma_is_coherent);
 #endif /* CONFIG_OF_ADDRESS */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index ba7d3dc..dc52931 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -74,6 +74,8 @@ extern int of_platform_populate(struct device_node *root,
 				struct device *parent);
 extern int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
 				phys_addr_t *paddr, phys_addr_t *size);
+extern bool of_dma_is_coherent(struct device_node *np);
+
 #else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
@@ -88,6 +90,11 @@ static inline int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
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
