From: ddaney.cavm@gmail.com (David Daney)
Date: Sat, 11 Jul 2015 13:25:23 -0700
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

Most broadcast TLB invalidations are unnecessary.  So when
invalidating for a given mm/vma target the only the needed CPUs via
and IPI.

For global TLB invalidations, also use IPI.

Tested on Cavium ThunderX.

This change reduces 'time make -j48' on kernel from 139s to 116s (83%
as long).

The patch is needed because of a ThunderX Pass1 erratum: Exclusive
store operations unreliable in the presence of broadcast TLB
invalidations.  The performance improvements shown make it compelling
even without the erratum workaround need.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/include/asm/tlbflush.h | 67 ++++++---------------------------------
 arch/arm64/mm/flush.c             | 46 +++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 42c09ec..2c132b0 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -63,46 +63,22 @@
  *		only require the D-TLB to be invalidated.
  *		- kaddr - Kernel virtual memory address
  */
-static inline void flush_tlb_all(void)
-{
-	dsb(ishst);
-	asm("tlbi	vmalle1is");
-	dsb(ish);
-	isb();
-}
-
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-	unsigned long asid = (unsigned long)ASID(mm) << 48;
+void flush_tlb_all(void);
 
-	dsb(ishst);
-	asm("tlbi	aside1is, %0" : : "r" (asid));
-	dsb(ish);
-}
+void flush_tlb_mm(struct mm_struct *mm);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long uaddr)
 {
-	unsigned long addr = uaddr >> 12 |
-		((unsigned long)ASID(vma->vm_mm) << 48);
-
-	dsb(ishst);
-	asm("tlbi	vae1is, %0" : : "r" (addr));
-	dsb(ish);
+	/* Simplify to entire mm. */
+	flush_tlb_mm(vma->vm_mm);
 }
 
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end)
 {
-	unsigned long asid = (unsigned long)ASID(vma->vm_mm) << 48;
-	unsigned long addr;
-	start = asid | (start >> 12);
-	end = asid | (end >> 12);
-
-	dsb(ishst);
-	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
-		asm("tlbi vae1is, %0" : : "r"(addr));
-	dsb(ish);
+	/* Simplify to entire mm. */
+	flush_tlb_mm(vma->vm_mm);
 }
 
 static inline void flush_tlb_all_local(void)
@@ -112,40 +88,17 @@ static inline void flush_tlb_all_local(void)
 	isb();
 }
 
-static inline void __flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-	unsigned long addr;
-	start >>= 12;
-	end >>= 12;
-
-	dsb(ishst);
-	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
-		asm("tlbi vaae1is, %0" : : "r"(addr));
-	dsb(ish);
-	isb();
-}
-
-/*
- * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
- * necessarily a performance improvement.
- */
-#define MAX_TLB_RANGE	(1024UL << PAGE_SHIFT)
-
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
-	if ((end - start) <= MAX_TLB_RANGE)
-		__flush_tlb_range(vma, start, end);
-	else
-		flush_tlb_mm(vma->vm_mm);
+	/* Simplify to entire mm. */
+	flush_tlb_mm(vma->vm_mm);
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	if ((end - start) <= MAX_TLB_RANGE)
-		__flush_tlb_kernel_range(start, end);
-	else
-		flush_tlb_all();
+	/* Simplify to all. */
+	flush_tlb_all();
 }
 
 /*
diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index 4dfa397..45f24d3 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -20,6 +20,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/smp.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
@@ -27,6 +28,51 @@
 
 #include "mm.h"
 
+static void flush_tlb_local(void *info)
+{
+	asm volatile("\n"
+		     "	tlbi	vmalle1\n"
+		     "	isb	sy"
+		);
+}
+
+static void flush_tlb_mm_local(void *info)
+{
+	unsigned long asid = (unsigned long)info;
+
+	asm volatile("\n"
+		     "	tlbi	aside1, %0\n"
+		     "	isb	sy"
+		     : : "r" (asid)
+		);
+}
+
+void flush_tlb_all(void)
+{
+	/* Make sure page table modifications are visible. */
+	dsb(ishst);
+	/* IPI to all CPUs to do local flush. */
+	on_each_cpu(flush_tlb_local, NULL, 1);
+
+}
+EXPORT_SYMBOL(flush_tlb_all);
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	if (!mm) {
+		flush_tlb_all();
+	} else {
+		unsigned long asid = (unsigned long)ASID(mm) << 48;
+		/* Make sure page table modifications are visible. */
+		dsb(ishst);
+		/* IPI to all CPUs to do local flush. */
+		on_each_cpu_mask(mm_cpumask(mm),
+				 flush_tlb_mm_local, (void *)asid, 1);
+	}
+
+}
+EXPORT_SYMBOL(flush_tlb_mm);
+
 void flush_cache_range(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end)
 {
-- 
1.9.1
