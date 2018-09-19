From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Sep 2018 11:41:21 +0100
Subject: [PATCH] arm64: cpu_errata: Remove ARM64_MISMATCHED_CACHE_LINE_SIZE
Message-ID: <1537353681-19677-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to treat mismatched cache-line sizes reported by CTR_EL0
differently to any other mismatched fields that we treat as "STRICT" in
the cpufeature code. In both cases we need to trap and emulate EL0
accesses to the register, so drop ARM64_MISMATCHED_CACHE_LINE_SIZE and
rely on ARM64_MISMATCHED_CACHE_TYPE instead.

Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h |  7 +++----
 arch/arm64/include/asm/cpucaps.h   |  2 +-
 arch/arm64/kernel/cpu_errata.c     | 15 ++-------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..6142402c2eb4 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -286,12 +286,11 @@ alternative_endif
 	ldr	\rd, [\rn, #MM_CONTEXT_ID]
 	.endm
 /*
- * read_ctr - read CTR_EL0. If the system has mismatched
- * cache line sizes, provide the system wide safe value
- * from arm64_ftr_reg_ctrel0.sys_val
+ * read_ctr - read CTR_EL0. If the system has mismatched register fields,
+ * provide the system wide safe value from arm64_ftr_reg_ctrel0.sys_val
  */
 	.macro	read_ctr, reg
-alternative_if_not ARM64_MISMATCHED_CACHE_LINE_SIZE
+alternative_if_not ARM64_MISMATCHED_CACHE_TYPE
 	mrs	\reg, ctr_el0			// read CTR
 	nop
 alternative_else
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index ae1f70450fb2..028eac8fc79d 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -33,7 +33,7 @@
 #define ARM64_WORKAROUND_CAVIUM_27456		12
 #define ARM64_HAS_32BIT_EL0			13
 #define ARM64_HARDEN_EL2_VECTORS		14
-#define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
+/* #define ARM64_YOUR_CAP_HERE			15 */
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index dec10898d688..ef3cc061d815 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -68,11 +68,7 @@ static bool
 has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
 			  int scope)
 {
-	u64 mask = CTR_CACHE_MINLINE_MASK;
-
-	/* Skip matching the min line sizes for cache type check */
-	if (entry->capability == ARM64_MISMATCHED_CACHE_TYPE)
-		mask ^= arm64_ftr_reg_ctrel0.strict_mask;
+	u64 mask = arm64_ftr_reg_ctrel0.strict_mask;;
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 	return (read_cpuid_cachetype() & mask) !=
@@ -616,14 +612,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	},
 #endif
 	{
-		.desc = "Mismatched cache line size",
-		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
-		.matches = has_mismatched_cache_type,
-		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
-		.cpu_enable = cpu_enable_trap_ctr_access,
-	},
-	{
-		.desc = "Mismatched cache type",
+		.desc = "Mismatched cache type (CTR_EL0)",
 		.capability = ARM64_MISMATCHED_CACHE_TYPE,
 		.matches = has_mismatched_cache_type,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
-- 
2.1.4
