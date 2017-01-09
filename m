From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  9 Jan 2017 13:45:52 +0000
Subject: [PATCH v7 01/19] iommu/dma: Implement PCI allocation optimisation
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483969570-3154-2-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <robin.murphy@arm.com>

Whilst PCI devices may have 64-bit DMA masks, they still benefit from
using 32-bit addresses wherever possible in order to avoid DAC (PCI) or
longer address packets (PCIe), which may incur a performance overhead.
Implement the same optimisation as other allocators by trying to get a
32-bit address first, only falling back to the full mask if that fails.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2db0d64..a59ca47 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -204,19 +204,28 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
 }
 
 static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
-		dma_addr_t dma_limit)
+		dma_addr_t dma_limit, struct device *dev)
 {
 	struct iova_domain *iovad = cookie_iovad(domain);
 	unsigned long shift = iova_shift(iovad);
 	unsigned long length = iova_align(iovad, size) >> shift;
+	struct iova *iova = NULL;
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
+
+	/* Try to get PCI devices a SAC address */
+	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
+		iova = alloc_iova(iovad, length, DMA_BIT_MASK(32) >> shift,
+				  true);
 	/*
 	 * Enforce size-alignment to be safe - there could perhaps be an
 	 * attribute to control this per-device, or at least per-domain...
 	 */
-	return alloc_iova(iovad, length, dma_limit >> shift, true);
+	if (!iova)
+		iova = alloc_iova(iovad, length, dma_limit >> shift, true);
+
+	return iova;
 }
 
 /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
@@ -369,7 +378,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
-	iova = __alloc_iova(domain, size, dev->coherent_dma_mask);
+	iova = __alloc_iova(domain, size, dev->coherent_dma_mask, dev);
 	if (!iova)
 		goto out_free_pages;
 
@@ -440,7 +449,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	struct iova_domain *iovad = cookie_iovad(domain);
 	size_t iova_off = iova_offset(iovad, phys);
 	size_t len = iova_align(iovad, size + iova_off);
-	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev));
+	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev), dev);
 
 	if (!iova)
 		return DMA_ERROR_CODE;
@@ -598,7 +607,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev));
+	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_restore_sg;
 
@@ -675,7 +684,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = __alloc_iova(domain, iovad->granule, dma_get_mask(dev));
+	iova = __alloc_iova(domain, iovad->granule, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_free_page;
 
-- 
1.9.1
