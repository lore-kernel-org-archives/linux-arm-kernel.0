From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 26 Feb 2016 17:36:02 +0900
Subject: [PATCH] ARM: dma-mapping: remove arm_dma_set_mask()
Message-ID: <1456475762-29511-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_dma_set_mask() implements exactly the same behavior as the fallback
that dma_set_mask() takes if the set_dma_mask op is not set. Remove it
and use that fallback instead like the dma_get_mask() counterpart
already does.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/include/asm/dma-mapping.h |  2 --
 arch/arm/mm/dma-mapping.c          | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 6ad1ceda62a5..0f2034d28885 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -162,8 +162,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 static inline void dma_mark_clean(void *addr, size_t size) { }
 
-extern int arm_dma_set_mask(struct device *dev, u64 dma_mask);
-
 /**
  * arm_dma_alloc - allocate consistent memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9f996a3d79f7..0525076cae38 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -141,7 +141,6 @@ struct dma_map_ops arm_dma_ops = {
 	.sync_single_for_device	= arm_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= arm_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_dma_sync_sg_for_device,
-	.set_dma_mask		= arm_dma_set_mask,
 };
 EXPORT_SYMBOL(arm_dma_ops);
 
@@ -160,7 +159,6 @@ struct dma_map_ops arm_coherent_dma_ops = {
 	.get_sgtable		= arm_dma_get_sgtable,
 	.map_page		= arm_coherent_dma_map_page,
 	.map_sg			= arm_dma_map_sg,
-	.set_dma_mask		= arm_dma_set_mask,
 };
 EXPORT_SYMBOL(arm_coherent_dma_ops);
 
@@ -1004,16 +1002,6 @@ int dma_supported(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_supported);
 
-int arm_dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
-	*dev->dma_mask = dma_mask;
-
-	return 0;
-}
-
 #define PREALLOC_DMA_DEBUG_ENTRIES	4096
 
 static int __init dma_debug_do_init(void)
@@ -1867,8 +1855,6 @@ struct dma_map_ops iommu_ops = {
 	.unmap_sg		= arm_iommu_unmap_sg,
 	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
-
-	.set_dma_mask		= arm_dma_set_mask,
 };
 
 struct dma_map_ops iommu_coherent_ops = {
@@ -1882,8 +1868,6 @@ struct dma_map_ops iommu_coherent_ops = {
 
 	.map_sg		= arm_coherent_iommu_map_sg,
 	.unmap_sg	= arm_coherent_iommu_unmap_sg,
-
-	.set_dma_mask	= arm_dma_set_mask,
 };
 
 /**
-- 
2.7.1
