From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 21 Jun 2012 12:50:44 +0200
Subject: [PATCH] ARM: dma-mapping: fix buffer chunk allocation order
Message-ID: <1340275844-18705-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU-aware dma_alloc_attrs() implementation allocates buffers in
power-of-two chunks to improve performance and take advantage of large
page mappings provided by some IOMMU hardware. However current code, due
to a subtle bug, allocated those chunks in the smallest-to-largest
order, what completely killed all the advantages of using larger than
page chunks. If a 4KiB chunk has been mapped as a first chunk, the
consecutive chunks are not aligned correctly to the power-of-two which
match their size and IOMMU drivers were not able to use internal
mappings of size other than the 4KiB (largest common denominator of
alignment and chunk size).

This patch fixes this issue by changing to the correct largest-to-smallest
chunk size allocation sequence.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d766e42..4044abc 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1067,7 +1067,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size, gfp_t
 		return NULL;
 
 	while (count) {
-		int j, order = __ffs(count);
+		int j, order = __fls(count);
 
 		pages[i] = alloc_pages(gfp | __GFP_NOWARN, order);
 		while (!pages[i] && order)
-- 
1.7.1.569.g6f426
