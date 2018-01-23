From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:27:57 +0000
Subject: [PATCH 04/16] arm64: capabilities: Prepare for fine grained
 capabilities
In-Reply-To: <20180123122809.16269-1-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
Message-ID: <20180123122809.16269-5-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use arm64_cpu_capabilities to represent CPU ELF HWCAPs exposed
to the userspace and the CPU hwcaps used by the kernel, which
include cpu features and CPU errata work arounds.

At the moment we have the following restricions:

 a) CPU feature hwcaps (arm64_features) and ELF HWCAPs (arm64_elf_hwcap)
   - Detected mostly on system wide CPU feature register. But
     there are some which really uses a local CPU's value to
     decide the availability (e.g, availability of hardware
     prefetch). So, we run the check only once, after all the
     boot-time active CPUs are turned on.
   - Any late CPU which doesn't posses all the established features
     is killed.
   - Any late CPU which possess a feature *not* already available
     is allowed to boot.

 b) CPU Errata work arounds (arm64_errata)
   - Detected mostly based on a local CPU's feature register.
     The checks are run on each boot time activated CPUs.
   - Any late CPU which doesn't have any of the established errata
     work around capabilities is ignored and is allowed to boot.
   - Any late CPU which has an errata work around not already available
     is killed.

However there are some exceptions to the cases above.

1) KPTI is a feature that we need to enable when at least one CPU needs it.
   And any late CPU that has this "feature" should be killed.
2) Hardware DBM feature is a non-conflicting capability which could be
   enabled on CPUs which has it without any issues, even if the CPU is
   brought up late.

So this calls for a lot more fine grained behavior for each capability.
And if we define all the attributes to control their behavior properly,
we may be able to use a single table for the CPU hwcaps (not the
ELF HWCAPs, which cover errata and features). This is a prepartory step
to get there. We define type for a capability, which for now encodes the
scope of the check. i.e, whether it should be checked system wide or on
each local CPU. We define two types :

  1) ARM64_CPUCAP_BOOT_SYSTEM_FEATURE - Implies (a) as described above.
  1) ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM - Implies (b) as described above.

As such there is no change in how the capabilities are treated.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 24 +++++++++++++++++------
 arch/arm64/kernel/cpu_errata.c      |  8 ++++----
 arch/arm64/kernel/cpufeature.c      | 38 ++++++++++++++++++-------------------
 3 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a23c0d4f27e9..4fd5de8ef33e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -86,16 +86,23 @@ struct arm64_ftr_reg {
 
 extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 
-/* scope of capability check */
-enum {
-	SCOPE_SYSTEM,
-	SCOPE_LOCAL_CPU,
-};
+
+/* Decide how the capability is detected. On a local CPU vs System wide */
+#define ARM64_CPUCAP_SCOPE_MASK			0x3
+#define ARM64_CPUCAP_SCOPE_LOCAL_CPU		BIT(0)
+#define ARM64_CPUCAP_SCOPE_SYSTEM		BIT(1)
+#define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
+#define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
+
+/* CPU errata detected at boot time based on feature of one or more CPUs */
+#define ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM	(ARM64_CPUCAP_SCOPE_LOCAL_CPU)
+/* CPU feature detected at boot time based on system-wide value of a feature */
+#define ARM64_CPUCAP_BOOT_SYSTEM_FEATURE	(ARM64_CPUCAP_SCOPE_SYSTEM)
 
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
-	int def_scope;			/* default scope */
+	u16 type;
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
 	/* Called on all active CPUs for all  "available" capabilities */
 	int (*enable)(const struct arm64_cpu_capabilities *caps);
@@ -116,6 +123,11 @@ struct arm64_cpu_capabilities {
 	};
 };
 
+static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
+{
+	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
+}
+
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 40c432d7d5c6..550ac8a0854b 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -180,14 +180,14 @@ static int qcom_enable_link_stack_sanitization(
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
 #define MIDR_RANGE(model, min, max) \
-	.def_scope = SCOPE_LOCAL_CPU, \
+	.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM, \
 	.matches = is_affected_midr_range, \
 	.midr_model = model, \
 	.midr_range_min = min, \
 	.midr_range_max = max
 
 #define MIDR_ALL_VERSIONS(model) \
-	.def_scope = SCOPE_LOCAL_CPU, \
+	.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM, \
 	.matches = is_affected_midr_range, \
 	.midr_model = model, \
 	.midr_range_min = 0, \
@@ -291,7 +291,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "Mismatched cache line size",
 		.capability = ARM64_MISMATCHED_CACHE_LINE_SIZE,
 		.matches = has_mismatched_cache_line_size,
-		.def_scope = SCOPE_LOCAL_CPU,
+		.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM,
 		.enable = cpu_enable_trap_ctr_access,
 	},
 #ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
@@ -305,7 +305,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "Qualcomm Technologies Kryo erratum 1003",
 		.capability = ARM64_WORKAROUND_QCOM_FALKOR_E1003,
-		.def_scope = SCOPE_LOCAL_CPU,
+		.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM,
 		.midr_model = MIDR_QCOM_KRYO,
 		.matches = is_kryo_midr,
 	},
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0bdc58454d7a..43c7e992d784 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -916,7 +916,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_useable_gicv3_cpuif,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_GIC_SHIFT,
@@ -927,7 +927,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Privileged Access Never",
 		.capability = ARM64_HAS_PAN,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
@@ -940,7 +940,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "LSE atomic instructions",
 		.capability = ARM64_HAS_LSE_ATOMICS,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
@@ -951,14 +951,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_no_hw_prefetch,
 	},
 #ifdef CONFIG_ARM64_UAO
 	{
 		.desc = "User Access Override",
 		.capability = ARM64_HAS_UAO,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
@@ -972,21 +972,21 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #ifdef CONFIG_ARM64_PAN
 	{
 		.capability = ARM64_ALT_PAN_NOT_UAO,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = cpufeature_pan_not_uao,
 	},
 #endif /* CONFIG_ARM64_PAN */
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = runs_at_el2,
 		.enable = cpu_copy_el2regs,
 	},
 	{
 		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
@@ -996,21 +996,21 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Reduced HYP mapping offset",
 		.capability = ARM64_HYP_OFFSET_LOW,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = hyp_offset_low,
 	},
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	{
 		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = unmap_kernel_at_el0,
 	},
 #endif
 	{
 		/* FP/SIMD is not implemented */
 		.capability = ARM64_HAS_NO_FPSIMD,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.min_field_value = 0,
 		.matches = has_no_fpsimd,
 	},
@@ -1018,7 +1018,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Data cache clean to Point of Persistence",
 		.capability = ARM64_HAS_DCPOP,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR1_EL1,
 		.field_pos = ID_AA64ISAR1_DPB_SHIFT,
@@ -1028,8 +1028,8 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #ifdef CONFIG_ARM64_SVE
 	{
 		.desc = "Scalable Vector Extension",
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.capability = ARM64_SVE,
-		.def_scope = SCOPE_SYSTEM,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
 		.field_pos = ID_AA64PFR0_SVE_SHIFT,
@@ -1042,7 +1042,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "RAS Extension Support",
 		.capability = ARM64_HAS_RAS_EXTN,
-		.def_scope = SCOPE_SYSTEM,
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
@@ -1054,16 +1054,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{},
 };
 
-#define HWCAP_CAP(reg, field, s, min_value, type, cap)	\
+#define HWCAP_CAP(reg, field, s, min_value, cap_type, cap)	\
 	{							\
 		.desc = #cap,					\
-		.def_scope = SCOPE_SYSTEM,			\
+		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,	\
 		.matches = has_cpuid_feature,			\
 		.sys_reg = reg,					\
 		.field_pos = field,				\
 		.sign = s,					\
 		.min_field_value = min_value,			\
-		.hwcap_type = type,				\
+		.hwcap_type = cap_type,				\
 		.hwcap = cap,					\
 	}
 
@@ -1156,7 +1156,7 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 	/* We support emulation of accesses to CPU ID feature registers */
 	elf_hwcap |= HWCAP_CPUID;
 	for (; hwcaps->matches; hwcaps++)
-		if (hwcaps->matches(hwcaps, hwcaps->def_scope))
+		if (hwcaps->matches(hwcaps, cpucap_default_scope(hwcaps)))
 			cap_set_elf_hwcap(hwcaps);
 }
 
@@ -1183,7 +1183,7 @@ static void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
 	for (; caps->matches; caps++) {
-		if (!caps->matches(caps, caps->def_scope))
+		if (!caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
 		if (!cpus_have_cap(caps->capability) && caps->desc)
-- 
2.13.6
