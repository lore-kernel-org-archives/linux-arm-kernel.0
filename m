From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Tue, 21 Feb 2017 08:09:55 -0600
Subject: [RESEND PATCH] arm64: Add support for VMID aware PIPT instruction
 cache
Message-ID: <1487686195-16282-1-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ARMv8.2 extension, a new instruction cache type 'VMID aware
PIPT' was introduced in addition to AIVIVT/VIPT/PIPT. Instruction
cache maintenance operations when issued from Non-secure EL1/EL0
have an effect only on cache line entries those were fetched in
Non-secure EL1/EL0 using the current VMID. For software point of
view, this cache type is same as PIPT and no aliasing problem.

The updated CTR_EL0.L1IP definition.
   00: VMID aware PIPT
   01: ASID-tagged Virtual Index, Virtual Tag (AIVIVT)
   10: Virtual Index, Physical Tag (VIPT)
   11: Physical Index, Physical Tag (PIPT)

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 arch/arm64/include/asm/cachetype.h | 2 +-
 arch/arm64/kernel/cpuinfo.c        | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index f05974c..cb84b4d 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -23,7 +23,7 @@
 #define CTR_CWG_SHIFT		24
 #define CTR_CWG_MASK		15
 
-#define ICACHE_POLICY_RESERVED	0
+#define ICACHE_POLICY_VPIPT	0
 #define ICACHE_POLICY_AIVIVT	1
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 2d52f8d..e2063de 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -43,7 +43,7 @@
 static struct cpuinfo_arm64 boot_cpu_data;
 
 static char *icache_policy_str[] = {
-	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
+	[ICACHE_POLICY_VPIPT] = "VPIPT",
 	[ICACHE_POLICY_AIVIVT] = "AIVIVT",
 	[ICACHE_POLICY_VIPT] = "VIPT",
 	[ICACHE_POLICY_PIPT] = "PIPT",
@@ -288,7 +288,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	unsigned int cpu = smp_processor_id();
 	u32 l1ip = CTR_L1IP(info->reg_ctr);
 
-	if (l1ip != ICACHE_POLICY_PIPT) {
+	if (l1ip == ICACHE_POLICY_AIVIVT || l1ip == ICACHE_POLICY_VIPT) {
 		/*
 		 * VIPT caches are non-aliasing if the VA always equals the PA
 		 * in all bit positions that are covered by the index. This is
@@ -299,9 +299,10 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 
 		if (l1ip != ICACHE_POLICY_VIPT || waysize > PAGE_SIZE)
 			set_bit(ICACHEF_ALIASING, &__icache_flags);
+
+		if (l1ip == ICACHE_POLICY_AIVIVT)
+			set_bit(ICACHEF_AIVIVT, &__icache_flags);
 	}
-	if (l1ip == ICACHE_POLICY_AIVIVT)
-		set_bit(ICACHEF_AIVIVT, &__icache_flags);
 
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
 }
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
