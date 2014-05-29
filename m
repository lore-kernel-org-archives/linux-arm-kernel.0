From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 29 May 2014 15:29:18 +0900
Subject: [PATCH] CMA: correct unlock target
Message-ID: <1401344958-3790-1-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'cma: Remove potential deadlock situation' introduces per cma area mutex
for bitmap management. It is good, but there is one mistake. When we
can't find appropriate area in bitmap, we release cma_mutex global lock
rather than cma->lock and this is a bug. So fix it.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 6f6bffc..83969f8 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -331,7 +331,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, int count,
 		pageno = bitmap_find_next_zero_area(cma->bitmap, cma->count,
 						    start, count, mask);
 		if (pageno >= cma->count) {
-			mutex_unlock(&cma_mutex);
+			mutex_unlock(&cma->lock);
 			break;
 		}
 		bitmap_set(cma->bitmap, pageno, count);
-- 
1.7.9.5
