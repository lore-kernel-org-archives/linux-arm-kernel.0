From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Jan 2016 10:58:14 +0000
Subject: [PATCH 2/4] arm64: cpufeature: Fix the sign of feature bits
In-Reply-To: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
References: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453805896-4397-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a confusion on whether the values of a feature are signed
or not in ARM. This is not clearly mentioned in the ARM ARM either.
We have dealt most of the bits as signed so far, and marked the
rest as unsigned explicitly. This fixed in ARM ARM and will be rolled
out soon.

Here is the criteria in a nutshell:

1) The fields, which are either signed or unsigned, use increasing
   numerical values to indicate an increase in functionality. Thus, if a value
   of 0x1 indicates the presence of some instructions, then the 0x2 value will
   indicate the presence of those instructions plus some additional instructions
   or functionality.

2) For ID field values where the value 0x0 defines that a feature is not present,
   the number is an unsigned value.

3) For some features where the feature was made optional or removed after the
   start of the definition of the architecture, the value 0x0 is used to
   indicate the presence of a feature, and 0xF indicates the absence of the
   feature. In these cases, the fields are, in effect, holding signed values.

So with these rules applied, we have only the following fields which are signed and
the rest are unsigned.

 a) ID_AA64PFR0_EL1: {FP, ASIMD}
 b) ID_AA64MMFR0_EL1: {TGran4K, TGran64K}
 c) ID_AA64DFR0_EL1: PMUVer (0xf - PMUv3 not implemented)
 d) ID_DFR0_EL1: PerfMon
 e) ID_MMFR0_EL1: {InnerShr, OuterShr}

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   50 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c393876..5eeca39 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -55,14 +55,14 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 		.safe_val = SAFE_VAL,			\
 	}
 
-/* Define a feature with signed values */
+/* Define a feature with unsigned values */
 #define ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
-	__ARM64_FTR_BITS(FTR_SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
-
-/* Define a feature with unsigned value */
-#define U_ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
 	__ARM64_FTR_BITS(FTR_UNSIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
 
+/* Define a feature with a signed value */
+#define S_ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
+	__ARM64_FTR_BITS(FTR_SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
+
 #define ARM64_FTR_END					\
 	{						\
 		.width = 0,				\
@@ -85,8 +85,8 @@ static struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
 	/* Linux doesn't care about the EL3 */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64PFR0_EL3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL2_SHIFT, 4, 0),
@@ -97,8 +97,8 @@ static struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 
 static struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_BIGENDEL0_SHIFT, 4, 0),
 	/* Linux shouldn't care about secure memory */
@@ -109,7 +109,7 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	 * Differing PARange is fine as long as all peripherals and memory are mapped
 	 * within the minimum PARange of all CPUs
 	 */
-	U_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -125,28 +125,28 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 };
 
 static struct arm64_ftr_bits ftr_ctr[] = {
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 3, 0),
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
 	 * make use of *minLine
 	 */
-	U_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, 0),	/* L1Ip */
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, 0),	/* L1Ip */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 10, 0),	/* RAZ */
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
 	ARM64_FTR_END,
 };
 
 static struct arm64_ftr_bits ftr_id_mmfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0xf),	/* InnerShr */
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0xf),	/* InnerShr */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 24, 4, 0),	/* FCSE */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* AuxReg */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 16, 4, 0),	/* TCM */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* ShareLvl */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0xf),	/* OuterShr */
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0xf),	/* OuterShr */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),	/* PMSA */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),	/* VMSA */
 	ARM64_FTR_END,
@@ -154,12 +154,12 @@ static struct arm64_ftr_bits ftr_id_mmfr0[] = {
 
 static struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
-	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
 	ARM64_FTR_END,
 };
 
@@ -207,7 +207,7 @@ static struct arm64_ftr_bits ftr_id_pfr0[] = {
 
 static struct arm64_ftr_bits ftr_id_dfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
+	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),
-- 
1.7.9.5
