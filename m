From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 31 Aug 2016 11:31:10 +0100
Subject: [PATCH v2 3/3] arm64: cpufeature: expose arm64_ftr_reg struct for
 CTR_EL0
In-Reply-To: <1472639470-28224-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472639470-28224-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472639470-28224-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose the arm64_ftr_reg struct covering CTR_EL0 outside of cpufeature.o
so that other code can refer to it directly (i.e., without performing the
binary search)

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cpufeature.h | 2 ++
 arch/arm64/kernel/cpufeature.c      | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8bb4f1527b26..c07c5d1cd04a 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -78,6 +78,8 @@ struct arm64_ftr_reg {
 	const struct arm64_ftr_bits	*ftr_bits;
 };
 
+extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
+
 /* scope of capability check */
 enum {
 	SCOPE_SYSTEM,
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index cc7451a27d94..c3d7ae48f92d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -155,6 +155,11 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_END,
 };
 
+struct arm64_ftr_reg arm64_ftr_reg_ctrel0 = {
+	.name		= "SYS_CTR_EL0",
+	.ftr_bits	= ftr_ctr
+};
+
 static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0xf),	/* InnerShr */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 24, 4, 0),	/* FCSE */
@@ -318,7 +323,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
 
 	/* Op1 = 3, CRn = 0, CRm = 0 */
-	ARM64_FTR_REG(SYS_CTR_EL0, ftr_ctr),
+	{ SYS_CTR_EL0, &arm64_ftr_reg_ctrel0 },
 	ARM64_FTR_REG(SYS_DCZID_EL0, ftr_dczid),
 
 	/* Op1 = 3, CRn = 14, CRm = 0 */
-- 
2.7.4
