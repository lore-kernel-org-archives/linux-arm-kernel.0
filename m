From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  2 Feb 2017 17:32:15 +0000
Subject: [PATCH 2/2] arm64: ensure __raw_read_system_reg() is self-consistent
In-Reply-To: <1486056735-29213-1-git-send-email-mark.rutland@arm.com>
References: <1486056735-29213-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1486056735-29213-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We recently discovered that __raw_read_system_reg() erroneously mapped
sysreg IDs to the wrong registers.

To ensure that we don't get hit by a similar issue in future, this patch
makes __raw_read_system_reg() use a macro for each case statement,
ensuring that each case reads the correct register.

To ensure that this patch hasn't introduced an issue, I've binary-diffed
the object files before and after this patch. No code or data sections
differ (though some debug section differ due to line numbering
changing).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 64 ++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 16fa1d3..90efd41 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -635,6 +635,9 @@ u64 read_system_reg(u32 id)
 	return regp->sys_val;
 }
 
+#define read_sysreg_case(r)	\
+	case r:		return read_sysreg_s(r)
+
 /*
  * __raw_read_system_reg() - Used by a STARTING cpu before cpuinfo is populated.
  * Read the system register on the current CPU
@@ -642,36 +645,37 @@ u64 read_system_reg(u32 id)
 static u64 __raw_read_system_reg(u32 sys_id)
 {
 	switch (sys_id) {
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
-	case SYS_ID_ISAR5_EL1:		return read_cpuid(ID_ISAR5_EL1);
-	case SYS_MVFR0_EL1:		return read_cpuid(MVFR0_EL1);
-	case SYS_MVFR1_EL1:		return read_cpuid(MVFR1_EL1);
-	case SYS_MVFR2_EL1:		return read_cpuid(MVFR2_EL1);
-
-	case SYS_ID_AA64PFR0_EL1:	return read_cpuid(ID_AA64PFR0_EL1);
-	case SYS_ID_AA64PFR1_EL1:	return read_cpuid(ID_AA64PFR1_EL1);
-	case SYS_ID_AA64DFR0_EL1:	return read_cpuid(ID_AA64DFR0_EL1);
-	case SYS_ID_AA64DFR1_EL1:	return read_cpuid(ID_AA64DFR1_EL1);
-	case SYS_ID_AA64MMFR0_EL1:	return read_cpuid(ID_AA64MMFR0_EL1);
-	case SYS_ID_AA64MMFR1_EL1:	return read_cpuid(ID_AA64MMFR1_EL1);
-	case SYS_ID_AA64MMFR2_EL1:	return read_cpuid(ID_AA64MMFR2_EL1);
-	case SYS_ID_AA64ISAR0_EL1:	return read_cpuid(ID_AA64ISAR0_EL1);
-	case SYS_ID_AA64ISAR1_EL1:	return read_cpuid(ID_AA64ISAR1_EL1);
-
-	case SYS_CNTFRQ_EL0:		return read_cpuid(CNTFRQ_EL0);
-	case SYS_CTR_EL0:		return read_cpuid(CTR_EL0);
-	case SYS_DCZID_EL0:		return read_cpuid(DCZID_EL0);
+	read_sysreg_case(SYS_ID_PFR0_EL1);
+	read_sysreg_case(SYS_ID_PFR1_EL1);
+	read_sysreg_case(SYS_ID_DFR0_EL1);
+	read_sysreg_case(SYS_ID_MMFR0_EL1);
+	read_sysreg_case(SYS_ID_MMFR1_EL1);
+	read_sysreg_case(SYS_ID_MMFR2_EL1);
+	read_sysreg_case(SYS_ID_MMFR3_EL1);
+	read_sysreg_case(SYS_ID_ISAR0_EL1);
+	read_sysreg_case(SYS_ID_ISAR1_EL1);
+	read_sysreg_case(SYS_ID_ISAR2_EL1);
+	read_sysreg_case(SYS_ID_ISAR3_EL1);
+	read_sysreg_case(SYS_ID_ISAR4_EL1);
+	read_sysreg_case(SYS_ID_ISAR5_EL1);
+	read_sysreg_case(SYS_MVFR0_EL1);
+	read_sysreg_case(SYS_MVFR1_EL1);
+	read_sysreg_case(SYS_MVFR2_EL1);
+
+	read_sysreg_case(SYS_ID_AA64PFR0_EL1);
+	read_sysreg_case(SYS_ID_AA64PFR1_EL1);
+	read_sysreg_case(SYS_ID_AA64DFR0_EL1);
+	read_sysreg_case(SYS_ID_AA64DFR1_EL1);
+	read_sysreg_case(SYS_ID_AA64MMFR0_EL1);
+	read_sysreg_case(SYS_ID_AA64MMFR1_EL1);
+	read_sysreg_case(SYS_ID_AA64MMFR2_EL1);
+	read_sysreg_case(SYS_ID_AA64ISAR0_EL1);
+	read_sysreg_case(SYS_ID_AA64ISAR1_EL1);
+
+	read_sysreg_case(SYS_CNTFRQ_EL0);
+	read_sysreg_case(SYS_CTR_EL0);
+	read_sysreg_case(SYS_DCZID_EL0);
+
 	default:
 		BUG();
 		return 0;
-- 
1.9.1
