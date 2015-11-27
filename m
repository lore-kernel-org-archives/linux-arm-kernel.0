From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Nov 2015 11:48:13 +0000
Subject: [PATCH v2] ARM: mm: keep reserved ASIDs in sync with mm after
 multiple rollovers
Message-ID: <1448624893-15991-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under some unusual context-switching patterns, it is possible to end up
with multiple threads from the same mm running concurrently with
different ASIDs:

1. CPU x schedules task t with mm p containing ASID a and generation g
   This task doesn't block and the CPU doesn't context switch.
   So:
     * per_cpu(active_asid, x) = {g,a}
     * p->context.id = {g,a}

2. Some other CPU generates an ASID rollover. The global generation is
   now (g + 1). CPU x is still running t, with no context switch and
   so per_cpu(reserved_asid, x) = {g,a}

3. CPU y schedules task t', which shares mm p with t. The generation
   mismatches, so we take the slowpath and hit the reserved ASID from
   CPU x. p is then updated so that p->context.id = {g + 1,a}

4. CPU y schedules some other task u, which has an mm != p.

5. Some other CPU generates *another* CPU rollover. The global
   generation is now (g + 2). CPU x is still running t, with no context
   switch and so per_cpu(reserved_asid, x) = {g,a}.

6. CPU y once again schedules task t', but now *fails* to hit the
   reserved ASID from CPU x because of the generation mismatch. This
   results in a new ASID being allocated, despite the fact that t is
   still running on CPU x with the same mm.

Consequently, TLBIs (e.g. as a result of CoW) will not be synchronised
between the two threads.

This patch fixes the problem by updating all of the matching reserved
ASIDs when we hit on the slowpath (i.e. in step 3 above). This keeps
the reserved ASIDs in-sync with the mm and avoids the problem.

Cc: <stable@vger.kernel.org>
Reported-by: Tony Thompson <anthony.thompson@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

v1 -> v2: Don't remove clearing of mm_cpumask on rollover.

 arch/arm/mm/context.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 845769e41332..c8c8b9ed02e0 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -165,13 +165,28 @@ static void flush_context(unsigned int cpu)
 		__flush_icache_all();
 }
 
-static int is_reserved_asid(u64 asid)
+static bool check_update_reserved_asid(u64 asid, u64 newasid)
 {
 	int cpu;
-	for_each_possible_cpu(cpu)
-		if (per_cpu(reserved_asids, cpu) == asid)
-			return 1;
-	return 0;
+	bool hit = false;
+
+	/*
+	 * Iterate over the set of reserved ASIDs looking for a match.
+	 * If we find one, then we can update our mm to use newasid
+	 * (i.e. the same ASID in the current generation) but we can't
+	 * exit the loop early, since we need to ensure that all copies
+	 * of the old ASID are updated to reflect the mm. Failure to do
+	 * so could result in us missing the reserved ASID in a future
+	 * generation.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (per_cpu(reserved_asids, cpu) == asid) {
+			hit = true;
+			per_cpu(reserved_asids, cpu) = newasid;
+		}
+	}
+
+	return hit;
 }
 
 static u64 new_context(struct mm_struct *mm, unsigned int cpu)
@@ -181,12 +196,14 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 	u64 generation = atomic64_read(&asid_generation);
 
 	if (asid != 0) {
+		u64 newasid = generation | (asid & ~ASID_MASK);
+
 		/*
 		 * If our current ASID was active during a rollover, we
 		 * can continue to use it and this was just a false alarm.
 		 */
-		if (is_reserved_asid(asid))
-			return generation | (asid & ~ASID_MASK);
+		if (check_update_reserved_asid(asid, newasid))
+			return newasid;
 
 		/*
 		 * We had a valid ASID in a previous life, so try to re-use
@@ -194,7 +211,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 		 */
 		asid &= ~ASID_MASK;
 		if (!__test_and_set_bit(asid, asid_map))
-			goto bump_gen;
+			return newasid;
 	}
 
 	/*
@@ -216,11 +233,8 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 
 	__set_bit(asid, asid_map);
 	cur_idx = asid;
-
-bump_gen:
-	asid |= generation;
 	cpumask_clear(mm_cpumask(mm));
-	return asid;
+	return asid | generation;
 }
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
-- 
2.1.4
