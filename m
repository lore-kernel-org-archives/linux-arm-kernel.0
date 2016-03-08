From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Tue,  8 Mar 2016 03:42:48 +0100
Subject: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Map/Unmap a device resource from a physical address. If no dma_map_ops
method is available the operation is a no-op.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 include/linux/dma-mapping.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e3aba4e..cc305d1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -216,6 +216,38 @@ static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
+static inline dma_addr_t dma_map_resource(struct device *dev,
+					  phys_addr_t phys_addr,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	unsigned long pfn = __phys_to_pfn(phys_addr);
+
+	BUG_ON(!valid_dma_direction(dir));
+
+	/* Don't allow RAM to be mapped */
+	BUG_ON(pfn_valid(pfn));
+
+	if (ops->map_resource)
+		return ops->map_resource(dev, phys_addr, size, dir, attrs);
+
+	return phys_addr;
+}
+
+static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
+				      size_t size, enum dma_data_direction dir,
+				      struct dma_attrs *attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->unmap_resource)
+		ops->unmap_resource(dev, addr, size, dir, attrs);
+
+}
+
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 					   size_t size,
 					   enum dma_data_direction dir)
-- 
2.7.2
