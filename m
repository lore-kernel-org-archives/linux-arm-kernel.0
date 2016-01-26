From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Jan 2016 10:58:13 +0000
Subject: [PATCH 1/4] arm64: cpufeature: Correct feature register tables
In-Reply-To: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
References: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453805896-4397-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the feature bit entries for :
  ID_DFR0
  ID_MMFR0

to fix the default safe value for some of the bits.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 3614066..c393876 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -141,12 +141,12 @@ static struct arm64_ftr_bits ftr_ctr[] = {
 };
 
 static struct arm64_ftr_bits ftr_id_mmfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0),	/* InnerShr */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0xf),	/* InnerShr */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 24, 4, 0),	/* FCSE */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* AuxReg */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 16, 4, 0),	/* TCM */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* ShareLvl */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0),	/* OuterShr */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0xf),	/* OuterShr */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),	/* PMSA */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),	/* VMSA */
 	ARM64_FTR_END,
@@ -205,6 +205,18 @@ static struct arm64_ftr_bits ftr_id_pfr0[] = {
 	ARM64_FTR_END,
 };
 
+static struct arm64_ftr_bits ftr_id_dfr0[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),
+	ARM64_FTR_END,
+};
+
 /*
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
@@ -250,7 +262,7 @@ static struct arm64_ftr_reg arm64_ftr_regs[] = {
 	/* Op1 = 0, CRn = 0, CRm = 1 */
 	ARM64_FTR_REG(SYS_ID_PFR0_EL1, ftr_id_pfr0),
 	ARM64_FTR_REG(SYS_ID_PFR1_EL1, ftr_generic_32bits),
-	ARM64_FTR_REG(SYS_ID_DFR0_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_ID_DFR0_EL1, ftr_id_dfr0),
 	ARM64_FTR_REG(SYS_ID_MMFR0_EL1, ftr_id_mmfr0),
 	ARM64_FTR_REG(SYS_ID_MMFR1_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_ID_MMFR2_EL1, ftr_generic_32bits),
-- 
1.7.9.5
