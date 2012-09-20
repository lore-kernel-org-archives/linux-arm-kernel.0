From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 17:16:08 +0100
Subject: [RESEND PATCH 1/3] ARM: mm: remove IPI broadcasting on ASID rollover
In-Reply-To: <1348157770-9647-1-git-send-email-will.deacon@arm.com>
References: <1348157770-9647-1-git-send-email-will.deacon@arm.com>
Message-ID: <1348157770-9647-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASIDs are allocated to MMU contexts based on a rolling counter. This
means that after 255 allocations we must invalidate all existing ASIDs
via an expensive IPI mechanism to synchronise all of the online CPUs and
ensure that all tasks execute with an ASID from the new generation.

This patch changes the rollover behaviour so that we rely instead on the
hardware broadcasting of the TLB invalidation to avoid the IPI calls.
This works by keeping track of the active ASID on each core, which is
then reserved in the case of a rollover so that currently scheduled
tasks can continue to run. For cores without hardware TLB broadcasting,
we keep track of pending flushes in a cpumask, so cores can flush their
local TLB before scheduling a new mm.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/mmu.h         |   11 +--
 arch/arm/include/asm/mmu_context.h |   82 +---------------
 arch/arm/mm/context.c              |  186 +++++++++++++++++-------------------
 3 files changed, 93 insertions(+), 186 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 1496565..5b53b53 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -5,18 +5,15 @@
 
 typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
-	unsigned int id;
-	raw_spinlock_t id_lock;
+	u64 id;
 #endif
 	unsigned int kvm_seq;
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
-#define ASID(mm)	((mm)->context.id & 255)
-
-/* init_mm.context.id_lock should be initialized. */
-#define INIT_MM_CONTEXT(name)                                                 \
-	.context.id_lock    = __RAW_SPIN_LOCK_UNLOCKED(name.context.id_lock),
+#define ASID_BITS	8
+#define ASID_MASK	((~0ULL) << ASID_BITS)
+#define ASID(mm)	((mm)->context.id & ~ASID_MASK)
 #else
 #define ASID(mm)	(0)
 #endif
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 0306bc6..a64f61c 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -24,84 +24,8 @@ void __check_kvm_seq(struct mm_struct *mm);
 
 #ifdef CONFIG_CPU_HAS_ASID
 
-/*
- * On ARMv6, we have the following structure in the Context ID:
- *
- * 31                         7          0
- * +-------------------------+-----------+
- * |      process ID         |   ASID    |
- * +-------------------------+-----------+
- * |              context ID             |
- * +-------------------------------------+
- *
- * The ASID is used to tag entries in the CPU caches and TLBs.
- * The context ID is used by debuggers and trace logic, and
- * should be unique within all running processes.
- */
-#define ASID_BITS		8
-#define ASID_MASK		((~0) << ASID_BITS)
-#define ASID_FIRST_VERSION	(1 << ASID_BITS)
-
-extern unsigned int cpu_last_asid;
-
-void __init_new_context(struct task_struct *tsk, struct mm_struct *mm);
-void __new_context(struct mm_struct *mm);
-void cpu_set_reserved_ttbr0(void);
-
-static inline void switch_new_context(struct mm_struct *mm)
-{
-	unsigned long flags;
-
-	__new_context(mm);
-
-	local_irq_save(flags);
-	cpu_switch_mm(mm->pgd, mm);
-	local_irq_restore(flags);
-}
-
-static inline void check_and_switch_context(struct mm_struct *mm,
-					    struct task_struct *tsk)
-{
-	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
-		__check_kvm_seq(mm);
-
-	/*
-	 * Required during context switch to avoid speculative page table
-	 * walking with the wrong TTBR.
-	 */
-	cpu_set_reserved_ttbr0();
-
-	if (!((mm->context.id ^ cpu_last_asid) >> ASID_BITS))
-		/*
-		 * The ASID is from the current generation, just switch to the
-		 * new pgd. This condition is only true for calls from
-		 * context_switch() and interrupts are already disabled.
-		 */
-		cpu_switch_mm(mm->pgd, mm);
-	else if (irqs_disabled())
-		/*
-		 * Defer the new ASID allocation until after the context
-		 * switch critical region since __new_context() cannot be
-		 * called with interrupts disabled (it sends IPIs).
-		 */
-		set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
-	else
-		/*
-		 * That is a direct call to switch_mm() or activate_mm() with
-		 * interrupts enabled and a new context.
-		 */
-		switch_new_context(mm);
-}
-
-#define init_new_context(tsk,mm)	(__init_new_context(tsk,mm),0)
-
-#define finish_arch_post_lock_switch \
-	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
-{
-	if (test_and_clear_thread_flag(TIF_SWITCH_MM))
-		switch_new_context(current->mm);
-}
+void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
+#define init_new_context(tsk,mm)	({ mm->context.id = 0; })
 
 #else	/* !CONFIG_CPU_HAS_ASID */
 
@@ -143,6 +67,7 @@ static inline void finish_arch_post_lock_switch(void)
 #endif	/* CONFIG_CPU_HAS_ASID */
 
 #define destroy_context(mm)		do { } while(0)
+#define activate_mm(prev,next)		switch_mm(prev, next, NULL)
 
 /*
  * This is called when "tsk" is about to enter lazy TLB mode.
@@ -186,6 +111,5 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 #define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, NULL)
 
 #endif
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 4e07eec..3172781 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -2,6 +2,9 @@
  *  linux/arch/arm/mm/context.c
  *
  *  Copyright (C) 2002-2003 Deep Blue Solutions Ltd, all rights reserved.
+ *  Copyright (C) 2012 ARM Limited
+ *
+ *  Author: Will Deacon <will.deacon@arm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,14 +17,35 @@
 #include <linux/percpu.h>
 
 #include <asm/mmu_context.h>
+#include <asm/smp_plat.h>
 #include <asm/thread_notify.h>
 #include <asm/tlbflush.h>
 
+/*
+ * On ARMv6, we have the following structure in the Context ID:
+ *
+ * 31                         7          0
+ * +-------------------------+-----------+
+ * |      process ID         |   ASID    |
+ * +-------------------------+-----------+
+ * |              context ID             |
+ * +-------------------------------------+
+ *
+ * The ASID is used to tag entries in the CPU caches and TLBs.
+ * The context ID is used by debuggers and trace logic, and
+ * should be unique within all running processes.
+ */
+#define ASID_FIRST_VERSION	(1ULL << ASID_BITS)
+
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-unsigned int cpu_last_asid = ASID_FIRST_VERSION;
+static u64 cpu_last_asid = ASID_FIRST_VERSION;
+
+static DEFINE_PER_CPU(u64, active_asids);
+static DEFINE_PER_CPU(u64, reserved_asids);
+static cpumask_t tlb_flush_pending;
 
 #ifdef CONFIG_ARM_LPAE
-void cpu_set_reserved_ttbr0(void)
+static void cpu_set_reserved_ttbr0(void)
 {
 	unsigned long ttbl = __pa(swapper_pg_dir);
 	unsigned long ttbh = 0;
@@ -37,7 +61,7 @@ void cpu_set_reserved_ttbr0(void)
 	isb();
 }
 #else
-void cpu_set_reserved_ttbr0(void)
+static void cpu_set_reserved_ttbr0(void)
 {
 	u32 ttb;
 	/* Copy TTBR1 into TTBR0 */
@@ -84,124 +108,86 @@ static int __init contextidr_notifier_init(void)
 arch_initcall(contextidr_notifier_init);
 #endif
 
-/*
- * We fork()ed a process, and we need a new context for the child
- * to run in.
- */
-void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+static void flush_context(unsigned int cpu)
 {
-	mm->context.id = 0;
-	raw_spin_lock_init(&mm->context.id_lock);
-}
+	int i;
 
-static void flush_context(void)
-{
-	cpu_set_reserved_ttbr0();
-	local_flush_tlb_all();
-	if (icache_is_vivt_asid_tagged()) {
+	/* Update the list of reserved ASIDs. */
+	per_cpu(active_asids, cpu) = 0;
+	for_each_possible_cpu(i)
+		per_cpu(reserved_asids, i) = per_cpu(active_asids, i);
+
+	/* Queue a TLB invalidate and flush the I-cache if necessary. */
+	if (!tlb_ops_need_broadcast())
+		cpumask_set_cpu(cpu, &tlb_flush_pending);
+	else
+		cpumask_setall(&tlb_flush_pending);
+
+	if (icache_is_vivt_asid_tagged())
 		__flush_icache_all();
-		dsb();
-	}
 }
 
-#ifdef CONFIG_SMP
+static int is_reserved_asid(u64 asid, u64 mask)
+{
+	int cpu;
+	for_each_possible_cpu(cpu)
+		if ((per_cpu(reserved_asids, cpu) & mask) == (asid & mask))
+			return 1;
+	return 0;
+}
 
-static void set_mm_context(struct mm_struct *mm, unsigned int asid)
+static void new_context(struct mm_struct *mm, unsigned int cpu)
 {
-	unsigned long flags;
+	u64 asid = mm->context.id;
 
-	/*
-	 * Locking needed for multi-threaded applications where the
-	 * same mm->context.id could be set from different CPUs during
-	 * the broadcast. This function is also called via IPI so the
-	 * mm->context.id_lock has to be IRQ-safe.
-	 */
-	raw_spin_lock_irqsave(&mm->context.id_lock, flags);
-	if (likely((mm->context.id ^ cpu_last_asid) >> ASID_BITS)) {
+	if (asid != 0 && is_reserved_asid(asid, ULLONG_MAX)) {
 		/*
-		 * Old version of ASID found. Set the new one and
-		 * reset mm_cpumask(mm).
+		 * Our current ASID was active during a rollover, we can
+		 * continue to use it and this was just a false alarm.
 		 */
-		mm->context.id = asid;
+		asid = (cpu_last_asid & ASID_MASK) | (asid & ~ASID_MASK);
+	} else {
+		/*
+		 * Allocate a free ASID. If we can't find one, take a
+		 * note of the currently active ASIDs and mark the TLBs
+		 * as requiring flushes.
+		 */
+		do {
+			asid = ++cpu_last_asid;
+			if ((asid & ~ASID_MASK) == 0)
+				flush_context(cpu);
+		} while (is_reserved_asid(asid, ~ASID_MASK));
 		cpumask_clear(mm_cpumask(mm));
 	}
-	raw_spin_unlock_irqrestore(&mm->context.id_lock, flags);
 
-	/*
-	 * Set the mm_cpumask(mm) bit for the current CPU.
-	 */
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+	mm->context.id = asid;
 }
 
-/*
- * Reset the ASID on the current CPU. This function call is broadcast
- * from the CPU handling the ASID rollover and holding cpu_asid_lock.
- */
-static void reset_context(void *info)
+void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 {
-	unsigned int asid;
+	unsigned long flags;
 	unsigned int cpu = smp_processor_id();
-	struct mm_struct *mm = current->active_mm;
-
-	smp_rmb();
-	asid = cpu_last_asid + cpu + 1;
-
-	flush_context();
-	set_mm_context(mm, asid);
-
-	/* set the new ASID */
-	cpu_switch_mm(mm->pgd, mm);
-}
-
-#else
 
-static inline void set_mm_context(struct mm_struct *mm, unsigned int asid)
-{
-	mm->context.id = asid;
-	cpumask_copy(mm_cpumask(mm), cpumask_of(smp_processor_id()));
-}
+	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
+		__check_kvm_seq(mm);
 
-#endif
-
-void __new_context(struct mm_struct *mm)
-{
-	unsigned int asid;
-
-	raw_spin_lock(&cpu_asid_lock);
-#ifdef CONFIG_SMP
 	/*
-	 * Check the ASID again, in case the change was broadcast from
-	 * another CPU before we acquired the lock.
+	 * Required during context switch to avoid speculative page table
+	 * walking with the wrong TTBR.
 	 */
-	if (unlikely(((mm->context.id ^ cpu_last_asid) >> ASID_BITS) == 0)) {
-		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-		raw_spin_unlock(&cpu_asid_lock);
-		return;
-	}
-#endif
-	/*
-	 * At this point, it is guaranteed that the current mm (with
-	 * an old ASID) isn't active on any other CPU since the ASIDs
-	 * are changed simultaneously via IPI.
-	 */
-	asid = ++cpu_last_asid;
-	if (asid == 0)
-		asid = cpu_last_asid = ASID_FIRST_VERSION;
+	cpu_set_reserved_ttbr0();
 
-	/*
-	 * If we've used up all our ASIDs, we need
-	 * to start a new version and flush the TLB.
-	 */
-	if (unlikely((asid & ~ASID_MASK) == 0)) {
-		asid = cpu_last_asid + smp_processor_id() + 1;
-		flush_context();
-#ifdef CONFIG_SMP
-		smp_wmb();
-		smp_call_function(reset_context, NULL, 1);
-#endif
-		cpu_last_asid += NR_CPUS;
-	}
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	/* Check that our ASID belongs to the current generation. */
+	if ((mm->context.id ^ cpu_last_asid) >> ASID_BITS)
+		new_context(mm, cpu);
 
-	set_mm_context(mm, asid);
-	raw_spin_unlock(&cpu_asid_lock);
+	*this_cpu_ptr(&active_asids) = mm->context.id;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+
+	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+		local_flush_tlb_all();
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+
+	cpu_switch_mm(mm->pgd, mm);
 }
-- 
1.7.4.1
