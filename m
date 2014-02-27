From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 27 Feb 2014 16:17:49 -0500
Subject: [PATCH v2 4/7] dma: of: introduce of_dma_is_coherent() helper
In-Reply-To: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393535872-20915-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_dma_is_coherent() helper parses the given DT device
node to see if the "dma-coherent" property is supported and
returns true or false accordingly.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/dma/of-dma.c   |   22 ++++++++++++++++++++++
 include/linux/of_dma.h |    5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 9b51768..c5958d1 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -304,3 +304,25 @@ out:
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
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
index f04171a..6191f02 100644
--- a/include/linux/of_dma.h
+++ b/include/linux/of_dma.h
@@ -44,6 +44,7 @@ extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 
 extern int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
 		phys_addr_t *paddr, phys_addr_t *size);
+extern bool of_dma_is_coherent(struct device_node *np);
 #else
 static inline int of_dma_controller_register(struct device_node *np,
 		struct dma_chan *(*of_dma_xlate)
@@ -74,6 +75,10 @@ static inline int of_dma_get_range(struct device_node *np, dma_addr_t *dma_addr,
 {
 	return -ENODEV;
 }
+static inline bool of_dma_is_coherent(struct device_node *np)
+{
+	return false;
+}
 #endif
 
 #endif /* __LINUX_OF_DMA_H */
-- 
1.7.9.5
