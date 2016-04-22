From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 22 Apr 2016 12:25:31 +0100
Subject: [PATCH v4 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
References: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1461324335-5081-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scope parameter to the arm64_cpu_capabilities::matches(), so that
this can be reused for checking the capability on a given CPU vs the
system wide. The system uses the default scope associated with the
capability for initialising the CPU_HWCAPs and ELF_HWCAPs.

Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

---
Changes since v3:
 - Move the __raw_read_system_reg to avoid forward declarations.
Changes since V2:
 - Rename SCOPE_CPU => SCOPE_LOCAL_CPU
 - Add check for preemptible() for SCOPE_LOCAL_CPU checks
Changes since V1:
 - Add a default scope for capabilities used by the system checks.
 - Add WARN_ON() for !SCOPE_CPU for midr checks
---
 arch/arm64/include/asm/cpufeature.h |    9 ++-
 arch/arm64/kernel/cpu_errata.c      |    4 +-
 arch/arm64/kernel/cpufeature.c      |  131 +++++++++++++++++++----------------
 3 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ca8fb4b..e501e4a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -78,10 +78,17 @@ struct arm64_ftr_reg {
 	struct arm64_ftr_bits	*ftr_bits;
 };
 
+/* scope of capability check */
+enum {
+	SCOPE_SYSTEM,
+	SCOPE_LOCAL_CPU,
+};
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
-	bool (*matches)(const struct arm64_cpu_capabilities *);
+	int def_scope;			/* default scope */
+	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
 	void (*enable)(void *);		/* Called on all active CPUs */
 	union {
 		struct {	/* To be used for erratum handling only */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 06afd04..2fdecd7 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -22,14 +22,16 @@
 #include <asm/cpufeature.h>
 
 static bool __maybe_unused
-is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
+is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
 {
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 	return MIDR_IS_CPU_MODEL_RANGE(read_cpuid_id(), entry->midr_model,
 				       entry->midr_range_min,
 				       entry->midr_range_max);
 }
 
 #define MIDR_RANGE(model, min, max) \
+	.def_scope = SCOPE_LOCAL_CPU, \
 	.matches = is_affected_midr_range, \
 	.midr_model = model, \
 	.midr_range_min = min, \
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8c46621..7f9441d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -71,7 +71,8 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
 /* meta feature for alternatives */
 static bool __maybe_unused
-cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry);
+cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
+
 
 static struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
@@ -622,6 +623,49 @@ u64 read_system_reg(u32 id)
 	return regp->sys_val;
 }
 
+/*
+ * __raw_read_system_reg() - Used by a STARTING cpu before cpuinfo is populated.
+ * Read the system register on the current CPU
+ */
+static u64 __raw_read_system_reg(u32 sys_id)
+{
+	switch (sys_id) {
+	case SYS_ID_PFR0_EL1:		return read_cpuid(ID_PFR0_EL1);
+	case SYS_ID_PFR1_EL1:		return read_cpuid(ID_PFR1_EL1);
+	case SYS_ID_DFR0_EL1:		return read_cpuid(ID_DFR0_EL1);
+	case SYS_ID_MMFR0_EL1:		return read_cpuid(ID_MMFR0_EL1);
+	case SYS_ID_MMFR1_EL1:		return read_cpuid(ID_MMFR1_EL1);
+	case SYS_ID_MMFR2_EL1:		return read_cpuid(ID_MMFR2_EL1);
+	case SYS_ID_MMFR3_EL1:		return read_cpuid(ID_MMFR3_EL1);
+	case SYS_ID_ISAR0_EL1:		return read_cpuid(ID_ISAR0_EL1);
+	case SYS_ID_ISAR1_EL1:		return read_cpuid(ID_ISAR1_EL1);
+	case SYS_ID_ISAR2_EL1:		return read_cpuid(ID_ISAR2_EL1);
+	case SYS_ID_ISAR3_EL1:		return read_cpuid(ID_ISAR3_EL1);
+	case SYS_ID_ISAR4_EL1:		return read_cpuid(ID_ISAR4_EL1);
+	case SYS_ID_ISAR5_EL1:		return read_cpuid(ID_ISAR4_EL1);
+	case SYS_MVFR0_EL1:		return read_cpuid(MVFR0_EL1);
+	case SYS_MVFR1_EL1:		return read_cpuid(MVFR1_EL1);
+	case SYS_MVFR2_EL1:		return read_cpuid(MVFR2_EL1);
+
+	case SYS_ID_AA64PFR0_EL1:	return read_cpuid(ID_AA64PFR0_EL1);
+	case SYS_ID_AA64PFR1_EL1:	return read_cpuid(ID_AA64PFR0_EL1);
+	case SYS_ID_AA64DFR0_EL1:	return read_cpuid(ID_AA64DFR0_EL1);
+	case SYS_ID_AA64DFR1_EL1:	return read_cpuid(ID_AA64DFR0_EL1);
+	case SYS_ID_AA64MMFR0_EL1:	return read_cpuid(ID_AA64MMFR0_EL1);
+	case SYS_ID_AA64MMFR1_EL1:	return read_cpuid(ID_AA64MMFR1_EL1);
+	case SYS_ID_AA64MMFR2_EL1:	return read_cpuid(ID_AA64MMFR2_EL1);
+	case SYS_ID_AA64ISAR0_EL1:	return read_cpuid(ID_AA64ISAR0_EL1);
+	case SYS_ID_AA64ISAR1_EL1:	return read_cpuid(ID_AA64ISAR1_EL1);
+
+	case SYS_CNTFRQ_EL0:		return read_cpuid(CNTFRQ_EL0);
+	case SYS_CTR_EL0:		return read_cpuid(CTR_EL0);
+	case SYS_DCZID_EL0:		return read_cpuid(DCZID_EL0);
+	default:
+		BUG();
+		return 0;
+	}
+}
+
 #include <linux/irqchip/arm-gic-v3.h>
 
 static bool
@@ -633,19 +677,24 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 }
 
 static bool
-has_cpuid_feature(const struct arm64_cpu_capabilities *entry)
+has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	u64 val;
 
-	val = read_system_reg(entry->sys_reg);
+	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
+	if (scope == SCOPE_SYSTEM)
+		val = read_system_reg(entry->sys_reg);
+	else
+		val = __raw_read_system_reg(entry->sys_reg);
+
 	return feature_matches(val, entry);
 }
 
-static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
+static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	bool has_sre;
 
-	if (!has_cpuid_feature(entry))
+	if (!has_cpuid_feature(entry, scope))
 		return false;
 
 	has_sre = gic_enable_sre();
@@ -656,7 +705,7 @@ static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
 	return has_sre;
 }
 
-static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry)
+static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	u32 midr = read_cpuid_id();
 	u32 rv_min, rv_max;
@@ -668,7 +717,7 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry)
 	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX, rv_min, rv_max);
 }
 
-static bool runs_at_el2(const struct arm64_cpu_capabilities *entry)
+static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	return is_kernel_in_hyp_mode();
 }
@@ -677,6 +726,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = has_useable_gicv3_cpuif,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.field_pos = ID_AA64PFR0_GIC_SHIFT,
@@ -687,6 +737,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Privileged Access Never",
 		.capability = ARM64_HAS_PAN,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR1_EL1,
 		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
@@ -699,6 +750,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "LSE atomic instructions",
 		.capability = ARM64_HAS_LSE_ATOMICS,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64ISAR0_EL1,
 		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
@@ -709,12 +761,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = has_no_hw_prefetch,
 	},
 #ifdef CONFIG_ARM64_UAO
 	{
 		.desc = "User Access Override",
 		.capability = ARM64_HAS_UAO,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
@@ -725,17 +779,20 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #ifdef CONFIG_ARM64_PAN
 	{
 		.capability = ARM64_ALT_PAN_NOT_UAO,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = cpufeature_pan_not_uao,
 	},
 #endif /* CONFIG_ARM64_PAN */
 	{
 		.desc = "Virtualization Host Extensions",
 		.capability = ARM64_HAS_VIRT_HOST_EXTN,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = runs_at_el2,
 	},
 	{
 		.desc = "32-bit EL0 Support",
 		.capability = ARM64_HAS_32BIT_EL0,
+		.def_scope = SCOPE_SYSTEM,
 		.matches = has_cpuid_feature,
 		.sys_reg = SYS_ID_AA64PFR0_EL1,
 		.sign = FTR_UNSIGNED,
@@ -748,6 +805,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #define HWCAP_CAP(reg, field, s, min_value, type, cap)	\
 	{							\
 		.desc = #cap,					\
+		.def_scope = SCOPE_SYSTEM,			\
 		.matches = has_cpuid_feature,			\
 		.sys_reg = reg,					\
 		.field_pos = field,				\
@@ -830,7 +888,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
 	for (; hwcaps->matches; hwcaps++)
-		if (hwcaps->matches(hwcaps))
+		if (hwcaps->matches(hwcaps, hwcaps->def_scope))
 			cap_set_elf_hwcap(hwcaps);
 }
 
@@ -838,7 +896,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
 	for (; caps->matches; caps++) {
-		if (!caps->matches(caps))
+		if (!caps->matches(caps, caps->def_scope))
 			continue;
 
 		if (!cpus_have_cap(caps->capability) && caps->desc)
@@ -875,48 +933,6 @@ static inline void set_sys_caps_initialised(void)
 }
 
 /*
- * __raw_read_system_reg() - Used by a STARTING cpu before cpuinfo is populated.
- */
-static u64 __raw_read_system_reg(u32 sys_id)
-{
-	switch (sys_id) {
-	case SYS_ID_PFR0_EL1:		return read_cpuid(ID_PFR0_EL1);
-	case SYS_ID_PFR1_EL1:		return read_cpuid(ID_PFR1_EL1);
-	case SYS_ID_DFR0_EL1:		return read_cpuid(ID_DFR0_EL1);
-	case SYS_ID_MMFR0_EL1:		return read_cpuid(ID_MMFR0_EL1);
-	case SYS_ID_MMFR1_EL1:		return read_cpuid(ID_MMFR1_EL1);
-	case SYS_ID_MMFR2_EL1:		return read_cpuid(ID_MMFR2_EL1);
-	case SYS_ID_MMFR3_EL1:		return read_cpuid(ID_MMFR3_EL1);
-	case SYS_ID_ISAR0_EL1:		return read_cpuid(ID_ISAR0_EL1);
-	case SYS_ID_ISAR1_EL1:		return read_cpuid(ID_ISAR1_EL1);
-	case SYS_ID_ISAR2_EL1:		return read_cpuid(ID_ISAR2_EL1);
-	case SYS_ID_ISAR3_EL1:		return read_cpuid(ID_ISAR3_EL1);
-	case SYS_ID_ISAR4_EL1:		return read_cpuid(ID_ISAR4_EL1);
-	case SYS_ID_ISAR5_EL1:		return read_cpuid(ID_ISAR4_EL1);
-	case SYS_MVFR0_EL1:		return read_cpuid(MVFR0_EL1);
-	case SYS_MVFR1_EL1:		return read_cpuid(MVFR1_EL1);
-	case SYS_MVFR2_EL1:		return read_cpuid(MVFR2_EL1);
-
-	case SYS_ID_AA64PFR0_EL1:	return read_cpuid(ID_AA64PFR0_EL1);
-	case SYS_ID_AA64PFR1_EL1:	return read_cpuid(ID_AA64PFR0_EL1);
-	case SYS_ID_AA64DFR0_EL1:	return read_cpuid(ID_AA64DFR0_EL1);
-	case SYS_ID_AA64DFR1_EL1:	return read_cpuid(ID_AA64DFR0_EL1);
-	case SYS_ID_AA64MMFR0_EL1:	return read_cpuid(ID_AA64MMFR0_EL1);
-	case SYS_ID_AA64MMFR1_EL1:	return read_cpuid(ID_AA64MMFR1_EL1);
-	case SYS_ID_AA64MMFR2_EL1:	return read_cpuid(ID_AA64MMFR2_EL1);
-	case SYS_ID_AA64ISAR0_EL1:	return read_cpuid(ID_AA64ISAR0_EL1);
-	case SYS_ID_AA64ISAR1_EL1:	return read_cpuid(ID_AA64ISAR1_EL1);
-
-	case SYS_CNTFRQ_EL0:		return read_cpuid(CNTFRQ_EL0);
-	case SYS_CTR_EL0:		return read_cpuid(CTR_EL0);
-	case SYS_DCZID_EL0:		return read_cpuid(DCZID_EL0);
-	default:
-		BUG();
-		return 0;
-	}
-}
-
-/*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
  */
@@ -929,28 +945,25 @@ static void
 verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 {
 
-	for (; caps->matches; caps++) {
-		if (!cpus_have_elf_hwcap(caps))
-			continue;
-		if (!feature_matches(__raw_read_system_reg(caps->sys_reg), caps)) {
+	for (; caps->matches; caps++)
+		if (cpus_have_elf_hwcap(caps) && !caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: missing HWCAP: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
 		}
-	}
 }
 
 static void
 verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
 {
 	for (; caps->matches; caps++) {
-		if (!cpus_have_cap(caps->capability) || !caps->sys_reg)
+		if (!cpus_have_cap(caps->capability))
 			continue;
 		/*
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!feature_matches(__raw_read_system_reg(caps->sys_reg), caps)) {
+		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: missing feature: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
@@ -1021,7 +1034,7 @@ void __init setup_cpu_features(void)
 }
 
 static bool __maybe_unused
-cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry)
+cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	return (cpus_have_cap(ARM64_HAS_PAN) && !cpus_have_cap(ARM64_HAS_UAO));
 }
-- 
1.7.9.5
