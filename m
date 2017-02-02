From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Thu,  2 Feb 2017 15:45:06 -0600
Subject: [PATCH] arm64: cache: Skip an unnecessary data cache clean PoU
 operation
Message-ID: <1486071906-2773-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cache management functions always do the data cache PoU
(point of unification) operations even though it is not required
on some systems. NO need to clean data cache till PoU if all the
cache levels below PoUIS are WT (Write-Through) caches. It causes
a huge performance degradation when operating on a larger memory
area, especially THP with 64K page size kernel.

For each online CPU, check the need of 'dc cvau' instruction and
update a global variable __skip_dcache_pou. The two functions
__flush_cache_user_range() and __clean_dcache_area_pou() are
patched using an alternative primitive to skip an unnecessary
code execution. It won't change the existing behavior if any one
of the CPU is capable of WB cache below PoUIS level.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 arch/arm64/include/asm/cachetype.h |  6 ++++++
 arch/arm64/include/asm/cpucaps.h   |  3 ++-
 arch/arm64/kernel/cpufeature.c     | 12 ++++++++++++
 arch/arm64/kernel/cpuinfo.c        | 23 +++++++++++++++++++++++
 arch/arm64/mm/cache.S              |  3 +++
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index f558869..f05974c 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -39,6 +39,12 @@
 
 extern unsigned long __icache_flags;
 
+extern bool __skip_dcache_pou;
+
+#define CLIDR_LOUIS_SHIFT	(21)
+#define CLIDR_LOUIS_MASK	(0x7)
+#define CLIDR_LOUIS(x)		(((x) >> CLIDR_LOUIS_SHIFT) & CLIDR_LOUIS_MASK)
+
 /*
  * NumSets, bits[27:13] - (Number of sets in cache) - 1
  * Associativity, bits[12:3] - (Associativity of cache) - 1
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 4174f09..6f4ea61 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -35,7 +35,8 @@
 #define ARM64_HYP_OFFSET_LOW			14
 #define ARM64_MISMATCHED_CACHE_LINE_SIZE	15
 #define ARM64_HAS_NO_FPSIMD			16
+#define ARM64_SKIP_DCACHE_POU			17
 
-#define ARM64_NCAPS				17
+#define ARM64_NCAPS				18
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fdf8f04..eaa86d1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -755,6 +755,12 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 					ID_AA64PFR0_FP_SHIFT) < 0;
 }
 
+static bool check_dcache_pou_skipped(const struct arm64_cpu_capabilities *entry,
+				     int __unused)
+{
+	return __skip_dcache_pou;
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -845,6 +851,12 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 		.min_field_value = 0,
 		.matches = has_no_fpsimd,
 	},
+	{
+		.desc = "Skip data cache clean PoU operation",
+		.capability = ARM64_SKIP_DCACHE_POU,
+		.def_scope = SCOPE_SYSTEM,
+		.matches = check_dcache_pou_skipped,
+	},
 	{},
 };
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 7b7be71..4fdbb55 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -50,6 +50,7 @@
 };
 
 unsigned long __icache_flags;
+bool __skip_dcache_pou = true;
 
 static const char *const hwcap_str[] = {
 	"fp",
@@ -305,6 +306,25 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
 }
 
+/*
+ * Check if all the data cache levels below LoUIS doesn't support WB.
+ * Return value 1 if any one of cache level below LoUIS has WB cache
+ * else return value 0.
+ */
+static bool is_dcache_below_pou_wt(void)
+{
+	u32 louis = CLIDR_LOUIS(read_sysreg(clidr_el1));
+	u32 lvl, csidr;
+
+	for (lvl = 0; lvl < louis; lvl++) {
+		csidr = cache_get_ccsidr(lvl << 1);
+		if (csidr & CCSIDR_EL1_WRITE_BACK)
+			return false;
+	}
+
+	return true;
+}
+
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
@@ -345,6 +365,9 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	}
 
 	cpuinfo_detect_icache_policy(info);
+
+	if (__skip_dcache_pou)
+		__skip_dcache_pou = is_dcache_below_pou_wt();
 }
 
 void cpuinfo_store_cpu(void)
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 83c27b6e..bb3cdb3 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -50,6 +50,7 @@ ENTRY(flush_icache_range)
  */
 ENTRY(__flush_cache_user_range)
 	uaccess_ttbr0_enable x2, x3
+	alternative_insn "nop", "b 2f", ARM64_SKIP_DCACHE_POU
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x4, x0, x3
@@ -60,6 +61,7 @@ user_alt 9f, "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
 	b.lo	1b
 	dsb	ish
 
+2:
 	icache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x4, x0, x3
@@ -104,6 +106,7 @@ ENDPIPROC(__flush_dcache_area)
  *	- size    - size in question
  */
 ENTRY(__clean_dcache_area_pou)
+	alternative_insn "nop", "ret", ARM64_SKIP_DCACHE_POU
 	dcache_by_line_op cvau, ish, x0, x1, x2, x3
 	ret
 ENDPROC(__clean_dcache_area_pou)
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
