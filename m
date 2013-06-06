From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Jun 2013 15:28:32 +0100
Subject: [PATCH 08/10] ARM: tlb: reduce scope of barrier domains for TLB
 invalidation
In-Reply-To: <1370528914-17506-1-git-send-email-will.deacon@arm.com>
References: <1370528914-17506-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370528914-17506-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our TLB invalidation routines may require a barrier before the
maintenance (in order to ensure pending page table writes are visible to
the hardware walker) and barriers afterwards (in order to ensure
completion of the maintenance and visibility in the instruction stream).

Whilst this is expensive, the cost can be reduced somewhat by reducing
the scope of the barrier instructions:

  - The barrier before only needs to apply to stores (pte writes)
  - Local ops are required only to affect the non-shareable domain
  - Global ops are required only to affect the inner-shareable domain

This patch makes these changes for the TLB flushing code.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 0bdd5d2d..77350a2 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -327,14 +327,14 @@ static inline void local_flush_tlb_all(void)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	tlb_op(TLB_V4_U_FULL | TLB_V6_U_FULL, "c8, c7, 0", zero);
 	tlb_op(TLB_V4_D_FULL | TLB_V6_D_FULL, "c8, c6, 0", zero);
 	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(nsh);
 		isb();
 	}
 }
@@ -345,12 +345,12 @@ static inline void __flush_tlb_all(void)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(ish);
 		isb();
 	}
 }
@@ -362,7 +362,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	if (possible_tlb_flags & (TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
 		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
@@ -377,7 +377,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	tlb_op(TLB_V6_I_ASID, "c8, c5, 2", asid);
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(nsh);
 }
 
 static inline void __flush_tlb_mm(struct mm_struct *mm)
@@ -385,7 +385,7 @@ static inline void __flush_tlb_mm(struct mm_struct *mm)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 #ifdef CONFIG_ARM_ERRATA_720789
 	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", 0);
@@ -394,7 +394,7 @@ static inline void __flush_tlb_mm(struct mm_struct *mm)
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(ish);
 }
 
 static inline void
@@ -406,7 +406,7 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	if (possible_tlb_flags & (TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
 	    cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
@@ -422,7 +422,7 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", uaddr);
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(nsh);
 }
 
 static inline void
@@ -433,7 +433,7 @@ __flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 #ifdef CONFIG_ARM_ERRATA_720789
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 3", uaddr & PAGE_MASK);
@@ -442,7 +442,7 @@ __flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(ish);
 }
 
 static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
@@ -453,7 +453,7 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	kaddr &= PAGE_MASK;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", kaddr);
 	tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", kaddr);
@@ -466,7 +466,7 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", kaddr);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(nsh);
 		isb();
 	}
 }
@@ -478,12 +478,12 @@ static inline void __flush_tlb_kernel_page(unsigned long kaddr)
 	kaddr &= PAGE_MASK;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", kaddr);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(ish);
 		isb();
 	}
 }
@@ -517,7 +517,7 @@ static inline void dummy_flush_tlb_a15_erratum(void)
 	 * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
 	 */
 	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
-	dsb();
+	dsb(ish);
 }
 #else
 static inline void dummy_flush_tlb_a15_erratum(void)
@@ -546,7 +546,7 @@ static inline void flush_pmd_entry(void *pmd)
 	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 }
 
 static inline void clean_pmd_entry(void *pmd)
-- 
1.8.2.2
