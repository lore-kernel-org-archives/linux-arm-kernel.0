From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 22 Sep 2015 20:06:01 +0100
Subject: [PATCH] arm/dma-mapping: Clarify arm_*_sync_sg_* usage
Message-ID: <e8d48fcd1f09604fcb21e3912979a001fdb5709a.1442948705.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The comments on the arm_iommu_sync_sg_* functions are misleading, and
do not hold up to scrutiny against the DMA API documentation. Since
cache maintenance is performed on the CPU addresses of the original
list, not the virtual DMA entries filled in by arm_iommu_map_sg,
passing in fewer than the original number of entries can only result
in the corresponding subset of the buffer being flushed/invalidated
while the rest is skipped, which is almost certainly not what the
caller desires.

Fix all the relevant comments to say the correct thing; no functional
difference for arm_dma_sync_sg*, as the current implementation of
arm_dma_map_sg always returns the same number of entries as passed in
if it succeeds.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mm/dma-mapping.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e626043..ea14f17 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -958,7 +958,7 @@ void arm_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
  * arm_dma_sync_sg_for_cpu
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
+ * @nents: number of buffers to map (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
 void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
@@ -977,7 +977,7 @@ void arm_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
  * arm_dma_sync_sg_for_device
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
  * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
+ * @nents: number of buffers to map (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
 void arm_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
@@ -1672,7 +1672,7 @@ void arm_iommu_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
  * arm_iommu_sync_sg_for_cpu
  * @dev: valid struct device pointer
  * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
+ * @nents: number of buffers to map (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
 void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
@@ -1690,7 +1690,7 @@ void arm_iommu_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
  * arm_iommu_sync_sg_for_device
  * @dev: valid struct device pointer
  * @sg: list of buffers
- * @nents: number of buffers to map (returned from dma_map_sg)
+ * @nents: number of buffers to map (same as was passed to dma_map_sg)
  * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  */
 void arm_iommu_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-- 
1.9.1
