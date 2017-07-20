From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 20 Jul 2017 11:19:59 +0100
Subject: [PATCH 2/2] ARM: NOMMU: Wire-up default DMA interface
In-Reply-To: <1500545999-17177-1-git-send-email-vladimir.murzin@arm.com>
References: <1500545999-17177-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1500545999-17177-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way how default DMA pool is exposed has changed and now we need to
use dedicated interface to work with it. This patch makes alloc/release
operations to use such interface. Since, default DMA pool is not
handled by generic code anymore we have to implement our own mmap
operation.

Tested-by: Andras Szemzo <sza@esh.hu>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/dma-mapping-nommu.c | 45 ++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 90ee354..6db5fc2 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -40,9 +40,21 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 
 {
 	const struct dma_map_ops *ops = &dma_noop_ops;
+	void *ret;
 
 	/*
-	 * We are here because:
+	 * Try generic allocator first if we are advertised that
+	 * consistency is not required.
+	 */
+
+	if (attrs & DMA_ATTR_NON_CONSISTENT)
+		return ops->alloc(dev, size, dma_handle, gfp, attrs);
+
+	ret = dma_alloc_from_global_coherent(size, dma_handle);
+
+	/*
+	 * dma_alloc_from_global_coherent() may fail because:
+	 *
 	 * - no consistent DMA region has been defined, so we can't
 	 *   continue.
 	 * - there is no space left in consistent DMA region, so we
@@ -50,11 +62,8 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 	 *   advertised that consistency is not required.
 	 */
 
-	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		return ops->alloc(dev, size, dma_handle, gfp, attrs);
-
-	WARN_ON_ONCE(1);
-	return NULL;
+	WARN_ON_ONCE(ret == NULL);
+	return ret;
 }
 
 static void arm_nommu_dma_free(struct device *dev, size_t size,
@@ -63,14 +72,31 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 {
 	const struct dma_map_ops *ops = &dma_noop_ops;
 
-	if (attrs & DMA_ATTR_NON_CONSISTENT)
+	if (attrs & DMA_ATTR_NON_CONSISTENT) {
 		ops->free(dev, size, cpu_addr, dma_addr, attrs);
-	else
-		WARN_ON_ONCE(1);
+	} else {
+		int ret = dma_release_from_global_coherent(get_order(size),
+							   cpu_addr);
+
+		WARN_ON_ONCE(ret == 0);
+	}
 
 	return;
 }
 
+static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
+			      unsigned long attrs)
+{
+	int ret;
+
+	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
+		return ret;
+
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+
+
 static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
 				  enum dma_data_direction dir)
 {
@@ -173,6 +199,7 @@ static void arm_nommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist
 const struct dma_map_ops arm_nommu_dma_ops = {
 	.alloc			= arm_nommu_dma_alloc,
 	.free			= arm_nommu_dma_free,
+	.mmap			= arm_nommu_dma_mmap,
 	.map_page		= arm_nommu_dma_map_page,
 	.unmap_page		= arm_nommu_dma_unmap_page,
 	.map_sg			= arm_nommu_dma_map_sg,
-- 
2.0.0
