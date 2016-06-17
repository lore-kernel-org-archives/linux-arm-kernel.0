From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 17 Jun 2016 18:33:00 +0100
Subject: [PATCH 2/2] arm64: update ASID limit
In-Reply-To: <20160617173300.4767-1-jean-philippe.brucker@arm.com>
References: <20160617173300.4767-1-jean-philippe.brucker@arm.com>
Message-ID: <20160617173300.4767-2-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During a rollover, we mark the active ASID on each CPU as reserved, before
allocating a new ID for the task that caused the rollover. This means that
with N CPUs, we can only guarantee the new task to obtain a valid ASID if
we have at least N+1 ASIDs. Update this limit in the initcall check.

Note that this restriction was introduced by commit 8e648066 on the
arch/arm side, which disallow re-using the previously active ASID on the
local CPU, as it would introduce a TLB race.

In addition, we only dispose of NUM_USER_ASIDS-1, since ASID 0 is
reserved. Add this restriction as well.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arch/arm64/mm/context.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 090bf88..036c44d 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -180,7 +180,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 						 &asid_generation);
 	flush_context(cpu);
 
-	/* We have at least 1 ASID per CPU, so this will always succeed */
+	/* We have more ASIDs than CPUs, so this will always succeed */
 	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
 
 set_asid:
@@ -228,8 +228,11 @@ switch_mm_fastpath:
 static int asids_init(void)
 {
 	asid_bits = get_cpu_asid_bits();
-	/* If we end up with more CPUs than ASIDs, expect things to crash */
-	WARN_ON(NUM_USER_ASIDS < num_possible_cpus());
+	/*
+	 * Expect allocation after rollover to fail if we don't have@least
+	 * one more ASID than CPUs. ASID #0 is reserved for init_mm.
+	 */
+	WARN_ON(NUM_USER_ASIDS - 1 <= num_possible_cpus());
 	atomic64_set(&asid_generation, ASID_FIRST_VERSION);
 	asid_map = kzalloc(BITS_TO_LONGS(NUM_USER_ASIDS) * sizeof(*asid_map),
 			   GFP_KERNEL);
-- 
2.8.3
