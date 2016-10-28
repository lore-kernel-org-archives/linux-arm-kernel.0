From: mzoran@crowfest.net (Michael Zoran)
Date: Fri, 28 Oct 2016 08:16:51 -0700
Subject: [PATCH] staging: vc04_services: tie up loose ends with dma_map_sg
 conversion
Message-ID: <20161028151651.3430-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conversion to dma_map_sg left a few loose ends.  This change
ties up those loose ends.

1. Settings the DMA mask is mandatory on 64 bit even though it
is optional on 32 bit.  Set the mask so that DMA space is always
in the lower 32 bit range of data on both platforms.

2. The scatterlist was not completely initialized correctly.
Initialize the list with sg_init_table so that DMA works correctly
if scatterlist debugging is enabled in the build configuration.

3. The error paths in create_pagelist were not consistent.  Make
them all consistent by calling a helper function called
cleanup_pagelistinfo to cleanup regardless of what state the pagelist
is in.

4. create_pagelist and free_pagelist had a very large amount of
duplication in computing offsets into a single allocation of memory
in the DMA area.  Introduce a new structure called the pagelistinfo
that is appened to the end of the allocation to store necessary
information to prevent duplication of code and make cleanup on errors
easier.

When combined with a fix for vchiq_copy_from_user which is not
included at this time, both functional and pings tests of vchiq_test
now pass in both 32 bit and 64 bit modes.

Even though this cleanup could have been broken down to chunks,
all the changes are to a single file and submitting it as a single
related change should make reviewing the diff much easier then if it
were submitted piecemeal.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c           | 239 +++++++++++----------
 1 file changed, 129 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index a5afcc5..06df77a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -62,6 +62,18 @@ typedef struct vchiq_2835_state_struct {
    VCHIQ_ARM_STATE_T arm_state;
 } VCHIQ_2835_ARM_STATE_T;
 
+struct vchiq_pagelist_info {
+	PAGELIST_T *pagelist;
+	size_t pagelist_buffer_size;
+	dma_addr_t dma_addr;
+	enum dma_data_direction dma_dir;
+	unsigned int num_pages;
+	unsigned int pages_need_release;
+	struct page **pages;
+	struct scatterlist *scatterlist;
+	unsigned int scatterlist_mapped;
+};
+
 static void __iomem *g_regs;
 static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
 static unsigned int g_fragments_size;
@@ -77,13 +89,13 @@ static DEFINE_SEMAPHORE(g_free_fragments_mutex);
 static irqreturn_t
 vchiq_doorbell_irq(int irq, void *dev_id);
 
-static int
+static struct vchiq_pagelist_info *
 create_pagelist(char __user *buf, size_t count, unsigned short type,
-		struct task_struct *task, PAGELIST_T **ppagelist,
-		dma_addr_t *dma_addr);
+		struct task_struct *task);
 
 static void
-free_pagelist(dma_addr_t dma_addr, PAGELIST_T *pagelist, int actual);
+free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
+	      int actual);
 
 int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 {
@@ -97,6 +109,16 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	int slot_mem_size, frag_mem_size;
 	int err, irq, i;
 
+	/*
+	 * Setting the DMA mask is necessary in the 64 bit environment.
+	 * It isn't necessary in a 32 bit environment, but is considered
+	 * a good practice.
+	 */
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+
+	if (err < 0)
+		return err;
+
 	(void)of_property_read_u32(dev->of_node, "cache-line-size",
 				   &g_cache_line_size);
 	g_fragments_size = 2 * g_cache_line_size;
@@ -226,29 +248,27 @@ VCHIQ_STATUS_T
 vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, VCHI_MEM_HANDLE_T memhandle,
 	void *offset, int size, int dir)
 {
-	PAGELIST_T *pagelist;
-	int ret;
-	dma_addr_t dma_addr;
+	struct vchiq_pagelist_info *pagelistinfo;
 
 	WARN_ON(memhandle != VCHI_MEM_HANDLE_INVALID);
 
-	ret = create_pagelist((char __user *)offset, size,
-			(dir == VCHIQ_BULK_RECEIVE)
-			? PAGELIST_READ
-			: PAGELIST_WRITE,
-			current,
-			&pagelist,
-			&dma_addr);
+	pagelistinfo = create_pagelist((char __user *)offset, size,
+				       (dir == VCHIQ_BULK_RECEIVE)
+				       ? PAGELIST_READ
+				       : PAGELIST_WRITE,
+				       current);
 
-	if (ret != 0)
+	if (!pagelistinfo)
 		return VCHIQ_ERROR;
 
 	bulk->handle = memhandle;
-	bulk->data = (void *)(unsigned long)dma_addr;
+	bulk->data = (void *)(unsigned long)pagelistinfo->dma_addr;
 
-	/* Store the pagelist address in remote_data, which isn't used by the
-	   slave. */
-	bulk->remote_data = pagelist;
+	/*
+	 * Store the pagelistinfo address in remote_data,
+	 * which isn't used by the slave.
+	 */
+	bulk->remote_data = pagelistinfo;
 
 	return VCHIQ_SUCCESS;
 }
@@ -257,8 +277,8 @@ void
 vchiq_complete_bulk(VCHIQ_BULK_T *bulk)
 {
 	if (bulk && bulk->remote_data && bulk->actual)
-		free_pagelist((dma_addr_t)(unsigned long)bulk->data,
-			      (PAGELIST_T *)bulk->remote_data, bulk->actual);
+		free_pagelist((struct vchiq_pagelist_info *)bulk->remote_data,
+			      bulk->actual);
 }
 
 void
@@ -346,6 +366,25 @@ vchiq_doorbell_irq(int irq, void *dev_id)
 	return ret;
 }
 
+static void
+cleaup_pagelistinfo(struct vchiq_pagelist_info *pagelistinfo)
+{
+	if (pagelistinfo->scatterlist_mapped) {
+		dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
+			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
+	}
+
+	if (pagelistinfo->pages_need_release) {
+		unsigned int i;
+
+		for (i = 0; i < pagelistinfo->num_pages; i++)
+			put_page(pagelistinfo->pages[i]);
+	}
+
+	dma_free_coherent(g_dev, pagelistinfo->pagelist_buffer_size,
+			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
+}
+
 /* There is a potential problem with partial cache lines (pages?)
 ** at the ends of the block when reading. If the CPU accessed anything in
 ** the same line (page?) then it may have pulled old data into the cache,
@@ -354,52 +393,64 @@ vchiq_doorbell_irq(int irq, void *dev_id)
 ** cached area.
 */
 
-static int
+static struct vchiq_pagelist_info *
 create_pagelist(char __user *buf, size_t count, unsigned short type,
-		struct task_struct *task, PAGELIST_T **ppagelist,
-		dma_addr_t *dma_addr)
+		struct task_struct *task)
 {
 	PAGELIST_T *pagelist;
+	struct vchiq_pagelist_info *pagelistinfo;
 	struct page **pages;
 	u32 *addrs;
 	unsigned int num_pages, offset, i, k;
 	int actual_pages;
-        unsigned long *need_release;
 	size_t pagelist_size;
 	struct scatterlist *scatterlist, *sg;
 	int dma_buffers;
-	int dir;
+	dma_addr_t dma_addr;
 
 	offset = ((unsigned int)(unsigned long)buf & (PAGE_SIZE - 1));
 	num_pages = (count + offset + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	pagelist_size = sizeof(PAGELIST_T) +
-			(num_pages * sizeof(unsigned long)) +
-			sizeof(unsigned long) +
+			(num_pages * sizeof(u32)) +
 			(num_pages * sizeof(pages[0]) +
-			(num_pages * sizeof(struct scatterlist)));
-
-	*ppagelist = NULL;
-
-	dir = (type == PAGELIST_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+			(num_pages * sizeof(struct scatterlist))) +
+			sizeof(struct vchiq_pagelist_info);
 
 	/* Allocate enough storage to hold the page pointers and the page
 	** list
 	*/
 	pagelist = dma_zalloc_coherent(g_dev,
 				       pagelist_size,
-				       dma_addr,
+				       &dma_addr,
 				       GFP_KERNEL);
 
 	vchiq_log_trace(vchiq_arm_log_level, "create_pagelist - %pK",
 			pagelist);
 	if (!pagelist)
-		return -ENOMEM;
+		return NULL;
+
+	addrs		= pagelist->addrs;
+	pages		= (struct page **)(addrs + num_pages);
+	scatterlist	= (struct scatterlist *)(pages + num_pages);
+	pagelistinfo	= (struct vchiq_pagelist_info *)
+			  (scatterlist + num_pages);
+
+	pagelist->length = count;
+	pagelist->type = type;
+	pagelist->offset = offset;
 
-	addrs = pagelist->addrs;
-        need_release = (unsigned long *)(addrs + num_pages);
-	pages = (struct page **)(addrs + num_pages + 1);
-	scatterlist = (struct scatterlist *)(pages + num_pages);
+	/* Populate the fields of the pagelistinfo structure */
+	pagelistinfo->pagelist = pagelist;
+	pagelistinfo->pagelist_buffer_size = pagelist_size;
+	pagelistinfo->dma_addr = dma_addr;
+	pagelistinfo->dma_dir =  (type == PAGELIST_WRITE) ?
+				  DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	pagelistinfo->num_pages = num_pages;
+	pagelistinfo->pages_need_release = 0;
+	pagelistinfo->pages = pages;
+	pagelistinfo->scatterlist = scatterlist;
+	pagelistinfo->scatterlist_mapped = 0;
 
 	if (is_vmalloc_addr(buf)) {
 		unsigned long length = count;
@@ -417,7 +468,7 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 			length -= bytes;
 			off = 0;
 		}
-		*need_release = 0; /* do not try and release vmalloc pages */
+		/* do not try and release vmalloc pages */
 	} else {
 		down_read(&task->mm->mmap_sem);
 		actual_pages = get_user_pages(
@@ -441,34 +492,34 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 				actual_pages--;
 				put_page(pages[actual_pages]);
 			}
-			dma_free_coherent(g_dev, pagelist_size,
-					  pagelist, *dma_addr);
-			if (actual_pages == 0)
-				actual_pages = -ENOMEM;
-			return actual_pages;
+			cleaup_pagelistinfo(pagelistinfo);
+			return NULL;
 		}
-		*need_release = 1; /* release user pages */
+		 /* release user pages */
+		pagelistinfo->pages_need_release = 1;
 	}
 
-	pagelist->length = count;
-	pagelist->type = type;
-	pagelist->offset = offset;
-
+	/*
+	 * Not completely necessary, initialize the scatterlist
+	 * so that the magic cookie is filled if debugging is enabled
+	 */
+	sg_init_table(scatterlist, num_pages);
+	/* Now set the pages for each scatterlist */
 	for (i = 0; i < num_pages; i++)
 		sg_set_page(scatterlist + i, pages[i], PAGE_SIZE, 0);
 
 	dma_buffers = dma_map_sg(g_dev,
 				 scatterlist,
 				 num_pages,
-				 dir);
+				 pagelistinfo->dma_dir);
 
 	if (dma_buffers == 0) {
-		dma_free_coherent(g_dev, pagelist_size,
-				  pagelist, *dma_addr);
-
-		return -EINTR;
+		cleaup_pagelistinfo(pagelistinfo);
+		return NULL;
 	}
 
+	pagelistinfo->scatterlist_mapped = 1;
+
 	/* Combine adjacent blocks for performance */
 	k = 0;
 	for_each_sg(scatterlist, sg, dma_buffers, i) {
@@ -500,11 +551,8 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 		char *fragments;
 
 		if (down_interruptible(&g_free_fragments_sema) != 0) {
-			dma_unmap_sg(g_dev, scatterlist, num_pages,
-				     DMA_BIDIRECTIONAL);
-			dma_free_coherent(g_dev, pagelist_size,
-					  pagelist, *dma_addr);
-			return -EINTR;
+			cleaup_pagelistinfo(pagelistinfo);
+			return NULL;
 		}
 
 		WARN_ON(g_free_fragments == NULL);
@@ -518,42 +566,28 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 			(fragments - g_fragments_base) / g_fragments_size;
 	}
 
-	*ppagelist = pagelist;
-
-	return 0;
+	return pagelistinfo;
 }
 
 static void
-free_pagelist(dma_addr_t dma_addr, PAGELIST_T *pagelist, int actual)
+free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
+	      int actual)
 {
-        unsigned long *need_release;
-	struct page **pages;
-	unsigned int num_pages, i;
-	size_t pagelist_size;
-	struct scatterlist *scatterlist;
-	int dir;
+	unsigned int i;
+	PAGELIST_T *pagelist   = pagelistinfo->pagelist;
+	struct page **pages    = pagelistinfo->pages;
+	unsigned int num_pages = pagelistinfo->num_pages;
 
 	vchiq_log_trace(vchiq_arm_log_level, "free_pagelist - %pK, %d",
-			pagelist, actual);
+			pagelistinfo->pagelist, actual);
 
-	dir = (pagelist->type == PAGELIST_WRITE) ? DMA_TO_DEVICE :
-						   DMA_FROM_DEVICE;
-
-	num_pages =
-		(pagelist->length + pagelist->offset + PAGE_SIZE - 1) /
-		PAGE_SIZE;
-
-	pagelist_size = sizeof(PAGELIST_T) +
-			(num_pages * sizeof(unsigned long)) +
-			sizeof(unsigned long) +
-			(num_pages * sizeof(pages[0]) +
-			(num_pages * sizeof(struct scatterlist)));
-
-        need_release = (unsigned long *)(pagelist->addrs + num_pages);
-	pages = (struct page **)(pagelist->addrs + num_pages + 1);
-	scatterlist = (struct scatterlist *)(pages + num_pages);
-
-	dma_unmap_sg(g_dev, scatterlist, num_pages, dir);
+	/*
+	 * NOTE: dma_unmap_sg must be called before the
+	 * cpu can touch and of the data/pages.
+	 */
+	dma_unmap_sg(g_dev, pagelistinfo->scatterlist,
+		     pagelistinfo->num_pages, pagelistinfo->dma_dir);
+	pagelistinfo->scatterlist_mapped = 0;
 
 	/* Deal with any partial cache lines (fragments) */
 	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS) {
@@ -591,27 +625,12 @@ free_pagelist(dma_addr_t dma_addr, PAGELIST_T *pagelist, int actual)
 		up(&g_free_fragments_sema);
 	}
 
-	if (*need_release) {
-		unsigned int length = pagelist->length;
-		unsigned int offset = pagelist->offset;
-
-		for (i = 0; i < num_pages; i++) {
-			struct page *pg = pages[i];
-
-			if (pagelist->type != PAGELIST_WRITE) {
-				unsigned int bytes = PAGE_SIZE - offset;
-
-				if (bytes > length)
-					bytes = length;
-
-				length -= bytes;
-				offset = 0;
-				set_page_dirty(pg);
-			}
-			put_page(pg);
-		}
+	/* Need to mark all the pages dirty. */
+	if (pagelist->type != PAGELIST_WRITE &&
+	    pagelistinfo->pages_need_release) {
+		for (i = 0; i < num_pages; i++)
+			set_page_dirty(pages[i]);
 	}
 
-	dma_free_coherent(g_dev, pagelist_size,
-			  pagelist, dma_addr);
+	cleaup_pagelistinfo(pagelistinfo);
 }
-- 
2.10.1
