From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Jun 2013 13:44:52 +0100
Subject: [PATCH 2/3] ARM: prevent risks of out-of-bound access in ASID
 allocator
In-Reply-To: <1371645893-7630-1-git-send-email-marc.zyngier@arm.com>
References: <1371645893-7630-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1371645893-7630-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a CPU that never ran anything, both the active and reserved ASID
fields are set to zero. In this case the ASID_TO_IDX() macro will
return -1, which is not a very useful value to index a bitmap.

Instead of trying to offset the ASID so that ASID #1 is actually
bit 0 in the asid_map bitmap, just always ignore bit 0 and start
the search from bit 1. This makes the code a bit more readable,
and without risk of OoB access.

Cc: <stable@vger.kernel.org> # 3.9
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mm/context.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 8e12fcb..83e0905 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -39,10 +39,7 @@
  * non 64-bit operations.
  */
 #define ASID_FIRST_VERSION	(1ULL << ASID_BITS)
-#define NUM_USER_ASIDS		(ASID_FIRST_VERSION - 1)
-
-#define ASID_TO_IDX(asid)	((asid & ~ASID_MASK) - 1)
-#define IDX_TO_ASID(idx)	((idx + 1) & ~ASID_MASK)
+#define NUM_USER_ASIDS		ASID_FIRST_VERSION
 
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 static atomic64_t asid_generation = ATOMIC64_INIT(ASID_FIRST_VERSION);
@@ -137,7 +134,7 @@ static void flush_context(unsigned int cpu)
 			 */
 			if (asid == 0)
 				asid = per_cpu(reserved_asids, i);
-			__set_bit(ASID_TO_IDX(asid), asid_map);
+			__set_bit(asid & ~ASID_MASK, asid_map);
 		}
 		per_cpu(reserved_asids, i) = asid;
 	}
@@ -176,17 +173,19 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 		/*
 		 * Allocate a free ASID. If we can't find one, take a
 		 * note of the currently active ASIDs and mark the TLBs
-		 * as requiring flushes.
+		 * as requiring flushes. We always count from ASID #1,
+		 * as we reserve ASID #0 to switch via TTBR0 and indicate
+		 * rollover events.
 		 */
-		asid = find_first_zero_bit(asid_map, NUM_USER_ASIDS);
+		asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
 		if (asid == NUM_USER_ASIDS) {
 			generation = atomic64_add_return(ASID_FIRST_VERSION,
 							 &asid_generation);
 			flush_context(cpu);
-			asid = find_first_zero_bit(asid_map, NUM_USER_ASIDS);
+			asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
 		}
 		__set_bit(asid, asid_map);
-		asid = generation | IDX_TO_ASID(asid);
+		asid |= generation;
 		cpumask_clear(mm_cpumask(mm));
 	}
 
-- 
1.8.2.3
