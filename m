From: nwatters@codeaurora.org (Nate Watterson)
Date: Mon, 19 Dec 2016 15:38:38 -0500
Subject: [PATCH] iommu/arm-smmu-v3: prevent corruption of ste stage-1 context
 ptr
Message-ID: <1482179918-4457-1-git-send-email-nwatters@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To ensure that the stage-1 context ptr for an ste points to the
intended context descriptor, this patch adds code to clear away
the stale context ptr value prior to or'ing in the new one.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d6ec44..093f9f1 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1080,6 +1080,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		if (smmu->features & ARM_SMMU_FEAT_STALLS)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
+		val &= ~(STRTAB_STE_0_S1CTXPTR_MASK <<
+			 STRTAB_STE_0_S1CTXPTR_SHIFT);
 		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
 		        << STRTAB_STE_0_S1CTXPTR_SHIFT) |
 			STRTAB_STE_0_CFG_S1_TRANS;
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
