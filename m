From: ohaugan@codeaurora.org (Olav Haugan)
Date: Sun,  3 Aug 2014 17:47:44 -0700
Subject: [PATCH v1 2/2] iommu/arm-smmu: Correctly program S2CR and SMR
 registers
In-Reply-To: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
References: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
Message-ID: <1407113264-23426-3-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When stream matching is supported by the hardware the S2CR is indexed
by the stream matching register group index and not the stream id.
Fix the programming of the S2CR register to ensure it is programmed
correctly in both cases.

In addition, the SMR registers does not exist when stream matching is not
supported by the hardware. Avoid writing to this register if not needed.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a83ca6a..19cca83 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1115,6 +1115,9 @@ static void arm_smmu_master_free_smrs(struct arm_smmu_device *smmu,
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	struct arm_smmu_smr *smrs = cfg->smrs;
 
+	if (!smrs)
+		return;
+
 	/* Invalidate the SMRs before freeing back to the allocator */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u8 idx = smrs[i].idx;
@@ -1134,10 +1137,10 @@ static void arm_smmu_bypass_stream_mapping(struct arm_smmu_device *smmu,
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
 	for (i = 0; i < cfg->num_streamids; ++i) {
-		u16 sid = cfg->streamids[i];
-
+		u32 idx;
+		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
 		writel_relaxed(S2CR_TYPE_BYPASS,
-			       gr0_base + ARM_SMMU_GR0_S2CR(sid));
+			       gr0_base + ARM_SMMU_GR0_S2CR(idx));
 	}
 }
 
@@ -1630,7 +1633,10 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
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
