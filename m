From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  4 Jul 2018 23:07:45 +0100
Subject: [PATCH 1/2] arm64: Fix mismatched cache line size detection
In-Reply-To: <1530742066-16276-1-git-send-email-suzuki.poulose@arm.com>
References: <1530742066-16276-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1530742066-16276-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If there is a mismatch in the I/D min line size, we must
always use the system wide safe value both in applications
and in the kernel, while performing cache operations. However,
we have been checking more bits than just the min line sizes,
which triggers false negatives. We may need to trap the user
accesses in such cases, but not necessarily patch the kernel.

This patch fixes the check to do the right thing as advertised.
A new capability will be added to check mismatches in other
fields and ensure we trap the CTR accesses.

Reported-by: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cache.h | 4 ++++
 arch/arm64/kernel/cpu_errata.c | 6 ++++--
 arch/arm64/kernel/cpufeature.c | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 5df5cfe..5ee5bca 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -21,12 +21,16 @@
 #define CTR_L1IP_SHIFT		14
 #define CTR_L1IP_MASK		3
 #define CTR_DMINLINE_SHIFT	16
+#define CTR_IMINLINE_SHIFT	0
 #define CTR_ERG_SHIFT		20
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
 #define CTR_IDC_SHIFT		28
 #define CTR_DIC_SHIFT		29
 
+#define CTR_CACHE_MINLINE_MASK	\
+	(0xf << CTR_DMINLINE_SHIFT | 0xf << CTR_IMINLINE_SHIFT)
+
 #define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
 
 #define ICACHE_POLICY_VPIPT	0
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 1d2b6d7..5d1fa92 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -68,9 +68,11 @@ static bool
 has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 				int scope)
 {
+	u64 mask = CTR_CACHE_MINLINE_MASK;
+
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
-	return (read_cpuid_cachetype() & arm64_ftr_reg_ctrel0.strict_mask) !=
-		(arm64_ftr_reg_ctrel0.sys_val & arm64_ftr_reg_ctrel0.strict_mask);
+	return (read_cpuid_cachetype() & mask) !=
+	       (arm64_ftr_reg_ctrel0.sys_val & mask);
 }
 
 static void
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f24892a..25d5cef 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -214,7 +214,7 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	 * If we have differing I-cache policies, report it as the weakest - VIPT.
 	 */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_VIPT),	/* L1Ip */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_IMINLINE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
-- 
2.9.5
