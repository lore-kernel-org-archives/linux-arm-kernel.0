From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Jan 2015 12:33:05 +0000
Subject: [PATCH] ARM: mm: ensure local active ASID is marked as allocated on
 rollover
Message-ID: <1422275585-19662-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e1a5848e3398 ("ARM: 7924/1: mm: don't bother with reserved ttbr0
when running with LPAE") removed the use of the reserved TTBR0 value
for LPAE systems, since the ASID is held in the TTBR and can be updated
atomicly with the pgd of the next mm.

Unfortunately, this patch forgot to update flush_context, which
deliberately avoids marking the local active ASID as allocated, since we
used to switch via ASID zero and didn't need to allocate the ASID of
the previous mm. The side-effect of this is that we can allocate the
same ASID to the next mm and, between flushing the local TLB and updating
TTBR0, we can perform speculative TLB fills for userspace nG mappings
using the page table of the previous mm.

The consequence of this is that the next mm can erroneously hit some
mappings of the previous mm. Note that this was made significantly
harder to hit by a391263cd84e ("ARM: 8203/1: mm: try to re-use old ASID
assignments following a rollover") but is still theoretically possible.

This patch fixes the problem by removing the code from flush_context
that forces the allocated ASID to zero for the local CPU. Many thanks
to the Broadcom guys for tracking this one down.

Fixes: e1a5848e3398 ("ARM: 7924/1: mm: don't bother with reserved ttbr0 when running with LPAE")
Cc: <stable@vger.kernel.org> # v3.14+
Reported-by: Raymond Ngun <rngun@broadcom.com>
Tested-by: Raymond Ngun <rngun@broadcom.com>
Reviewed-by: Gregory Fong <gregory.0xf0@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 91892569710f..845769e41332 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -144,21 +144,17 @@ static void flush_context(unsigned int cpu)
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
 	bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
 	for_each_possible_cpu(i) {
-		if (i == cpu) {
-			asid = 0;
-		} else {
-			asid = atomic64_xchg(&per_cpu(active_asids, i), 0);
-			/*
-			 * If this CPU has already been through a
-			 * rollover, but hasn't run another task in
-			 * the meantime, we must preserve its reserved
-			 * ASID, as this is the only trace we have of
-			 * the process it is still running.
-			 */
-			if (asid == 0)
-				asid = per_cpu(reserved_asids, i);
-			__set_bit(asid & ~ASID_MASK, asid_map);
-		}
+		asid = atomic64_xchg(&per_cpu(active_asids, i), 0);
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
 		per_cpu(reserved_asids, i) = asid;
 	}
 
-- 
2.1.4
