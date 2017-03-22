From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:08 +0000
Subject: [RFC PATCH v2 38/41] arm64/sve: Detect SVE via the cpufeature
 framework
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-39-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For robust feature detection and appropriate handling of feature
mismatches between CPUs, this patch adds knowledge of the new
feature fields and new registers ZCR_EL1 and ID_AA64ZFR0_EL1 to the
cpufeature framework.

ZCR_EL1 is not architecturally an ID register, but for smoother
integration with the cpufeatures code, this patch pretends that it
is: the LEN field is populated with the maximum supported value.
The minimum can then be taken across all CPUs and used later on to
configure the default and supported set of vector lengths for the
system.

For now, this must coexist with (and overrides) and early
initialisation done by init_task_struct_size(), which may allocate
more space in task_struct that we really need.  This will be
addressed in subsequent patches.

No fields are yet defined in ID_AA64ZFR0_EL1, and if zeros don't
stick to any of the RES0 bits in ZCR_EL1, that likely indicates
something won't work the way the kernel expects: this patch follows
the established policy of warning about mismatches and treating the
affected register or fields as zero for feature determination
purposes.

The SVE field in AA64PFR0 is made visible visible to userspace MRS
emulation.  This should make sense for future architecture
extensions.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/cpu.h        |  3 +++
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/cpufeature.h | 12 ++++++++++++
 arch/arm64/include/asm/fpsimd.h     |  4 ++++
 arch/arm64/include/asm/sysreg.h     |  4 ++++
 arch/arm64/kernel/cpufeature.c      | 38 ++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/cpuinfo.c         | 13 +++++++++++++
 arch/arm64/kernel/fpsimd.c          | 23 +++++++++++++++++++---
 8 files changed, 95 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 889226b..2318914 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -41,6 +41,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64mmfr2;
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
+	u64		reg_id_aa64zfr0;
 
 	u32		reg_id_dfr0;
 	u32		reg_id_isar0;
@@ -59,6 +60,8 @@ struct cpuinfo_arm64 {
 	u32		reg_mvfr0;
 	u32		reg_mvfr1;
 	u32		reg_mvfr2;
+
+	u64		reg_zcr;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index fb78a5d..cebb602 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -37,7 +37,8 @@
 #define ARM64_HAS_NO_FPSIMD			16
 #define ARM64_WORKAROUND_REPEAT_TLBI		17
 #define ARM64_WORKAROUND_QCOM_FALKOR_E1003	18
+#define ARM64_SVE				19
 
-#define ARM64_NCAPS				19
+#define ARM64_NCAPS				20
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f31c48d..90e4b79 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -215,6 +215,13 @@ static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
 	return val == ID_AA64PFR0_EL0_32BIT_64BIT;
 }
 
+static inline bool id_aa64pfr0_sve(u64 pfr0)
+{
+	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_SVE_SHIFT);
+
+	return val > 0;
+}
+
 void __init setup_cpu_features(void);
 
 void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
@@ -254,6 +261,11 @@ static inline bool system_uses_ttbr0_pan(void)
 		!cpus_have_const_cap(ARM64_HAS_PAN);
 }
 
+static inline bool system_supports_sve(void)
+{
+	return cpus_have_const_cap(ARM64_SVE);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 385ef226..4a50139 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -118,6 +118,8 @@ extern int sve_set_task_vl(struct task_struct *task,
 			   unsigned long vector_length, unsigned long flags);
 extern int sve_get_task_vl(struct task_struct *task);
 
+extern void __init sve_setup(void);
+
 #else /* ! CONFIG_ARM64_SVE */
 
 static void __maybe_unused sve_sync_to_fpsimd(struct task_struct *task) { }
@@ -135,6 +137,8 @@ static int __maybe_unused sve_get_task_vl(struct task_struct *task)
 	return -EINVAL;
 }
 
+static void __maybe_unused sve_setup(void) { }
+
 #endif /* ! CONFIG_ARM64_SVE */
 
 #endif
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9c4a2cc..9bfe156 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -107,6 +107,7 @@
 
 #define SYS_ID_AA64PFR0_EL1		sys_reg(3, 0, 0, 4, 0)
 #define SYS_ID_AA64PFR1_EL1		sys_reg(3, 0, 0, 4, 1)
+#define SYS_ID_AA64ZFR0_EL1		sys_reg(3, 0, 0, 4, 4)
 
 #define SYS_ID_AA64DFR0_EL1		sys_reg(3, 0, 0, 5, 0)
 #define SYS_ID_AA64DFR1_EL1		sys_reg(3, 0, 0, 5, 1)
@@ -169,6 +170,7 @@
 #define ID_AA64PFR0_EL1_SHIFT		4
 #define ID_AA64PFR0_EL0_SHIFT		0
 
+#define ID_AA64PFR0_SVE			0x1
 #define ID_AA64PFR0_FP_NI		0xf
 #define ID_AA64PFR0_FP_SUPPORTED	0x0
 #define ID_AA64PFR0_ASIMD_NI		0xf
@@ -270,6 +272,8 @@
 #endif
 
 
+#define ZCR_EL1_LEN_SHIFT	0
+#define ZCR_EL1_LEN_SIZE	9
 #define ZCR_EL1_LEN_MASK	0x1ff
 
 #define CPACR_EL1_ZEN_EL1EN	(1 << 16)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 707dfdb..83c1999 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -27,6 +27,7 @@
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
+#include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/sysreg.h>
@@ -98,6 +99,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
@@ -241,6 +243,12 @@ static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_zcr[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,
+		ZCR_EL1_LEN_SHIFT, ZCR_EL1_LEN_SIZE, 0),	/* LEN */
+	ARM64_FTR_END,
+};
+
 /*
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
@@ -307,6 +315,7 @@ static const struct __ftr_reg_entry {
 	/* Op1 = 0, CRn = 0, CRm = 4 */
 	ARM64_FTR_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0),
 	ARM64_FTR_REG(SYS_ID_AA64PFR1_EL1, ftr_raz),
+	ARM64_FTR_REG(SYS_ID_AA64ZFR0_EL1, ftr_raz),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
@@ -321,6 +330,9 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1),
 	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
 
+	/* Op1 = 0, CRn = 1, CRm = 2 */
+	ARM64_FTR_REG(SYS_ZCR_EL1, ftr_zcr),
+
 	/* Op1 = 3, CRn = 0, CRm = 0 */
 	{ SYS_CTR_EL0, &arm64_ftr_reg_ctrel0 },
 	ARM64_FTR_REG(SYS_DCZID_EL0, ftr_dczid),
@@ -458,6 +470,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64ZFR0_EL1, info->reg_id_aa64zfr0);
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
 		init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
@@ -478,6 +491,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
 	}
 
+	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0))
+		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -581,6 +596,9 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64PFR1_EL1, cpu,
 				      info->reg_id_aa64pfr1, boot->reg_id_aa64pfr1);
 
+	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
+				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
+
 	/*
 	 * If we have AArch32, we care about 32-bit features for compat.
 	 * If the system doesn't support AArch32, don't update them.
@@ -628,6 +646,10 @@ void update_cpu_features(int cpu,
 					info->reg_mvfr2, boot->reg_mvfr2);
 	}
 
+	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0))
+		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
+					info->reg_zcr, boot->reg_zcr);
+
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
 	 * pretend to support them.
@@ -860,6 +882,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 0,
 		.matches = has_no_fpsimd,
 	},
+#ifdef CONFIG_ARM64_SVE
+	{
+		.desc = "Scalable Vector Extension",
+		.capability = ARM64_SVE,
+		.def_scope = SCOPE_SYSTEM,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR0_SVE_SHIFT,
+		.min_field_value = ID_AA64PFR0_SVE,
+		.matches = has_cpuid_feature,
+	},
+#endif /* CONFIG_ARM64_SVE */
 	{},
 };
 
@@ -889,7 +923,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 0, CAP_HWCAP, HWCAP_ASIMD),
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_ASIMD_SHIFT, FTR_SIGNED, 1, CAP_HWCAP, HWCAP_ASIMDHP),
 #ifdef CONFIG_ARM64_SVE
-	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, HWCAP_SVE),
+	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, HWCAP_SVE),
 #endif
 	{},
 };
@@ -1120,6 +1154,8 @@ void __init setup_cpu_features(void)
 	if (system_supports_32bit_el0())
 		setup_elf_hwcaps(compat_elf_hwcaps);
 
+	sve_setup();
+
 	/* Advertise that we have computed the system capabilities */
 	set_sys_caps_initialised();
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 8dd410e..cb3b0dd 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/fpsimd.h>
 
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -325,6 +326,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64mmfr2 = read_cpuid(ID_AA64MMFR2_EL1);
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
+	info->reg_id_aa64zfr0 = read_cpuid(ID_AA64ZFR0_EL1);
 
 	/* Update the 32bit ID registers only if AArch32 is implemented */
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
@@ -347,6 +349,17 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 		info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
 	}
 
+	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
+		u64 zcr;
+
+		write_sysreg_s(ZCR_EL1_LEN_MASK, SYS_ZCR_EL1);
+		zcr = read_sysreg_s(SYS_ZCR_EL1);
+		zcr &= ~(u64)ZCR_EL1_LEN_MASK;
+		zcr |= sve_get_vl() / 16 - 1;
+
+		info->reg_zcr = zcr;
+	}
+
 	cpuinfo_detect_icache_policy(info);
 }
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ddb651a..34ec75e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -340,6 +340,26 @@ int sve_get_task_vl(struct task_struct *task)
 	return sve_prctl_status(task);
 }
 
+void __init sve_setup(void)
+{
+	u64 zcr;
+
+	if (!system_supports_sve())
+		return;
+
+	zcr = read_system_reg(SYS_ZCR_EL1);
+
+	BUG_ON(((zcr & ZCR_EL1_LEN_MASK) + 1) * 16 > sve_max_vl);
+
+	sve_max_vl = ((zcr & ZCR_EL1_LEN_MASK) + 1) * 16;
+	sve_default_vl = sve_max_vl > 64 ? 64 : sve_max_vl;
+
+	pr_info("SVE: maximum available vector length %u bytes per vector\n",
+		sve_max_vl);
+	pr_info("SVE: default vector length %u bytes per vector\n",
+		sve_default_vl);
+}
+
 #ifdef CONFIG_PROC_FS
 
 struct default_vl_write_state {
@@ -898,9 +918,6 @@ static int __init fpsimd_init(void)
 	if (!(elf_hwcap & HWCAP_ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
 
-	if (!(elf_hwcap & HWCAP_SVE))
-		pr_info("Scalable Vector Extension available\n");
-
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
 		return sve_procfs_init();
 
-- 
2.1.4
