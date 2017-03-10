From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 20:32:24 +0000
Subject: [PATCH 5/6] arm64: cache: Identify VPIPT I-caches
In-Reply-To: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
References: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
Message-ID: <1489177945-8590-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for detecting VPIPT I-caches, as introduced by ARMv8.2.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cache.h | 7 +++++++
 arch/arm64/kernel/cpuinfo.c    | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 7acb52634299..ea9bb4e0e9bb 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -25,6 +25,7 @@
 
 #define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
 
+#define ICACHE_POLICY_VPIPT	0
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
@@ -45,6 +46,7 @@
 #include <linux/bitops.h>
 
 #define ICACHEF_ALIASING	0
+#define ICACHEF_VPIPT		1
 extern unsigned long __icache_flags;
 
 /*
@@ -56,6 +58,11 @@ static inline int icache_is_aliasing(void)
 	return test_bit(ICACHEF_ALIASING, &__icache_flags);
 }
 
+static inline int icache_is_vpipt(void)
+{
+	return test_bit(ICACHEF_VPIPT, &__icache_flags);
+}
+
 static inline u32 cache_type_cwg(void)
 {
 	return (read_cpuid_cachetype() >> CTR_CWG_SHIFT) & CTR_CWG_MASK;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 260b54f415b8..7d27f4b4881e 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -46,6 +46,7 @@ static char *icache_policy_str[] = {
 	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
 	[ICACHE_POLICY_VIPT]		= "VIPT",
 	[ICACHE_POLICY_PIPT]		= "PIPT",
+	[ICACHE_POLICY_VPIPT]		= "VPIPT",
 };
 
 unsigned long __icache_flags;
@@ -291,6 +292,9 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	switch (l1ip) {
 	case ICACHE_POLICY_PIPT:
 		break;
+	case ICACHE_POLICY_VPIPT:
+		set_bit(ICACHEF_VPIPT, &__icache_flags);
+		break;
 	default:
 		/* Fallthrough */
 	case ICACHE_POLICY_VIPT:
-- 
2.1.4
