From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Sat, 6 Oct 2018 16:49:04 +0800
Subject: [PATCH] arm64: mm: Drop the unused cpu parameter
Message-ID: <1538815744-27408-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cpu parameter is never used in flush_context, remove it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/arm64/mm/context.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index c127f94..009a7b2c 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -88,7 +88,7 @@ void verify_cpu_asid_bits(void)
 	}
 }
 
-static void flush_context(unsigned int cpu)
+static void flush_context(void)
 {
 	int i;
 	u64 asid;
@@ -142,7 +142,7 @@ static bool check_update_reserved_asid(u64 asid, u64 newasid)
 	return hit;
 }
 
-static u64 new_context(struct mm_struct *mm, unsigned int cpu)
+static u64 new_context(struct mm_struct *mm)
 {
 	static u32 cur_idx = 1;
 	u64 asid = atomic64_read(&mm->context.id);
@@ -180,7 +180,7 @@ static u64 new_context(struct mm_struct *mm, unsigned int cpu)
 	/* We're out of ASIDs, so increment the global generation count */
 	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
 						 &asid_generation);
-	flush_context(cpu);
+	flush_context();
 
 	/* We have more ASIDs than CPUs, so this will always succeed */
 	asid = find_next_zero_bit(asid_map, NUM_USER_ASIDS, 1);
@@ -223,7 +223,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
 	if ((asid ^ atomic64_read(&asid_generation)) >> asid_bits) {
-		asid = new_context(mm, cpu);
+		asid = new_context(mm);
 		atomic64_set(&mm->context.id, asid);
 	}
 
-- 
2.7.4
