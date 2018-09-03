From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  3 Sep 2018 11:01:33 +0100
Subject: [PATCH stable 2/2] arm64: Handle mismatched cache type
In-Reply-To: <1535968893-5455-1-git-send-email-suzuki.poulose@arm.com>
References: <1535968893-5455-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1535968893-5455-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 314d53d297980676011e6fd83dac60db4a01dc70 upstream

Track mismatches in the cache type register (CTR_EL0), other
than the D/I min line sizes and trap user accesses if there are any.

Fixes: be68a8aaf925 ("arm64: cpufeature: Fix CTR_EL0 field definitions")
Cc: <stable@vger.kernel.org> # v4.14
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c   | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 76c0d23..7d6425d 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -44,7 +44,8 @@
 #define ARM64_HARDEN_BRANCH_PREDICTOR		24
 #define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
 #define ARM64_SSBD				26
+#define ARM64_MISMATCHED_CACHE_TYPE		27
 
-#define ARM64_NCAPS				27
+#define ARM64_NCAPS				28
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 3d1569c..762b1ad 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -45,11 +45,15 @@ is_kryo_midr(const struct arm64_cpu_capabilities *entry, int scope)
 }
 
 static bool
-has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
-				int scope)
+has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
+			  int scope)
 {
 	u64 mask = CTR_CACHE_MINLINE_MASK;
 
+	/* Skip matching the min line sizes for cache type check */
+	if (entry->capability == ARM64_MISMATCHED_CACHE_TYPE)
+		mask ^= arm64_ftr_reg_ctrel0.strict_mask;
+
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 	return (read_cpuid_cachetype() & mask) !=
 	       (arm64_ftr_reg_ctrel0.sys_val & mask);
@@ -513,7 +517,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Mismatched cache line size",
 		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
-		.matches = has_mismatched_cache_line_size,
+		.matches = has_mismatched_cache_type,
+		.def_scope = SCOPE_LOCAL_CPU,
+		.enable = cpu_enable_trap_ctr_access,
+	},
+	{
+		.desc = "Mismatched cache type",
+		.capability = ARM64_MISMATCHED_CACHE_TYPE,
+		.matches = has_mismatched_cache_type,
 		.def_scope = SCOPE_LOCAL_CPU,
 		.enable = cpu_enable_trap_ctr_access,
 	},
-- 
2.7.4
