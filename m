From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Sep 2009 22:53:02 +0100
Subject: ixp4xx dmabounce
In-Reply-To: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
Message-ID: <20090917215302.GA14939@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2009 at 05:02:59PM -0400, Brian Walsh wrote:
> Any ideas or suggestions?

It's caused because we don't allow dma_free_coherent() to be called from
IRQ context (which is reasonable because it needs to flush TLBs across
all processors on SMP systems.)

Unfortunately, with the DMA bounce code enabled, this function does get
called from IRQ context, and so tends to spit out these warnings.

I did have a patch which made dma_free_coherent() lazy, but it was
reported that the suffered disk corruption (though it was never
conclusive whether it was caused by the patch or not.)  Here's an
updated version of that patch.

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db7b3e3..2d1dcb0 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -16,6 +16,7 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/memory.h>
@@ -68,7 +69,6 @@
  * These are the page tables (2MB each) covering uncached, DMA consistent allocations
  */
 static pte_t *consistent_pte[NUM_CONSISTENT_PTES];
-static DEFINE_SPINLOCK(consistent_lock);
 
 /*
  * VM region handling support.
@@ -101,20 +101,24 @@ static DEFINE_SPINLOCK(consistent_lock);
  */
 struct arm_vm_region {
 	struct list_head	vm_list;
+	struct list_head	vm_gc;
 	unsigned long		vm_start;
 	unsigned long		vm_end;
 	struct page		*vm_pages;
 	int			vm_active;
 };
 
-static struct arm_vm_region consistent_head = {
-	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
-	.vm_start	= CONSISTENT_BASE,
-	.vm_end		= CONSISTENT_END,
-};
+struct arm_vm_region_head {
+	spinlock_t		vm_lock;
+	struct list_head	vm_list;
+	struct list_head	vm_gc;
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+	struct work_struct	work;
+};	
 
 static struct arm_vm_region *
-arm_vm_region_alloc(struct arm_vm_region *head, size_t size, gfp_t gfp)
+arm_vm_region_alloc(struct arm_vm_region_head *head, size_t size, gfp_t gfp)
 {
 	unsigned long addr = head->vm_start, end = head->vm_end - size;
 	unsigned long flags;
@@ -124,7 +128,7 @@ arm_vm_region_alloc(struct arm_vm_region *head, size_t size, gfp_t gfp)
 	if (!new)
 		goto out;
 
-	spin_lock_irqsave(&consistent_lock, flags);
+	spin_lock_irqsave(&head->vm_lock, flags);
 
 	list_for_each_entry(c, &head->vm_list, vm_list) {
 		if ((addr + size) < addr)
@@ -145,17 +149,17 @@ arm_vm_region_alloc(struct arm_vm_region *head, size_t size, gfp_t gfp)
 	new->vm_end = addr + size;
 	new->vm_active = 1;
 
-	spin_unlock_irqrestore(&consistent_lock, flags);
+	spin_unlock_irqrestore(&head->vm_lock, flags);
 	return new;
 
  nospc:
-	spin_unlock_irqrestore(&consistent_lock, flags);
+	spin_unlock_irqrestore(&head->vm_lock, flags);
 	kfree(new);
  out:
 	return NULL;
 }
 
-static struct arm_vm_region *arm_vm_region_find(struct arm_vm_region *head, unsigned long addr)
+static struct arm_vm_region *arm_vm_region_find(struct arm_vm_region_head *head, unsigned long addr)
 {
 	struct arm_vm_region *c;
 	
@@ -168,10 +172,114 @@ static struct arm_vm_region *arm_vm_region_find(struct arm_vm_region *head, unsigned long ad
 	return c;
 }
 
+static void __dma_free(struct arm_vm_region *region);
+
+/*
+ * GC the region.  Walk the gc list, and free each entry.  This is done
+ * in process context, so __dma_free() can sleep as required.  Only
+ * after __dma_free() has completed do we take it off the active vm_list,
+ * at which point the region becomes available for further allocations.
+ */
+static void arm_vm_region_gc(struct work_struct *work)
+{
+	struct arm_vm_region_head *head = container_of(work, struct arm_vm_region_head, work);
+	unsigned long flags;
+	struct list_head h;
+	struct arm_vm_region *region, *tmp;
+
+	spin_lock_irqsave(&head->vm_lock, flags);
+	list_replace_init(&head->vm_gc, &h);
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+
+	list_for_each_entry_safe(region, tmp, &h, vm_gc) {
+		__dma_free(region);
+
+		flush_tlb_kernel_range(region->vm_start, region->vm_end);
+
+		spin_lock_irqsave(&head->vm_lock, flags);
+		list_del(&region->vm_list);
+		spin_unlock_irqrestore(&head->vm_lock, flags);
+
+		kfree(region);
+	}
+}
+
+/*
+ * Mark the region not in use, and place it on to the gc list.
+ * Note: we leave the region on the active vm_list until the
+ * region is actually free, so we avoid reallocating the region.
+ */
+static struct arm_vm_region *vm_region_free(struct arm_vm_region_head *head, unsigned long addr)
+{
+	unsigned long flags;
+	struct arm_vm_region *c;
+
+	spin_lock_irqsave(&head->vm_lock, flags);
+	c = vm_region_find(head, addr);
+	if (c) {
+		c->vm_active = 0;
+		list_add(&c->vm_gc, &head->vm_gc);
+		schedule_work(&head->work);
+	}
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+
+	return c;
+}
+
+static struct arm_vm_region_head consistent_head = {
+	.vm_lock	= __SPIN_LOCK_UNLOCKED(&consistent_head.vm_lock),
+	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
+	.vm_gc		= LIST_HEAD_INIT(consistent_head.vm_gc),
+	.vm_start	= CONSISTENT_BASE,
+	.vm_end		= CONSISTENT_END,
+	.work		= __WORK_INITIALIZER(consistent_head.work, arm_vm_region_gc),
+};
+
 #ifdef CONFIG_HUGETLB_PAGE
 #error ARM Coherent DMA allocator does not (yet) support huge TLB
 #endif
 
+static void __dma_free(struct arm_vm_region *region)
+{
+	unsigned long addr = region->vm_start;
+	pte_t *ptep;
+	int idx = CONSISTENT_PTE_INDEX(addr);
+	u32 off = CONSISTENT_OFFSET(addr) & (PTRS_PER_PTE-1);
+
+	ptep = consistent_pte[idx] + off;
+	do {
+		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
+		unsigned long pfn;
+
+		ptep++;
+		addr += PAGE_SIZE;
+		off++;
+		if (off >= PTRS_PER_PTE) {
+			off = 0;
+			ptep = consistent_pte[++idx];
+		}
+
+		if (!pte_none(pte) && pte_present(pte)) {
+			pfn = pte_pfn(pte);
+
+			if (pfn_valid(pfn)) {
+				struct page *page = pfn_to_page(pfn);
+
+				/*
+				 * x86 does not mark the pages reserved...
+				 */
+				ClearPageReserved(page);
+
+				__free_page(page);
+				continue;
+			}
+		}
+
+		printk(KERN_CRIT "%s: bad page in kernel page table\n",
+		       __func__);
+	} while (addr != region->vm_end);
+}
+
 static void *
 __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	    pgprot_t prot)
@@ -354,9 +462,9 @@ static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	user_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 
-	spin_lock_irqsave(&consistent_lock, flags);
+	spin_lock_irqsave(&consistent_head.vm_lock, flags);
 	c = arm_vm_region_find(&consistent_head, (unsigned long)cpu_addr);
-	spin_unlock_irqrestore(&consistent_lock, flags);
+	spin_unlock_irqrestore(&consistent_head.vm_lock, flags);
 
 	if (c) {
 		unsigned long off = vma->vm_pgoff;
@@ -400,12 +508,6 @@ EXPORT_SYMBOL(dma_mmap_writecombine);
 void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr_t handle)
 {
 	struct arm_vm_region *c;
-	unsigned long flags, addr;
-	pte_t *ptep;
-	int idx;
-	u32 off;
-
-	WARN_ON(irqs_disabled());
 
 	if (dma_release_from_coherent(dev, get_order(size), cpu_addr))
 		return;
@@ -415,73 +517,20 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 		return;
 	}
 
-	size = PAGE_ALIGN(size);
-
-	spin_lock_irqsave(&consistent_lock, flags);
-	c = arm_vm_region_find(&consistent_head, (unsigned long)cpu_addr);
-	if (!c)
-		goto no_area;
-
-	c->vm_active = 0;
-	spin_unlock_irqrestore(&consistent_lock, flags);
+	c = arm_vm_region_free(&consistent_head, (unsigned long)cpu_addr);
+	if (!c) {
+		printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
+		       __func__, cpu_addr);
+		dump_stack();
+		return;
+	}
 
+	size = PAGE_ALIGN(size);
 	if ((c->vm_end - c->vm_start) != size) {
 		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
 		       __func__, c->vm_end - c->vm_start, size);
 		dump_stack();
-		size = c->vm_end - c->vm_start;
 	}
-
-	idx = CONSISTENT_PTE_INDEX(c->vm_start);
-	off = CONSISTENT_OFFSET(c->vm_start) & (PTRS_PER_PTE-1);
-	ptep = consistent_pte[idx] + off;
-	addr = c->vm_start;
-	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-		unsigned long pfn;
-
-		ptep++;
-		addr += PAGE_SIZE;
-		off++;
-		if (off >= PTRS_PER_PTE) {
-			off = 0;
-			ptep = consistent_pte[++idx];
-		}
-
-		if (!pte_none(pte) && pte_present(pte)) {
-			pfn = pte_pfn(pte);
-
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-
-				/*
-				 * x86 does not mark the pages reserved...
-				 */
-				ClearPageReserved(page);
-
-				__free_page(page);
-				continue;
-			}
-		}
-
-		printk(KERN_CRIT "%s: bad page in kernel page table\n",
-		       __func__);
-	} while (size -= PAGE_SIZE);
-
-	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-
-	spin_lock_irqsave(&consistent_lock, flags);
-	list_del(&c->vm_list);
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
-	kfree(c);
-	return;
-
- no_area:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
-	       __func__, cpu_addr);
-	dump_stack();
 }
 #else	/* !CONFIG_MMU */
 void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr_t handle)
