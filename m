From: nwatters@codeaurora.org (Nate Watterson)
Date: Mon, 19 Dec 2016 15:26:40 -0500
Subject: [PATCH] iommu/arm-smmu-v3: avoid over allocating for l2 stream tables
Message-ID: <1482179200-4264-1-git-send-email-nwatters@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, all l2 stream tables are being allocated with space for
(1<<split) stes without regard to the number of sid bits the smmu
physically supports. To avoid allocating memory for inaccessible
stes, this patch limits the span of an l2 table to be no larger
than the sid size of the smmu to which it belongs.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d6ec44..5dca671 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1129,6 +1129,7 @@ static void arm_smmu_init_bypass_stes(u64 *strtab, unsigned int nent)
 
 static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 {
+	u8 span;
 	size_t size;
 	void *strtab;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
@@ -1137,10 +1138,11 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	if (desc->l2ptr)
 		return 0;
 
-	size = 1 << (STRTAB_SPLIT + ilog2(STRTAB_STE_DWORDS) + 3);
+	span = (smmu->sid_bits < STRTAB_SPLIT) ? smmu->sid_bits : STRTAB_SPLIT;
+	size = 1 << (span + ilog2(STRTAB_STE_DWORDS) + 3);
 	strtab = &cfg->strtab[(sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS];
 
-	desc->span = STRTAB_SPLIT + 1;
+	desc->span = span + 1;
 	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
 					  GFP_KERNEL | __GFP_ZERO);
 	if (!desc->l2ptr) {
@@ -1150,7 +1152,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 		return -ENOMEM;
 	}
 
-	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
+	arm_smmu_init_bypass_stes(desc->l2ptr, 1 << span);
 	arm_smmu_write_strtab_l1_desc(strtab, desc);
 	return 0;
 }
@@ -2001,6 +2003,8 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev,
 			 "2-level strtab only covers %u/%u bits of SID\n",
 			 size, smmu->sid_bits);
+	else if (smmu->sid_bits < size)
+		size = smmu->sid_bits;
 
 	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
 	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
