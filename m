From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Sep 2012 17:16:09 +0100
Subject: [RESEND PATCH 2/3] ARM: mm: avoid taking ASID spinlock on fastpath
In-Reply-To: <1348157770-9647-1-git-send-email-will.deacon@arm.com>
References: <1348157770-9647-1-git-send-email-will.deacon@arm.com>
Message-ID: <1348157770-9647-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When scheduling a new mm, we take a spinlock so that we can:

  1. Safely allocate a new ASID, if required
  2. Update our active_asids field without worrying about parallel
     updates to reserved_asids
  3. Ensure that we flush our local TLB, if required

However, this has the nasty affect of serialising context-switch across
all CPUs in the system. The usual (fast) case is where the next mm has
a valid ASID for the current generation. In such a scenario, we can
avoid taking the lock and instead use atomic64_xchg to update the
active_asids variable for the current CPU. If a rollover occurs on
another CPU (which would take the lock), when copying the active_asids
into the reserved_asids another atomic64_xchg is used to replace each
active_asids with 0. The fast path can then detect this case and fall
back to spinning on the lock.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 3172781..994a7a4 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -38,9 +38,9 @@
 #define ASID_FIRST_VERSION	(1ULL << ASID_BITS)
 
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-static u64 cpu_last_asid = ASID_FIRST_VERSION;
+static atomic64_t cpu_last_asid = ATOMIC64_INIT(ASID_FIRST_VERSION);
 
-static DEFINE_PER_CPU(u64, active_asids);
+static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;
 
@@ -113,9 +113,10 @@ static void flush_context(unsigned int cpu)
 	int i;
 
 	/* Update the list of reserved ASIDs. */
-	per_cpu(active_asids, cpu) = 0;
 	for_each_possible_cpu(i)
-		per_cpu(reserved_asids, i) = per_cpu(active_asids, i);
+		per_cpu(reserved_asids, i) =
+			atomic64_xchg(&per_cpu(active_asids, i), 0);
+	per_cpu(reserved_asids, cpu) = 0;
 
 	/* Queue a TLB invalidate and flush the I-cache if necessary. */
 	if (!tlb_ops_need_broadcast())
@@ -145,7 +146,8 @@ static void new_context(struct mm_struct *mm, unsigned int cpu)
 		 * Our current ASID was active during a rollover, we can
 		 * continue to use it and this was just a false alarm.
 		 */
-		asid = (cpu_last_asid & ASID_MASK) | (asid & ~ASID_MASK);
+		asid = (atomic64_read(&cpu_last_asid) & ASID_MASK) | \
+		       (asid & ~ASID_MASK);
 	} else {
 		/*
 		 * Allocate a free ASID. If we can't find one, take a
@@ -153,7 +155,7 @@ static void new_context(struct mm_struct *mm, unsigned int cpu)
 		 * as requiring flushes.
 		 */
 		do {
-			asid = ++cpu_last_asid;
+			asid = atomic64_inc_return(&cpu_last_asid);
 			if ((asid & ~ASID_MASK) == 0)
 				flush_context(cpu);
 		} while (is_reserved_asid(asid, ~ASID_MASK));
@@ -171,6 +173,10 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
 		__check_kvm_seq(mm);
 
+	if (!((mm->context.id ^ atomic64_read(&cpu_last_asid)) >> ASID_BITS) &&
+	    atomic64_xchg(&per_cpu(active_asids, cpu), mm->context.id))
+		goto switch_mm_fastpath;
+
 	/*
 	 * Required during context switch to avoid speculative page table
 	 * walking with the wrong TTBR.
@@ -179,15 +185,16 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
-	if ((mm->context.id ^ cpu_last_asid) >> ASID_BITS)
+	if ((mm->context.id ^ atomic64_read(&cpu_last_asid)) >> ASID_BITS)
 		new_context(mm, cpu);
 
-	*this_cpu_ptr(&active_asids) = mm->context.id;
+	atomic64_set(&per_cpu(active_asids, cpu), mm->context.id);
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
 	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
 		local_flush_tlb_all();
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
+switch_mm_fastpath:
 	cpu_switch_mm(mm->pgd, mm);
 }
-- 
1.7.4.1
