From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jan 2015 10:31:56 +0000
Subject: [PATCH] arm64: sanity checks: add missing AArch32 registers
Message-ID: <1420626716-9182-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't currently check a number of registers exposed to AArch32 guests
(MVFR{0,1,2}_EL1 and ID_DFR0_EL1), despite the fact these describe
AArch32 feature support exposed to userspace and KVM guests similarly to
AArch64 registers which we do check. We do not expect these registers to
vary across a set of CPUs.

This patch adds said registers to the cpuinfo framework and sanity
checks. No sanity check failures have been observed on a current ARMv8
big.LITTLE platform (Juno).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reported-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpu.h |  5 +++++
 arch/arm64/kernel/cpuinfo.c  | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index ace7068..8e797b2 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -39,6 +39,7 @@ struct cpuinfo_arm64 {
 	u64		reg_id_aa64pfr0;
 	u64		reg_id_aa64pfr1;
 
+	u32		reg_id_dfr0;
 	u32		reg_id_isar0;
 	u32		reg_id_isar1;
 	u32		reg_id_isar2;
@@ -51,6 +52,10 @@ struct cpuinfo_arm64 {
 	u32		reg_id_mmfr3;
 	u32		reg_id_pfr0;
 	u32		reg_id_pfr1;
+
+	u32		reg_mvfr0;
+	u32		reg_mvfr1;
+	u32		reg_mvfr2;
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm64, cpu_data);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 57b6417..07d435c 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -147,6 +147,7 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	 * If we have AArch32, we care about 32-bit features for compat. These
 	 * registers should be RES0 otherwise.
 	 */
+	diff |= CHECK(id_dfr0, boot, cur, cpu);
 	diff |= CHECK(id_isar0, boot, cur, cpu);
 	diff |= CHECK(id_isar1, boot, cur, cpu);
 	diff |= CHECK(id_isar2, boot, cur, cpu);
@@ -165,6 +166,10 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	diff |= CHECK(id_pfr0, boot, cur, cpu);
 	diff |= CHECK(id_pfr1, boot, cur, cpu);
 
+	diff |= CHECK(mvfr0, boot, cur, cpu);
+	diff |= CHECK(mvfr1, boot, cur, cpu);
+	diff |= CHECK(mvfr2, boot, cur, cpu);
+
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
 	 * pretend to support them.
@@ -189,6 +194,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
 	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
 
+	info->reg_id_dfr0 = read_cpuid(ID_DFR0_EL1);
 	info->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
 	info->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
 	info->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
@@ -202,6 +208,10 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
 	info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
 
+	info->reg_mvfr0 = read_cpuid(MVFR0_EL1);
+	info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
+	info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
+
 	cpuinfo_detect_icache_policy(info);
 
 	check_local_cpu_errata();
-- 
1.9.1
