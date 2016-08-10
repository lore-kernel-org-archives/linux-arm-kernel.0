From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Wed, 10 Aug 2016 13:22:16 +0200
Subject: [PATCHv9 3/6] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160810112219.17964-4-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Map/Unmap a device MMIO resource from a physical address. If no dma_map_ops
method is available the operation is a no-op.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 Documentation/DMA-API.txt   | 22 +++++++++++++++++-----
 include/linux/dma-mapping.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 1d26eeb6..6b20128 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -277,14 +277,26 @@ and <size> parameters are provided to do partial page mapping, it is
 recommended that you never use these unless you really know what the
 cache width is.
 
+dma_addr_t
+dma_map_resource(struct device *dev, phys_addr_t phys_addr, size_t size,
+		 enum dma_data_direction dir, unsigned long attrs)
+
+void
+dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
+		   enum dma_data_direction dir, unsigned long attrs)
+
+API for mapping and unmapping for MMIO resources. All the notes and
+warnings for the other mapping APIs apply here. The API should only be
+used to map device MMIO resources, mapping of RAM is not permitted.
+
 int
 dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 
-In some circumstances dma_map_single() and dma_map_page() will fail to create
-a mapping. A driver can check for these errors by testing the returned
-DMA address with dma_mapping_error(). A non-zero return value means the mapping
-could not be created and the driver should take appropriate action (e.g.
-reduce current DMA mapping usage or delay and try again later).
+In some circumstances dma_map_single(), dma_map_page() and dma_map_resource()
+will fail to create a mapping. A driver can check for these errors by testing
+the returned DMA address with dma_mapping_error(). A non-zero return value
+means the mapping could not be created and the driver should take appropriate
+action (e.g. reduce current DMA mapping usage or delay and try again later).
 
 	int
 	dma_map_sg(struct device *dev, struct scatterlist *sg,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e3bd27f..9a07882 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -264,6 +264,42 @@ static inline void dma_unmap_page(struct device *dev, dma_addr_t addr,
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
+static inline dma_addr_t dma_map_resource(struct device *dev,
+					  phys_addr_t phys_addr,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  unsigned long attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	unsigned long pfn = __phys_to_pfn(phys_addr);
+	dma_addr_t addr;
+
+	BUG_ON(!valid_dma_direction(dir));
+
+	/* Don't allow RAM to be mapped */
+	BUG_ON(pfn_valid(pfn));
+
+	addr = phys_addr;
+	if (ops->map_resource)
+		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
+
+	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
+
+	return addr;
+}
+
+static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
+				      size_t size, enum dma_data_direction dir,
+				      unsigned long attrs)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (ops->unmap_resource)
+		ops->unmap_resource(dev, addr, size, dir, attrs);
+	debug_dma_unmap_resource(dev, addr, size, dir);
+}
+
 static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 					   size_t size,
 					   enum dma_data_direction dir)
-- 
2.9.2
