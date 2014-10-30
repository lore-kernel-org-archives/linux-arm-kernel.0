From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Oct 2014 16:55:58 +0000
Subject: [PATCH] ARM: mm: try to re-use old ASID assignments following a
 rollover
Message-ID: <1414688158-12741-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than unconditionally allocating a fresh ASID to an mm from an
older generation, attempt to re-use the old assignment where possible.

This can bring performance benefits on systems where the ASID is used to
tag things other than the TLB (e.g. branch prediction resources).

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c | 58 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 6eb97b3a7481..91892569710f 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -184,36 +184,46 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 	u64 asid = atomic64_read(&mm->context.id);
 	u64 generation = atomic64_read(&asid_generation);
 
-	if (asid != 0 && is_reserved_asid(asid)) {
+	if (asid != 0) {
 		/*
-		 * Our current ASID was active during a rollover, we can
-		 * continue to use it and this was just a false alarm.
+		 * If our current ASID was active during a rollover, we
+		 * can continue to use it and this was just a false alarm.
 		 */
-		asid = generation | (asid & ~ASID_MASK);
-	} else {
+		if (is_reserved_asid(asid))
+			return generation | (asid & ~ASID_MASK);
+
 		/*
-		 * Allocate a free ASID. If we can't find one, take a
-		 * note of the currently active ASIDs and mark the TLBs
-		 * as requiring flushes. We always count from ASID #1,
-		 * as we reserve ASID #0 to switch via TTBR0 and to
-		 * avoid speculative page table walks from hitting in
-		 * any partial walk caches, which could be populated
-		 * from overlapping level-1 descriptors used to map both
-		 * the module area and the userspace stack.
+		 * We had a valid ASID in a previous life, so try to re-use
+		 * it if possible.,
 		 */
-		asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
-		if (asid == NUM_USER_ASIDS) {
-			generation = atomic64_add_return(ASID_FIRST_VERSION,
-							 &asid_generation);
-			flush_context(cpu);
-			asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
-		}
-		__set_bit(asid, asid_map);
-		cur_idx = asid;
-		asid |= generation;
-		cpumask_clear(mm_cpumask(mm));
+		asid &= ~ASID_MASK;
+		if (!__test_and_set_bit(asid, asid_map))
+			goto bump_gen;
 	}
 
+	/*
+	 * Allocate a free ASID. If we can't find one, take a note of the
+	 * currently active ASIDs and mark the TLBs as requiring flushes.
+	 * We always count from ASID #1, as we reserve ASID #0 to switch
+	 * via TTBR0 and to avoid speculative page table walks from hitting
+	 * in any partial walk caches, which could be populated from
+	 * overlapping level-1 descriptors used to map both the module
+	 * area and the userspace stack.
+	 */
+	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
+	if (asid == NUM_USER_ASIDS) {
+		generation = atomic64_add_return(ASID_FIRST_VERSION,
+						 &asid_generation);
+		flush_context(cpu);
+		asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
+	}
+
+	__set_bit(asid, asid_map);
+	cur_idx = asid;
+
+bump_gen:
+	asid |= generation;
+	cpumask_clear(mm_cpumask(mm));
 	return asid;
 }
 
-- 
2.1.1
