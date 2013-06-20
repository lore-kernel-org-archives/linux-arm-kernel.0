From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:20 +0100
Subject: [PATCH v2 06/12] ARM: tlb: reduce scope of barrier domains for TLB
 invalidation
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-7-git-send-email-will.deacon@arm.com>
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
index b9c0811..39eddeb 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -335,13 +335,13 @@ static inline void local_flush_tlb_all(void)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	__local_flush_tlb_all();
 	tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(nsh);
 		isb();
 	}
 }
@@ -352,13 +352,13 @@ static inline void __flush_tlb_all(void)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 	__local_flush_tlb_all();
 	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(ish);
 		isb();
 	}
 }
@@ -388,13 +388,13 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	__local_flush_tlb_mm(mm);
 	tlb_op(TLB_V7_UIS_ASID, "c8, c7, 2", asid);
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(nsh);
 }
 
 static inline void __flush_tlb_mm(struct mm_struct *mm)
@@ -402,7 +402,7 @@ static inline void __flush_tlb_mm(struct mm_struct *mm)
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 	__local_flush_tlb_mm(mm);
 #ifdef CONFIG_ARM_ERRATA_720789
@@ -412,7 +412,7 @@ static inline void __flush_tlb_mm(struct mm_struct *mm)
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(ish);
 }
 
 static inline void
@@ -445,13 +445,13 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	__local_flush_tlb_page(vma, uaddr);
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c7, 1", uaddr);
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(nsh);
 }
 
 static inline void
@@ -462,7 +462,7 @@ __flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 	__local_flush_tlb_page(vma, uaddr);
 #ifdef CONFIG_ARM_ERRATA_720789
@@ -472,7 +472,7 @@ __flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
-		dsb();
+		dsb(ish);
 }
 
 static inline void __local_flush_tlb_kernel_page(unsigned long kaddr)
@@ -498,13 +498,13 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	kaddr &= PAGE_MASK;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(nshst);
 
 	__local_flush_tlb_kernel_page(kaddr);
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c7, 1", kaddr);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(nsh);
 		isb();
 	}
 }
@@ -516,13 +516,13 @@ static inline void __flush_tlb_kernel_page(unsigned long kaddr)
 	kaddr &= PAGE_MASK;
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 
 	__local_flush_tlb_kernel_page(kaddr);
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", kaddr);
 
 	if (tlb_flag(TLB_BARRIER)) {
-		dsb();
+		dsb(ish);
 		isb();
 	}
 }
@@ -567,7 +567,7 @@ static inline void dummy_flush_tlb_a15_erratum(void)
 	 * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
 	 */
 	asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
-	dsb();
+	dsb(ish);
 }
 #else
 static inline void dummy_flush_tlb_a15_erratum(void)
@@ -596,7 +596,7 @@ static inline void flush_pmd_entry(void *pmd)
 	tlb_l2_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
 
 	if (tlb_flag(TLB_WB))
-		dsb();
+		dsb(ishst);
 }
 
 static inline void clean_pmd_entry(void *pmd)
-- 
1.8.2.2
