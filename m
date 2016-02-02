From: james.morse@arm.com (James Morse)
Date: Tue,  2 Feb 2016 17:03:28 +0000
Subject: [PATCH v1 2/5] arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
In-Reply-To: <1454432611-21333-1-git-send-email-james.morse@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
Message-ID: <1454432611-21333-3-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv8.2 adds a new feature register id_aa64mmfr2. This patch adds the
cpu feature boiler plate used by the actual features in later patches.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/cpu.h    | 1 +
 arch/arm64/include/asm/sysreg.h | 1 +
 arch/arm64/kernel/cpufeature.c  | 9 +++++++++
 arch/arm64/kernel/cpuinfo.c     | 1 +
 4 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index b5e9cee4b5f8..13a6103130cd 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -36,6 +36,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64isar1;
 	u64		reg_id_aa64mmfr0;
 	u64		reg_id_aa64mmfr1;
+	u64		reg_id_aa64mmfr2;
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4aeebec3d882..6d2cec2fcfd5 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -72,6 +72,7 @@
 
 #define SYS_ID_AA64MMFR0_EL1		sys_reg(3, 0, 0, 7, 0)
 #define SYS_ID_AA64MMFR1_EL1		sys_reg(3, 0, 0, 7, 1)
+#define SYS_ID_AA64MMFR2_EL1		sys_reg(3, 0, 0, 7, 2)
 
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
 #define SYS_CTR_EL0			sys_reg(3, 3, 0, 0, 1)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a84febc40db2..a4f665f95f9f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -123,6 +123,10 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 	ARM64_FTR_END,
 };
 
+static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
+	ARM64_FTR_END,
+};
+
 static struct arm64_ftr_bits ftr_ctr[] = {
 	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 3, 0),
@@ -284,6 +288,7 @@ static struct arm64_ftr_reg arm64_ftr_regs[] = {
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
 	ARM64_FTR_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1),
+	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
 
 	/* Op1 = 3, CRn = 0, CRm = 0 */
 	ARM64_FTR_REG(SYS_CTR_EL0, ftr_ctr),
@@ -408,6 +413,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
 	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
@@ -517,6 +523,8 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64mmfr0, boot->reg_id_aa64mmfr0);
 	taint |= check_update_ftr_reg(SYS_ID_AA64MMFR1_EL1, cpu,
 				      info->reg_id_aa64mmfr1, boot->reg_id_aa64mmfr1);
+	taint |= check_update_ftr_reg(SYS_ID_AA64MMFR2_EL1, cpu,
+				      info->reg_id_aa64mmfr2, boot->reg_id_aa64mmfr2);
 
 	/*
 	 * EL3 is not our concern.
@@ -814,6 +822,7 @@ static u64 __raw_read_system_reg(u32 sys_id)
 	case SYS_ID_AA64DFR1_EL1:	return read_cpuid(SYS_ID_AA64DFR0_EL1);
 	case SYS_ID_AA64MMFR0_EL1:	return read_cpuid(SYS_ID_AA64MMFR0_EL1);
 	case SYS_ID_AA64MMFR1_EL1:	return read_cpuid(SYS_ID_AA64MMFR1_EL1);
+	case SYS_ID_AA64MMFR2_EL1:	return read_cpuid(SYS_ID_AA64MMFR2_EL1);
 	case SYS_ID_AA64ISAR0_EL1:	return read_cpuid(SYS_ID_AA64ISAR0_EL1);
 	case SYS_ID_AA64ISAR1_EL1:	return read_cpuid(SYS_ID_AA64ISAR1_EL1);
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 76df22272804..966fbd52550b 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -210,6 +210,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64isar1 = read_cpuid(SYS_ID_AA64ISAR1_EL1);
 	info->reg_id_aa64mmfr0 = read_cpuid(SYS_ID_AA64MMFR0_EL1);
 	info->reg_id_aa64mmfr1 = read_cpuid(SYS_ID_AA64MMFR1_EL1);
+	info->reg_id_aa64mmfr2 = read_cpuid(SYS_ID_AA64MMFR2_EL1);
 	info->reg_id_aa64pfr0 = read_cpuid(SYS_ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(SYS_ID_AA64PFR1_EL1);
 
-- 
2.6.2
