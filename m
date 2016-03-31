From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 31 Mar 2016 18:27:32 +0100
Subject: [PATCH v3 4/7] arm64: cpufeature: Check availability of AArch32
In-Reply-To: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459445255-15653-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARMv8 support for AArch32 state is optional. Hence it is
not safe to check the AArch32 ID registers for sanity, which
could lead to false warnings. This patch makes sure that the
AArch32 state is implemented before we keep track of the 32bit
ID registers.

As per ARM ARM (D.1.21.2 - Support for Exception Levels and
Execution States, DDI0487A.h), checking the support for AArch32
at EL0 is good enough to check the support for AArch32 (i.e,
AArch32 at EL1 => AArch32 at EL0, but not vice versa).

Tested-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   86 ++++++++++++++++++++++------------------
 arch/arm64/kernel/cpuinfo.c    |   37 +++++++++--------
 2 files changed, 67 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a067c31..cfc0cfd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -435,22 +435,26 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	init_cpu_ftr_reg(SYS_ID_AA64MMFR2_EL1, info->reg_id_aa64mmfr2);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
 	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
-	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
-	init_cpu_ftr_reg(SYS_ID_ISAR0_EL1, info->reg_id_isar0);
-	init_cpu_ftr_reg(SYS_ID_ISAR1_EL1, info->reg_id_isar1);
-	init_cpu_ftr_reg(SYS_ID_ISAR2_EL1, info->reg_id_isar2);
-	init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
-	init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
-	init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
-	init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
-	init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
-	init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
-	init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
-	init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
-	init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
-	init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
-	init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
-	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
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
 }
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
@@ -555,47 +559,51 @@ void update_cpu_features(int cpu,
 				      info->reg_id_aa64pfr1, boot->reg_id_aa64pfr1);
 
 	/*
-	 * If we have AArch32, we care about 32-bit features for compat. These
-	 * registers should be RES0 otherwise.
+	 * If we have AArch32, we care about 32-bit features for compat.
+	 * If the system doesn't support AArch32, don't update them.
 	 */
-	taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
+	if (id_aa64pfr0_32bit_el0(read_system_reg(SYS_ID_AA64PFR0_EL1)) &&
+		id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
+
+		taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
 					info->reg_id_dfr0, boot->reg_id_dfr0);
-	taint |= check_update_ftr_reg(SYS_ID_ISAR0_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_ISAR0_EL1, cpu,
 					info->reg_id_isar0, boot->reg_id_isar0);
-	taint |= check_update_ftr_reg(SYS_ID_ISAR1_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_ISAR1_EL1, cpu,
 					info->reg_id_isar1, boot->reg_id_isar1);
-	taint |= check_update_ftr_reg(SYS_ID_ISAR2_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_ISAR2_EL1, cpu,
 					info->reg_id_isar2, boot->reg_id_isar2);
-	taint |= check_update_ftr_reg(SYS_ID_ISAR3_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_ISAR3_EL1, cpu,
 					info->reg_id_isar3, boot->reg_id_isar3);
-	taint |= check_update_ftr_reg(SYS_ID_ISAR4_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_ISAR4_EL1, cpu,
 					info->reg_id_isar4, boot->reg_id_isar4);
-	taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
 					info->reg_id_isar5, boot->reg_id_isar5);
 
-	/*
-	 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
-	 * ACTLR formats could differ across CPUs and therefore would have to
-	 * be trapped for virtualization anyway.
-	 */
-	taint |= check_update_ftr_reg(SYS_ID_MMFR0_EL1, cpu,
+		/*
+		 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
+		 * ACTLR formats could differ across CPUs and therefore would have to
+		 * be trapped for virtualization anyway.
+		 */
+		taint |= check_update_ftr_reg(SYS_ID_MMFR0_EL1, cpu,
 					info->reg_id_mmfr0, boot->reg_id_mmfr0);
-	taint |= check_update_ftr_reg(SYS_ID_MMFR1_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_MMFR1_EL1, cpu,
 					info->reg_id_mmfr1, boot->reg_id_mmfr1);
-	taint |= check_update_ftr_reg(SYS_ID_MMFR2_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_MMFR2_EL1, cpu,
 					info->reg_id_mmfr2, boot->reg_id_mmfr2);
-	taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
 					info->reg_id_mmfr3, boot->reg_id_mmfr3);
-	taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
 					info->reg_id_pfr0, boot->reg_id_pfr0);
-	taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
 					info->reg_id_pfr1, boot->reg_id_pfr1);
-	taint |= check_update_ftr_reg(SYS_MVFR0_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_MVFR0_EL1, cpu,
 					info->reg_mvfr0, boot->reg_mvfr0);
-	taint |= check_update_ftr_reg(SYS_MVFR1_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_MVFR1_EL1, cpu,
 					info->reg_mvfr1, boot->reg_mvfr1);
-	taint |= check_update_ftr_reg(SYS_MVFR2_EL1, cpu,
+		taint |= check_update_ftr_reg(SYS_MVFR2_EL1, cpu,
 					info->reg_mvfr2, boot->reg_mvfr2);
+	}
 
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 84c8684..92189e2 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -216,23 +216,26 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
 
-	info->reg_id_dfr0 = read_cpuid(ID_DFR0_EL1);
-	info->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
-	info->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
-	info->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
-	info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
-	info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
-	info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
-	info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
-	info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
-	info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
-	info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
-	info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
-	info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
-
-	info->reg_mvfr0 = read_cpuid(MVFR0_EL1);
-	info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
-	info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
+	/* Update the 32bit ID registers only if AArch32 is implemented */
+	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
+		info->reg_id_dfr0 = read_cpuid(ID_DFR0_EL1);
+		info->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
+		info->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
+		info->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
+		info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
+		info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
+		info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
+		info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
+		info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
+		info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
+		info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
+		info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
+		info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
+
+		info->reg_mvfr0 = read_cpuid(MVFR0_EL1);
+		info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
+		info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
+	}
 
 	cpuinfo_detect_icache_policy(info);
 
-- 
1.7.9.5
