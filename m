From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Apr 2015 13:46:16 +0200
Subject: [PATCH] arm64: dma-mapping: always clear allocated buffers
Message-ID: <1429789576-19570-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Buffers allocated by dma_alloc_coherent() are always zeroed on Alpha,
ARM (32bit), MIPS, PowerPC, x86/x86_64 and probably other architectures.
It turned out that some drivers rely on this 'feature'. Allocated buffer
might be also exposed to userspace with dma_mmap() call, so clearing it
is desired from security point of view to avoid exposing random memory
to userspace. This patch unifies dma_alloc_coherent() behavior on ARM64
architecture with other implementations by unconditionally zeroing
allocated buffer.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Hello,

This issue was really nasty to debug. The problem has been observed with
dw_mmc driver on Exynos 5433. I've also check if there are any calls to
dma_alloc_coherent() with __GFP_ZERO flag and found only two drivers in
the whole kernel tree: drivers/staging/android/ion/ion_cma_heap.c and
drivers/thunderbolt/nhi.c. The best will be to review all drivers and
add missing __GFP_ZERO flag or replace it with dma_zalloc_coherent() and
only then convert all implementation for all architectures to honor this
flag. However I expect that this is a huge task and for now ARM64 should
just match the behavior of other architectures.

Best regards
Marek Szyprowski
Samsung Poland R&D Center
---
 arch/arm64/mm/dma-mapping.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index ef7d112..e0f14ee 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -67,8 +67,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
 
 		*ret_page = phys_to_page(phys);
 		ptr = (void *)val;
-		if (flags & __GFP_ZERO)
-			memset(ptr, 0, size);
+		memset(ptr, 0, size);
 	}
 
 	return ptr;
@@ -113,8 +112,7 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 		addr = page_address(page);
-		if (flags & __GFP_ZERO)
-			memset(addr, 0, size);
+		memset(addr, 0, size);
 		return addr;
 	} else {
 		return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
-- 
1.9.2
