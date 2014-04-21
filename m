From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 Apr 2014 14:03:10 -0400
Subject: [PATCH] ARM: mm: dma: Update coherent streaming apis with missing
 memory barrier
Message-ID: <1398103390-31968-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM coherent CPU dma map APIS are assumed to be nops on cache coherent
machines. While this is true, one still needs to ensure that no
outstanding writes are pending in CPU write buffers. To take care
of that, we at least need a memory barrier to commit those changes
to main memory.

Patch is trying to fix those cases. Without such a patch, you will
end up patching device drivers to avoid the synchronisation issues.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mm/dma-mapping.c |   57 ++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5260f43..7c9f55d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -83,6 +83,8 @@ static dma_addr_t arm_coherent_dma_map_page(struct device *dev, struct page *pag
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     struct dma_attrs *attrs)
 {
+	/* Drain cpu write buffer to main memory */
+	wmb();
 	return pfn_to_dma(dev, page_to_pfn(page)) + offset;
 }
 
@@ -117,6 +119,13 @@ static void arm_dma_sync_single_for_cpu(struct device *dev,
 	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
+static void arm_coherent_dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	/* Drain cpu write buffer to main memory */
+	wmb();
+}
+
 static void arm_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
@@ -125,6 +134,33 @@ static void arm_dma_sync_single_for_device(struct device *dev,
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
+/**
+ * arm_dma_sync_sg_for_cpu
+ * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
+ * @sg: list of buffers
+ * @nents: number of buffers to map (returned from dma_map_sg)
+ * @dir: DMA transfer direction (same as was passed to dma_map_sg)
+ */
+void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+			int nents, enum dma_data_direction dir)
+{
+	struct dma_map_ops *ops = get_dma_ops(dev);
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		ops->sync_single_for_cpu(dev, sg_dma_address(s), s->length,
+					 dir);
+}
+
+void arm_coherent_dma_sync_sg_for_cpu(struct device *dev,
+			struct scatterlist *sg,
+			int nents, enum dma_data_direction dir)
+{
+	/* Drain cpu write buffer to main memory */
+	wmb();
+}
+
 struct dma_map_ops arm_dma_ops = {
 	.alloc			= arm_dma_alloc,
 	.free			= arm_dma_free,
@@ -154,6 +190,8 @@ struct dma_map_ops arm_coherent_dma_ops = {
 	.get_sgtable		= arm_dma_get_sgtable,
 	.map_page		= arm_coherent_dma_map_page,
 	.map_sg			= arm_dma_map_sg,
+	.sync_single_for_cpu	= arm_coherent_dma_sync_single_for_cpu,
+	.sync_sg_for_cpu	= arm_coherent_dma_sync_sg_for_cpu,
 	.set_dma_mask		= arm_dma_set_mask,
 };
 EXPORT_SYMBOL(arm_coherent_dma_ops);
@@ -994,25 +1032,6 @@ void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 }
 
 /**
- * arm_dma_sync_sg_for_cpu
- * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
- * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- */
-void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-			int nents, enum dma_data_direction dir)
-{
-	struct dma_map_ops *ops = get_dma_ops(dev);
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i)
-		ops->sync_single_for_cpu(dev, sg_dma_address(s), s->length,
-					 dir);
-}
-
-/**
  * arm_dma_sync_sg_for_device
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
-- 
1.7.9.5
