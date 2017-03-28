From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue, 28 Mar 2017 16:11:12 +0530
Subject: [PATCH] iommu/arm-smmu: Fix 16bit ASID configuration
Message-ID: <1490697672-15928-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

16bit ASID should be enabled before initializing TTBR0/1,
otherwise only LSB 8bit ASID will be considered. Hence
moving configuration of TTBCR register ahead of TTBR0/1
while initializing context bank.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/iommu/arm-smmu.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9b33700..2845d73 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -758,6 +758,28 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
 
+	/* TTBCR */
+	if (stage1) {
+		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
+			reg = pgtbl_cfg->arm_v7s_cfg.tcr;
+			reg2 = 0;
+		} else {
+			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
+			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
+			reg2 |= TTBCR2_SEP_UPSTREAM;
+			/* 16bit ASID should be enabled before write to TTBR,
+			 * otherwise only LSB 8bit will be considered.
+			 */
+			if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
+				reg2 |= TTBCR2_AS;
+		}
+		if (smmu->version > ARM_SMMU_V1)
+			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
+	} else {
+		reg = pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
+	}
+	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
+
 	/* TTBRs */
 	if (stage1) {
 		u16 asid = ARM_SMMU_CB_ASID(smmu, cfg);
@@ -781,25 +803,6 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 		writeq_relaxed(reg64, cb_base + ARM_SMMU_CB_TTBR0);
 	}
 
-	/* TTBCR */
-	if (stage1) {
-		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
-			reg = pgtbl_cfg->arm_v7s_cfg.tcr;
-			reg2 = 0;
-		} else {
-			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
-			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
-			reg2 |= TTBCR2_SEP_UPSTREAM;
-			if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
-				reg2 |= TTBCR2_AS;
-		}
-		if (smmu->version > ARM_SMMU_V1)
-			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
-	} else {
-		reg = pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
-	}
-	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
-
 	/* MAIRs (stage-1 only) */
 	if (stage1) {
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH32_S) {
-- 
2.7.4
