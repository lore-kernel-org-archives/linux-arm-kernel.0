From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 May 2013 17:54:37 +0100
Subject: [PATCH 1/2] ARM: tlb: don't perform inner-shareable invalidation for
 local TLB ops
Message-ID: <1368809678-25818-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inner-shareable TLB invalidation is typically more expensive than local
(non-shareable) invalidation, so performing the broadcasting for
local_flush_tlb_* operations is a waste of cycles and needlessly
clobbers entries in the TLBs of other CPUs.

This patch introduces __flush_tlb_* versions for many of the TLB
invalidation functions, which only respect inner-shareable variants of
the invalidation instructions. This allows us to modify the v7 SMP TLB
flags to include *both* inner-shareable and non-shareable operations and
then check the relevant flags depending on whether the operation is
local or not.

This gains us around 0.5% in hackbench scores for a dual-core A15, but I
would expect this to improve as more cores (and clusters) are added to
the equation.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Albin Tonnerre <Albin.Tonnerre@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 67 ++++++++++++++++++++++++++++++++++++++---
 arch/arm/kernel/smp_tlb.c       |  8 ++---
 arch/arm/mm/context.c           |  6 +---
 3 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index a3625d1..55b5e18 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -167,6 +167,8 @@
 #endif
 
 #define v7wbi_tlb_flags_smp	(TLB_WB | TLB_BARRIER | \
+				 TLB_V6_U_FULL | TLB_V6_U_PAGE | \
+				 TLB_V6_U_ASID | \
 				 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | \
 				 TLB_V7_UIS_ASID | TLB_V7_UIS_BP)
 #define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BARRIER | \
@@ -330,6 +332,21 @@ static inline void local_flush_tlb_all(void)
 	tlb_op(TLB_V4_U_FULL | TLB_V6_U_FULL, "c8, c7, 0", zero);
 	tlb_op(TLB_V4_D_FULL | TLB_V6_D_FULL, "c8, c6, 0", zero);
 	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
+
+	if (tlb_flag(TLB_BARRIER)) {
+		dsb();
+		isb();
+	}
+}
+
+static inline void __flush_tlb_all(void)
+{
+	const int zero = 0;
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	if (tlb_flag(TLB_WB))
+		dsb();
+
 	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
 
 	if (tlb_flag(TLB_BARRIER)) {
@@ -348,21 +365,32 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 		dsb();
 
 	if (possible_tlb_flags & (TLB_V4_U_FULL|TLB_V4_D_FULL|TLB_V4_I_FULL)) {
-		if (cpumask_test_cpu(get_cpu(), mm_cpumask(mm))) {
+		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
 			tlb_op(TLB_V4_U_FULL, "c8, c7, 0", zero);
 			tlb_op(TLB_V4_D_FULL, "c8, c6, 0", zero);
 			tlb_op(TLB_V4_I_FULL, "c8, c5, 0", zero);
 		}
-		put_cpu();
 	}
 
 	tlb_op(TLB_V6_U_ASID, "c8, c7, 2", asid);
 	tlb_op(TLB_V6_D_ASID, "c8, c6, 2", asid);
 	tlb_op(TLB_V6_I_ASID, "c8, c5, 2", asid);
+
+	if (tlb_flag(TLB_BARRIER))
+		dsb();
+}
+
+static inline void __flush_tlb_mm(struct mm_struct *mm)
+{
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	if (tlb_flag(TLB_WB))
+		dsb();
+
 #ifdef CONFIG_ARM_ERRATA_720789
-	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", zero);
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", 0);
 #else
-	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", asid);
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", ASID(mm));
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
@@ -392,6 +420,21 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", uaddr);
 	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", uaddr);
 	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", uaddr);
+
+	if (tlb_flag(TLB_BARRIER))
+		dsb();
+}
+
+static inline void
+__flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
+{
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
+
+	if (tlb_flag(TLB_WB))
+		dsb();
+
 #ifdef CONFIG_ARM_ERRATA_720789
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 3", uaddr & PAGE_MASK);
 #else
@@ -421,6 +464,22 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", kaddr);
 	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", kaddr);
 	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", kaddr);
+
+	if (tlb_flag(TLB_BARRIER)) {
+		dsb();
+		isb();
+	}
+}
+
+static inline void __flush_tlb_kernel_page(unsigned long kaddr)
+{
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	kaddr &= PAGE_MASK;
+
+	if (tlb_flag(TLB_WB))
+		dsb();
+
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 1", kaddr);
 
 	if (tlb_flag(TLB_BARRIER)) {
diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
index 9a52a07..cc299b5 100644
--- a/arch/arm/kernel/smp_tlb.c
+++ b/arch/arm/kernel/smp_tlb.c
@@ -135,7 +135,7 @@ void flush_tlb_all(void)
 	if (tlb_ops_need_broadcast())
 		on_each_cpu(ipi_flush_tlb_all, NULL, 1);
 	else
-		local_flush_tlb_all();
+		__flush_tlb_all();
 	broadcast_tlb_a15_erratum();
 }
 
@@ -144,7 +144,7 @@ void flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_ops_need_broadcast())
 		on_each_cpu_mask(mm_cpumask(mm), ipi_flush_tlb_mm, mm, 1);
 	else
-		local_flush_tlb_mm(mm);
+		__flush_tlb_mm(mm);
 	broadcast_tlb_mm_a15_erratum(mm);
 }
 
@@ -157,7 +157,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		on_each_cpu_mask(mm_cpumask(vma->vm_mm), ipi_flush_tlb_page,
 					&ta, 1);
 	} else
-		local_flush_tlb_page(vma, uaddr);
+		__flush_tlb_page(vma, uaddr);
 	broadcast_tlb_mm_a15_erratum(vma->vm_mm);
 }
 
@@ -168,7 +168,7 @@ void flush_tlb_kernel_page(unsigned long kaddr)
 		ta.ta_start = kaddr;
 		on_each_cpu(ipi_flush_tlb_kernel_page, &ta, 1);
 	} else
-		local_flush_tlb_kernel_page(kaddr);
+		__flush_tlb_kernel_page(kaddr);
 	broadcast_tlb_a15_erratum();
 }
 
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 2ac3737..62c1ec5 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -134,10 +134,7 @@ static void flush_context(unsigned int cpu)
 	}
 
 	/* Queue a TLB invalidate and flush the I-cache if necessary. */
-	if (!tlb_ops_need_broadcast())
-		cpumask_set_cpu(cpu, &tlb_flush_pending);
-	else
-		cpumask_setall(&tlb_flush_pending);
+	cpumask_setall(&tlb_flush_pending);
 
 	if (icache_is_vivt_asid_tagged())
 		__flush_icache_all();
@@ -215,7 +212,6 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending)) {
 		local_flush_bp_all();
 		local_flush_tlb_all();
-		dummy_flush_tlb_a15_erratum();
 	}
 
 	atomic64_set(&per_cpu(active_asids, cpu), asid);
-- 
1.8.2.2
