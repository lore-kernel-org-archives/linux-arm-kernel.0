From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 14 Aug 2018 14:04:18 +0100
Subject: [PATCH 3/3] arm64/dma-mapping: Mildly optimise non-coherent IOMMU ops
In-Reply-To: <cover.1534250425.git.robin.murphy@arm.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
Message-ID: <52b017ead032f90e5f2b70b87747a49eb86209c8.1534250425.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst the symmetry of deferring to the existing sync callback in
__iommu_map_page() is nice, taking a round-trip through
iommu_iova_to_phys() is a pretty heavyweight way to get an address we
can trivially compute from the page we already have. Tweaking it to just
perform the cache maintenance directly when appropriate doesn't really
make the code any more complicated, and the runtime efficiency gain can
only be a benefit.

Furthermore, the sync operations themselves know they can only be
invoked on a managed DMA ops domain, so can use the fast specific domain
lookup to avoid excessive manipulation of the group refcount
(particularly in the scatterlist cases).

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/mm/dma-mapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 61e93f0b5482..5d4144093c20 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -712,7 +712,7 @@ static void __iommu_sync_single_for_cpu(struct device *dev,
 	if (is_device_dma_coherent(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dev_addr);
 	__dma_unmap_area(phys_to_virt(phys), size, dir);
 }
 
@@ -725,7 +725,7 @@ static void __iommu_sync_single_for_device(struct device *dev,
 	if (is_device_dma_coherent(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_domain_for_dev(dev), dev_addr);
+	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dev_addr);
 	__dma_map_area(phys_to_virt(phys), size, dir);
 }
 
@@ -738,9 +738,9 @@ static dma_addr_t __iommu_map_page(struct device *dev, struct page *page,
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dev_addr = iommu_dma_map_page(dev, page, offset, size, prot);
 
-	if (!iommu_dma_mapping_error(dev, dev_addr) &&
-	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__iommu_sync_single_for_device(dev, dev_addr, size, dir);
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    !iommu_dma_mapping_error(dev, dev_addr))
+		__dma_map_area(page_address(page), size, dir);
 
 	return dev_addr;
 }
-- 
2.17.1.dirty
