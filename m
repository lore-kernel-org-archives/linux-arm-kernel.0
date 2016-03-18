From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 18 Mar 2016 11:12:26 +0900
Subject: [PATCH] ARM: DMA: Fix kzalloc flags in __dma_alloc
Message-ID: <1458267146-24451-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 19e6e5e5392b ("ARM: 8547/1: dma-mapping: store buffer
information") allocates a structure meant for internal buffer management
with the GFP flags of the buffer itself. This can trigger the following
safeguard in the slab/slub allocator:

	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
		BUG();
	}

Fix this by allocating the structure with GFP_KERNEL, as it is meant to
be used by the kernel and not for DMA.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index deac58d5f1f7..6a19ebe6a461 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -762,7 +762,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (!mask)
 		return NULL;
 
-	buf = kzalloc(sizeof(*buf), gfp);
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
-- 
2.7.3
