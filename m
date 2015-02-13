From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 13 Feb 2015 15:35:55 +0900
Subject: [PATCH RESEND v2] ARM: DMA: Fix kzalloc flags in
 __iommu_alloc_buffer()
Message-ID: <1423809355-9429-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Courbot <gnurou@gmail.com>

There doesn't seem to be any valid reason to allocate the pages array
with the same flags as the buffer itself. Doing so can eventually lead
to the following safeguard in mm/slab.c's cache_grow() to be hit:

        if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
		BUG();
	}

This happens when buffers are allocated with __GFP_DMA32 or
__GFP_HIGHMEM.

Fix this by allocating the pages array with GFP_KERNEL to follow what is
done elsewhere in this file. Using GFP_KERNEL in __iommu_alloc_buffer()
is safe because atomic allocations are handled by __iommu_alloc_atomic().

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
Changes since v1:
- Updated commit message to better point the assert that fails
- Added Will's ack

 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 903dba064a03..170a116d1b29 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1106,7 +1106,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int i = 0;
 
 	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, gfp);
+		pages = kzalloc(array_size, GFP_KERNEL);
 	else
 		pages = vzalloc(array_size);
 	if (!pages)
-- 
2.3.0
