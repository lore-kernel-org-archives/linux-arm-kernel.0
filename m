From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 18 Mar 2016 18:28:49 +0900
Subject: [PATCH v2] ARM: DMA: Fix kzalloc flags in __dma_alloc
Message-ID: <1458293329-5519-1-git-send-email-acourbot@nvidia.com>
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

Fix this by filtering the flags that make the slab allocator unhappy.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Cc: Rabin Vincent <rabin@rab.in>
---
Changes since v1:
- Filter flags that may cause problem instead of forcing GFP_KERNEL
  (and risk sleeping in atomic context), as suggested by Rabin.

 arch/arm/mm/dma-mapping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index deac58d5f1f7..c941e93048ad 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -762,7 +762,8 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (!mask)
 		return NULL;
 
-	buf = kzalloc(sizeof(*buf), gfp);
+	buf = kzalloc(sizeof(*buf),
+		      gfp & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM));
 	if (!buf)
 		return NULL;
 
-- 
2.7.3
