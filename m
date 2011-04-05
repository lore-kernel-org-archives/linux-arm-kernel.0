From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Apr 2011 16:06:46 +0200
Subject: [PATCH 3/7] v4l: videobuf2: dma-sg: move some generic functions to
	memops
In-Reply-To: <1302012410-17984-1-git-send-email-m.szyprowski@samsung.com>
References: <1302012410-17984-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1302012410-17984-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

This patch moves some generic code to videobuf2-memops. This code will
be later used by the iommu allocator. This patch adds also vma locking
in user pointer mode.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Pawel Osciak <pawel@osciak.com>
---
 drivers/media/video/videobuf2-dma-sg.c |   37 +++++----------
 drivers/media/video/videobuf2-memops.c |   76 ++++++++++++++++++++++++++++++++
 include/media/videobuf2-memops.h       |    5 ++
 3 files changed, 93 insertions(+), 25 deletions(-)

diff --git a/drivers/media/video/videobuf2-dma-sg.c b/drivers/media/video/videobuf2-dma-sg.c
index b2d9485..240abaa 100644
--- a/drivers/media/video/videobuf2-dma-sg.c
+++ b/drivers/media/video/videobuf2-dma-sg.c
@@ -29,6 +29,7 @@ struct vb2_dma_sg_buf {
 	struct vb2_dma_sg_desc		sg_desc;
 	atomic_t			refcount;
 	struct vb2_vmarea_handler	handler;
+	struct vm_area_struct		*vma;
 };
 
 static void vb2_dma_sg_put(void *buf_priv);
@@ -150,15 +151,9 @@ static void *vb2_dma_sg_get_userptr(void *alloc_ctx, unsigned long vaddr,
 	if (!buf->pages)
 		goto userptr_fail_pages_array_alloc;
 
-	down_read(&current->mm->mmap_sem);
-	num_pages_from_user = get_user_pages(current, current->mm,
-					     vaddr & PAGE_MASK,
-					     buf->sg_desc.num_pages,
-					     write,
-					     1, /* force */
-					     buf->pages,
-					     NULL);
-	up_read(&current->mm->mmap_sem);
+	num_pages_from_user = vb2_get_user_pages(vaddr, buf->sg_desc.num_pages,
+					     buf->pages, write, &buf->vma);
+
 	if (num_pages_from_user != buf->sg_desc.num_pages)
 		goto userptr_fail_get_user_pages;
 
@@ -177,6 +172,8 @@ userptr_fail_get_user_pages:
 	       num_pages_from_user, buf->sg_desc.num_pages);
 	while (--num_pages_from_user >= 0)
 		put_page(buf->pages[num_pages_from_user]);
+	if (buf->vma)
+		vb2_put_vma(buf->vma);
 	kfree(buf->pages);
 
 userptr_fail_pages_array_alloc:
@@ -200,6 +197,8 @@ static void vb2_dma_sg_put_userptr(void *buf_priv)
 	       __func__, buf->sg_desc.num_pages);
 	if (buf->vaddr)
 		vm_unmap_ram(buf->vaddr, buf->sg_desc.num_pages);
+	if (buf->vma)
+		vb2_put_vma(buf->vma);
 	while (--i >= 0) {
 		if (buf->write)
 			set_page_dirty_lock(buf->pages[i]);
@@ -236,28 +235,16 @@ static unsigned int vb2_dma_sg_num_users(void *buf_priv)
 static int vb2_dma_sg_mmap(void *buf_priv, struct vm_area_struct *vma)
 {
 	struct vb2_dma_sg_buf *buf = buf_priv;
-	unsigned long uaddr = vma->vm_start;
-	unsigned long usize = vma->vm_end - vma->vm_start;
-	int i = 0;
+	int ret;
 
 	if (!buf) {
 		printk(KERN_ERR "No memory to map\n");
 		return -EINVAL;
 	}
 
-	do {
-		int ret;
-
-		ret = vm_insert_page(vma, uaddr, buf->pages[i++]);
-		if (ret) {
-			printk(KERN_ERR "Remapping memory, error: %d\n", ret);
-			return ret;
-		}
-
-		uaddr += PAGE_SIZE;
-		usize -= PAGE_SIZE;
-	} while (usize > 0);
-
+	ret = vb2_insert_pages(vma, buf->pages);
+	if (ret)
+		return ret;
 
 	/*
 	 * Use common vm_area operations to track buffer refcount.
diff --git a/drivers/media/video/videobuf2-memops.c b/drivers/media/video/videobuf2-memops.c
index 5370a3a..9d44473 100644
--- a/drivers/media/video/videobuf2-memops.c
+++ b/drivers/media/video/videobuf2-memops.c
@@ -185,6 +185,82 @@ int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
 EXPORT_SYMBOL_GPL(vb2_mmap_pfn_range);
 
 /**
+ * vb2_get_user_pages() - pin user pages
+ * @vaddr:	virtual address from which to start
+ * @num_pages:	number of pages to pin
+ * @pages:	table of pointers to struct pages to pin
+ * @write:	if 0, the pages must not be written to
+ * @vma:	output parameter, copy of the vma or NULL
+ *		if get_user_pages fails
+ *
+ * This function just forwards invocation to get_user_pages, but eases using
+ * the latter in videobuf2 allocators.
+ */
+int vb2_get_user_pages(unsigned long vaddr, unsigned int num_pages,
+		       struct page **pages, int write, struct vm_area_struct **vma)
+{
+	struct vm_area_struct *found_vma;
+	struct mm_struct *mm = current->mm;
+	int ret = -EFAULT;
+
+	down_read(&current->mm->mmap_sem);
+
+	found_vma = find_vma(mm, vaddr);
+	if (NULL == found_vma || found_vma->vm_end < (vaddr + num_pages * PAGE_SIZE))
+		goto done;
+
+	*vma = vb2_get_vma(found_vma);
+	if (NULL == *vma) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	ret = get_user_pages(current, current->mm, vaddr & PAGE_MASK, num_pages,
+			     write, 1 /* force */, pages, NULL);
+
+	if (ret != num_pages) {
+		vb2_put_vma(*vma);
+		*vma = NULL;
+	}
+
+done:
+	up_read(&current->mm->mmap_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vb2_get_user_pages);
+
+/**
+ * vb2_insert_pages - insert pages into user vma
+ * @vma:	virtual memory region for the mapping
+ * @pages:	table of pointers to struct pages to be inserted
+ *
+ * This function for each page to be inserted performs vm_insert_page.
+ */
+int vb2_insert_pages(struct vm_area_struct *vma, struct page **pages)
+{
+	unsigned long uaddr = vma->vm_start;
+	unsigned long usize = vma->vm_end - vma->vm_start;
+	int i = 0;
+
+	do {
+		int ret;
+
+		ret = vm_insert_page(vma, uaddr, pages[i++]);
+		if (ret) {
+			printk(KERN_ERR "Remapping memory, error: %d\n", ret);
+			return ret;
+		}
+
+		uaddr += PAGE_SIZE;
+		usize -= PAGE_SIZE;
+	} while (usize > 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vb2_insert_pages);
+
+/**
  * vb2_common_vm_open() - increase refcount of the vma
  * @vma:	virtual memory region for the mapping
  *
diff --git a/include/media/videobuf2-memops.h b/include/media/videobuf2-memops.h
index 84e1f6c..f8a0886 100644
--- a/include/media/videobuf2-memops.h
+++ b/include/media/videobuf2-memops.h
@@ -41,5 +41,10 @@ int vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
 struct vm_area_struct *vb2_get_vma(struct vm_area_struct *vma);
 void vb2_put_vma(struct vm_area_struct *vma);
 
+int vb2_get_user_pages(unsigned long vaddr, unsigned int num_pages,
+		       struct page **pages, int write,
+		       struct vm_area_struct **vma);
+
+int vb2_insert_pages(struct vm_area_struct *vma, struct page **pages);
 
 #endif
-- 
1.7.1.569.g6f426
