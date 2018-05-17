From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 17 May 2018 13:36:19 -0400
Subject: [PATCH] mm/dmapool: localize page allocations
Message-ID: <1526578581-7658-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to keep the pool closer to the device's NUMA node by changing kmalloc()
to kmalloc_node() and devres_alloc() to devres_alloc_node().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 mm/dmapool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 4d90a64..023f3d9 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -223,7 +223,7 @@ static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
 {
 	struct dma_page *page;
 
-	page = kmalloc(sizeof(*page), mem_flags);
+	page = kmalloc_node(sizeof(*page), mem_flags, dev_to_node(pool->dev));
 	if (!page)
 		return NULL;
 	page->vaddr = dma_alloc_coherent(pool->dev, pool->allocation,
@@ -504,7 +504,8 @@ struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
 {
 	struct dma_pool **ptr, *pool;
 
-	ptr = devres_alloc(dmam_pool_release, sizeof(*ptr), GFP_KERNEL);
+	ptr = devres_alloc_node(dmam_pool_release, sizeof(*ptr), GFP_KERNEL,
+				dev_to_node(dev));
 	if (!ptr)
 		return NULL;
 
-- 
2.7.4
