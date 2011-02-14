From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 17:39:58 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page tables
Message-ID: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer processors like Cortex-A15 may cache entries in the higher page
table levels. These cached entries are ASID-tagged and are invalidated
during normal TLB operations.

When a level 2 (pte) page table is removed, the current code sequence
first clears the level 1 (pmd) entry, flushes the cache, frees the level
2 table and then invalidates the TLB. Because of the caching of the
higher page table entries, the processor may speculatively create a TLB
entry after the level 2 page table has been freed but before the TLB
invalidation. If such speculative PTW accesses random data, it could
create a global TLB entry that gets used for subsequent user space
accesses.

The patch ensures that the TLB is invalidated before the page table is
freed (pte_free_tlb). Since pte_free_tlb() does not get a vma structure,
the patch also introduces flush_tlb_user_page() which takes an mm_struct
rather than vma_struct. The original flush_tlb_page() is implemented as
a call to flush_tlb_user_page().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/tlb.h      |   17 +++++++++++++++--
 arch/arm/include/asm/tlbflush.h |   16 +++++++++++-----
 arch/arm/kernel/smp_tlb.c       |   11 ++++++-----
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index f41a6f5..565403a 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -102,8 +102,21 @@ tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
 }
 
 #define tlb_remove_page(tlb,page)	free_page_and_swap_cache(page)
-#define pte_free_tlb(tlb, ptep, addr)	pte_free((tlb)->mm, ptep)
-#define pmd_free_tlb(tlb, pmdp, addr)	pmd_free((tlb)->mm, pmdp)
+
+static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
+				unsigned long addr)
+{
+#if __LINUX_ARM_ARCH__ >= 7
+	flush_tlb_user_page(tlb->mm, addr);
+#endif
+	pte_free(tlb->mm, pte);
+}
+
+static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
+				unsigned long addr)
+{
+	pmd_free(tlb->mm, pmdp);
+}
 
 #define tlb_migrate_finish(mm)		do { } while (0)
 
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index ce7378e..7bd9c52cd 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -408,17 +408,17 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 }
 
 static inline void
-local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
+local_flush_tlb_user_page(struct mm_struct *mm, unsigned long uaddr)
 {
 	const int zero = 0;
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
+	uaddr = (uaddr & PAGE_MASK) | ASID(mm);
 
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
 		if (tlb_flag(TLB_V3_PAGE))
 			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (uaddr) : "cc");
 		if (tlb_flag(TLB_V4_U_PAGE))
@@ -556,19 +556,25 @@ static inline void clean_pmd_entry(pmd_t *pmd)
 #ifndef CONFIG_SMP
 #define flush_tlb_all		local_flush_tlb_all
 #define flush_tlb_mm		local_flush_tlb_mm
-#define flush_tlb_page		local_flush_tlb_page
+#define flush_tlb_user_page	local_flush_tlb_user_page
 #define flush_tlb_kernel_page	local_flush_tlb_kernel_page
 #define flush_tlb_range		local_flush_tlb_range
 #define flush_tlb_kernel_range	local_flush_tlb_kernel_range
 #else
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
-extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr);
+extern void flush_tlb_user_page(struct mm_struct *mm, unsigned long uaddr);
 extern void flush_tlb_kernel_page(unsigned long kaddr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 #endif
 
+static inline void
+flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
+{
+	flush_tlb_user_page(vma->vm_mm, uaddr);
+}
+
 /*
  * If PG_dcache_clean is not set for the page, we need to ensure that any
  * cache entries for the kernels virtual memory range are written
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 7dcb352..8f57f32 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -32,6 +32,7 @@ static void on_each_cpu_mask(void (*func)(void *), void *info, int wait,
  */
 struct tlb_args {
 	struct vm_area_struct *ta_vma;
+	struct mm_struct *ta_mm;
 	unsigned long ta_start;
 	unsigned long ta_end;
 };
@@ -52,7 +53,7 @@ static inline void ipi_flush_tlb_page(void *arg)
 {
 	struct tlb_args *ta = (struct tlb_args *)arg;
 
-	local_flush_tlb_page(ta->ta_vma, ta->ta_start);
+	local_flush_tlb_user_page(ta->ta_mm, ta->ta_start);
 }
 
 static inline void ipi_flush_tlb_kernel_page(void *arg)
@@ -92,15 +93,15 @@ void flush_tlb_mm(struct mm_struct *mm)
 		local_flush_tlb_mm(mm);
 }
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
+void flush_tlb_user_page(struct mm_struct *mm, unsigned long uaddr)
 {
 	if (tlb_ops_need_broadcast()) {
 		struct tlb_args ta;
-		ta.ta_vma = vma;
+		ta.ta_mm = mm;
 		ta.ta_start = uaddr;
-		on_each_cpu_mask(ipi_flush_tlb_page, &ta, 1, mm_cpumask(vma->vm_mm));
+		on_each_cpu_mask(ipi_flush_tlb_page, &ta, 1, mm_cpumask(mm));
 	} else
-		local_flush_tlb_page(vma, uaddr);
+		local_flush_tlb_user_page(mm, uaddr);
 }
 
 void flush_tlb_kernel_page(unsigned long kaddr)
