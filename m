From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  9 Jan 2017 17:28:25 +0000
Subject: [PATCH v4 2/9] arm64: cpufeature: remove explicit RAZ fields
In-Reply-To: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
References: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1483982912-27215-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

We currently have some RAZ fields described explicitly in our
arm64_ftr_bits arrays. These are inconsistently commented, grouped,
and/or applied, and maintaining these is error-prone.

Luckily, we don't need these at all. We'll never need to inspect RAZ
fields to determine feature support, and init_cpu_ftr_reg() will ensure
that any bits without a corresponding arm64_ftr_bits entry are treated
as RES0 with strict matching requirements. In check_update_ftr_reg()
we'll then compare these bits from the relevant cpuinfo_arm64
structures, and need not store them in a arm64_ftr_reg.

This patch removes the unnecessary arm64_ftr_bits entries for RES0 bits.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ea02201..72bda9d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -81,21 +81,16 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 
 
 static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 24, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA2_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA1_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_AES_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),	/* RAZ */
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
@@ -108,7 +103,6 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
@@ -126,7 +120,6 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_LOR_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_HPD_SHIFT, 4, 0),
@@ -147,7 +140,6 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 
 static const struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 3, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
@@ -157,7 +149,6 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	 * If we have differing I-cache policies, report it as the weakest - AIVIVT.
 	 */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_AIVIVT),	/* L1Ip */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 10, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
 	ARM64_FTR_END,
 };
@@ -191,14 +182,12 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_mvfr2[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 24, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* FPMisc */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* SIMDMisc */
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_dczid[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 5, 27, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 1, 1),		/* DZP */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* BS */
 	ARM64_FTR_END,
@@ -207,7 +196,6 @@ static const struct arm64_ftr_bits ftr_dczid[] = {
 
 static const struct arm64_ftr_bits ftr_id_isar5[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_RDM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 20, 4, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_CRC32_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_SHA2_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_SHA1_SHIFT, 4, 0),
@@ -217,14 +205,11 @@ static const struct arm64_ftr_bits ftr_id_isar5[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 24, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* ac2 */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* RAZ */
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_pfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 16, 16, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* State3 */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0),		/* State2 */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* State1 */
-- 
2.7.4
