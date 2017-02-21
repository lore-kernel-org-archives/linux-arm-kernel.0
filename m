From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 21 Feb 2017 08:21:35 -0600
Subject: [RESEND PATCH v2] arm64: cache: Skip an unnecessary data cache clean
 PoU operation
Message-ID: <1487686895-18065-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cache management functions always do the data cache PoU
(point of unification) operations even though it is not required
on some systems. No need to clean data cache till PoU if all the
cache levels below PoUIS are WT (Write-Through) caches. It causes
a huge performance degradation when operating on a larger memory
area, especially THP with 64K page size kernel.

For each online CPU, check the need of 'dc cvau' instruction and
update a global variable __dcache_flags. The two functions
__flush_cache_user_range() and __clean_dcache_area_pou() are
modified to skip an unnecessary code execution based on flags.
It won't change the existing behavior if any one of the online
CPU is capable of WB cache below PoUIS level.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
Changes since v1:
    handle skipping a dcache clean POU operation by checking the
    global variable __dcache_flags in cache.S instead of patching
    the code segment.

 arch/arm64/include/asm/cachetype.h |  8 ++++++++
 arch/arm64/kernel/cpuinfo.c        | 30 ++++++++++++++++++++++++++++++
 arch/arm64/mm/cache.S              |  8 +++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index f558869..352fb23 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -28,6 +28,8 @@
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
+#define DCACHE_SKIP_POU		0
+
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
@@ -39,6 +41,12 @@
 
 extern unsigned long __icache_flags;
 
+extern unsigned long __dcache_flags;
+
+#define CLIDR_LOUIS_SHIFT	(21)
+#define CLIDR_LOUIS_MASK	(0x7)
+#define CLIDR_LOUIS(x)		(((x) >> CLIDR_LOUIS_SHIFT) & CLIDR_LOUIS_MASK)
+
 /*
  * NumSets, bits[27:13] - (Number of sets in cache) - 1
  * Associativity, bits[12:3] - (Associativity of cache) - 1
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 7b7be71..0e1a30a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -50,6 +50,7 @@
 };
 
 unsigned long __icache_flags;
+unsigned long __dcache_flags;
 
 static const char *const hwcap_str[] = {
 	"fp",
@@ -305,6 +306,33 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
 }
 
+/*
+ * Check if all the data cache levels below LoUIS doesn't support WB.
+ * The flag DCACHE_SKIP_POU set to 0 if any one of the online CPU
+ * doesn't support WB cache below LoUIS.
+ */
+static void cpuinfo_ckeck_dcache_pou(struct cpuinfo_arm64 *info)
+{
+	u32 louis = CLIDR_LOUIS(read_sysreg(clidr_el1));
+	static bool update_pou_once;
+	u32 lvl, csidr;
+
+	/* Set the DCACHE_SKIP_POU flag only first time */
+	if (!update_pou_once) {
+		set_bit(DCACHE_SKIP_POU, &__dcache_flags);
+		update_pou_once = true;
+	}
+
+	/* Go through all the cache level below LoUIS */
+	for (lvl = 0; lvl < louis; lvl++) {
+		csidr = cache_get_ccsidr(lvl << 1);
+		if (csidr & CCSIDR_EL1_WRITE_BACK) {
+			clear_bit(DCACHE_SKIP_POU, &__dcache_flags);
+			break;
+		}
+	}
+}
+
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
@@ -345,6 +373,8 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	}
 
 	cpuinfo_detect_icache_policy(info);
+	cpuinfo_ckeck_dcache_pou(info);
+
 }
 
 void cpuinfo_store_cpu(void)
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 83c27b6e..1884da2 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -24,6 +24,7 @@
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
 #include <asm/asm-uaccess.h>
+#include <asm/cachetype.h>
 
 /*
  *	flush_icache_range(start,end)
@@ -50,6 +51,8 @@ ENTRY(flush_icache_range)
  */
 ENTRY(__flush_cache_user_range)
 	uaccess_ttbr0_enable x2, x3
+	ldr_l	x4, __dcache_flags
+	tbnz	x4, #DCACHE_SKIP_POU, 2f
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x4, x0, x3
@@ -60,6 +63,7 @@ user_alt 9f, "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
 	b.lo	1b
 	dsb	ish
 
+2:
 	icache_line_size x2, x3
 	sub	x3, x2, #1
 	bic	x4, x0, x3
@@ -104,8 +108,10 @@ ENDPIPROC(__flush_dcache_area)
  *	- size    - size in question
  */
 ENTRY(__clean_dcache_area_pou)
+	ldr_l	x2, __dcache_flags
+	tbnz	x2, #DCACHE_SKIP_POU, 1f
 	dcache_by_line_op cvau, ish, x0, x1, x2, x3
-	ret
+1:	ret
 ENDPROC(__clean_dcache_area_pou)
 
 /*
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
