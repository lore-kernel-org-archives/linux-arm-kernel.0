From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 17 Jan 2018 11:54:39 +0000
Subject: [PATCH v2 1/6] arm64: cpufeature: Allow early detect of specific
 features
In-Reply-To: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1516190084-18978-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently it is not possible to detect features of the boot CPU
until the other CPUs have been brought up.

This prevents us from reacting to features of the boot CPU until
fairly late in the boot process. To solve this we allow a subset
of features (that are likely to be common to all clusters) to be
detected based on the boot CPU alone.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
[julien.thierry at arm.com: check non-boot cpu missing early features, avoid
			 duplicates between early features and normal
			 features]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 69 ++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a73a592..6698404 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -52,6 +52,8 @@
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcaps);

+static void __init setup_early_feature_capabilities(void);
+
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -542,6 +544,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
 		sve_init_vq_map();
 	}
+
+	setup_early_feature_capabilities();
 }

 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -846,7 +850,7 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 					ID_AA64PFR0_FP_SHIFT) < 0;
 }

-static const struct arm64_cpu_capabilities arm64_features[] = {
+static const struct arm64_cpu_capabilities arm64_early_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
 		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
@@ -857,6 +861,10 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
 		.sign = FTR_UNSIGNED,
 		.min_field_value = 1,
 	},
+	{}
+};
+
+static const struct arm64_cpu_capabilities arm64_features[] = {
 #ifdef CONFIG_ARM64_PAN
 	{
 		.desc = "Privileged Access Never",
@@ -1111,6 +1119,29 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 	}
 }

+/* Returns false on a capability mismatch */
+static bool
+verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
+{
+	for (; caps->matches; caps++) {
+		if (!cpus_have_cap(caps->capability))
+			continue;
+		/*
+		 * If the new CPU misses an advertised feature, we cannot
+		 * proceed further, park the cpu.
+		 */
+		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
+			pr_crit("CPU%d: missing feature: %s\n",
+					smp_processor_id(), caps->desc);
+			return false;
+		}
+		if (caps->enable)
+			caps->enable(NULL);
+	}
+
+	return true;
+}
+
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
@@ -1119,6 +1150,9 @@ static void check_early_cpu_features(void)
 {
 	verify_cpu_run_el();
 	verify_cpu_asid_bits();
+
+	if (!verify_local_cpu_features(arm64_early_features))
+		cpu_panic_kernel();
 }

 static void
@@ -1133,26 +1167,6 @@ static void check_early_cpu_features(void)
 		}
 }

-static void
-verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
-{
-	for (; caps->matches; caps++) {
-		if (!cpus_have_cap(caps->capability))
-			continue;
-		/*
-		 * If the new CPU misses an advertised feature, we cannot proceed
-		 * further, park the cpu.
-		 */
-		if (!caps->matches(caps, SCOPE_LOCAL_CPU)) {
-			pr_crit("CPU%d: missing feature: %s\n",
-					smp_processor_id(), caps->desc);
-			cpu_die_early();
-		}
-		if (caps->enable)
-			caps->enable(NULL);
-	}
-}
-
 static void verify_sve_features(void)
 {
 	u64 safe_zcr = read_sanitised_ftr_reg(SYS_ZCR_EL1);
@@ -1181,7 +1195,10 @@ static void verify_sve_features(void)
 static void verify_local_cpu_capabilities(void)
 {
 	verify_local_cpu_errata_workarounds();
-	verify_local_cpu_features(arm64_features);
+
+	if (!verify_local_cpu_features(arm64_features))
+		cpu_die_early();
+
 	verify_local_elf_hwcaps(arm64_elf_hwcaps);

 	if (system_supports_32bit_el0())
@@ -1211,6 +1228,13 @@ void check_local_cpu_capabilities(void)
 		verify_local_cpu_capabilities();
 }

+static void __init setup_early_feature_capabilities(void)
+{
+	update_cpu_capabilities(arm64_early_features,
+				"early detected feature:");
+	enable_cpu_capabilities(arm64_early_features);
+}
+
 static void __init setup_feature_capabilities(void)
 {
 	update_cpu_capabilities(arm64_features, "detected feature:");
@@ -1249,6 +1273,7 @@ static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
 bool this_cpu_has_cap(unsigned int cap)
 {
 	return (__this_cpu_has_cap(arm64_features, cap) ||
+		__this_cpu_has_cap(arm64_early_features, cap) ||
 		__this_cpu_has_cap(arm64_errata, cap));
 }

--
1.9.1
