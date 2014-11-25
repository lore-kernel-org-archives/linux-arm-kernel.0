From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Nov 2014 13:27:43 +0000
Subject: [PATCH 3/3] arm64: sanity checks: add ID_AA64DFR{0,1}_EL1
In-Reply-To: <1416922063-8693-1-git-send-email-mark.rutland@arm.com>
References: <1416922063-8693-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1416922063-8693-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we currently expect self-hosted debug support to be identical
across CPUs, we don't currently sanity check this.

This patch adds logging of the ID_AA64DFR{0,1}_EL1 values and associated
sanity checking code.

It's not clear to me whether we need to check PMUVer, TraceVer, and
DebugVer, as we don't currently rely on these fields at all.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cpu.h |  2 ++
 arch/arm64/kernel/cpuinfo.c  | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index 0564430..ace7068 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -30,6 +30,8 @@ struct cpuinfo_arm64 {
 	u32		reg_dczid;
 	u32		reg_midr;
 
+	u64		reg_id_aa64dfr0;
+	u64		reg_id_aa64dfr1;
 	u64		reg_id_aa64isar0;
 	u64		reg_id_aa64isar1;
 	u64		reg_id_aa64mmfr0;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 1191472..0d17a92 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -111,6 +111,15 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	diff |= CHECK(cntfrq, boot, cur, cpu);
 
 	/*
+	 * The kernel uses self-hosted debug features and expects CPUs to
+	 * support identical debug features. We presently need CTX_CMPs, WRPs,
+	 * and BRPs to be identical.
+	 * ID_AA64DFR1 is currently RES0.
+	 */
+	diff |= CHECK(id_aa64dfr0, boot, cur, cpu);
+	diff |= CHECK(id_aa64dfr1, boot, cur, cpu);
+
+	/*
 	 * Even in big.LITTLE, processors should be identical instruction-set
 	 * wise.
 	 */
@@ -170,6 +179,8 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	info->reg_dczid = read_cpuid(DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
 
+	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
+	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
 	info->reg_id_aa64isar0 = read_cpuid(ID_AA64ISAR0_EL1);
 	info->reg_id_aa64isar1 = read_cpuid(ID_AA64ISAR1_EL1);
 	info->reg_id_aa64mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
-- 
1.9.1
