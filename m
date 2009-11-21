From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 Nov 2009 19:37:22 +0000
Subject: [PATCH 01/10] ARM: dma-mapping: split out vmregion code from dma
	coherent mapping code
In-Reply-To: <20091121193539.GG13956@n2100.arm.linux.org.uk>
References: <20091121193539.GG13956@n2100.arm.linux.org.uk>
Message-ID: <E1NBvlq-0007qa-Ur@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Makefile      |    2 +-
 arch/arm/mm/dma-mapping.c |  132 +++++----------------------------------------
 arch/arm/mm/vmregion.c    |  131 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/vmregion.h    |   29 ++++++++++
 4 files changed, 174 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm/mm/vmregion.c
 create mode 100644 arch/arm/mm/vmregion.h

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 055cb2a..42352e7 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -6,7 +6,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   iomap.o
 
 obj-$(CONFIG_MMU)		+= fault-armv.o flush.o ioremap.o mmap.o \
-				   pgd.o mmu.o
+				   pgd.o mmu.o vmregion.o
 
 ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4193904..536dfb2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -68,106 +68,16 @@ static u64 get_coherent_dma_mask(struct device *dev)
  * These are the page tables (2MB each) covering uncached, DMA consistent allocations
  */
 static pte_t *consistent_pte[NUM_CONSISTENT_PTES];
-static DEFINE_SPINLOCK(consistent_lock);
 
-/*
- * VM region handling support.
- *
- * This should become something generic, handling VM region allocations for
- * vmalloc and similar (ioremap, module space, etc).
- *
- * I envisage vmalloc()'s supporting vm_struct becoming:
- *
- *  struct vm_struct {
- *    struct vm_region	region;
- *    unsigned long	flags;
- *    struct page	**pages;
- *    unsigned int	nr_pages;
- *    unsigned long	phys_addr;
- *  };
- *
- * get_vm_area() would then call vm_region_alloc with an appropriate
- * struct vm_region head (eg):
- *
- *  struct vm_region vmalloc_head = {
- *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
- *	.vm_start	= VMALLOC_START,
- *	.vm_end		= VMALLOC_END,
- *  };
- *
- * However, vmalloc_head.vm_start is variable (typically, it is dependent on
- * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
- * would have to initialise this each time prior to calling vm_region_alloc().
- */
-struct arm_vm_region {
-	struct list_head	vm_list;
-	unsigned long		vm_start;
-	unsigned long		vm_end;
-	struct page		*vm_pages;
-	int			vm_active;
-};
+#include "vmregion.h"
 
-static struct arm_vm_region consistent_head = {
+static struct arm_vmregion_head consistent_head = {
+	.vm_lock	= __SPIN_LOCK_UNLOCKED(&consistent_head.vm_lock),
 	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
 	.vm_start	= CONSISTENT_BASE,
 	.vm_end		= CONSISTENT_END,
 };
 
-static struct arm_vm_region *
-arm_vm_region_alloc(struct arm_vm_region *head, size_t size, gfp_t gfp)
-{
-	unsigned long addr = head->vm_start, end = head->vm_end - size;
-	unsigned long flags;
-	struct arm_vm_region *c, *new;
-
-	new = kmalloc(sizeof(struct arm_vm_region), gfp);
-	if (!new)
-		goto out;
-
-	spin_lock_irqsave(&consistent_lock, flags);
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if ((addr + size) < addr)
-			goto nospc;
-		if ((addr + size) <= c->vm_start)
-			goto found;
-		addr = c->vm_end;
-		if (addr > end)
-			goto nospc;
-	}
-
- found:
-	/*
-	 * Insert this entry _before_ the one we found.
-	 */
-	list_add_tail(&new->vm_list, &c->vm_list);
-	new->vm_start = addr;
-	new->vm_end = addr + size;
-	new->vm_active = 1;
-
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	return new;
-
- nospc:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	kfree(new);
- out:
-	return NULL;
-}
-
-static struct arm_vm_region *arm_vm_region_find(struct arm_vm_region *head, unsigned long addr)
-{
-	struct arm_vm_region *c;
-	
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if (c->vm_active && c->vm_start == addr)
-			goto out;
-	}
-	c = NULL;
- out:
-	return c;
-}
-
 #ifdef CONFIG_HUGETLB_PAGE
 #error ARM Coherent DMA allocator does not (yet) support huge TLB
 #endif
@@ -177,7 +87,7 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	    pgprot_t prot)
 {
 	struct page *page;
-	struct arm_vm_region *c;
+	struct arm_vmregion *c;
 	unsigned long order;
 	u64 mask = get_coherent_dma_mask(dev);
 	u64 limit;
@@ -191,13 +101,9 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	if (!mask)
 		goto no_page;
 
-	/*
-	 * Sanity check the allocation size.
-	 */
 	size = PAGE_ALIGN(size);
 	limit = (mask + 1) & ~mask;
-	if ((limit && size >= limit) ||
-	    size >= (CONSISTENT_END - CONSISTENT_BASE)) {
+	if (limit && size >= limit) {
 		printk(KERN_WARNING "coherent allocation too big "
 		       "(requested %#x mask %#llx)\n", size, mask);
 		goto no_page;
@@ -226,7 +132,7 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	/*
 	 * Allocate a virtual address in the consistent mapping region.
 	 */
-	c = arm_vm_region_alloc(&consistent_head, size,
+	c = arm_vmregion_alloc(&consistent_head, size,
 			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
 	if (c) {
 		pte_t *pte;
@@ -349,15 +255,12 @@ static int dma_mmap(struct device *dev, struct vm_area_struct *vma,
 {
 	int ret = -ENXIO;
 #ifdef CONFIG_MMU
-	unsigned long flags, user_size, kern_size;
-	struct arm_vm_region *c;
+	unsigned long user_size, kern_size;
+	struct arm_vmregion *c;
 
 	user_size = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 
-	spin_lock_irqsave(&consistent_lock, flags);
-	c = arm_vm_region_find(&consistent_head, (unsigned long)cpu_addr);
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
+	c = arm_vmregion_find(&consistent_head, (unsigned long)cpu_addr);
 	if (c) {
 		unsigned long off = vma->vm_pgoff;
 
@@ -399,8 +302,8 @@ EXPORT_SYMBOL(dma_mmap_writecombine);
 #ifdef CONFIG_MMU
 void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr_t handle)
 {
-	struct arm_vm_region *c;
-	unsigned long flags, addr;
+	struct arm_vmregion *c;
+	unsigned long addr;
 	pte_t *ptep;
 	int idx;
 	u32 off;
@@ -417,14 +320,10 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 
 	size = PAGE_ALIGN(size);
 
-	spin_lock_irqsave(&consistent_lock, flags);
-	c = arm_vm_region_find(&consistent_head, (unsigned long)cpu_addr);
+	c = arm_vmregion_find_remove(&consistent_head, (unsigned long)cpu_addr);
 	if (!c)
 		goto no_area;
 
-	c->vm_active = 0;
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
 	if ((c->vm_end - c->vm_start) != size) {
 		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
 		       __func__, c->vm_end - c->vm_start, size);
@@ -470,15 +369,10 @@ void dma_free_coherent(struct device *dev, size_t size, void *cpu_addr, dma_addr
 
 	flush_tlb_kernel_range(c->vm_start, c->vm_end);
 
-	spin_lock_irqsave(&consistent_lock, flags);
-	list_del(&c->vm_list);
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
-	kfree(c);
+	arm_vmregion_free(&consistent_head, c);
 	return;
 
  no_area:
-	spin_unlock_irqrestore(&consistent_lock, flags);
 	printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
 	       __func__, cpu_addr);
 	dump_stack();
diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
new file mode 100644
index 0000000..19e09bd
--- /dev/null
+++ b/arch/arm/mm/vmregion.c
@@ -0,0 +1,131 @@
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "vmregion.h"
+
+/*
+ * VM region handling support.
+ *
+ * This should become something generic, handling VM region allocations for
+ * vmalloc and similar (ioremap, module space, etc).
+ *
+ * I envisage vmalloc()'s supporting vm_struct becoming:
+ *
+ *  struct vm_struct {
+ *    struct vmregion	region;
+ *    unsigned long	flags;
+ *    struct page	**pages;
+ *    unsigned int	nr_pages;
+ *    unsigned long	phys_addr;
+ *  };
+ *
+ * get_vm_area() would then call vmregion_alloc with an appropriate
+ * struct vmregion head (eg):
+ *
+ *  struct vmregion vmalloc_head = {
+ *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
+ *	.vm_start	= VMALLOC_START,
+ *	.vm_end		= VMALLOC_END,
+ *  };
+ *
+ * However, vmalloc_head.vm_start is variable (typically, it is dependent on
+ * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
+ * would have to initialise this each time prior to calling vmregion_alloc().
+ */
+
+struct arm_vmregion *
+arm_vmregion_alloc(struct arm_vmregion_head *head, size_t size, gfp_t gfp)
+{
+	unsigned long addr = head->vm_start, end = head->vm_end - size;
+	unsigned long flags;
+	struct arm_vmregion *c, *new;
+
+	if (head->vm_end - head->vm_start < size) {
+		printk(KERN_WARNING "%s: allocation too big (requested %#x)\n",
+			__func__, size);
+		goto out;
+	}
+
+	new = kmalloc(sizeof(struct arm_vmregion), gfp);
+	if (!new)
+		goto out;
+
+	spin_lock_irqsave(&head->vm_lock, flags);
+
+	list_for_each_entry(c, &head->vm_list, vm_list) {
+		if ((addr + size) < addr)
+			goto nospc;
+		if ((addr + size) <= c->vm_start)
+			goto found;
+		addr = c->vm_end;
+		if (addr > end)
+			goto nospc;
+	}
+
+ found:
+	/*
+	 * Insert this entry _before_ the one we found.
+	 */
+	list_add_tail(&new->vm_list, &c->vm_list);
+	new->vm_start = addr;
+	new->vm_end = addr + size;
+	new->vm_active = 1;
+
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+	return new;
+
+ nospc:
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+	kfree(new);
+ out:
+	return NULL;
+}
+
+static struct arm_vmregion *__arm_vmregion_find(struct arm_vmregion_head *head, unsigned long addr)
+{
+	struct arm_vmregion *c;
+
+	list_for_each_entry(c, &head->vm_list, vm_list) {
+		if (c->vm_active && c->vm_start == addr)
+			goto out;
+	}
+	c = NULL;
+ out:
+	return c;
+}
+
+struct arm_vmregion *arm_vmregion_find(struct arm_vmregion_head *head, unsigned long addr)
+{
+	struct arm_vmregion *c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&head->vm_lock, flags);
+	c = __arm_vmregion_find(head, addr);
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+	return c;
+}
+
+struct arm_vmregion *arm_vmregion_find_remove(struct arm_vmregion_head *head, unsigned long addr)
+{
+	struct arm_vmregion *c;
+	unsigned long flags;
+
+	spin_lock_irqsave(&head->vm_lock, flags);
+	c = __arm_vmregion_find(head, addr);
+	if (c)
+		c->vm_active = 0;
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+	return c;
+}
+
+void arm_vmregion_free(struct arm_vmregion_head *head, struct arm_vmregion *c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&head->vm_lock, flags);
+	list_del(&c->vm_list);
+	spin_unlock_irqrestore(&head->vm_lock, flags);
+
+	kfree(c);
+}
diff --git a/arch/arm/mm/vmregion.h b/arch/arm/mm/vmregion.h
new file mode 100644
index 0000000..6b2cdbd
--- /dev/null
+++ b/arch/arm/mm/vmregion.h
@@ -0,0 +1,29 @@
+#ifndef VMREGION_H
+#define VMREGION_H
+
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
+struct page;
+
+struct arm_vmregion_head {
+	spinlock_t		vm_lock;
+	struct list_head	vm_list;
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+};
+
+struct arm_vmregion {
+	struct list_head	vm_list;
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+	struct page		*vm_pages;
+	int			vm_active;
+};
+
+struct arm_vmregion *arm_vmregion_alloc(struct arm_vmregion_head *, size_t, gfp_t);
+struct arm_vmregion *arm_vmregion_find(struct arm_vmregion_head *, unsigned long);
+struct arm_vmregion *arm_vmregion_find_remove(struct arm_vmregion_head *, unsigned long);
+void arm_vmregion_free(struct arm_vmregion_head *, struct arm_vmregion *);
+
+#endif
-- 
1.6.2.5
