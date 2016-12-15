From: labbott@redhat.com (Laura Abbott)
Date: Wed, 14 Dec 2016 16:07:42 -0800
Subject: [RFC PATCH 3/4] staging: android: ion: Remove page faulting support
In-Reply-To: <1481760463-3515-1-git-send-email-labbott@redhat.com>
References: <1481760463-3515-1-git-send-email-labbott@redhat.com>
Message-ID: <1481760463-3515-4-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Unclear if this is wanted or needed?

Not-signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion.c | 74 ---------------------------------------
 1 file changed, 74 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 76b874a0..86dba07 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -41,37 +41,11 @@
 #include "ion_priv.h"
 #include "compat_ion.h"
 
-bool ion_buffer_fault_user_mappings(struct ion_buffer *buffer)
-{
-	return (buffer->flags & ION_FLAG_CACHED) &&
-		!(buffer->flags & ION_FLAG_CACHED_NEEDS_SYNC);
-}
-
 bool ion_buffer_cached(struct ion_buffer *buffer)
 {
 	return !!(buffer->flags & ION_FLAG_CACHED);
 }
 
-static inline struct page *ion_buffer_page(struct page *page)
-{
-	return (struct page *)((unsigned long)page & ~(1UL));
-}
-
-static inline bool ion_buffer_page_is_dirty(struct page *page)
-{
-	return !!((unsigned long)page & 1UL);
-}
-
-static inline void ion_buffer_page_dirty(struct page **page)
-{
-	*page = (struct page *)((unsigned long)(*page) | 1UL);
-}
-
-static inline void ion_buffer_page_clean(struct page **page)
-{
-	*page = (struct page *)((unsigned long)(*page) & ~(1UL));
-}
-
 /* this function should only be called while dev->lock is held */
 static void ion_buffer_add(struct ion_device *dev,
 			   struct ion_buffer *buffer)
@@ -139,25 +113,6 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
 	buffer->dev = dev;
 	buffer->size = len;
 
-	if (ion_buffer_fault_user_mappings(buffer)) {
-		int num_pages = PAGE_ALIGN(buffer->size) / PAGE_SIZE;
-		struct scatterlist *sg;
-		int i, j, k = 0;
-
-		buffer->pages = vmalloc(sizeof(struct page *) * num_pages);
-		if (!buffer->pages) {
-			ret = -ENOMEM;
-			goto err1;
-		}
-
-		for_each_sg(table->sgl, sg, table->nents, i) {
-			struct page *page = sg_page(sg);
-
-			for (j = 0; j < sg->length / PAGE_SIZE; j++)
-				buffer->pages[k++] = page++;
-		}
-	}
-
 	buffer->dev = dev;
 	buffer->size = len;
 	INIT_LIST_HEAD(&buffer->vmas);
@@ -845,25 +800,6 @@ struct ion_vma_list {
 	struct vm_area_struct *vma;
 };
 
-static int ion_vm_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct ion_buffer *buffer = vma->vm_private_data;
-	unsigned long pfn;
-	int ret;
-
-	mutex_lock(&buffer->lock);
-	ion_buffer_page_dirty(buffer->pages + vmf->pgoff);
-	BUG_ON(!buffer->pages || !buffer->pages[vmf->pgoff]);
-
-	pfn = page_to_pfn(ion_buffer_page(buffer->pages[vmf->pgoff]));
-	ret = vm_insert_pfn(vma, (unsigned long)vmf->virtual_address, pfn);
-	mutex_unlock(&buffer->lock);
-	if (ret)
-		return VM_FAULT_ERROR;
-
-	return VM_FAULT_NOPAGE;
-}
-
 static void ion_vm_open(struct vm_area_struct *vma)
 {
 	struct ion_buffer *buffer = vma->vm_private_data;
@@ -900,7 +836,6 @@ static void ion_vm_close(struct vm_area_struct *vma)
 static const struct vm_operations_struct ion_vma_ops = {
 	.open = ion_vm_open,
 	.close = ion_vm_close,
-	.fault = ion_vm_fault,
 };
 
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
@@ -914,15 +849,6 @@ static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 		return -EINVAL;
 	}
 
-	if (ion_buffer_fault_user_mappings(buffer)) {
-		vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND |
-							VM_DONTDUMP;
-		vma->vm_private_data = buffer;
-		vma->vm_ops = &ion_vma_ops;
-		ion_vm_open(vma);
-		return 0;
-	}
-
 	if (!(buffer->flags & ION_FLAG_CACHED))
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 
-- 
2.7.4
