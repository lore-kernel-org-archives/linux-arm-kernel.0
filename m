From: mzoran@crowfest.net (Michael Zoran)
Date: Tue, 25 Oct 2016 19:23:27 -0700
Subject: [PATCH v2] staging: vc04_services: Replace dmac_map_area with
 dmac_map_sg
Message-ID: <20161026022327.19055-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original arm implementation uses dmac_map_area which is not
portable.  Replace it with an architecture neutral version
which uses dma_map_sg.

As you can see that for larger page sizes, the dma_map_sg
implementation is faster then the original unportable dma_map_area
implementation.

Test                       dmac_map_area   dma_map_page dma_map_sg
vchiq_test -b 4 10000      51us/iter       76us/iter    76us
vchiq_test -b 8 10000      70us/iter       82us/iter    91us
vchiq_test -b 16 10000     94us/iter       118us/iter   121us
vchiq_test -b 32 10000     146us/iter      173us/iter   187us
vchiq_test -b 64 10000     263us/iter      328us/iter   299us
vchiq_test -b 128 10000    529us/iter      631us/iter   595us
vchiq_test -b 256 10000    2285us/iter     2275us/iter  2001us
vchiq_test -b 512 10000    4372us/iter     4616us/iter  4123us

For message sizes >= 64KB, dma_map_sg is faster then dma_map_page.

For message size >= 256KB, the dma_map_sg is the fastest
implementation.

"Normal" messages sizes should be about 1MB which is beyond
the length that this change shows a speed increase.

This is v2 of the patch which includes extra WARN_ONs and
incorporates feedback from Eric Anholt <eric@anholt.net>.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 .../interface/vchiq_arm/vchiq_2835_arm.c           | 152 +++++++++++++--------
 1 file changed, 93 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 32d12e6..a5afcc5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -45,13 +45,8 @@
 #include <asm/pgtable.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
-#define dmac_map_area			__glue(_CACHE,_dma_map_area)
-#define dmac_unmap_area 		__glue(_CACHE,_dma_unmap_area)
-
 #define TOTAL_SLOTS (VCHIQ_SLOT_ZERO_SLOTS + 2 * 32)
 
-#define VCHIQ_ARM_ADDRESS(x) ((void *)((char *)x + g_virt_to_bus_offset))
-
 #include "vchiq_arm.h"
 #include "vchiq_2835.h"
 #include "vchiq_connected.h"
@@ -73,7 +68,7 @@ static unsigned int g_fragments_size;
 static char *g_fragments_base;
 static char *g_free_fragments;
 static struct semaphore g_free_fragments_sema;
-static unsigned long g_virt_to_bus_offset;
+static struct device *g_dev;
 
 extern int vchiq_arm_log_level;
 
@@ -84,10 +79,11 @@ vchiq_doorbell_irq(int irq, void *dev_id);
 
 static int
 create_pagelist(char __user *buf, size_t count, unsigned short type,
-                struct task_struct *task, PAGELIST_T ** ppagelist);
+		struct task_struct *task, PAGELIST_T **ppagelist,
+		dma_addr_t *dma_addr);
 
 static void
-free_pagelist(PAGELIST_T *pagelist, int actual);
+free_pagelist(dma_addr_t dma_addr, PAGELIST_T *pagelist, int actual);
 
 int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 {
@@ -101,8 +97,6 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	int slot_mem_size, frag_mem_size;
 	int err, irq, i;
 
-	g_virt_to_bus_offset = virt_to_dma(dev, (void *)0);
-
 	(void)of_property_read_u32(dev->of_node, "cache-line-size",
 				   &g_cache_line_size);
 	g_fragments_size = 2 * g_cache_line_size;
@@ -118,7 +112,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 		return -ENOMEM;
 	}
 
-	WARN_ON(((int)slot_mem & (PAGE_SIZE - 1)) != 0);
+	WARN_ON(((unsigned long)slot_mem & (PAGE_SIZE - 1)) != 0);
 
 	vchiq_slot_zero = vchiq_init_slots(slot_mem, slot_mem_size);
 	if (!vchiq_slot_zero)
@@ -170,6 +164,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 		return err ? : -ENXIO;
 	}
 
+	g_dev = dev;
 	vchiq_log_info(vchiq_arm_log_level,
 		"vchiq_init - done (slots %pK, phys %pad)",
 		vchiq_slot_zero, &slot_phys);
@@ -233,6 +228,7 @@ vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, VCHI_MEM_HANDLE_T memhandle,
 {
 	PAGELIST_T *pagelist;
 	int ret;
+	dma_addr_t dma_addr;
 
 	WARN_ON(memhandle != VCHI_MEM_HANDLE_INVALID);
 
@@ -241,12 +237,14 @@ vchiq_prepare_bulk_data(VCHIQ_BULK_T *bulk, VCHI_MEM_HANDLE_T memhandle,
 			? PAGELIST_READ
 			: PAGELIST_WRITE,
 			current,
-			&pagelist);
+			&pagelist,
+			&dma_addr);
+
 	if (ret != 0)
 		return VCHIQ_ERROR;
 
 	bulk->handle = memhandle;
-	bulk->data = VCHIQ_ARM_ADDRESS(pagelist);
+	bulk->data = (void *)(unsigned long)dma_addr;
 
 	/* Store the pagelist address in remote_data, which isn't used by the
 	   slave. */
@@ -259,7 +257,8 @@ void
 vchiq_complete_bulk(VCHIQ_BULK_T *bulk)
 {
 	if (bulk && bulk->remote_data && bulk->actual)
-		free_pagelist((PAGELIST_T *)bulk->remote_data, bulk->actual);
+		free_pagelist((dma_addr_t)(unsigned long)bulk->data,
+			      (PAGELIST_T *)bulk->remote_data, bulk->actual);
 }
 
 void
@@ -353,38 +352,44 @@ vchiq_doorbell_irq(int irq, void *dev_id)
 ** obscuring the new data underneath. We can solve this by transferring the
 ** partial cache lines separately, and allowing the ARM to copy into the
 ** cached area.
-
-** N.B. This implementation plays slightly fast and loose with the Linux
-** driver programming rules, e.g. its use of dmac_map_area instead of
-** dma_map_single, but it isn't a multi-platform driver and it benefits
-** from increased speed as a result.
 */
 
 static int
 create_pagelist(char __user *buf, size_t count, unsigned short type,
-	struct task_struct *task, PAGELIST_T ** ppagelist)
+		struct task_struct *task, PAGELIST_T **ppagelist,
+		dma_addr_t *dma_addr)
 {
 	PAGELIST_T *pagelist;
 	struct page **pages;
-	unsigned long *addrs;
-	unsigned int num_pages, offset, i;
-	char *addr, *base_addr, *next_addr;
-	int run, addridx, actual_pages;
+	u32 *addrs;
+	unsigned int num_pages, offset, i, k;
+	int actual_pages;
         unsigned long *need_release;
+	size_t pagelist_size;
+	struct scatterlist *scatterlist, *sg;
+	int dma_buffers;
+	int dir;
 
-	offset = (unsigned int)buf & (PAGE_SIZE - 1);
+	offset = ((unsigned int)(unsigned long)buf & (PAGE_SIZE - 1));
 	num_pages = (count + offset + PAGE_SIZE - 1) / PAGE_SIZE;
 
+	pagelist_size = sizeof(PAGELIST_T) +
+			(num_pages * sizeof(unsigned long)) +
+			sizeof(unsigned long) +
+			(num_pages * sizeof(pages[0]) +
+			(num_pages * sizeof(struct scatterlist)));
+
 	*ppagelist = NULL;
 
+	dir = (type == PAGELIST_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
 	/* Allocate enough storage to hold the page pointers and the page
 	** list
 	*/
-	pagelist = kmalloc(sizeof(PAGELIST_T) +
-                           (num_pages * sizeof(unsigned long)) +
-                           sizeof(unsigned long) +
-                           (num_pages * sizeof(pages[0])),
-                           GFP_KERNEL);
+	pagelist = dma_zalloc_coherent(g_dev,
+				       pagelist_size,
+				       dma_addr,
+				       GFP_KERNEL);
 
 	vchiq_log_trace(vchiq_arm_log_level, "create_pagelist - %pK",
 			pagelist);
@@ -394,10 +399,9 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 	addrs = pagelist->addrs;
         need_release = (unsigned long *)(addrs + num_pages);
 	pages = (struct page **)(addrs + num_pages + 1);
+	scatterlist = (struct scatterlist *)(pages + num_pages);
 
 	if (is_vmalloc_addr(buf)) {
-		int dir = (type == PAGELIST_WRITE) ?
-			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 		unsigned long length = count;
 		unsigned int off = offset;
 
@@ -410,7 +414,6 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 			if (bytes > length)
 				bytes = length;
 			pages[actual_pages] = pg;
-			dmac_map_area(page_address(pg) + off, bytes, dir);
 			length -= bytes;
 			off = 0;
 		}
@@ -438,7 +441,8 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 				actual_pages--;
 				put_page(pages[actual_pages]);
 			}
-			kfree(pagelist);
+			dma_free_coherent(g_dev, pagelist_size,
+					  pagelist, *dma_addr);
 			if (actual_pages == 0)
 				actual_pages = -ENOMEM;
 			return actual_pages;
@@ -450,30 +454,44 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 	pagelist->type = type;
 	pagelist->offset = offset;
 
-	/* Group the pages into runs of contiguous pages */
+	for (i = 0; i < num_pages; i++)
+		sg_set_page(scatterlist + i, pages[i], PAGE_SIZE, 0);
+
+	dma_buffers = dma_map_sg(g_dev,
+				 scatterlist,
+				 num_pages,
+				 dir);
 
-	base_addr = VCHIQ_ARM_ADDRESS(page_address(pages[0]));
-	next_addr = base_addr + PAGE_SIZE;
-	addridx = 0;
-	run = 0;
+	if (dma_buffers == 0) {
+		dma_free_coherent(g_dev, pagelist_size,
+				  pagelist, *dma_addr);
 
-	for (i = 1; i < num_pages; i++) {
-		addr = VCHIQ_ARM_ADDRESS(page_address(pages[i]));
-		if ((addr == next_addr) && (run < (PAGE_SIZE - 1))) {
-			next_addr += PAGE_SIZE;
-			run++;
+		return -EINTR;
+	}
+
+	/* Combine adjacent blocks for performance */
+	k = 0;
+	for_each_sg(scatterlist, sg, dma_buffers, i) {
+		u32 len = sg_dma_len(sg);
+		u32 addr = sg_dma_address(sg);
+
+		/* Note: addrs is the address + page_count - 1
+		 * The firmware expects the block to be page
+		 * aligned and a multiple of the page size
+		 */
+		WARN_ON(len == 0);
+		WARN_ON(len & ~PAGE_MASK);
+		WARN_ON(addr & ~PAGE_MASK);
+		if (k > 0 &&
+		    ((addrs[k - 1] & PAGE_MASK) |
+			((addrs[k - 1] & ~PAGE_MASK) + 1) << PAGE_SHIFT)
+		    == addr) {
+			addrs[k - 1] += (len >> PAGE_SHIFT);
 		} else {
-			addrs[addridx] = (unsigned long)base_addr + run;
-			addridx++;
-			base_addr = addr;
-			next_addr = addr + PAGE_SIZE;
-			run = 0;
+			addrs[k++] = addr | ((len >> PAGE_SHIFT) - 1);
 		}
 	}
 
-	addrs[addridx] = (unsigned long)base_addr + run;
-	addridx++;
-
 	/* Partial cache lines (fragments) require special measures */
 	if ((type == PAGELIST_READ) &&
 		((pagelist->offset & (g_cache_line_size - 1)) ||
@@ -482,7 +500,10 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 		char *fragments;
 
 		if (down_interruptible(&g_free_fragments_sema) != 0) {
-			kfree(pagelist);
+			dma_unmap_sg(g_dev, scatterlist, num_pages,
+				     DMA_BIDIRECTIONAL);
+			dma_free_coherent(g_dev, pagelist_size,
+					  pagelist, *dma_addr);
 			return -EINTR;
 		}
 
@@ -497,29 +518,42 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 			(fragments - g_fragments_base) / g_fragments_size;
 	}
 
-	dmac_flush_range(pagelist, addrs + num_pages);
-
 	*ppagelist = pagelist;
 
 	return 0;
 }
 
 static void
-free_pagelist(PAGELIST_T *pagelist, int actual)
+free_pagelist(dma_addr_t dma_addr, PAGELIST_T *pagelist, int actual)
 {
         unsigned long *need_release;
 	struct page **pages;
 	unsigned int num_pages, i;
+	size_t pagelist_size;
+	struct scatterlist *scatterlist;
+	int dir;
 
 	vchiq_log_trace(vchiq_arm_log_level, "free_pagelist - %pK, %d",
 			pagelist, actual);
 
+	dir = (pagelist->type == PAGELIST_WRITE) ? DMA_TO_DEVICE :
+						   DMA_FROM_DEVICE;
+
 	num_pages =
 		(pagelist->length + pagelist->offset + PAGE_SIZE - 1) /
 		PAGE_SIZE;
 
+	pagelist_size = sizeof(PAGELIST_T) +
+			(num_pages * sizeof(unsigned long)) +
+			sizeof(unsigned long) +
+			(num_pages * sizeof(pages[0]) +
+			(num_pages * sizeof(struct scatterlist)));
+
         need_release = (unsigned long *)(pagelist->addrs + num_pages);
 	pages = (struct page **)(pagelist->addrs + num_pages + 1);
+	scatterlist = (struct scatterlist *)(pages + num_pages);
+
+	dma_unmap_sg(g_dev, scatterlist, num_pages, dir);
 
 	/* Deal with any partial cache lines (fragments) */
 	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS) {
@@ -569,8 +603,7 @@ free_pagelist(PAGELIST_T *pagelist, int actual)
 
 				if (bytes > length)
 					bytes = length;
-				dmac_unmap_area(page_address(pg) + offset,
-						bytes, DMA_FROM_DEVICE);
+
 				length -= bytes;
 				offset = 0;
 				set_page_dirty(pg);
@@ -579,5 +612,6 @@ free_pagelist(PAGELIST_T *pagelist, int actual)
 		}
 	}
 
-	kfree(pagelist);
+	dma_free_coherent(g_dev, pagelist_size,
+			  pagelist, dma_addr);
 }
-- 
2.10.1
