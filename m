From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 14:10:33 +0000
Subject: [PATCH 1/6] Global ASID allocation on SMP
In-Reply-To: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091207141023.30429.6539.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current ASID allocation algorithm doesn't ensure the notification
of the other CPUs when the ASID rolls over. This may lead to two
processes using the same ASID (but different generation) or multiple
threads of the same process using different ASIDs.

This patch adds the broadcasting of the ASID rollover event to the
other CPUs. To avoid a race on multiple CPUs modifying "cpu_last_asid"
during the handling of the broadcast, the ASID numbering now starts at
"smp_processor_id() + 1". At rollover, the cpu_last_asid will be set
to NR_CPUS.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/mmu.h         |    1 
 arch/arm/include/asm/mmu_context.h |   15 +++++
 arch/arm/mm/context.c              |  120 ++++++++++++++++++++++++++++++++----
 3 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index b561584..68870c7 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -6,6 +6,7 @@
 typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
 	unsigned int id;
+	spinlock_t id_lock;
 #endif
 	unsigned int kvm_seq;
 } mm_context_t;
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index de6cefb..a0b3cac 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -43,12 +43,23 @@ void __check_kvm_seq(struct mm_struct *mm);
 #define ASID_FIRST_VERSION	(1 << ASID_BITS)
 
 extern unsigned int cpu_last_asid;
+#ifdef CONFIG_SMP
+DECLARE_PER_CPU(struct mm_struct *, current_mm);
+#endif
 
 void __init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 void __new_context(struct mm_struct *mm);
 
 static inline void check_context(struct mm_struct *mm)
 {
+	/*
+	 * This code is executed with interrupts enabled. Therefore,
+	 * mm->context.id cannot be updated to the latest ASID version
+	 * on a different CPU (and condition below not triggered)
+	 * without first getting an IPI to reset the context. The
+	 * alternative is to take a read_lock on mm->context.id_lock
+	 * (after changing its type to rwlock_t).
+	 */
 	if (unlikely((mm->context.id ^ cpu_last_asid) >> ASID_BITS))
 		__new_context(mm);
 
@@ -108,6 +119,10 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		__flush_icache_all();
 #endif
 	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
+#ifdef CONFIG_SMP
+		struct mm_struct **crt_mm = &per_cpu(current_mm, cpu);
+		*crt_mm = next;
+#endif
 		check_context(next);
 		cpu_switch_mm(next->pgd, next);
 		if (cache_is_vivt())
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index a9e22e3..626375b 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -10,12 +10,17 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/percpu.h>
 
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
 static DEFINE_SPINLOCK(cpu_asid_lock);
 unsigned int cpu_last_asid = ASID_FIRST_VERSION;
+#ifdef CONFIG_SMP
+DEFINE_PER_CPU(struct mm_struct *, current_mm);
+#endif
 
 /*
  * We fork()ed a process, and we need a new context for the child
@@ -26,13 +31,105 @@ unsigned int cpu_last_asid = ASID_FIRST_VERSION;
 void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	mm->context.id = 0;
+	spin_lock_init(&mm->context.id_lock);
 }
 
+static void flush_context(void)
+{
+	/* set the reserved ASID before flushing the TLB */
+	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (0));
+	isb();
+	local_flush_tlb_all();
+	if (icache_is_vivt_asid_tagged()) {
+		__flush_icache_all();
+		dsb();
+	}
+}
+
+#ifdef CONFIG_SMP
+
+static void set_mm_context(struct mm_struct *mm, unsigned int asid)
+{
+	/*
+	 * Locking needed for multi-threaded applications where the
+	 * same mm->context.id could be set from different CPUs during
+	 * the broadcast.
+	 */
+	spin_lock(&mm->context.id_lock);
+	if (likely((mm->context.id ^ cpu_last_asid) >> ASID_BITS)) {
+		/*
+		 * Old version of ASID found. Set the new one and
+		 * reset mm_cpumask(mm).
+		 */
+		mm->context.id = asid;
+		cpumask_clear(mm_cpumask(mm));
+	}
+	spin_unlock(&mm->context.id_lock);
+
+	/*
+	 * Set the mm_cpumask(mm) bit for the current CPU.
+	 */
+	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+}
+
+/*
+ * Reset the ASID on the current CPU. This function call is broadcast
+ * from the CPU handling the ASID rollover and holding cpu_asid_lock.
+ */
+static void reset_context(void *info)
+{
+	unsigned int asid;
+	unsigned int cpu = smp_processor_id();
+	struct mm_struct *mm = per_cpu(current_mm, cpu);
+
+	/*
+	 * Check if a current_mm was set on this CPU as it might still
+	 * be in the early booting stages and using the reserved ASID.
+	 */
+	if (!mm)
+		return;
+
+	smp_rmb();
+	asid = cpu_last_asid + cpu + 1;
+
+	flush_context();
+	set_mm_context(mm, asid);
+
+	/* set the new ASID */
+	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (mm->context.id));
+}
+
+#else
+
+static inline void set_mm_context(struct mm_struct *mm, unsigned int asid)
+{
+	mm->context.id = asid;
+	cpumask_copy(mm_cpumask(mm), cpumask_of(smp_processor_id()));
+}
+
+#endif
+
 void __new_context(struct mm_struct *mm)
 {
 	unsigned int asid;
 
 	spin_lock(&cpu_asid_lock);
+#ifdef CONFIG_SMP
+	/*
+	 * Check the ASID again, in case the change was broadcast from
+	 * another CPU before we acquired the lock.
+	 */
+	if (unlikely(((mm->context.id ^ cpu_last_asid) >> ASID_BITS) == 0)) {
+		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+		spin_unlock(&cpu_asid_lock);
+		return;
+	}
+#endif
+	/*
+	 * At this point, it is guaranteed that the current mm (with
+	 * an old ASID) isn't active on any other CPU since the ASIDs
+	 * are changed simultaneously via IPI.
+	 */
 	asid = ++cpu_last_asid;
 	if (asid == 0)
 		asid = cpu_last_asid = ASID_FIRST_VERSION;
@@ -42,20 +139,15 @@ void __new_context(struct mm_struct *mm)
 	 * to start a new version and flush the TLB.
 	 */
 	if (unlikely((asid & ~ASID_MASK) == 0)) {
-		asid = ++cpu_last_asid;
-		/* set the reserved ASID before flushing the TLB */
-		asm("mcr	p15, 0, %0, c13, c0, 1	@ set reserved context ID\n"
-		    :
-		    : "r" (0));
-		isb();
-		flush_tlb_all();
-		if (icache_is_vivt_asid_tagged()) {
-			__flush_icache_all();
-			dsb();
-		}
+		asid = cpu_last_asid + smp_processor_id() + 1;
+		flush_context();
+#ifdef CONFIG_SMP
+		smp_wmb();
+		smp_call_function(reset_context, NULL, 1);
+#endif
+		cpu_last_asid += NR_CPUS;
 	}
-	spin_unlock(&cpu_asid_lock);
 
-	cpumask_copy(mm_cpumask(mm), cpumask_of(smp_processor_id()));
-	mm->context.id = asid;
+	set_mm_context(mm, asid);
+	spin_unlock(&cpu_asid_lock);
 }
