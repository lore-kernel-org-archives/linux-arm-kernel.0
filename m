From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 11 Jun 2018 07:13:40 +0200
Subject: [PATCH] arm64: dma-mapping: clear buffers allocated with
 FORCE_CONTIGUOUS flag
References: <CGME20180611051352eucas1p1f256a2a303da85a1e0923f012d709e39@eucas1p1.samsung.com>
Message-ID: <20180611051340.9024-1-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_alloc_*() buffers might be exposed to userspace via mmap() call, so
they should be cleared on allocation. In case of IOMMU-based dma-mapping
implementation such buffer clearing was missing in the code path for
DMA_ATTR_FORCE_CONTIGUOUS flag handling. This patch fixes this issue. For
more information on clearing buffers allocated by dma_alloc_* functions,
see commit 44176bb38fa4 ("arm64: dma-mapping: always clear allocated
buffers").

Fixes: 44176bb38fa4 ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm64/mm/dma-mapping.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 632d32109755..aa0037a3185f 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -629,13 +629,14 @@ static void *__iommu_alloc_attrs(struct device *dev, size_t size,
 						    size >> PAGE_SHIFT);
 			return NULL;
 		}
-		if (!coherent)
-			__dma_flush_area(page_to_virt(page), iosize);
-
 		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
 						   prot,
 						   __builtin_return_address(0));
-		if (!addr) {
+		if (addr) {
+			memset(addr, 0, size);
+			if (!coherent)
+				__dma_flush_area(page_to_virt(page), iosize);
+		} else {
 			iommu_dma_unmap_page(dev, *handle, iosize, 0, attrs);
 			dma_release_from_contiguous(dev, page,
 						    size >> PAGE_SHIFT);
-- 
2.17.1
