From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:01:53 +0100
Subject: [PATCH v2 04/22] arm64: Move mixed endian support detection
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the mixed endian support detection code to cpufeature.c
from cpuinfo.c. This also moves the update_cpu_features()
used by mixed endian detection code, which will get more
functionality.

Also moves the ID register field shifts to asm/sysreg.h,
where all the useful definitions will end up in later patches.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpu.h        |    2 ++
 arch/arm64/include/asm/cpufeature.h |    7 +++++++
 arch/arm64/include/asm/cputype.h    |   15 ---------------
 arch/arm64/include/asm/sysreg.h     |    3 +++
 arch/arm64/kernel/cpufeature.c      |   22 ++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |   21 ---------------------
 6 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 8e797b2..30db691 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -63,4 +63,6 @@ DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 void cpuinfo_store_cpu(void);
 void __init cpuinfo_store_boot_cpu(void);
 
+void update_cpu_features(struct cpuinfo_arm64 *info);
+
 #endif /* __ASM_CPU_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b7769f6..b5f313d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -10,6 +10,7 @@
 #define __ASM_CPUFEATURE_H
 
 #include <asm/hwcap.h>
+#include <asm/sysreg.h>
 
 /*
  * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
@@ -81,6 +82,12 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
 	return (s64)(features << (64 - 4 - field)) >> (64 - 4);
 }
 
+static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
+{
+	return cpuid_feature_extract_field(mmfr0, ID_AA64MMFR0_BIGENDEL_SHIFT) == 0x1 ||
+		cpuid_feature_extract_field(mmfr0, ID_AA64MMFR0_BIGENDEL0_SHIFT) == 0x1;
+}
+
 void __init setup_cpu_features(void);
 
 void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index ee6403d..31678b2 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -72,15 +72,6 @@
 
 #define APM_CPU_PART_POTENZA	0x000
 
-#define ID_AA64MMFR0_BIGENDEL0_SHIFT	16
-#define ID_AA64MMFR0_BIGENDEL0_MASK	(0xf << ID_AA64MMFR0_BIGENDEL0_SHIFT)
-#define ID_AA64MMFR0_BIGENDEL0(mmfr0)	\
-	(((mmfr0) & ID_AA64MMFR0_BIGENDEL0_MASK) >> ID_AA64MMFR0_BIGENDEL0_SHIFT)
-#define ID_AA64MMFR0_BIGEND_SHIFT	8
-#define ID_AA64MMFR0_BIGEND_MASK	(0xf << ID_AA64MMFR0_BIGEND_SHIFT)
-#define ID_AA64MMFR0_BIGEND(mmfr0)	\
-	(((mmfr0) & ID_AA64MMFR0_BIGEND_MASK) >> ID_AA64MMFR0_BIGEND_SHIFT)
-
 #ifndef __ASSEMBLY__
 
 /*
@@ -112,12 +103,6 @@ static inline u32 __attribute_const__ read_cpuid_cachetype(void)
 {
 	return read_cpuid(CTR_EL0);
 }
-
-static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
-{
-	return (ID_AA64MMFR0_BIGEND(mmfr0) == 0x1) ||
-		(ID_AA64MMFR0_BIGENDEL0(mmfr0) == 0x1);
-}
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index a7f3d4b..4246e41 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -44,6 +44,9 @@
 #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
 				     (!!x)<<8 | 0x1f)
 
+#define ID_AA64MMFR0_BIGENDEL0_SHIFT	16
+#define ID_AA64MMFR0_BIGENDEL_SHIFT	8
+
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e49be15..1ae8b24 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -22,7 +22,9 @@
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/processor.h>
+#include <asm/sysreg.h>
 
+static bool mixed_endian_el0 = true;
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
@@ -41,6 +43,26 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
 
+bool cpu_supports_mixed_endian_el0(void)
+{
+	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
+}
+
+bool system_supports_mixed_endian_el0(void)
+{
+	return mixed_endian_el0;
+}
+
+static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
+{
+	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
+}
+
+void update_cpu_features(struct cpuinfo_arm64 *info)
+{
+	update_mixed_endian_el0_support(info);
+}
+
 static bool
 feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 75d5a86..8307b33 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -35,7 +35,6 @@
  */
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
-static bool mixed_endian_el0 = true;
 
 static char *icache_policy_str[] = {
 	[ICACHE_POLICY_RESERVED] = "RESERVED/UNKNOWN",
@@ -69,26 +68,6 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
 }
 
-bool cpu_supports_mixed_endian_el0(void)
-{
-	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
-}
-
-bool system_supports_mixed_endian_el0(void)
-{
-	return mixed_endian_el0;
-}
-
-static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
-{
-	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
-}
-
-static void update_cpu_features(struct cpuinfo_arm64 *info)
-{
-	update_mixed_endian_el0_support(info);
-}
-
 static int check_reg_mask(char *name, u64 mask, u64 boot, u64 cur, int cpu)
 {
 	if ((boot & mask) == (cur & mask))
-- 
1.7.9.5
