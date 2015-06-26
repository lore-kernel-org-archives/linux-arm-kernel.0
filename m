From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 26 Jun 2015 16:32:57 +0800
Subject: [PATCH 1/8] iommu/arm-smmu: fix the assignment of log2size field
In-Reply-To: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1435307584-9812-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new local variable to store the value of log2size, so that it will
not be overridden by L1 table size.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f141301..ba7fe2d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2021,19 +2021,19 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 {
 	void *strtab;
 	u64 reg;
-	u32 size;
+	u32 size, log2size;
 	int ret;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;

 	/* Calculate the L1 size, capped to the SIDSIZE */
-	size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
-	size = min(size, smmu->sid_bits - STRTAB_SPLIT);
-	if (size + STRTAB_SPLIT < smmu->sid_bits)
+	log2size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
+	log2size = min(log2size, smmu->sid_bits - STRTAB_SPLIT);
+	if (log2size + STRTAB_SPLIT < smmu->sid_bits)
 		dev_warn(smmu->dev,
 			 "2-level strtab only covers %u/%u bits of SID\n",
-			 size + STRTAB_SPLIT, smmu->sid_bits);
+			 log2size + STRTAB_SPLIT, smmu->sid_bits);

-	cfg->num_l1_ents = 1 << size;
+	cfg->num_l1_ents = 1 << log2size;
 	size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
 	strtab = dma_zalloc_coherent(smmu->dev, size, &cfg->strtab_dma,
 				     GFP_KERNEL);
@@ -2047,7 +2047,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)

 	/* Configure strtab_base_cfg for 2 levels */
 	reg  = STRTAB_BASE_CFG_FMT_2LVL;
-	reg |= (size & STRTAB_BASE_CFG_LOG2SIZE_MASK)
+	reg |= (log2size & STRTAB_BASE_CFG_LOG2SIZE_MASK)
 		<< STRTAB_BASE_CFG_LOG2SIZE_SHIFT;
 	reg |= (STRTAB_SPLIT & STRTAB_BASE_CFG_SPLIT_MASK)
 		<< STRTAB_BASE_CFG_SPLIT_SHIFT;
--
1.8.0
