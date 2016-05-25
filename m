From: labbott@redhat.com (Laura Abbott)
Date: Wed, 25 May 2016 12:48:02 -0700
Subject: [RFC][PATCH 1/3] staging: ion: Move away from the DMA APIs for cache
 flushing
In-Reply-To: <1464205684-5587-1-git-send-email-labbott@redhat.com>
References: <1464205684-5587-1-git-send-email-labbott@redhat.com>
Message-ID: <1464205684-5587-2-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Ion is currently using the DMA APIs in non-compliant ways for cache
maintaince. The issue is Ion needs to do cache operations outside of
the regular DMA model. The Ion model matches more closely with the
DRM model which calls cache APIs directly. Add an appropriate
abstraction layer for Ion to call cache operations outside of the
DMA API.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/Kconfig             | 14 ++++-
 drivers/staging/android/ion/Makefile            |  3 +
 drivers/staging/android/ion/ion-arm.c           | 83 +++++++++++++++++++++++++
 drivers/staging/android/ion/ion-arm64.c         | 46 ++++++++++++++
 drivers/staging/android/ion/ion-x86.c           | 34 ++++++++++
 drivers/staging/android/ion/ion.c               | 59 ++++++------------
 drivers/staging/android/ion/ion_carveout_heap.c |  5 +-
 drivers/staging/android/ion/ion_chunk_heap.c    |  7 +--
 drivers/staging/android/ion/ion_page_pool.c     |  3 +-
 drivers/staging/android/ion/ion_priv.h          | 14 ++---
 drivers/staging/android/ion/ion_system_heap.c   |  5 +-
 11 files changed, 210 insertions(+), 63 deletions(-)
 create mode 100644 drivers/staging/android/ion/ion-arm.c
 create mode 100644 drivers/staging/android/ion/ion-arm64.c
 create mode 100644 drivers/staging/android/ion/ion-x86.c

diff --git a/drivers/staging/android/ion/Kconfig b/drivers/staging/android/ion/Kconfig
index 19c1572..c1b1813 100644
--- a/drivers/staging/android/ion/Kconfig
+++ b/drivers/staging/android/ion/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ION
 	bool "Ion Memory Manager"
-	depends on HAVE_MEMBLOCK && HAS_DMA && MMU
+	depends on HAVE_MEMBLOCK && HAS_DMA && MMU && (X86 || ARM || ARM64)
 	select GENERIC_ALLOCATOR
 	select DMA_SHARED_BUFFER
 	---help---
@@ -10,6 +10,18 @@ menuconfig ION
 	  If you're not using Android its probably safe to
 	  say N here.
 
+config ION_ARM
+	depends on ION && ARM
+	def_bool y
+
+config ION_ARM64
+	depends on ION && ARM64
+	def_bool y
+
+config ION_X86
+	depends on ION && X86
+	def_bool y
+
 config ION_TEST
 	tristate "Ion Test Device"
 	depends on ION
diff --git a/drivers/staging/android/ion/Makefile b/drivers/staging/android/ion/Makefile
index 18cc2aa..1b82bb5 100644
--- a/drivers/staging/android/ion/Makefile
+++ b/drivers/staging/android/ion/Makefile
@@ -1,5 +1,8 @@
 obj-$(CONFIG_ION) +=	ion.o ion_heap.o ion_page_pool.o ion_system_heap.o \
 			ion_carveout_heap.o ion_chunk_heap.o ion_cma_heap.o
+obj-$(CONFIG_ION_X86) += ion-x86.o
+obj-$(CONFIG_ION_ARM) += ion-arm.o
+obj-$(CONFIG_ION_ARM64) += ion-arm64.o
 obj-$(CONFIG_ION_TEST) += ion_test.o
 ifdef CONFIG_COMPAT
 obj-$(CONFIG_ION) += compat_ion.o
diff --git a/drivers/staging/android/ion/ion-arm.c b/drivers/staging/android/ion/ion-arm.c
new file mode 100644
index 0000000..b91287f
--- /dev/null
+++ b/drivers/staging/android/ion/ion-arm.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2016 Laura Abbott <laura@labbott.name>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-mapping.h>
+#include <linux/highmem.h>
+
+#include <asm/cacheflush.h>
+
+#include "ion_priv.h"
+
+
+void ion_clean_page(struct page *page, size_t size)
+{
+	unsigned long pfn;
+	size_t left = size;
+
+	pfn = page_to_pfn(page);
+
+	/*
+	 * A single sg entry may refer to multiple physically contiguous
+	 * pages.  But we still need to process highmem pages individually.
+	 * If highmem is not configured then the bulk of this loop gets
+	 * optimized out.
+	 */
+	do {
+		size_t len = left;
+		void *vaddr;
+
+		page = pfn_to_page(pfn);
+
+		if (PageHighMem(page)) {
+			if (len > PAGE_SIZE)
+				len = PAGE_SIZE;
+
+			if (cache_is_vipt_nonaliasing()) {
+				vaddr = kmap_atomic(page);
+				__cpuc_flush_dcache_area(vaddr, len);
+				kunmap_atomic(vaddr);
+			} else {
+				vaddr = kmap_high_get(page);
+				if (vaddr) {
+					__cpuc_flush_dcache_area(vaddr, len);
+					kunmap_high(page);
+				}
+			}
+		} else {
+			vaddr = page_address(page);
+			__cpuc_flush_dcache_area(vaddr, len);
+		}
+		pfn++;
+		left -= len;
+	} while (left);
+}
+
+/*
+ * ARM has highmem and a bunch of other 'fun' features. It's so much easier just
+ * to do the ISA DMA and call things that way
+ */
+
+void ion_invalidate_buffer(struct ion_buffer *buffer)
+{
+	dma_unmap_sg(NULL, buffer->sg_table->sgl, buffer->sg_table->orig_nents,
+			DMA_BIDIRECTIONAL);
+}
+
+void ion_clean_buffer(struct ion_buffer *buffer)
+{
+	dma_map_sg(NULL, buffer->sg_table->sgl, buffer->sg_table->orig_nents,
+			DMA_BIDIRECTIONAL);
+}
diff --git a/drivers/staging/android/ion/ion-arm64.c b/drivers/staging/android/ion/ion-arm64.c
new file mode 100644
index 0000000..afd387a
--- /dev/null
+++ b/drivers/staging/android/ion/ion-arm64.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2016 Laura Abbott <laura@labbott.name>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/cacheflush.h>
+
+#include "ion_priv.h"
+
+void ion_clean_page(struct page *page, size_t size)
+{
+	__flush_dcache_area(page_address(page), size);
+}
+
+void ion_invalidate_buffer(struct ion_buffer *buffer)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(buffer->sg_table->sgl, sg, buffer->sg_table->orig_nents, i)
+		__dma_unmap_area(page_address(sg_page(sg)), sg->length,
+					DMA_BIDIRECTIONAL);
+}
+
+void ion_clean_buffer(struct ion_buffer *buffer)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(buffer->sg_table->sgl, sg, buffer->sg_table->orig_nents, i)
+		__dma_map_area(page_address(sg_page(sg)), sg->length,
+					DMA_BIDIRECTIONAL);
+}
diff --git a/drivers/staging/android/ion/ion-x86.c b/drivers/staging/android/ion/ion-x86.c
new file mode 100644
index 0000000..05fd684
--- /dev/null
+++ b/drivers/staging/android/ion/ion-x86.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2016 Laura Abbott <laura@labbott.name>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/dma-mapping.h>
+
+#include "ion_priv.h"
+
+void ion_clean_page(struct page *page, size_t size)
+{
+	/* Do nothing right now */
+}
+
+void ion_invalidate_buffer(struct ion_buffer *buffer)
+{
+	/* Do nothing right now */
+}
+
+void ion_clean_buffer(struct ion_buffer *buffer)
+{
+	/* Do nothing right now */
+}
diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index a2cf93b..9282d96a 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -937,42 +937,6 @@ struct sg_table *ion_sg_table(struct ion_client *client,
 }
 EXPORT_SYMBOL(ion_sg_table);
 
-static void ion_buffer_sync_for_device(struct ion_buffer *buffer,
-				       struct device *dev,
-				       enum dma_data_direction direction);
-
-static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
-					enum dma_data_direction direction)
-{
-	struct dma_buf *dmabuf = attachment->dmabuf;
-	struct ion_buffer *buffer = dmabuf->priv;
-
-	ion_buffer_sync_for_device(buffer, attachment->dev, direction);
-	return buffer->sg_table;
-}
-
-static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
-			      struct sg_table *table,
-			      enum dma_data_direction direction)
-{
-}
-
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
@@ -997,8 +961,7 @@ static void ion_buffer_sync_for_device(struct ion_buffer *buffer,
 		struct page *page = buffer->pages[i];
 
 		if (ion_buffer_page_is_dirty(page))
-			ion_pages_sync_for_device(dev, ion_buffer_page(page),
-							PAGE_SIZE, dir);
+			ion_clean_page(ion_buffer_page(page), PAGE_SIZE);
 
 		ion_buffer_page_clean(buffer->pages + i);
 	}
@@ -1011,6 +974,22 @@ static void ion_buffer_sync_for_device(struct ion_buffer *buffer,
 	mutex_unlock(&buffer->lock);
 }
 
+static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
+					enum dma_data_direction direction)
+{
+	struct dma_buf *dmabuf = attachment->dmabuf;
+	struct ion_buffer *buffer = dmabuf->priv;
+
+	ion_buffer_sync_for_device(buffer, attachment->dev, direction);
+	return buffer->sg_table;
+}
+
+static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
+			      struct sg_table *table,
+			      enum dma_data_direction direction)
+{
+}
+
 static int ion_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct ion_buffer *buffer = vma->vm_private_data;
@@ -1293,8 +1272,8 @@ static int ion_sync_for_device(struct ion_client *client, int fd)
 	}
 	buffer = dmabuf->priv;
 
-	dma_sync_sg_for_device(NULL, buffer->sg_table->sgl,
-			       buffer->sg_table->nents, DMA_BIDIRECTIONAL);
+	ion_clean_buffer(buffer);
+
 	dma_buf_put(dmabuf);
 	return 0;
 }
diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index 1fb0d81..d213cbf 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -116,8 +116,7 @@ static void ion_carveout_heap_free(struct ion_buffer *buffer)
 	ion_heap_buffer_zero(buffer);
 
 	if (ion_buffer_cached(buffer))
-		dma_sync_sg_for_device(NULL, table->sgl, table->nents,
-				       DMA_BIDIRECTIONAL);
+		ion_clean_page(page, buffer->size);
 
 	ion_carveout_free(heap, paddr, buffer->size);
 	sg_free_table(table);
@@ -157,7 +156,7 @@ struct ion_heap *ion_carveout_heap_create(struct ion_platform_heap *heap_data)
 	page = pfn_to_page(PFN_DOWN(heap_data->base));
 	size = heap_data->size;
 
-	ion_pages_sync_for_device(NULL, page, size, DMA_BIDIRECTIONAL);
+	ion_clean_page(page, size);
 
 	ret = ion_heap_pages_zero(page, size, pgprot_writecombine(PAGE_KERNEL));
 	if (ret)
diff --git a/drivers/staging/android/ion/ion_chunk_heap.c b/drivers/staging/android/ion/ion_chunk_heap.c
index e0553fe..0666529 100644
--- a/drivers/staging/android/ion/ion_chunk_heap.c
+++ b/drivers/staging/android/ion/ion_chunk_heap.c
@@ -104,11 +104,10 @@ static void ion_chunk_heap_free(struct ion_buffer *buffer)
 
 	ion_heap_buffer_zero(buffer);
 
-	if (ion_buffer_cached(buffer))
-		dma_sync_sg_for_device(NULL, table->sgl, table->nents,
-							DMA_BIDIRECTIONAL);
 
 	for_each_sg(table->sgl, sg, table->nents, i) {
+		if (ion_buffer_cached(buffer))
+			ion_clean_page(sg_page(table->sgl), sg->length);
 		gen_pool_free(chunk_heap->pool, page_to_phys(sg_page(sg)),
 			      sg->length);
 	}
@@ -148,7 +147,7 @@ struct ion_heap *ion_chunk_heap_create(struct ion_platform_heap *heap_data)
 	page = pfn_to_page(PFN_DOWN(heap_data->base));
 	size = heap_data->size;
 
-	ion_pages_sync_for_device(NULL, page, size, DMA_BIDIRECTIONAL);
+	ion_clean_page(page, size);
 
 	ret = ion_heap_pages_zero(page, size, pgprot_writecombine(PAGE_KERNEL));
 	if (ret)
diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
index 1fe8016..b854f91 100644
--- a/drivers/staging/android/ion/ion_page_pool.c
+++ b/drivers/staging/android/ion/ion_page_pool.c
@@ -30,8 +30,7 @@ static void *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
 
 	if (!page)
 		return NULL;
-	ion_pages_sync_for_device(NULL, page, PAGE_SIZE << pool->order,
-						DMA_BIDIRECTIONAL);
+	ion_clean_page(page, PAGE_SIZE << pool->order);
 	return page;
 }
 
diff --git a/drivers/staging/android/ion/ion_priv.h b/drivers/staging/android/ion/ion_priv.h
index 0239883..b368338 100644
--- a/drivers/staging/android/ion/ion_priv.h
+++ b/drivers/staging/android/ion/ion_priv.h
@@ -392,15 +392,9 @@ void ion_page_pool_free(struct ion_page_pool *, struct page *);
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
+void ion_clean_page(struct page *page, size_t size);
+
+void ion_clean_buffer(struct ion_buffer *buffer);
 
+void ion_invalidate_buffer(struct ion_buffer *buffer);
 #endif /* _ION_PRIV_H */
diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
index b69dfc7..aa39660 100644
--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -70,8 +70,7 @@ static struct page *alloc_buffer_page(struct ion_system_heap *heap,
 		page = alloc_pages(gfp_flags | __GFP_COMP, order);
 		if (!page)
 			return NULL;
-		ion_pages_sync_for_device(NULL, page, PAGE_SIZE << order,
-						DMA_BIDIRECTIONAL);
+		ion_clean_page(page, PAGE_SIZE << order);
 	}
 
 	return page;
@@ -360,7 +359,7 @@ static int ion_system_contig_heap_allocate(struct ion_heap *heap,
 
 	buffer->priv_virt = table;
 
-	ion_pages_sync_for_device(NULL, page, len, DMA_BIDIRECTIONAL);
+	ion_clean_page(page, len);
 
 	return 0;
 
-- 
2.5.5
