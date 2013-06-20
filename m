From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 15:21:16 +0100
Subject: [PATCH v2 02/12] ARM: tlb: don't perform inner-shareable invalidation
 for local TLB ops
In-Reply-To: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
References: <1371738086-6707-1-git-send-email-will.deacon@arm.com>
Message-ID: <1371738086-6707-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inner-shareable TLB invalidation is typically more expensive than local
(non-shareable) invalidation, so performing the broadcasting for
local_flush_tlb_* operations is a waste of cycles and needlessly
clobbers entries in the TLBs of other CPUs.

This patch introduces __flush_tlb_* versions for many of the TLB
invalidation functions, which only respect inner-shareable variants of
the invalidation instructions when presented with the TLB_V7_UIS_FULL
flag. The local version is also inlined to prevent SMP_ON_UP kernels
from missing flushes, where the __flush variant would be called with
the UP flags.

This gains us around 0.5% in hackbench scores for a dual-core A15, but I
would expect this to improve as more cores (and clusters) are added to
the equation.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Albin Tonnerre <Albin.Tonnerre@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/tlbflush.h | 138 ++++++++++++++++++++++++++++++++++------
 arch/arm/kernel/smp_tlb.c       |   8 +--
 arch/arm/mm/context.c           |   6 +-
 3 files changed, 123 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index a3625d1..91b2922 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -319,6 +319,16 @@ extern struct cpu_tlb_fns cpu_tlb;
 #define tlb_op(f, regs, arg)	__tlb_op(f, "p15, 0, %0, " regs, arg)
 #define tlb_l2_op(f, regs, arg)	__tlb_op(f, "p15, 1, %0, " regs, arg)
 
+static inline void __local_flush_tlb_all(void)
+{
+	const int zero = 0;
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	tlb_op(TLB_V4_U_FULL | TLB_V6_U_FULL, "c8, c7, 0", zero);
+	tlb_op(TLB_V4_D_FULL | TLB_V6_D_FULL, "c8, c6, 0", zero);
+	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
+}
+
 static inline void local_flush_tlb_all(void)
 {
 	const int zero = 0;
@@ -327,10 +337,8 @@ static inline void local_flush_tlb_all(void)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	tlb_op(TLB_V4_U_FULL | TLB_V6_U_FULL, "c8, c7, 0", zero);
-	tlb_op(TLB_V4_D_FULL | TLB_V6_D_FULL, "c8, c6, 0", zero);
-	tlb_op(TLB_V4_I_FULL | TLB_V6_I_FULL, "c8, c5, 0", zero);
-	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
+	__local_flush_tlb_all();
+	tlb_op(TLB_V7_UIS_FULL, "c8, c7, 0", zero);
 
 	if (tlb_flag(TLB_BARRIER)) {
 		dsb();
@@ -338,31 +346,69 @@ static inline void local_flush_tlb_all(void)
 	}
 }
 
-static inline void local_flush_tlb_mm(struct mm_struct *mm)
+static inline void __flush_tlb_all(void)
 {
 	const int zero = 0;
-	const int asid = ASID(mm);
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	if (tlb_flag(TLB_WB))
 		dsb();
 
+	__local_flush_tlb_all();
+	tlb_op(TLB_V7_UIS_FULL, "c8, c3, 0", zero);
+
+	if (tlb_flag(TLB_BARRIER)) {
+		dsb();
+		isb();
+	}
+}
+
+static inline void __local_flush_tlb_mm(struct mm_struct *mm)
+{
+	const int zero = 0;
+	const int asid = ASID(mm);
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
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
+}
+
+static inline void local_flush_tlb_mm(struct mm_struct *mm)
+{
+	const int asid = ASID(mm);
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	if (tlb_flag(TLB_WB))
+		dsb();
+
+	__local_flush_tlb_mm(mm);
+	tlb_op(TLB_V7_UIS_ASID, "c8, c7, 2", asid);
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
+	__local_flush_tlb_mm(mm);
 #ifdef CONFIG_ARM_ERRATA_720789
-	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", zero);
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 0", 0);
 #else
-	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", asid);
+	tlb_op(TLB_V7_UIS_ASID, "c8, c3, 2", ASID(mm));
 #endif
 
 	if (tlb_flag(TLB_BARRIER))
@@ -370,16 +416,13 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 }
 
 static inline void
-local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
+__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 {
 	const int zero = 0;
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
 	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
 
-	if (tlb_flag(TLB_WB))
-		dsb();
-
 	if (possible_tlb_flags & (TLB_V4_U_PAGE|TLB_V4_D_PAGE|TLB_V4_I_PAGE|TLB_V4_I_FULL) &&
 	    cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
 		tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", uaddr);
@@ -392,6 +435,36 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", uaddr);
 	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", uaddr);
 	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", uaddr);
+}
+
+static inline void
+local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
+{
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	uaddr = (uaddr & PAGE_MASK) | ASID(vma->vm_mm);
+
+	if (tlb_flag(TLB_WB))
+		dsb();
+
+	__local_flush_tlb_page(vma, uaddr);
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c7, 1", uaddr);
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
+	__local_flush_tlb_page(vma, uaddr);
 #ifdef CONFIG_ARM_ERRATA_720789
 	tlb_op(TLB_V7_UIS_PAGE, "c8, c3, 3", uaddr & PAGE_MASK);
 #else
@@ -402,16 +475,11 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		dsb();
 }
 
-static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
+static inline void __local_flush_tlb_kernel_page(unsigned long kaddr)
 {
 	const int zero = 0;
 	const unsigned int __tlb_flag = __cpu_tlb_flags;
 
-	kaddr &= PAGE_MASK;
-
-	if (tlb_flag(TLB_WB))
-		dsb();
-
 	tlb_op(TLB_V4_U_PAGE, "c8, c7, 1", kaddr);
 	tlb_op(TLB_V4_D_PAGE, "c8, c6, 1", kaddr);
 	tlb_op(TLB_V4_I_PAGE, "c8, c5, 1", kaddr);
@@ -421,6 +489,36 @@ static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
 	tlb_op(TLB_V6_U_PAGE, "c8, c7, 1", kaddr);
 	tlb_op(TLB_V6_D_PAGE, "c8, c6, 1", kaddr);
 	tlb_op(TLB_V6_I_PAGE, "c8, c5, 1", kaddr);
+}
+
+static inline void local_flush_tlb_kernel_page(unsigned long kaddr)
+{
+	const unsigned int __tlb_flag = __cpu_tlb_flags;
+
+	kaddr &= PAGE_MASK;
+
+	if (tlb_flag(TLB_WB))
+		dsb();
+
+	__local_flush_tlb_kernel_page(kaddr);
+	tlb_op(TLB_V7_UIS_PAGE, "c8, c7, 1", kaddr);
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
+	__local_flush_tlb_kernel_page(kaddr);
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
