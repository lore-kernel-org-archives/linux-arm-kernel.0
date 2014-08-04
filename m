From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon,  4 Aug 2014 11:01:02 -0700
Subject: [PATCH v2 1/2] iommu/arm-smmu: Fix programming of SMMU_CBn_TCR for
 stage 1
In-Reply-To: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org>
References: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org>
Message-ID: <1407175263-10699-2-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stage-1 context bank does not have SMMU_CBn_TCR[SL0] field. SL0 field
is only applicable to stage-2 context banks.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3cf698d..c16431f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -864,8 +864,11 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	reg |= TTBCR_EAE |
 	      (TTBCR_SH_IS << TTBCR_SH0_SHIFT) |
 	      (TTBCR_RGN_WBWA << TTBCR_ORGN0_SHIFT) |
-	      (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT) |
-	      (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
+	      (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT);
+
+	if (!stage1)
+		reg |= (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
+
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
 
 	/* MAIR0 (stage-1 only) */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
