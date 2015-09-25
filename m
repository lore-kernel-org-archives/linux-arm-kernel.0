From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 25 Sep 2015 13:15:43 +0100
Subject: [PATCH 1/4] dmapool: Fix overflow condition in pool_find_page
In-Reply-To: <cover.1443178314.git.robin.murphy@arm.com>
References: <cover.1443178314.git.robin.murphy@arm.com>
Message-ID: <be19713dc9e80c6486e86c60a43e149d45b104a3.1443178314.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a DMA pool lies at the very top of the dma_addr_t range (as may
happen with an IOMMU involved), the calculated end address of the pool
wraps around to zero, and page lookup always fails. Tweak the relevant
calculation to be overflow-proof.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 71a8998..312a716 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -394,7 +394,7 @@ static struct dma_page *pool_find_page(struct dma_pool *pool, dma_addr_t dma)
 	list_for_each_entry(page, &pool->page_list, page_list) {
 		if (dma < page->dma)
 			continue;
-		if (dma < (page->dma + pool->allocation))
+		if ((dma - page->dma) < pool->allocation)
 			return page;
 	}
 	return NULL;
-- 
1.9.1
