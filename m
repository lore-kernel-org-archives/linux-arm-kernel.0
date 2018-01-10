From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 09:00:21 +0100
Subject: [PATCH 27/33] dma-direct: use node local allocations for coherent
 memory
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Message-ID: <20180110080027.13879-28-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To preserve the x86 behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index a9ae98be7af3..f04a424f91fa 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -38,7 +38,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
 	if (!page)
-		page = alloc_pages(gfp, page_order);
+		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
 	if (!page)
 		return NULL;
 
-- 
2.14.2
