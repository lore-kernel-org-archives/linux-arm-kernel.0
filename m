From: abhinav.k@samsung.com (Abhinav Kochhar)
Date: Tue, 08 Jan 2013 05:12:24 -0500
Subject: [Linaro-mm-sig][RFC] ARM: dma-mapping: Add DMA attribute to skip iommu
 mapping
Message-ID: <1357639944-12050-1-git-send-email-abhinav.k@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding a new dma attribute which can be used by the
platform drivers to avoid creating iommu mappings.
In some cases the buffers are allocated by display
controller driver using dma alloc apis but are not 
used for scanout. Though the buffers are allocated 
by display controller but are only used for sharing 
among different devices.
With this attribute the platform drivers can choose
not to create iommu mapping at the time of buffer
allocation and only create the mapping when they
access this buffer. 

Change-Id: I2178b3756170982d814e085ca62474d07b616a21
Signed-off-by: Abhinav Kochhar <abhinav.k@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    8 +++++---
 include/linux/dma-attrs.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c0f0f43..e73003c 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1279,9 +1279,11 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (!pages)
 		return NULL;
 
-	*handle = __iommu_create_mapping(dev, pages, size);
-	if (*handle == DMA_ERROR_CODE)
-		goto err_buffer;
+	if (!dma_get_attr(DMA_ATTR_NO_IOMMU_MAPPING, attrs)) {
+		*handle = __iommu_create_mapping(dev, pages, size);
+		if (*handle == DMA_ERROR_CODE)
+			goto err_buffer;
+	}
 
 	if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
 		return pages;
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index c8e1831..1f04419 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -15,6 +15,7 @@ enum dma_attr {
 	DMA_ATTR_WEAK_ORDERING,
 	DMA_ATTR_WRITE_COMBINE,
 	DMA_ATTR_NON_CONSISTENT,
+	DMA_ATTR_NO_IOMMU_MAPPING,
 	DMA_ATTR_NO_KERNEL_MAPPING,
 	DMA_ATTR_SKIP_CPU_SYNC,
 	DMA_ATTR_FORCE_CONTIGUOUS,
-- 
1.7.8.6
