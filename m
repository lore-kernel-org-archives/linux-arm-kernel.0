From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:13 +0100
Subject: [PATCH 04/10] arm64: mm: rewrite ASID allocator and MM
 context-switching code
In-Reply-To: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442494219-6133-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our current switch_mm implementation suffers from a number of problems:

  (1) The ASID allocator relies on IPIs to synchronise the CPUs on a
      rollover event

  (2) Because of (1), we cannot allocate ASIDs with interrupts disabled
      and therefore make use of a TIF_SWITCH_MM flag to postpone the
      actual switch to finish_arch_post_lock_switch

  (3) We run context switch with a reserved (invalid) TTBR0 value, even
      though the ASID and pgd are updated atomically

  (4) We take a global spinlock (cpu_asid_lock) during context-switch

  (5) We use h/w broadcast TLB operations when they are not required
      (e.g. in flush_context)

This patch addresses these problems by rewriting the ASID algorithm to
match the bitmap-based arch/arm/ implementation more closely. This in
turn allows us to remove much of the complications surrounding switch_mm,
including the ugly thread flag.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu.h         |  10 +-
 arch/arm64/include/asm/mmu_context.h |  76 ++---------
 arch/arm64/include/asm/thread_info.h |   1 -
 arch/arm64/kernel/asm-offsets.c      |   2 +-
 arch/arm64/kernel/efi.c              |   1 -
 arch/arm64/mm/context.c              | 238 +++++++++++++++++++++--------------
 arch/arm64/mm/proc.S                 |   2 +-
 7 files changed, 161 insertions(+), 169 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 030208767185..6af677c4f118 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -17,15 +17,11 @@
 #define __ASM_MMU_H
 
 typedef struct {
-	unsigned int id;
-	raw_spinlock_t id_lock;
-	void *vdso;
+	atomic64_t	id;
+	void		*vdso;
 } mm_context_t;
 
-#define INIT_MM_CONTEXT(name) \
-	.context.id_lock = __RAW_SPIN_LOCK_UNLOCKED(name.context.id_lock),
-
-#define ASID(mm)	((mm)->context.id & 0xffff)
+#define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
 extern void paging_init(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 549b89554ce8..f4c74a951b6c 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -28,13 +28,6 @@
 #include <asm/cputype.h>
 #include <asm/pgtable.h>
 
-#define MAX_ASID_BITS	16
-
-extern unsigned int cpu_last_asid;
-
-void __init_new_context(struct task_struct *tsk, struct mm_struct *mm);
-void __new_context(struct mm_struct *mm);
-
 #ifdef CONFIG_PID_IN_CONTEXTIDR
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
@@ -96,66 +89,19 @@ static inline void cpu_set_default_tcr_t0sz(void)
 	: "r"(TCR_T0SZ(VA_BITS)), "I"(TCR_T0SZ_OFFSET), "I"(TCR_TxSZ_WIDTH));
 }
 
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
-	/*
-	 * Required during context switch to avoid speculative page table
-	 * walking with the wrong TTBR.
-	 */
-	cpu_set_reserved_ttbr0();
-
-	if (!((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS))
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
-		 * called with interrupts disabled.
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
+/*
+ * It would be nice to return ASIDs back to the allocator, but unfortunately
+ * that introduces a race with a generation rollover where we could erroneously
+ * free an ASID allocated in a future generation. We could workaround this by
+ * freeing the ASID from the context of the dying mm (e.g. in arch_exit_mmap),
+ * but we'd then need to make sure that we didn't dirty any TLBs afterwards.
+ * Setting a reserved TTBR0 or EPD0 would work, but it all gets ugly when you
+ * take CPU migration into account.
+ */
 #define destroy_context(mm)		do { } while(0)
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
-#define finish_arch_post_lock_switch \
-	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
-{
-	if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
-		struct mm_struct *mm = current->mm;
-		unsigned long flags;
-
-		__new_context(mm);
-
-		local_irq_save(flags);
-		cpu_switch_mm(mm->pgd, mm);
-		local_irq_restore(flags);
-	}
-}
+#define init_new_context(tsk,mm)	({ atomic64_set(&mm->context.id, 0); 0; })
 
 /*
  * This is called when "tsk" is about to enter lazy TLB mode.
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index dcd06d18a42a..555c6dec5ef2 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -111,7 +111,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* 32bit process */
-#define TIF_SWITCH_MM		23	/* deferred switch_mm */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 8d89cf8dae55..25de8b244961 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -60,7 +60,7 @@ int main(void)
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
-  DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id));
+  DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id.counter));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
   DEFINE(VMA_VM_FLAGS,		offsetof(struct vm_area_struct, vm_flags));
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index b0f6dbdc5260..de30a469ccd5 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -48,7 +48,6 @@ static struct mm_struct efi_mm = {
 	.mmap_sem		= __RWSEM_INITIALIZER(efi_mm.mmap_sem),
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
-	INIT_MM_CONTEXT(efi_mm)
 };
 
 static int uefi_debug __initdata;
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 48b53fb381af..e902229b1a3d 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -17,135 +17,187 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/init.h>
+#include <linux/bitops.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/percpu.h>
 
+#include <asm/cpufeature.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
-#include <asm/cachetype.h>
 
-#define asid_bits(reg) \
-	(((read_cpuid(ID_AA64MMFR0_EL1) & 0xf0) >> 2) + 8)
+static u32 asid_bits;
+static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 
-#define ASID_FIRST_VERSION	(1 << MAX_ASID_BITS)
+static atomic64_t asid_generation;
+static unsigned long *asid_map;
 
-static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-unsigned int cpu_last_asid = ASID_FIRST_VERSION;
+static DEFINE_PER_CPU(atomic64_t, active_asids);
+static DEFINE_PER_CPU(u64, reserved_asids);
+static cpumask_t tlb_flush_pending;
 
-/*
- * We fork()ed a process, and we need a new context for the child to run in.
- */
-void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+#define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
+#define ASID_FIRST_VERSION	(1UL << asid_bits)
+#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+
+static void flush_context(unsigned int cpu)
 {
-	mm->context.id = 0;
-	raw_spin_lock_init(&mm->context.id_lock);
+	int i;
+	u64 asid;
+
+	/* Update the list of reserved ASIDs and the ASID bitmap. */
+	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+
+	/*
+	 * Ensure the generation bump is observed before we xchg the
+	 * active_asids.
+	 */
+	smp_wmb();
+
+	for_each_possible_cpu(i) {
+		asid = atomic64_xchg_relaxed(&per_cpu(active_asids, i), 0);
+		/*
+		 * If this CPU has already been through a
+		 * rollover, but hasn't run another task in
+		 * the meantime, we must preserve its reserved
+		 * ASID, as this is the only trace we have of
+		 * the process it is still running.
+		 */
+		if (asid == 0)
+			asid = per_cpu(reserved_asids, i);
+		__set_bit(asid & ~ASID_MASK, asid_map);
+		per_cpu(reserved_asids, i) = asid;
+	}
+
+	/* Queue a TLB invalidate and flush the I-cache if necessary. */
+	cpumask_setall(&tlb_flush_pending);
+
+	if (icache_is_aivivt())
+		__flush_icache_all();
 }
 
-static void flush_context(void)
+static int is_reserved_asid(u64 asid)
 {
-	/* set the reserved TTBR0 before flushing the TLB */
-	cpu_set_reserved_ttbr0();
-	local_flush_tlb_all();
-	if (icache_is_aivivt())
-		__local_flush_icache_all();
+	int cpu;
+	for_each_possible_cpu(cpu)
+		if (per_cpu(reserved_asids, cpu) == asid)
+			return 1;
+	return 0;
 }
 
-static void set_mm_context(struct mm_struct *mm, unsigned int asid)
+static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 {
-	unsigned long flags;
+	static u32 cur_idx = 1;
+	u64 asid = atomic64_read(&mm->context.id);
+	u64 generation = atomic64_read(&asid_generation);
 
-	/*
-	 * Locking needed for multi-threaded applications where the same
-	 * mm->context.id could be set from different CPUs during the
-	 * broadcast. This function is also called via IPI so the
-	 * mm->context.id_lock has to be IRQ-safe.
-	 */
-	raw_spin_lock_irqsave(&mm->context.id_lock, flags);
-	if (likely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS)) {
+	if (asid != 0) {
 		/*
-		 * Old version of ASID found. Set the new one and reset
-		 * mm_cpumask(mm).
+		 * If our current ASID was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
 		 */
-		mm->context.id = asid;
-		cpumask_clear(mm_cpumask(mm));
+		if (is_reserved_asid(asid))
+			return generation | (asid & ~ASID_MASK);
+
+		/*
+		 * We had a valid ASID in a previous life, so try to re-use
+		 * it if possible.
+		 */
+		asid &= ~ASID_MASK;
+		if (!__test_and_set_bit(asid, asid_map))
+			goto bump_gen;
 	}
-	raw_spin_unlock_irqrestore(&mm->context.id_lock, flags);
 
 	/*
-	 * Set the mm_cpumask(mm) bit for the current CPU.
+	 * Allocate a free ASID. If we can't find one, take a note of the
+	 * currently active ASIDs and mark the TLBs as requiring flushes.
+	 * We always count from ASID #1, as we use ASID #0 when setting a
+	 * reserved TTBR0 for the init_mm.
 	 */
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
+	if (asid != NUM_USER_ASIDS)
+		goto set_asid;
+
+	/* We're out of ASIDs, so increment the global generation count */
+	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
+						 &asid_generation);
+	flush_context(cpu);
+
+	/* We have at least 1 ASID per CPU, so this will always succeed */
+	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
+
+set_asid:
+	__set_bit(asid, asid_map);
+	cur_idx = asid;
+
+bump_gen:
+	asid |= generation;
+	cpumask_clear(mm_cpumask(mm));
+	return asid;
 }
 
-/*
- * Reset the ASID on the current CPU. This function call is broadcast from the
- * CPU handling the ASID rollover and holding cpu_asid_lock.
- */
-static void reset_context(void *info)
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 {
-	unsigned int asid;
-	unsigned int cpu = smp_processor_id();
-	struct mm_struct *mm = current->active_mm;
+	unsigned long flags;
+	u64 asid;
+
+	asid = atomic64_read(&mm->context.id);
 
 	/*
-	 * current->active_mm could be init_mm for the idle thread immediately
-	 * after secondary CPU boot or hotplug. TTBR0_EL1 is already set to
-	 * the reserved value, so no need to reset any context.
+	 * The memory ordering here is subtle. We rely on the control
+	 * dependency between the generation read and the update of
+	 * active_asids to ensure that we are synchronised with a
+	 * parallel rollover (i.e. this pairs with the smp_wmb() in
+	 * flush_context).
 	 */
-	if (mm == &init_mm)
-		return;
+	if (!((asid ^ atomic64_read(&asid_generation)) >> asid_bits)
+	    && atomic64_xchg_relaxed(&per_cpu(active_asids, cpu), asid))
+		goto switch_mm_fastpath;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	/* Check that our ASID belongs to the current generation. */
+	asid = atomic64_read(&mm->context.id);
+	if ((asid ^ atomic64_read(&asid_generation)) >> asid_bits) {
+		asid = new_context(mm, cpu);
+		atomic64_set(&mm->context.id, asid);
+	}
 
-	smp_rmb();
-	asid = cpu_last_asid + cpu;
+	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+		local_flush_tlb_all();
 
-	flush_context();
-	set_mm_context(mm, asid);
+	atomic64_set(&per_cpu(active_asids, cpu), asid);
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
-	/* set the new ASID */
+switch_mm_fastpath:
 	cpu_switch_mm(mm->pgd, mm);
 }
 
-void __new_context(struct mm_struct *mm)
+static int asids_init(void)
 {
-	unsigned int asid;
-	unsigned int bits = asid_bits();
-
-	raw_spin_lock(&cpu_asid_lock);
-	/*
-	 * Check the ASID again, in case the change was broadcast from another
-	 * CPU before we acquired the lock.
-	 */
-	if (!unlikely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS)) {
-		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-		raw_spin_unlock(&cpu_asid_lock);
-		return;
-	}
-	/*
-	 * At this point, it is guaranteed that the current mm (with an old
-	 * ASID) isn't active on any other CPU since the ASIDs are changed
-	 * simultaneously via IPI.
-	 */
-	asid = ++cpu_last_asid;
-
-	/*
-	 * If we've used up all our ASIDs, we need to start a new version and
-	 * flush the TLB.
-	 */
-	if (unlikely((asid & ((1 << bits) - 1)) == 0)) {
-		/* increment the ASID version */
-		cpu_last_asid += (1 << MAX_ASID_BITS) - (1 << bits);
-		if (cpu_last_asid == 0)
-			cpu_last_asid = ASID_FIRST_VERSION;
-		asid = cpu_last_asid + smp_processor_id();
-		flush_context();
-		smp_wmb();
-		smp_call_function(reset_context, NULL, 1);
-		cpu_last_asid += NR_CPUS - 1;
+	int fld = cpuid_feature_extract_field(read_cpuid(ID_AA64MMFR0_EL1), 4);
+
+	switch (fld) {
+	default:
+		pr_warn("Unknown ASID size (%d); assuming 8-bit\n", fld);
+		/* Fallthrough */
+	case 0:
+		asid_bits = 8;
+		break;
+	case 2:
+		asid_bits = 16;
 	}
 
-	set_mm_context(mm, asid);
-	raw_spin_unlock(&cpu_asid_lock);
+	/* If we end up with more CPUs than ASIDs, expect things to crash */
+	WARN_ON(NUM_USER_ASIDS < num_possible_cpus());
+	atomic64_set(&asid_generation, ASID_FIRST_VERSION);
+	asid_map = kzalloc(BITS_TO_LONGS(NUM_USER_ASIDS) * sizeof(*asid_map),
+			   GFP_KERNEL);
+	if (!asid_map)
+		panic("Failed to allocate bitmap for %lu ASIDs\n",
+		      NUM_USER_ASIDS);
+
+	pr_info("ASID allocator initialised with %lu entries\n", NUM_USER_ASIDS);
+	return 0;
 }
+early_initcall(asids_init);
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index bbde13d77da5..91cb2eaac256 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -130,7 +130,7 @@ ENDPROC(cpu_do_resume)
  *	- pgd_phys - physical address of new TTB
  */
 ENTRY(cpu_do_switch_mm)
-	mmid	w1, x1				// get mm->context.id
+	mmid	x1, x1				// get mm->context.id
 	bfi	x0, x1, #48, #16		// set the ASID
 	msr	ttbr0_el1, x0			// set TTBR0
 	isb
-- 
2.1.4
