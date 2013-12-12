From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Dec 2013 18:26:02 +0000
Subject: [PATCH 2/3] ARM: mm: keep track of last ASID allocation to improve
 bitmap searching
In-Reply-To: <1386872763-14845-1-git-send-email-will.deacon@arm.com>
References: <1386872763-14845-1-git-send-email-will.deacon@arm.com>
Message-ID: <1386872763-14845-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we only clear entries in the ASID bitmap on a rollover event, the
bitmap tends to consist of a block of consecutive set bits followed by
a block of consecutive clear bits. The exception to this rule is for
ASIDs which have been carried over from a previous generation, but
these are bound by the number of CPUs.

This patch optimises our bitmap searching strategy, so that we search
from the last successful allocation, rather than search from index 1
each time we allocate a new ASID.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 3ad0fdaa5cc1..52e6f13ac9c7 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -180,6 +180,7 @@ static int is_reserved_asid(u64 asid)
 
 static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 {
+	static u32 cur_idx = 1;
 	u64 asid = atomic64_read(&mm->context.id);
 	u64 generation = atomic64_read(&asid_generation);
 
@@ -197,7 +198,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 		 * as we reserve ASID #0 to switch via TTBR0 and indicate
 		 * rollover events.
 		 */
-		asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
+		asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, cur_idx);
 		if (asid == NUM_USER_ASIDS) {
 			generation = atomic64_add_return(ASID_FIRST_VERSION,
 							 &asid_generation);
@@ -205,6 +206,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 			asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
 		}
 		__set_bit(asid, asid_map);
+		cur_idx = asid;
 		asid |= generation;
 		cpumask_clear(mm_cpumask(mm));
 	}
-- 
1.8.2.2
