From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:02:22 +0000
Subject: [PATCH] ARM: add dma coherent region reporting via procfs
Message-ID: <E1RoBIc-0005U3-UH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new seqfile for reporting coherent DMA allocations.  This contains
the address range, size and the function which was used to allocate
each region, allowing these allocations to be viewed in much the same
way as /proc/vmallocinfo.

The DMA coherent region has limited space, so this allows allocation
failures to be viewed, as well as finding out how much space is being
used.

Make sure this file is only readable by root - same as vmallocinfo - to
prevent information leakage.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/dma-mapping.c |   20 ++++++++----
 arch/arm/mm/vmregion.c    |   76 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mm/vmregion.h    |    5 ++-
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1aa664a..db23ae4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -214,7 +214,8 @@ static int __init consistent_init(void)
 core_initcall(consistent_init);
 
 static void *
-__dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
+__dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
+	const void *caller)
 {
 	struct arm_vmregion *c;
 	size_t align;
@@ -241,7 +242,7 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
 	 * Allocate a virtual address in the consistent mapping region.
 	 */
 	c = arm_vmregion_alloc(&consistent_head, align, size,
-			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
+			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM), caller);
 	if (c) {
 		pte_t *pte;
 		int idx = CONSISTENT_PTE_INDEX(c->vm_start);
@@ -320,14 +321,14 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 
 #else	/* !CONFIG_MMU */
 
-#define __dma_alloc_remap(page, size, gfp, prot)	page_address(page)
+#define __dma_alloc_remap(page, size, gfp, prot, c)	page_address(page)
 #define __dma_free_remap(addr, size)			do { } while (0)
 
 #endif	/* CONFIG_MMU */
 
 static void *
 __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
-	    pgprot_t prot)
+	    pgprot_t prot, const void *caller)
 {
 	struct page *page;
 	void *addr;
@@ -349,7 +350,7 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 		return NULL;
 
 	if (!arch_is_coherent())
-		addr = __dma_alloc_remap(page, size, gfp, prot);
+		addr = __dma_alloc_remap(page, size, gfp, prot, caller);
 	else
 		addr = page_address(page);
 
@@ -374,7 +375,8 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gf
 		return memory;
 
 	return __dma_alloc(dev, size, handle, gfp,
-			   pgprot_dmacoherent(pgprot_kernel));
+			   pgprot_dmacoherent(pgprot_kernel),
+			   __builtin_return_address(0));
 }
 EXPORT_SYMBOL(dma_alloc_coherent);
 
@@ -386,7 +388,8 @@ void *
 dma_alloc_writecombine(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
 {
 	return __dma_alloc(dev, size, handle, gfp,
-			   pgprot_writecombine(pgprot_kernel));
+			   pgprot_writecombine(pgprot_kernel),
+			   __builtin_return_address(0));
 }
 EXPORT_SYMBOL(dma_alloc_writecombine);
 
@@ -723,6 +726,9 @@ EXPORT_SYMBOL(dma_set_mask);
 
 static int __init dma_debug_do_init(void)
 {
+#ifdef CONFIG_MMU
+	arm_vmregion_create_proc("dma-mappings", &consistent_head);
+#endif
 	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
 	return 0;
 }
diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
index 036fdbf..a631016 100644
--- a/arch/arm/mm/vmregion.c
+++ b/arch/arm/mm/vmregion.c
@@ -1,5 +1,8 @@
+#include <linux/fs.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 #include "vmregion.h"
@@ -36,7 +39,7 @@
 
 struct arm_vmregion *
 arm_vmregion_alloc(struct arm_vmregion_head *head, size_t align,
-		   size_t size, gfp_t gfp)
+		   size_t size, gfp_t gfp, const void *caller)
 {
 	unsigned long start = head->vm_start, addr = head->vm_end;
 	unsigned long flags;
@@ -52,6 +55,8 @@ arm_vmregion_alloc(struct arm_vmregion_head *head, size_t align,
 	if (!new)
 		goto out;
 
+	new->caller = caller;
+
 	spin_lock_irqsave(&head->vm_lock, flags);
 
 	addr = rounddown(addr - size, align);
@@ -129,3 +134,72 @@ void arm_vmregion_free(struct arm_vmregion_head *head, struct arm_vmregion *c)
 
 	kfree(c);
 }
+
+#ifdef CONFIG_PROC_FS
+static int arm_vmregion_show(struct seq_file *m, void *p)
+{
+	struct arm_vmregion *c = list_entry(p, struct arm_vmregion, vm_list);
+
+	seq_printf(m, "0x%08lx-0x%08lx %7lu", c->vm_start, c->vm_end,
+		c->vm_end - c->vm_start);
+	if (c->caller)
+		seq_printf(m, " %pS", (void *)c->caller);
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static void *arm_vmregion_start(struct seq_file *m, loff_t *pos)
+{
+	struct arm_vmregion_head *h = m->private;
+	spin_lock_irq(&h->vm_lock);
+	return seq_list_start(&h->vm_list, *pos);
+}
+
+static void *arm_vmregion_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct arm_vmregion_head *h = m->private;
+	return seq_list_next(p, &h->vm_list, pos);
+}
+
+static void arm_vmregion_stop(struct seq_file *m, void *p)
+{
+	struct arm_vmregion_head *h = m->private;
+	spin_unlock_irq(&h->vm_lock);
+}
+
+static const struct seq_operations arm_vmregion_ops = {
+	.start	= arm_vmregion_start,
+	.stop	= arm_vmregion_stop,
+	.next	= arm_vmregion_next,
+	.show	= arm_vmregion_show,
+};
+
+static int arm_vmregion_open(struct inode *inode, struct file *file)
+{
+	struct arm_vmregion_head *h = PDE(inode)->data;
+	int ret = seq_open(file, &arm_vmregion_ops);
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		m->private = h;
+	}
+	return ret;
+}
+
+static const struct file_operations arm_vmregion_fops = {
+	.open	= arm_vmregion_open,
+	.read	= seq_read,
+	.llseek	= seq_lseek,
+	.release = seq_release,
+};
+
+int arm_vmregion_create_proc(const char *path, struct arm_vmregion_head *h)
+{
+	proc_create_data(path, S_IRUSR, NULL, &arm_vmregion_fops, h);
+	return 0;
+}
+#else
+int arm_vmregion_create_proc(const char *path, struct arm_vmregion_head *h)
+{
+	return 0;
+}
+#endif
diff --git a/arch/arm/mm/vmregion.h b/arch/arm/mm/vmregion.h
index 15e9f04..162be66 100644
--- a/arch/arm/mm/vmregion.h
+++ b/arch/arm/mm/vmregion.h
@@ -19,11 +19,14 @@ struct arm_vmregion {
 	unsigned long		vm_end;
 	struct page		*vm_pages;
 	int			vm_active;
+	const void		*caller;
 };
 
-struct arm_vmregion *arm_vmregion_alloc(struct arm_vmregion_head *, size_t, size_t, gfp_t);
+struct arm_vmregion *arm_vmregion_alloc(struct arm_vmregion_head *, size_t, size_t, gfp_t, const void *);
 struct arm_vmregion *arm_vmregion_find(struct arm_vmregion_head *, unsigned long);
 struct arm_vmregion *arm_vmregion_find_remove(struct arm_vmregion_head *, unsigned long);
 void arm_vmregion_free(struct arm_vmregion_head *, struct arm_vmregion *);
 
+int arm_vmregion_create_proc(const char *, struct arm_vmregion_head *);
+
 #endif
-- 
1.7.4.4
