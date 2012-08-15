From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Aug 2012 17:54:02 +0100
Subject: [PATCH 3/3] ARM: mm: use bitmap operations when allocating new ASIDs
In-Reply-To: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
References: <1345049642-29704-1-git-send-email-will.deacon@arm.com>
Message-ID: <1345049642-29704-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When allocating a new ASID, we must take care not to re-assign a
reserved ASID-value to a new mm. This requires us to check each
candidate ASID against those currently reserved by other cores before
assigning a new ASID to the current mm.

This patch improves the ASID allocation algorithm by using a
bitmap-based approach. Rather than iterating over the reserved ASID
array for each candidate ASID, we simply find the first zero bit,
ensuring that those indices corresponding to reserved ASIDs are set
when flushing during a rollover event.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c |   56 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 733774f..1a9e2ab 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -36,9 +36,14 @@
  * should be unique within all running processes.
  */
 #define ASID_FIRST_VERSION	(1ULL << ASID_BITS)
+#define NUM_USER_ASIDS		(ASID_FIRST_VERSION - 1)
+
+#define ASID_TO_IDX(asid)	((asid & ~ASID_MASK) - 1)
+#define IDX_TO_ASID(idx)	((idx + 1) & ~ASID_MASK)
 
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-static atomic64_t cpu_last_asid = ATOMIC64_INIT(ASID_FIRST_VERSION);
+static atomic64_t asid_generation = ATOMIC64_INIT(ASID_FIRST_VERSION);
+static DECLARE_BITMAP(asid_map, NUM_USER_ASIDS);
 
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
@@ -110,12 +115,19 @@ arch_initcall(contextidr_notifier_init);
 static void flush_context(unsigned int cpu)
 {
 	int i;
-
-	/* Update the list of reserved ASIDs. */
-	for_each_possible_cpu(i)
-		per_cpu(reserved_asids, i) =
-			atomic64_xchg(&per_cpu(active_asids, i), 0);
-	per_cpu(reserved_asids, cpu) = 0;
+	u64 asid;
+
+	/* Update the list of reserved ASIDs and the ASID bitmap. */
+	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
+	for_each_possible_cpu(i) {
+		if (i == cpu) {
+			asid = 0;
+		} else {
+			asid = atomic64_xchg(&per_cpu(active_asids, i), 0);
+			__set_bit(ASID_TO_IDX(asid), asid_map);
+		}
+		per_cpu(reserved_asids, i) = asid;
+	}
 
 	/* Queue a TLB invalidate and flush the I-cache if necessary. */
 	if (!tlb_ops_need_broadcast())
@@ -127,11 +139,11 @@ static void flush_context(unsigned int cpu)
 		__flush_icache_all();
 }
 
-static int is_reserved_asid(u64 asid, u64 mask)
+static int is_reserved_asid(u64 asid)
 {
 	int cpu;
 	for_each_possible_cpu(cpu)
-		if ((per_cpu(reserved_asids, cpu) & mask) == (asid & mask))
+		if (per_cpu(reserved_asids, cpu) == asid)
 			return 1;
 	return 0;
 }
@@ -139,25 +151,29 @@ static int is_reserved_asid(u64 asid, u64 mask)
 static void new_context(struct mm_struct *mm, unsigned int cpu)
 {
 	u64 asid = mm->context.id;
+	u64 generation = atomic64_read(&asid_generation);
 
-	if (asid != 0 && is_reserved_asid(asid, ULLONG_MAX)) {
+	if (asid != 0 && is_reserved_asid(asid)) {
 		/*
 		 * Our current ASID was active during a rollover, we can
 		 * continue to use it and this was just a false alarm.
 		 */
-		asid = (atomic64_read(&cpu_last_asid) & ASID_MASK) | \
-		       (asid & ~ASID_MASK);
+		asid = generation | (asid & ~ASID_MASK);
 	} else {
 		/*
 		 * Allocate a free ASID. If we can't find one, take a
 		 * note of the currently active ASIDs and mark the TLBs
 		 * as requiring flushes.
 		 */
-		do {
-			asid = atomic64_inc_return(&cpu_last_asid);
-			if ((asid & ~ASID_MASK) == 0)
-				flush_context(cpu);
-		} while (is_reserved_asid(asid, ~ASID_MASK));
+		asid = find_first_zero_bit(asid_map, NUM_USER_ASIDS);
+		if (asid == NUM_USER_ASIDS) {
+			generation = atomic64_add_return(ASID_FIRST_VERSION,
+							 &asid_generation);
+			flush_context(cpu);
+			asid = find_first_zero_bit(asid_map, NUM_USER_ASIDS);
+		}
+		__set_bit(asid, asid_map);
+		asid = generation | IDX_TO_ASID(asid);
 		cpumask_clear(mm_cpumask(mm));
 	}
 
@@ -172,8 +188,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
 		__check_kvm_seq(mm);
 
-	if (!((mm->context.id ^ atomic64_read(&cpu_last_asid)) >> ASID_BITS) &&
-	    atomic64_xchg(&per_cpu(active_asids, cpu), mm->context.id))
+	if (!((mm->context.id ^ atomic64_read(&asid_generation)) >> ASID_BITS)
+	    && atomic64_xchg(&per_cpu(active_asids, cpu), mm->context.id))
 		goto switch_mm_fastpath;
 
 	/*
@@ -184,7 +200,7 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
-	if ((mm->context.id ^ atomic64_read(&cpu_last_asid)) >> ASID_BITS)
+	if ((mm->context.id ^ atomic64_read(&asid_generation)) >> ASID_BITS)
 		new_context(mm, cpu);
 
 	atomic64_set(&per_cpu(active_asids, cpu), mm->context.id);
-- 
1.7.4.1
