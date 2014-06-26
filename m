From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Jun 2014 16:18:45 +0100
Subject: [PATCHv3 4/5] arm64: cachetype: report weakest cache policy
In-Reply-To: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1403795926-17139-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In big.LITTLE systems, the I-cache policy may differ across CPUs, and
thus we must always meet the most stringent maintenance requirements of
any I-cache in the system when performing maintenance to ensure
correctness. Unfortunately this requirement is not met as we always look
at the current CPU's cache type register to determine the maintenance
requirements.

This patch causes the I-cache policy of all CPUs to be taken into
account for icache_is_aliasing and icache_is_aivivt. If any I-cache in
the system is aliasing or AIVIVT, the respective function will return
true. At boot each CPU may set flags to identify that at least one
I-cache in the system is aliasing and/or AIVIVT.

The now unused and potentially misleading icache_policy function is
removed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cachetype.h | 16 ++++++++++------
 arch/arm64/kernel/cpuinfo.c        | 32 +++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 4b23e75..7a2e076 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -30,10 +30,14 @@
 
 #ifndef __ASSEMBLY__
 
-static inline u32 icache_policy(void)
-{
-	return (read_cpuid_cachetype() >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK;
-}
+#include <linux/bitops.h>
+
+#define CTR_L1IP(ctr)	(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
+
+#define ICACHEF_ALIASING	BIT(0)
+#define ICACHEF_AIVIVT		BIT(1)
+
+extern unsigned long __icache_flags;
 
 /*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
@@ -41,12 +45,12 @@ static inline u32 icache_policy(void)
  */
 static inline int icache_is_aliasing(void)
 {
-	return icache_policy() != ICACHE_POLICY_PIPT;
+	return test_bit(ICACHEF_ALIASING, &__icache_flags);
 }
 
 static inline int icache_is_aivivt(void)
 {
-	return icache_policy() == ICACHE_POLICY_AIVIVT;
+	return test_bit(ICACHEF_AIVIVT, &__icache_flags);
 }
 
 static inline u32 cache_type_cwg(void)
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 65907f3..20ca6d0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -19,7 +19,9 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 
+#include <linux/bitops.h>
 #include <linux/init.h>
+#include <linux/printk.h>
 #include <linux/smp.h>
 
 /*
@@ -30,7 +32,29 @@
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
 
-static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
+static char *icache_policy_str[] = {
+	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
+	[ICACHE_POLICY_AIVIVT] = "AIVIVT",
+	[ICACHE_POLICY_VIPT] = "VIPT",
+	[ICACHE_POLICY_PIPT] = "PIPT",
+};
+
+unsigned long __icache_flags;
+
+static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info,
+					 unsigned int cpu)
+{
+	u32 l1ip = CTR_L1IP(info->reg_ctr);
+
+	if (l1ip != ICACHE_POLICY_PIPT)
+		set_bit(ICACHEF_ALIASING, &__icache_flags);
+	if (l1ip == ICACHE_POLICY_AIVIVT);
+		set_bit(ICACHEF_AIVIVT, &__icache_flags);
+
+	pr_info("Detected %s I-cache on CPU%d", icache_policy_str[l1ip], cpu);
+}
+
+static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info, unsigned int cpu)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
 	info->reg_ctr = read_cpuid_cachetype();
@@ -56,20 +80,22 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
 	info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
 	info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
+
+	cpuinfo_detect_icache_policy(info, cpu);
 }
 
 void cpuinfo_store_cpu(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
-	__cpuinfo_store_cpu(info);
+	__cpuinfo_store_cpu(info, cpu);
 }
 
 void __init cpuinfo_store_boot_cpu(void)
 {
 	unsigned int cpu = smp_processor_id();
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
-	__cpuinfo_store_cpu(info);
+	__cpuinfo_store_cpu(info, cpu);
 
 	boot_cpu_data = *info;
 }
-- 
1.9.1
