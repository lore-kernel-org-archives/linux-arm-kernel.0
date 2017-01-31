From: nwatters@codeaurora.org (Nate Watterson)
Date: Tue, 31 Jan 2017 15:16:01 -0500
Subject: [PATCH 2/2] arm64/dma-mapping: validate dma_masks against IORT
 defined limits
In-Reply-To: <1485893763-20671-1-git-send-email-nwatters@codeaurora.org>
References: <1485893763-20671-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <1485893763-20671-2-git-send-email-nwatters@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers set the dma_mask of client devices based solely on values
read from capability registers which may not account for platform
specific bus address width limitations. Fortunately, the ACPI IORT table
provides a way to report the effective number of address bits a device
can use to access memory. This information, when present, is used to
supplement the checks already being done in dma_supported() to avoid
setting overly generous dma_masks.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 arch/arm64/mm/dma-mapping.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index e040827..467fd23 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -19,6 +19,7 @@
 
 #include <linux/gfp.h>
 #include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bootmem.h>
 #include <linux/cache.h>
 #include <linux/export.h>
@@ -347,6 +348,12 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 
 static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
+	int dma_limit;
+
+	dma_limit = iort_get_memory_address_limit(hwdev);
+	if (dma_limit >= 0 && DMA_BIT_MASK(dma_limit) < mask)
+		return 0;
+
 	if (swiotlb)
 		return swiotlb_dma_supported(hwdev, mask);
 	return 1;
@@ -784,6 +791,17 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	iommu_dma_unmap_sg(dev, sgl, nelems, dir, attrs);
 }
 
+static int __iommu_dma_supported(struct device *hwdev, u64 mask)
+{
+	int dma_limit;
+
+	dma_limit = iort_get_memory_address_limit(hwdev);
+	if (dma_limit >= 0 && DMA_BIT_MASK(dma_limit) < mask)
+		return 0;
+
+	return iommu_dma_supported(hwdev, mask);
+}
+
 static struct dma_map_ops iommu_dma_ops = {
 	.alloc = __iommu_alloc_attrs,
 	.free = __iommu_free_attrs,
@@ -799,7 +817,7 @@ static void __iommu_unmap_sg_attrs(struct device *dev,
 	.sync_sg_for_device = __iommu_sync_sg_for_device,
 	.map_resource = iommu_dma_map_resource,
 	.unmap_resource = iommu_dma_unmap_resource,
-	.dma_supported = iommu_dma_supported,
+	.dma_supported = __iommu_dma_supported,
 	.mapping_error = iommu_dma_mapping_error,
 };
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
