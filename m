From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:14 +0200
Subject: [PATCH] FCSE: differentiate cpu_tlb_mask from cpu_vm_mask.
In-Reply-To: <1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Linux kernel uses mm->cpu_vm_mask to avoid unnecessary TLB and
cache flushes when the process about to be flushed has already been
flushed because of a context switch.

When enabling FCSE, a context switch flushes the TLB, but no longer
flushes the cache, so, for correctness, we need to distinguish whether
a process is "present" in the TLB by using a second mask
mm->context.cpu_tlb_mask, or whether it is "present" in the cache by
using mm->cpu_vm_mask.

The current cpu bit is set and cleared from cpu_tlb_mask upon context
switch, but only set in cpu_vm_mask.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/fcse.h        |    5 +++++
 arch/arm/include/asm/mmu.h         |    1 +
 arch/arm/include/asm/mmu_context.h |    7 +++++--
 arch/arm/include/asm/tlbflush.h    |    4 ++--
 arch/arm/kernel/smp.c              |    7 ++++---
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/fcse.h b/arch/arm/include/asm/fcse.h
index e443278..4e9503d 100644
--- a/arch/arm/include/asm/fcse.h
+++ b/arch/arm/include/asm/fcse.h
@@ -30,6 +30,9 @@
 /* Mask to get rid of PID from relocated address */
 #define FCSE_PID_MASK (FCSE_PID_TASK_SIZE - 1)
 
+#define fcse_tlb_mask(mm) (&(mm)->context.cpu_tlb_mask)
+#define fcse_cpu_set_vm_mask(cpu, mm) cpumask_set_cpu(cpu, mm_cpumask(mm))
+
 /* Sets the CPU's PID Register */
 static inline void fcse_pid_set(unsigned long pid)
 {
@@ -68,6 +71,8 @@ void fcse_pid_free(unsigned pid);
 #define fcse_pid_set(pid) do { } while (0)
 #define fcse_mva_to_va(x) (x)
 #define fcse_va_to_mva(mm, x) ({ (void)(mm); (x); })
+#define fcse_tlb_mask(mm) mm_cpumask(mm)
+#define fcse_cpu_set_vm_mask(cpu, mm) do { } while (0)
 #endif /* ! CONFIG_ARM_FCSE */
 
 #endif /* __ASM_ARM_FCSE_H */
diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 4a5a8db..7472598 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -9,6 +9,7 @@ typedef struct {
 #endif
 #ifdef CONFIG_ARM_FCSE
 	unsigned long pid;
+	cpumask_t cpu_tlb_mask;
 #endif /* CONFIG_ARM_FCSE */
 	unsigned int kvm_seq;
 } mm_context_t;
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index ec7a84d..042a26d 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -75,6 +75,8 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 #ifdef CONFIG_ARM_FCSE
 	int pid;
 
+	cpus_clear(mm->context.cpu_tlb_mask);
+
 	pid = fcse_pid_alloc();
 	if (pid < 0)
 		return pid;
@@ -126,12 +128,13 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	    !cpumask_test_cpu(cpu, mm_cpumask(next)))
 		__flush_icache_all();
 #endif
-	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
+	if (!cpumask_test_and_set_cpu(cpu, fcse_tlb_mask(next)) || prev != next) {
+		fcse_cpu_set_vm_mask(cpu, next);
 		check_context(next);
 		fcse_pid_set(next->context.pid);
 		cpu_switch_mm(next->pgd, next);
 		if (cache_is_vivt())
-			cpumask_clear_cpu(cpu, mm_cpumask(prev));
+			cpumask_clear_cpu(cpu, fcse_tlb_mask(prev));
 	}
 #endif
 }
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 7e14a84..86355b3 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -351,7 +351,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
+	if (cpumask_test_cpu(smp_processor_id(), fcse_tlb_mask(mm))) {
 		if (tlb_flag(TLB_V3_FULL))
 			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (zero) : "cc");
 		if (tlb_flag(TLB_V4_U_FULL))
@@ -390,7 +390,7 @@ local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 	if (tlb_flag(TLB_WB))
 		dsb();
 
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(vma->vm_mm))) {
+	if (cpumask_test_cpu(smp_processor_id(), fcse_tlb_mask(vma->vm_mm))) {
 		if (tlb_flag(TLB_V3_PAGE))
 			asm("mcr p15, 0, %0, c6, c0, 0" : : "r" (uaddr) : "cc");
 		if (tlb_flag(TLB_V4_U_PAGE))
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index e0d3277..a0eb423 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -36,6 +36,7 @@
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
 #include <asm/localtimer.h>
+#include <asm/fcse.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
@@ -643,7 +644,7 @@ void flush_tlb_all(void)
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	if (tlb_ops_need_broadcast())
-		on_each_cpu_mask(ipi_flush_tlb_mm, mm, 1, mm_cpumask(mm));
+		on_each_cpu_mask(ipi_flush_tlb_mm, mm, 1, fcse_tlb_mask(mm));
 	else
 		local_flush_tlb_mm(mm);
 }
@@ -654,7 +655,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)
 		struct tlb_args ta;
 		ta.ta_vma = vma;
 		ta.ta_start = uaddr;
-		on_each_cpu_mask(ipi_flush_tlb_page, &ta, 1, mm_cpumask(vma->vm_mm));
+		on_each_cpu_mask(ipi_flush_tlb_page, &ta, 1, fcse_tlb_mask(vma->vm_mm));
 	} else
 		local_flush_tlb_page(vma, uaddr);
 }
@@ -677,7 +678,7 @@ void flush_tlb_range(struct vm_area_struct *vma,
 		ta.ta_vma = vma;
 		ta.ta_start = start;
 		ta.ta_end = end;
-		on_each_cpu_mask(ipi_flush_tlb_range, &ta, 1, mm_cpumask(vma->vm_mm));
+		on_each_cpu_mask(ipi_flush_tlb_range, &ta, 1, fcse_tlb_mask(vma->vm_mm));
 	} else
 		local_flush_tlb_range(vma, start, end);
 }
-- 
1.5.6.5
