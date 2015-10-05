From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon,  5 Oct 2015 18:02:02 +0100
Subject: [PATCH v2 13/22] arm64: Make use of system wide capability checks
In-Reply-To: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444064531-25607-14-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we can reliably read the system wide safe value for a
feature register, use that to compute the system capability.
This patch also replaces the 'feature-register-specific'
methods with a generic routine to check the capability.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    1 +
 arch/arm64/kernel/cpufeature.c      |   34 ++++++++++++++++------------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index cbf3c62..1234c9c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -79,6 +79,7 @@ struct arm64_cpu_capabilities {
 		};
 
 		struct {	/* Feature register checking */
+			u32 sys_reg;
 			int field_pos;
 			int min_field_value;
 		};
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 573a244..1278752 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -590,34 +590,31 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
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
@@ -626,8 +623,9 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
-- 
1.7.9.5
