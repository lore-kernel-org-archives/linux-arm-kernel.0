From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 20:32:20 +0000
Subject: [PATCH 1/6] arm64: cpuinfo: remove I-cache VIPT aliasing detection
Message-ID: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCSIDR_EL1.{NumSets,Associativity,LineSize} fields are only for use
in conjunction with set/way cache maintenance and are not guaranteed to
represent the actual microarchitectural features of a design.

The architecture explicitly states:

| You cannot make any inference about the actual sizes of caches based
| on these parameters.

We currently use these fields to determine whether or the I-cache is
aliasing, which is bogus and known to break on some platforms. Instead,
assume the I-cache is always aliasing if it advertises a VIPT policy.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cachetype.h | 13 -------------
 arch/arm64/kernel/cpuinfo.c        | 23 ++++++++++-------------
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index f5588692f1d4..4dbf3d10022d 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -63,19 +63,6 @@ extern unsigned long __icache_flags;
 #define CACHE_NUMSETS(x)	(CCSIDR_EL1_NUMSETS(x) + 1)
 #define CACHE_ASSOCIATIVITY(x)	(CCSIDR_EL1_ASSOCIATIVITY(x) + 1)
 
-extern u64 __attribute_const__ cache_get_ccsidr(u64 csselr);
-
-/* Helpers for Level 1 Instruction cache csselr = 1L */
-static inline int icache_get_linesize(void)
-{
-	return CACHE_LINESIZE(cache_get_ccsidr(1L));
-}
-
-static inline int icache_get_numsets(void)
-{
-	return CACHE_NUMSETS(cache_get_ccsidr(1L));
-}
-
 /*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
  * permitted in the I-cache.
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 5b22c687f02a..155ddd8ad56a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -289,20 +289,17 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	unsigned int cpu = smp_processor_id();
 	u32 l1ip = CTR_L1IP(info->reg_ctr);
 
-	if (l1ip != ICACHE_POLICY_PIPT) {
-		/*
-		 * VIPT caches are non-aliasing if the VA always equals the PA
-		 * in all bit positions that are covered by the index. This is
-		 * the case if the size of a way (# of sets * line size) does
-		 * not exceed PAGE_SIZE.
-		 */
-		u32 waysize = icache_get_numsets() * icache_get_linesize();
-
-		if (l1ip != ICACHE_POLICY_VIPT || waysize > PAGE_SIZE)
-			set_bit(ICACHEF_ALIASING, &__icache_flags);
-	}
-	if (l1ip == ICACHE_POLICY_AIVIVT)
+	switch (l1ip) {
+	case ICACHE_POLICY_PIPT:
+		break;
+	default:
+	case ICACHE_POLICY_AIVIVT:
 		set_bit(ICACHEF_AIVIVT, &__icache_flags);
+		/* Fallthrough */
+	case ICACHE_POLICY_VIPT:
+		/* Assume aliasing */
+		set_bit(ICACHEF_ALIASING, &__icache_flags);
+	}
 
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
 }
-- 
2.1.4
