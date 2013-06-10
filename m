From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Jun 2013 19:34:39 +0100
Subject: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
 protection attributes
In-Reply-To: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370889285-22799-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU mappings take a prot parameter, identifying the protection bits
to enforce on the newly created mapping (READ or WRITE). The ARM
dma-mapping framework currently just passes 0 as the prot argument,
resulting in faulting mappings.

This patch infers the protection attributes based on the direction of
the DMA transfer.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/dma-mapping.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6fb80cf..d119de7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1636,13 +1636,27 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 {
 	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
 	dma_addr_t dma_addr;
-	int ret, len = PAGE_ALIGN(size + offset);
+	int ret, prot, len = PAGE_ALIGN(size + offset);
 
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_ERROR_CODE)
 		return dma_addr;
 
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, 0);
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		prot = IOMMU_READ | IOMMU_WRITE;
+		break;
+	case DMA_TO_DEVICE:
+		prot = IOMMU_READ;
+		break;
+	case DMA_FROM_DEVICE:
+		prot = IOMMU_WRITE;
+		break;
+	default:
+		prot = 0;
+	}
+
+	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
 	if (ret < 0)
 		goto fail;
 
-- 
1.8.2.2
