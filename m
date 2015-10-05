From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:01:59 +0100
Subject: [PATCH v2 10/22] arm64: Cleanup mixed endian support detection
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the system wide safe register to decide the support
for mixed endian.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a4eff72..3506876 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -24,7 +24,6 @@
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 
-static bool mixed_endian_el0 = true;
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
@@ -42,22 +41,6 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
-
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
 #define ARM64_FTR_BITS(ftr_strict, ftr_type, ftr_shift, ftr_width, ftr_safe_val) \
 	{							\
 		.strict = ftr_strict,				\
@@ -438,9 +421,6 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
 	init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
 	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
-
-	/* This will be removed later, once we start using the infrastructure */
-	update_mixed_endian_el0_support(info);
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -590,8 +570,6 @@ void update_cpu_features(int cpu,
 	 */
 	WARN_TAINT_ONCE(taint, TAINT_CPU_OUT_OF_SPEC,
 			"Unsupported CPU feature variation.\n");
-
-	update_mixed_endian_el0_support(info);
 }
 
 u64 read_system_reg(u32 id)
@@ -681,6 +659,16 @@ void check_local_cpu_features(void)
 	check_cpu_capabilities(arm64_features, "detected feature:");
 }
 
+bool cpu_supports_mixed_endian_el0(void)
+{
+	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
+}
+
+bool system_supports_mixed_endian_el0(void)
+{
+	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
+}
+
 void __init setup_cpu_features(void)
 {
 	u64 features;
-- 
1.7.9.5
