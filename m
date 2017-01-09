From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  9 Jan 2017 17:28:26 +0000
Subject: [PATCH v4 3/9] arm64: cpufeature: Cleanup feature bit tables
In-Reply-To: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
References: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1483982912-27215-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does the following clean ups :

1) All undescribed fields of a register are now treated as 'strict'
   with a safe value of 0. Hence we could leave an empty table for
   describing registers which are RAZ.

2) ID_AA64DFR1_EL1 is RAZ and should use the table for RAZ register.

3) ftr_generic32 is used to represent a register with a 32bit feature
   value. Rename this to ftr_singl32 to make it more obvious. Since
   we don't have a 64bit singe feature register, kill ftr_generic.

Based on a patch by Mark Rutland.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 72bda9d..fb519e1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -247,18 +247,13 @@ static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_END,
 };
 
-static const struct arm64_ftr_bits ftr_generic[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 64, 0),
-	ARM64_FTR_END,
-};
-
-static const struct arm64_ftr_bits ftr_generic32[] = {
+/* Table for a single 32bit feature value */
+static const struct arm64_ftr_bits ftr_single32[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 32, 0),
 	ARM64_FTR_END,
 };
 
-static const struct arm64_ftr_bits ftr_aa64raz[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 64, 0),
+static const struct arm64_ftr_bits ftr_raz[] = {
 	ARM64_FTR_END,
 };
 
@@ -299,15 +294,15 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 4 */
 	ARM64_FTR_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0),
-	ARM64_FTR_REG(SYS_ID_AA64PFR1_EL1, ftr_aa64raz),
+	ARM64_FTR_REG(SYS_ID_AA64PFR1_EL1, ftr_raz),
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
-	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_generic),
+	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
 
 	/* Op1 = 0, CRn = 0, CRm = 6 */
 	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
-	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_aa64raz),
+	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_raz),
 
 	/* Op1 = 0, CRn = 0, CRm = 7 */
 	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
@@ -319,7 +314,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_DCZID_EL0, ftr_dczid),
 
 	/* Op1 = 3, CRn = 14, CRm = 0 */
-	ARM64_FTR_REG(SYS_CNTFRQ_EL0, ftr_generic32),
+	ARM64_FTR_REG(SYS_CNTFRQ_EL0, ftr_single32),
 };
 
 static int search_cmp_ftr_reg(const void *id, const void *regp)
-- 
2.7.4
