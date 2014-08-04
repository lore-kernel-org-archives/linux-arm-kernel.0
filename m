From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon,  4 Aug 2014 11:01:03 -0700
Subject: [PATCH v2 2/2] iommu/arm-smmu: Do not access non-existing SMR
 registers
In-Reply-To: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org>
References: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org>
Message-ID: <1407175263-10699-3-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SMR registers do not exist when stream matching is not
supported by the hardware. Avoid writing to this register if not needed.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c16431f..1f3a5b3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1731,7 +1731,10 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
-		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
+		if (smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) {
+			writel_relaxed(~SMR_VALID,
+					gr0_base + ARM_SMMU_GR0_SMR(i));
+		}
 		writel_relaxed(S2CR_TYPE_BYPASS,
 			gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
