From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 28 Apr 2015 11:08:09 +0200
Subject: [PATCH] arm: dma-mapping: fix off-by-one check in
 arm_setup_iommu_dma_ops
Message-ID: <1430212089-5418-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 22b3c181c6c324a46f71aae806d8ddbe61d25761 ("arm: dma-mapping: limit
IOMMU mapping size") added a check for IO address space size. However
this patch broke IOMMU initialization for typical platforms initialized
from device tree, which get the default IO address space size of 4GiB.
This value doesn't fit into size_t and fails a check introduced by that
commit resulting in failed dma-mapping/iommu initialization. This patch
fixes this issue by adding proper support for full 4GiB address space
size.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/include/asm/dma-iommu.h | 2 +-
 arch/arm/mm/dma-mapping.c        | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 8e3fcb924db6..2ef282f96651 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -25,7 +25,7 @@ struct dma_iommu_mapping {
 };
 
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size);
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 09c5fe3d30c2..b43b762eebc1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1878,7 +1878,7 @@ struct dma_map_ops iommu_coherent_ops = {
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 size)
 {
 	unsigned int bits = size >> PAGE_SHIFT;
 	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
@@ -2057,11 +2057,8 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	if (!iommu)
 		return false;
 
-	/*
-	 * currently arm_iommu_create_mapping() takes a max of size_t
-	 * for size param. So check this limit for now.
-	 */
-	if (size > SIZE_MAX)
+	/* Only 32-bit DMA address space is supported for now */
+	if (size > DMA_BIT_MASK(32) + 1)
 		return false;
 
 	mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
-- 
1.9.2
