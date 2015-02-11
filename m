From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 11 Feb 2015 18:01:41 +0900
Subject: [PATCH RESEND] ARM: DMA: Fix kzalloc flags in __iommu_alloc_buffer()
Message-ID: <1423645301-709-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There doesn't seem to be any valid reason to allocate the pages array
with the same flags as the buffer itself. Doing so can eventually lead
to the following safeguard in mm/slab.c to be hit:

BUG_ON(flags & GFP_SLAB_BUG_MASK);

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
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 903dba0..170a116 100644
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
