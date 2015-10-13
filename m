From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 13 Oct 2015 18:22:23 +0100
Subject: [PATCH v3 15/24] arm64: Make use of system wide capability checks
In-Reply-To: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444756952-31145-16-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can reliably read the system wide safe value for a
feature register, use that to compute the system capability.
This patch also replaces the 'feature-register-specific'
methods with a generic routine to check the capability.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    1 +
 arch/arm64/kernel/cpufeature.c      |   79 ++++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4a02a18..bf71a8e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -78,6 +78,7 @@ struct arm64_cpu_capabilities {
 		};
 
 		struct {	/* Feature register checking */
+			u32 sys_reg;
 			int field_pos;
 			int min_field_value;
 		};
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4360637..dd58c32 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -561,34 +561,31 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 	return val >= entry->min_field_value;
 }
 
-#define __ID_FEAT_CHK(reg)						\
-static bool __maybe_unused						\
-has_##reg##_feature(const struct arm64_cpu_capabilities *entry)		\
-{									\
-	u64 val;							\
-									\
-	val = read_cpuid(reg##_el1);					\
-	return feature_matches(val, entry);				\
-}
+static bool
+has_cpuid_feature(const struct arm64_cpu_capabilities *entry)
+{
+	u64 val;
 
-__ID_FEAT_CHK(id_aa64pfr0);
-__ID_FEAT_CHK(id_aa64mmfr1);
-__ID_FEAT_CHK(id_aa64isar0);
+	val = read_system_reg(entry->sys_reg);
+	return feature_matches(val, entry);
+}
 
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
-		.matches = has_id_aa64pfr0_feature,
-		.field_pos = 24,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_GIC_SHIFT,
 		.min_field_value = 1,
 	},
 #ifdef CONFIG_ARM64_PAN
 	{
 		.desc = "Privileged Access Never",
 		.capability = ARM64_HAS_PAN,
-		.matches = has_id_aa64mmfr1_feature,
-		.field_pos = 20,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64MMFR1_EL1,
+		.field_pos = ID_AA64MMFR1_PAN_SHIFT,
 		.min_field_value = 1,
 		.enable = cpu_enable_pan,
 	},
@@ -597,8 +594,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "LSE atomic instructions",
 		.capability = ARM64_HAS_LSE_ATOMICS,
-		.matches = has_id_aa64isar0_feature,
-		.field_pos = 20,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64ISAR0_EL1,
+		.field_pos = ID_AA64ISAR0_ATOMICS_SHIFT,
 		.min_field_value = 2,
 	},
 #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
@@ -628,6 +626,47 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 }
 
 /*
+ * __raw_read_system_reg() - Used by a STARTING cpu before cpuinfo is populated.
+ */
+static u64 __raw_read_system_reg(u32 sys_id)
+{
+	switch(sys_id) {
+	case SYS_ID_PFR0_EL1:		return (u64)read_cpuid(ID_PFR0_EL1);
+	case SYS_ID_PFR1_EL1:		return (u64)read_cpuid(ID_PFR1_EL1);
+	case SYS_ID_DFR0_EL1:		return (u64)read_cpuid(ID_DFR0_EL1);
+	case SYS_ID_MMFR0_EL1:		return (u64)read_cpuid(ID_MMFR0_EL1);
+	case SYS_ID_MMFR1_EL1:		return (u64)read_cpuid(ID_MMFR1_EL1);
+	case SYS_ID_MMFR2_EL1:		return (u64)read_cpuid(ID_MMFR2_EL1);
+	case SYS_ID_MMFR3_EL1:		return (u64)read_cpuid(ID_MMFR3_EL1);
+	case SYS_ID_ISAR0_EL1:		return (u64)read_cpuid(ID_ISAR0_EL1);
+	case SYS_ID_ISAR1_EL1:		return (u64)read_cpuid(ID_ISAR1_EL1);
+	case SYS_ID_ISAR2_EL1:		return (u64)read_cpuid(ID_ISAR2_EL1);
+	case SYS_ID_ISAR3_EL1:		return (u64)read_cpuid(ID_ISAR3_EL1);
+	case SYS_ID_ISAR4_EL1:		return (u64)read_cpuid(ID_ISAR4_EL1);
+	case SYS_ID_ISAR5_EL1:		return (u64)read_cpuid(ID_ISAR4_EL1);
+	case SYS_MVFR0_EL1:		return (u64)read_cpuid(MVFR0_EL1);
+	case SYS_MVFR1_EL1:		return (u64)read_cpuid(MVFR1_EL1);
+	case SYS_MVFR2_EL1:		return (u64)read_cpuid(MVFR2_EL1);
+
+	case SYS_ID_AA64PFR0_EL1:	return (u64)read_cpuid(ID_AA64PFR0_EL1);
+	case SYS_ID_AA64PFR1_EL1:	return (u64)read_cpuid(ID_AA64PFR0_EL1);
+	case SYS_ID_AA64DFR0_EL1:	return (u64)read_cpuid(ID_AA64DFR0_EL1);
+	case SYS_ID_AA64DFR1_EL1:	return (u64)read_cpuid(ID_AA64DFR0_EL1);
+	case SYS_ID_AA64MMFR0_EL1:	return (u64)read_cpuid(ID_AA64MMFR0_EL1);
+	case SYS_ID_AA64MMFR1_EL1:	return (u64)read_cpuid(ID_AA64MMFR1_EL1);
+	case SYS_ID_AA64ISAR0_EL1:	return (u64)read_cpuid(ID_AA64ISAR0_EL1);
+	case SYS_ID_AA64ISAR1_EL1:	return (u64)read_cpuid(ID_AA64ISAR1_EL1);
+
+	case SYS_CNTFRQ_EL0:		return (u64)read_cpuid(CNTFRQ_EL0);
+	case SYS_CTR_EL0:		return (u64)read_cpuid(CTR_EL0);
+	case SYS_DCZID_EL0:		return (u64)read_cpuid(DCZID_EL0);
+	default:
+		BUG();
+		return 0;
+	}
+}
+
+/*
  * Park the CPU which doesn't have the capability as advertised
  * by the system.
  */
@@ -664,13 +703,13 @@ void cpu_enable_features(void)
 	const struct arm64_cpu_capabilities *caps = arm64_features;
 
 	for(i = 0; caps[i].desc; i++) {
-		if(!cpus_have_cap(caps[i].capability))
+		if(!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
 			continue;
 		/*
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!caps[i].matches(&caps[i]))
+		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg) , &caps[i]))
 			fail_incapable_cpu("arm64_features", &caps[i]);
 		if (caps[i].enable)
 			caps[i].enable(NULL);
-- 
1.7.9.5
