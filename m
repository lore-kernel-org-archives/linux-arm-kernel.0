From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 28 Jun 2017 10:16:58 +0100
Subject: [PATCH 2/2] fixup: ARM: NOMMU: Introduce dma operations for noMMU
In-Reply-To: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
References: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1498641418-3554-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_common_mmap() is already available for NOMMU, so there is no point
to carry own version. Moreover, existent implementation relies on
dma-noop provides mmap, but it is not true anymore.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/dma-mapping-nommu.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 6adc02f..90ee354 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -71,23 +71,6 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 	return;
 }
 
-static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      unsigned long attrs)
-{
-	const struct dma_map_ops *ops = &dma_noop_ops;
-	int ret;
-
-	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-
-	WARN_ON_ONCE(1);
-	return -ENXIO;
-}
-
 static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
 				  enum dma_data_direction dir)
 {
@@ -190,7 +173,6 @@ static void arm_nommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist
 const struct dma_map_ops arm_nommu_dma_ops = {
 	.alloc			= arm_nommu_dma_alloc,
 	.free			= arm_nommu_dma_free,
-	.mmap			= arm_nommu_dma_mmap,
 	.map_page		= arm_nommu_dma_map_page,
 	.unmap_page		= arm_nommu_dma_unmap_page,
 	.map_sg			= arm_nommu_dma_map_sg,
-- 
2.0.0
