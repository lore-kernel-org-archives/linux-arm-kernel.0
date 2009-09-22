From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Sep 2009 18:17:23 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1253614753.14049.47.camel@pc1117.cambridge.arm.com>
References: <20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921213802.GH30821@n2100.arm.linux.org.uk>
	<1253614753.14049.47.camel@pc1117.cambridge.arm.com>
Message-ID: <1253639843.14049.95.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-09-22 at 11:19 +0100, Catalin Marinas wrote:
> Yet another idea - add a generic flush_cache_range_for_mprotect()
> function with a specific implementation for ARM (called via
> change_protection).

The patch below looks like the best option in my opinion but requires
some generic kernel changes (minimal though). The patch contains the
ARM-specific code as well but can be split in two for pushing upstream.

Apart from this patch, I ran some lmbench tests and my workaround
affects mmap tests quite a lot because of the read-implies-exec forcing
flush_cache_range() in several places. Russell's patch for adding cache
flushing during CoW (either coherent_kernel_range or flush_dcache_page)
slows the fork() tests a bit but the lmbench tests are relatively small
and don't cause a lot of page CoW. This may be different for something
like apache.


Add generic flush_prot_range() and ARM-specific implementation

From: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/cacheflush.h |    3 +++
 arch/arm/mm/cache-v6.S            |   20 ++++++++++++++++++--
 arch/arm/mm/cache-v7.S            |   19 +++++++++++++++++--
 arch/arm/mm/flush.c               |   19 +++++++++++++++++++
 include/linux/highmem.h           |    8 ++++++++
 mm/hugetlb.c                      |    2 +-
 mm/mprotect.c                     |    2 +-
 7 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 91aec14..d53832b 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -391,12 +391,15 @@ flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 	}
 }
 #else
+#define ARCH_HAS_FLUSH_PROT_RANGE
 extern void flush_cache_mm(struct mm_struct *mm);
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn);
 extern void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 				unsigned long uaddr, void *kaddr,
 				unsigned long len, int write);
+extern void flush_prot_range(struct vm_area_struct *vma, unsigned long start,
+			     unsigned long end);
 #endif
 
 #define flush_cache_dup_mm(mm) flush_cache_mm(mm)
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 8364f6c..7baa6ce 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -12,6 +12,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 #include "proc-macros.S"
 
@@ -129,11 +130,13 @@ ENTRY(v6_coherent_kern_range)
  *	- the Icache does not read data from the write buffer
  */
 ENTRY(v6_coherent_user_range)
-
+ UNWIND(.fnstart		)
 #ifdef HARVARD_CACHE
 	bic	r0, r0, #CACHE_LINE_SIZE - 1
-1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D line
+1:
+ USER(	mcr	p15, 0, r0, c7, c10, 1	)	@ clean D line
 	add	r0, r0, #CACHE_LINE_SIZE
+2:
 	cmp	r0, r1
 	blo	1b
 #endif
@@ -151,6 +154,19 @@ ENTRY(v6_coherent_user_range)
 	mov	pc, lr
 
 /*
+ * Fault handling for the cache operation above. If the virtual address in r0
+ * isn't mapped, just try the next page.
+ */
+9001:
+	mov	r0, r0, lsr #12
+	mov	r0, r0, lsl #12
+	add	r0, r0, #4096
+	b	2b
+ UNWIND(.fnend		)
+ENDPROC(v6_coherent_user_range)
+ENDPROC(v6_coherent_kern_range)
+
+/*
  *	v6_flush_kern_dcache_page(kaddr)
  *
  *	Ensure that the data held in the page kaddr is written back
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 29e6904..4b733d1 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
+#include <asm/unwind.h>
 
 #include "proc-macros.S"
 
@@ -153,13 +154,16 @@ ENTRY(v7_coherent_kern_range)
  *	- the Icache does not read data from the write buffer
  */
 ENTRY(v7_coherent_user_range)
+ UNWIND(.fnstart		)
 	dcache_line_size r2, r3
 	sub	r3, r2, #1
 	bic	r0, r0, r3
-1:	mcr	p15, 0, r0, c7, c11, 1		@ clean D line to the point of unification
+1:
+ USER(	mcr	p15, 0, r0, c7, c11, 1	)	@ clean D line to the point of unification
 	dsb
-	mcr	p15, 0, r0, c7, c5, 1		@ invalidate I line
+ USER(	mcr	p15, 0, r0, c7, c5, 1	)	@ invalidate I line
 	add	r0, r0, r2
+2:
 	cmp	r0, r1
 	blo	1b
 	mov	r0, #0
@@ -167,6 +171,17 @@ ENTRY(v7_coherent_user_range)
 	dsb
 	isb
 	mov	pc, lr
+
+/*
+ * Fault handling for the cache operation above. If the virtual address in r0
+ * isn't mapped, just try the next page.
+ */
+9001:
+	mov	r0, r0, lsr #12
+	mov	r0, r0, lsl #12
+	add	r0, r0, #4096
+	b	2b
+ UNWIND(.fnend		)
 ENDPROC(v7_coherent_kern_range)
 ENDPROC(v7_coherent_user_range)
 
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 73b886e..ed07f4d 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -87,6 +87,25 @@ void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned
 	}
 }
 
+void flush_prot_range(struct vm_area_struct *vma, unsigned long start,
+		      unsigned long end)
+{
+	if (cache_is_vipt_nonaliasing()) {
+		if (vma->vm_flags & VM_EXEC) {
+			/*
+			 * Increment the task's preempt_count so that
+			 * in_atomic() is true and do_page_fault() does not
+			 * try to map pages in. If a page isn't mapped yet, it
+			 * will be ignored.
+			 */
+			inc_preempt_count();
+			flush_cache_user_range(vma, start, end);
+			dec_preempt_count();
+		}
+	} else
+		flush_cache_range(vma, start, end);
+}
+
 void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsigned long pfn)
 {
 	if (cache_is_vivt()) {
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 13875ce..067e67d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -19,6 +19,14 @@ static inline void flush_kernel_dcache_page(struct page *page)
 }
 #endif
 
+#ifndef ARCH_HAS_FLUSH_PROT_RANGE
+static inline void flush_prot_range(struct vm_area_struct *vma,
+				    unsigned long start, unsigned long end)
+{
+	flush_cache_range(vma, start, end);
+}
+#endif
+
 #ifdef CONFIG_HIGHMEM
 
 #include <asm/highmem.h>
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6058b53..7ce4f57 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2213,7 +2213,7 @@ void hugetlb_change_protection(struct vm_area_struct *vma,
 	struct hstate *h = hstate_vma(vma);
 
 	BUG_ON(address >= end);
-	flush_cache_range(vma, address, end);
+	flush_prot_range(vma, address, end);
 
 	spin_lock(&vma->vm_file->f_mapping->i_mmap_lock);
 	spin_lock(&mm->page_table_lock);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index fded06f..a6b7616 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -123,7 +123,7 @@ static void change_protection(struct vm_area_struct *vma,
 
 	BUG_ON(addr >= end);
 	pgd = pgd_offset(mm, addr);
-	flush_cache_range(vma, addr, end);
+	flush_prot_range(vma, addr, end);
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))


-- 
Catalin
