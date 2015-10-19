From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:00:34 +0100
Subject: [PATCHv4 11/24] arm64: Cleanup mixed endian support detection
In-Reply-To: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
References: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445259647-21541-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the system wide safe register to decide the support
for mixed endian.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   12 ++++++++++--
 arch/arm64/kernel/cpufeature.c      |   22 ----------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c882d46..2797876 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -141,11 +141,19 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
 void check_local_cpu_features(void);
-bool cpu_supports_mixed_endian_el0(void);
-bool system_supports_mixed_endian_el0(void);
 
 u64 read_system_reg(u32 id);
 
+static inline bool cpu_supports_mixed_endian_el0(void)
+{
+	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
+}
+
+static inline bool system_supports_mixed_endian_el0(void)
+{
+	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b4656ca..a90a64d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -26,7 +26,6 @@
 #include <asm/processor.h>
 #include <asm/sysreg.h>
 
-static bool mixed_endian_el0 = true;
 unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
@@ -44,22 +43,6 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 
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
 #define ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
 	{						\
 		.strict = STRICT,			\
@@ -433,9 +416,6 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
 	init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
 	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
-
-	/* This will be removed later, once we start using the infrastructure */
-	update_mixed_endian_el0_support(info);
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -586,8 +566,6 @@ void update_cpu_features(int cpu,
 	 */
 	WARN_TAINT_ONCE(taint, TAINT_CPU_OUT_OF_SPEC,
 			"Unsupported CPU feature variation.\n");
-
-	update_mixed_endian_el0_support(info);
 }
 
 u64 read_system_reg(u32 id)
-- 
1.7.9.5
