From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Feb 2018 14:41:44 +0000
Subject: [PATCH] arm64: cpufeature: Fix CTR_EL0 field definitions
Message-ID: <1519051304-25141-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our field definitions for CTR_EL0 suffer from a number of problems:

  - The IDC and DIC fields are missing, which causes us to enable CTR
    trapping on CPUs with either of these returning non-zero values.

  - The ERG is FTR_LOWER_SAFE, whereas it should be treated like CWG as
    FTR_HIGHER_SAFE so that applications can use it to avoid false sharing.

  - [nit] A RES1 field is described as "RAO"

This patch updates the CTR_EL0 field definitions to fix these issues.

Cc: <stable@vger.kernel.org>
Cc: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 29b1f873e337..2985a067fc13 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -199,9 +199,11 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 };
 
 static const struct arm64_ftr_bits ftr_ctr[] = {
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),		/* RES1 */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 29, 1, 1),	/* DIC */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 28, 1, 1),	/* IDC */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 20, 4, 0),	/* ERG */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
-- 
2.1.4
