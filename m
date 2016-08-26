From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Aug 2016 18:15:42 +0100
Subject: [RFC PATCH 3/3] arm64: cpufeature: expose arm64_ftr_reg struct for
 CTR_EL0
In-Reply-To: <1472231742-13387-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472231742-13387-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472231742-13387-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose the arm64_ftr_reg struct outside of cpufeature.o so that other
code can refer to it directly (i.e., without performing the binary
search)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cpufeature.h | 2 ++
 arch/arm64/kernel/cpufeature.c      | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8bb4f1527b26..858d8d03a101 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -109,6 +109,8 @@ struct arm64_cpu_capabilities {
 
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
+extern struct arm64_ftr_reg ctrel0_ftr_reg;
+
 bool this_cpu_has_cap(unsigned int cap);
 
 static inline bool cpu_have_feature(unsigned int num)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 35a17487ffb9..3aa7ad6c5e60 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -155,6 +155,11 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_END,
 };
 
+struct arm64_ftr_reg ctrel0_ftr_reg = {
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
+	{ SYS_CTR_EL0, &ctrel0_ftr_reg },
 	ARM64_FTR_REG(SYS_DCZID_EL0, ftr_dczid),
 
 	/* Op1 = 3, CRn = 14, CRm = 0 */
-- 
2.7.4
