From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 19 Aug 2016 17:13:11 +0100
Subject: [RFC PATCH v3 3/7] arm64: cpufeature: Allow early detect of specific
 features
In-Reply-To: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
References: <1471623195-7829-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1471623195-7829-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is not possible to detect features of the boot CPU
until the other CPUs have been brought up.

This prevents us from reacting to features of the boot CPU until
fairly late in the boot process. To solve this we allow a subset
of features (that are likely to be common to all clusters) to be
detected based on the boot CPU alone.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/kernel/cpufeature.c | 92 ++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 62272eac1352..e5af761c80b8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -423,45 +423,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	reg->strict_mask = strict_mask;
 }
 
-void __init init_cpu_features(struct cpuinfo_arm64 *info)
-{
-	/* Before we start using the tables, make sure it is sorted */
-	sort_ftr_regs();
-
-	init_cpu_ftr_reg(SYS_CTR_EL0, info->reg_ctr);
-	init_cpu_ftr_reg(SYS_DCZID_EL0, info->reg_dczid);
-	init_cpu_ftr_reg(SYS_CNTFRQ_EL0, info->reg_cntfrq);
-	init_cpu_ftr_reg(SYS_ID_AA64DFR0_EL1, info->reg_id_aa64dfr0);
-	init_cpu_ftr_reg(SYS_ID_AA64DFR1_EL1, info->reg_id_aa64dfr1);
-	init_cpu_ftr_reg(SYS_ID_AA64ISAR0_EL1, info->reg_id_aa64isar0);
-	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
-	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
-	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
-	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
-	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
-	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
-
-	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
-		init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
-		init_cpu_ftr_reg(SYS_ID_ISAR0_EL1, info->reg_id_isar0);
-		init_cpu_ftr_reg(SYS_ID_ISAR1_EL1, info->reg_id_isar1);
-		init_cpu_ftr_reg(SYS_ID_ISAR2_EL1, info->reg_id_isar2);
-		init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
-		init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
-		init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
-		init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
-		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
-		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
-		init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
-		init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
-		init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
-		init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
-		init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
-		init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
-	}
-
-}
-
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
 {
 	struct arm64_ftr_bits *ftrp;
@@ -739,6 +700,18 @@ static bool hyp_offset_low(const struct arm64_cpu_capabilities *entry,
 	return idmap_addr > GENMASK(VA_BITS - 2, 0) && !is_kernel_in_hyp_mode();
 }
 
+static const struct arm64_cpu_capabilities arm64_early_features[] = {
+	{
+		.desc = "GIC system register CPU interface",
+		.capability = ARM64_HAS_SYSREG_GIC_CPUIF,
+		.matches = has_useable_gicv3_cpuif,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_GIC_SHIFT,
+		.min_field_value = 1,
+	},
+	{}
+};
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1023,6 +996,47 @@ void verify_local_cpu_capabilities(void)
 		verify_local_elf_hwcaps(compat_elf_hwcaps);
 }
 
+void __init init_cpu_features(struct cpuinfo_arm64 *info)
+{
+	/* Before we start using the tables, make sure it is sorted */
+	sort_ftr_regs();
+
+	init_cpu_ftr_reg(SYS_CTR_EL0, info->reg_ctr);
+	init_cpu_ftr_reg(SYS_DCZID_EL0, info->reg_dczid);
+	init_cpu_ftr_reg(SYS_CNTFRQ_EL0, info->reg_cntfrq);
+	init_cpu_ftr_reg(SYS_ID_AA64DFR0_EL1, info->reg_id_aa64dfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64DFR1_EL1, info->reg_id_aa64dfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64ISAR0_EL1, info->reg_id_aa64isar0);
+	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
+	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
+	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
+
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
+		init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
+		init_cpu_ftr_reg(SYS_ID_ISAR0_EL1, info->reg_id_isar0);
+		init_cpu_ftr_reg(SYS_ID_ISAR1_EL1, info->reg_id_isar1);
+		init_cpu_ftr_reg(SYS_ID_ISAR2_EL1, info->reg_id_isar2);
+		init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
+		init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
+		init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
+		init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
+		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
+		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
+		init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
+		init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
+		init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
+		init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
+		init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
+		init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
+	}
+
+	update_cpu_capabilities(arm64_early_features,
+				"early detected feature:");
+}
+
 static void __init setup_feature_capabilities(void)
 {
 	update_cpu_capabilities(arm64_features, "detected feature:");
-- 
2.7.4
