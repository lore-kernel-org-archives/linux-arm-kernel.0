From: labbott@redhat.com (Laura Abbott)
Date: Mon,  8 Aug 2016 10:49:36 -0700
Subject: [RFCv2][PATCH 4/5] staging: android: ion: Convert to the
 kernel_force_cache APIs
In-Reply-To: <1470678577-14010-1-git-send-email-labbott@redhat.com>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
Message-ID: <1470678577-14010-5-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Now that there exists a proper set of cache sync APIs, move away
from the dma_sync and do less bad things.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c               | 22 ++++------------------
 drivers/staging/android/ion/ion_carveout_heap.c |  8 +++++---
 drivers/staging/android/ion/ion_chunk_heap.c    | 12 +++++++-----
 drivers/staging/android/ion/ion_page_pool.c     |  6 ++++--
 drivers/staging/android/ion/ion_priv.h          | 11 -----------
 drivers/staging/android/ion/ion_system_heap.c   |  6 +++---
 6 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index a2cf93b..5cbe22e 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -37,6 +37,8 @@
 #include <linux/dma-buf.h>
 #include <linux/idr.h>
 
+#include <linux/cacheflush.h>
+
 #include "ion.h"
 #include "ion_priv.h"
 #include "compat_ion.h"
@@ -957,22 +959,6 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 {
 }
 
-void ion_pages_sync_for_device(struct device *dev, struct page *page,
-		size_t size, enum dma_data_direction dir)
-{
-	struct scatterlist sg;
-
-	sg_init_table(&sg, 1);
-	sg_set_page(&sg, page, size, 0);
-	/*
-	 * This is not correct - sg_dma_address needs a dma_addr_t that is valid
-	 * for the targeted device, but this works on the currently targeted
-	 * hardware.
-	 */
-	sg_dma_address(&sg) = page_to_phys(page);
-	dma_sync_sg_for_device(dev, &sg, 1, dir);
-}
-
 struct ion_vma_list {
 	struct list_head list;
 	struct vm_area_struct *vma;
@@ -997,8 +983,8 @@ static void ion_buffer_sync_for_device(struct ion_buffer *buffer,
 		struct page *page = buffer->pages[i];
 
 		if (ion_buffer_page_is_dirty(page))
-			ion_pages_sync_for_device(dev, ion_buffer_page(page),
-							PAGE_SIZE, dir);
+			kernel_force_cache_clean(ion_buffer_page(page),
+							PAGE_SIZE);
 
 		ion_buffer_page_clean(buffer->pages + i);
 	}
diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index 1fb0d81..34c38b0 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -22,6 +22,9 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+
+#include <linux/cacheflush.h>
+
 #include "ion.h"
 #include "ion_priv.h"
 
@@ -116,8 +119,7 @@ static void ion_carveout_heap_free(struct ion_buffer *buffer)
 	ion_heap_buffer_zero(buffer);
 
 	if (ion_buffer_cached(buffer))
-		dma_sync_sg_for_device(NULL, table->sgl, table->nents,
-				       DMA_BIDIRECTIONAL);
+		kernel_force_cache_clean(page, buffer->size);
 
 	ion_carveout_free(heap, paddr, buffer->size);
 	sg_free_table(table);
@@ -157,7 +159,7 @@ struct ion_heap *ion_carveout_heap_create(struct ion_platform_heap *heap_data)
 	page = pfn_to_page(PFN_DOWN(heap_data->base));
 	size = heap_data->size;
 
-	ion_pages_sync_for_device(NULL, page, size, DMA_BIDIRECTIONAL);
+	kernel_force_cache_clean(page, size);
 
 	ret = ion_heap_pages_zero(page, size, pgprot_writecombine(PAGE_KERNEL));
 	if (ret)
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index e0553fe..dde14f3 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -21,6 +21,9 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+
+#include <linux/cacheflush.h>
+
 #include "ion.h"
 #include "ion_priv.h"
 
@@ -104,11 +107,10 @@ static void ion_chunk_heap_free(struct ion_buffer *buffer)
 
 	ion_heap_buffer_zero(buffer);
 
-	if (ion_buffer_cached(buffer))
-		dma_sync_sg_for_device(NULL, table->sgl, table->nents,
-							DMA_BIDIRECTIONAL);
-
 	for_each_sg(table->sgl, sg, table->nents, i) {
+		if (ion_buffer_cached(buffer))
+			kernel_force_cache_clean(sg_page(table->sgl),
+						 sg->length);
 		gen_pool_free(chunk_heap->pool, page_to_phys(sg_page(sg)),
 			      sg->length);
 	}
@@ -148,7 +150,7 @@ struct ion_heap *ion_chunk_heap_create(struct ion_platform_heap *heap_data)
 	page = pfn_to_page(PFN_DOWN(heap_data->base));
 	size = heap_data->size;
 
-	ion_pages_sync_for_device(NULL, page, size, DMA_BIDIRECTIONAL);
+	kernel_force_cache_clean(page, size);
 
 	ret = ion_heap_pages_zero(page, size, pgprot_writecombine(PAGE_KERNEL));
 	if (ret)
diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 1fe8016..51805d2 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -22,6 +22,9 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
+
+#include <linux/cacheflush.h>
+
 #include "ion_priv.h"
 
 static void *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
@@ -30,8 +33,7 @@ static void *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
 
 	if (!page)
 		return NULL;
-	ion_pages_sync_for_device(NULL, page, PAGE_SIZE << pool->order,
-						DMA_BIDIRECTIONAL);
+	kernel_force_cache_clean(page, PAGE_SIZE << pool->order);
 	return page;
 }
 
diff --git a/drivers/staging/android/ion/ion_priv.h b/drivers/staging/android/ion/ion_priv.h
index 0239883..5828738 100644
--- a/drivers/staging/android/ion/ion_priv.h
+++ b/drivers/staging/android/ion/ion_priv.h
@@ -392,15 +392,4 @@ void ion_page_pool_free(struct ion_page_pool *, struct page *);
 int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
 			  int nr_to_scan);
 
-/**
- * ion_pages_sync_for_device - cache flush pages for use with the specified
- *                             device
- * @dev:		the device the pages will be used with
- * @page:		the first page to be flushed
- * @size:		size in bytes of region to be flushed
- * @dir:		direction of dma transfer
- */
-void ion_pages_sync_for_device(struct device *dev, struct page *page,
-		size_t size, enum dma_data_direction dir);
-
 #endif /* _ION_PRIV_H */
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b69dfc7..04955f4 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -23,6 +23,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/cacheflush.h>
 #include "ion.h"
 #include "ion_priv.h"
 
@@ -70,8 +71,7 @@ static struct page *alloc_buffer_page(struct ion_system_heap *heap,
 		page = alloc_pages(gfp_flags | __GFP_COMP, order);
 		if (!page)
 			return NULL;
-		ion_pages_sync_for_device(NULL, page, PAGE_SIZE << order,
-						DMA_BIDIRECTIONAL);
+		kernel_force_cache_clean(page, PAGE_SIZE << order);
 	}
 
 	return page;
@@ -360,7 +360,7 @@ static int ion_system_contig_heap_allocate(struct ion_heap *heap,
 
 	buffer->priv_virt = table;
 
-	ion_pages_sync_for_device(NULL, page, len, DMA_BIDIRECTIONAL);
+	kernel_force_cache_clean(page, len);
 
 	return 0;
 
-- 
2.7.4
