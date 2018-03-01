From: lmark@codeaurora.org (Liam Mark)
Date: Wed, 28 Feb 2018 21:18:27 -0800 (PST)
Subject: [RFC] android: ion: How to properly clean caches for uncached
 allocations
Message-ID: <alpine.DEB.2.02.1802282111320.22860@lmark-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The issue:

Currently in ION if you allocate uncached memory it is possible that there
are still dirty lines in the cache.  And often these dirty lines in the
cache are the zeros which were meant to clear out any sensitive kernel
data.

What this means is that if you allocate uncached memory from ION, and then
subsequently write to that buffer (using the uncached mapping you are
provided by ION) then the data you have written could be corrupted at some
point in the future if a dirty line is evicted from the cache.

Also this means there is a potential security issue.  If an un-privileged
userspace user allocated uncached memory (for example from the system heap)
and then if they were to read from that buffer (through the un-cached
mapping they are provided by ION), and if some of the zeros which were
written to that memory are still in the cache then this un-privileged
userspace user could read potentially sensitive kernel data.


An unacceptable fix:

I have included some sample code which should resolve this issue for the
system heap and the cma heap on some architectures, however this code
would not be acceptable for upstreaming since it uses hacks to clean
the cache.
Similar changes would need to be made to carveout heap and chunk heap.

I would appreciate some feedback on the proper way for ION to clean the
caches for memory it has allocated that is intended for uncached access.

I realize that it may be tempting, as a solution to this problem, to
simply strip uncached support from ION. I hope that we can try to find a
solution which preserves uncached memory support as ION uncached memory
is often used (though perhaps not in upstreamed code) in cases such as
multimedia use cases where there is no CPU access required, in secure
heap allocations, and in some cases where there is minimal CPU access
and therefore uncached memory performs better.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 drivers/staging/android/ion/ion.c             | 16 ++++++++++++++++
 drivers/staging/android/ion/ion.h             |  5 ++++-
 drivers/staging/android/ion/ion_cma_heap.c    |  3 +++
 drivers/staging/android/ion/ion_page_pool.c   |  8 ++++++--
 drivers/staging/android/ion/ion_system_heap.c |  7 ++++++-
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 57e0d8035b2e..10e967b0a0f4 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -38,6 +38,22 @@ bool ion_buffer_cached(struct ion_buffer *buffer)
 	return !!(buffer->flags & ION_FLAG_CACHED);
 }
 
+void ion_pages_sync_for_device(struct page *page, size_t size,
+			       enum dma_data_direction dir)
+{
+	struct scatterlist sg;
+	struct device dev = {0};
+
+	/* hack, use dummy device */
+	arch_setup_dma_ops(&dev, 0, 0, NULL, false);
+
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, page, size, 0);
+	/* hack, use phys address for dma address */
+	sg_dma_address(&sg) = page_to_phys(page);
+	dma_sync_sg_for_device(&dev, &sg, 1, dir);
+}
+
 /* this function should only be called while dev->lock is held */
 static void ion_buffer_add(struct ion_device *dev,
 			   struct ion_buffer *buffer)
diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/ion/ion.h
index a238f23c9116..227b9928d185 100644
--- a/drivers/staging/android/ion/ion.h
+++ b/drivers/staging/android/ion/ion.h
@@ -192,6 +192,9 @@ struct ion_heap {
  */
 bool ion_buffer_cached(struct ion_buffer *buffer);
 
+void ion_pages_sync_for_device(struct page *page, size_t size,
+			       enum dma_data_direction dir);
+
 /**
  * ion_buffer_fault_user_mappings - fault in user mappings of this buffer
  * @buffer:		buffer
@@ -333,7 +336,7 @@ struct ion_page_pool {
 struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int order,
 					   bool cached);
 void ion_page_pool_destroy(struct ion_page_pool *pool);
-struct page *ion_page_pool_alloc(struct ion_page_pool *pool);
+struct page *ion_page_pool_alloc(struct ion_page_pool *pool, bool *from_pool);
 void ion_page_pool_free(struct ion_page_pool *pool, struct page *page);
 
 /** ion_page_pool_shrink - shrinks the size of the memory cached in the pool
diff --git a/drivers/staging/android/ion/ion_cma_heap.c b/drivers/staging/android/ion/ion_cma_heap.c
index 49718c96bf9e..82e80621d114 100644
--- a/drivers/staging/android/ion/ion_cma_heap.c
+++ b/drivers/staging/android/ion/ion_cma_heap.c
@@ -59,6 +59,9 @@ static int ion_cma_allocate(struct ion_heap *heap, struct ion_buffer *buffer,
 		memset(page_address(pages), 0, size);
 	}
 
+	if (!ion_buffer_cached(buffer))
+		ion_pages_sync_for_device(pages, size, DMA_BIDIRECTIONAL);
+
 	table = kmalloc(sizeof(*table), GFP_KERNEL);
 	if (!table)
 		goto err;
diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index b3017f12835f..169a321778ed 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -63,7 +63,7 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
 	return page;
 }
 
-struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
+struct page *ion_page_pool_alloc(struct ion_page_pool *pool, bool *from_pool)
 {
 	struct page *page = NULL;
 
@@ -76,8 +76,12 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
 		page = ion_page_pool_remove(pool, false);
 	mutex_unlock(&pool->mutex);
 
-	if (!page)
+	if (!page) {
 		page = ion_page_pool_alloc_pages(pool);
+		*from_pool = false;
+	} else {
+		*from_pool = true;
+	}
 
 	return page;
 }
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index bc19cdd30637..3bb4604e032b 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -57,13 +57,18 @@ static struct page *alloc_buffer_page(struct ion_system_heap *heap,
 	bool cached = ion_buffer_cached(buffer);
 	struct ion_page_pool *pool;
 	struct page *page;
+	bool from_pool;
 
 	if (!cached)
 		pool = heap->uncached_pools[order_to_index(order)];
 	else
 		pool = heap->cached_pools[order_to_index(order)];
 
-	page = ion_page_pool_alloc(pool);
+	page = ion_page_pool_alloc(pool, &from_pool);
+
+	if (!from_pool && !ion_buffer_cached(buffer))
+		ion_pages_sync_for_device(page, PAGE_SIZE << order,
+					  DMA_BIDIRECTIONAL);
 
 	return page;
 }
-- 
1.8.5.2


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
