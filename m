From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 7 Jul 2015 11:30:14 +0800
Subject: [PATCH v2 1/9] iommu/arm-smmu: fix the assignment of L1 table
 log2entries
In-Reply-To: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1436239822-14132-2-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new local variable to store the value of L1 talbe size, so that it
will not conflict with L1 talbe log2entries(stored in variable size).

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f141301..56a1fbe 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2021,21 +2021,23 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 {
 	void *strtab;
 	u64 reg;
-	u32 size;
+	u32 size, l1size;
 	int ret;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;

 	/* Calculate the L1 size, capped to the SIDSIZE */
 	size = STRTAB_L1_SZ_SHIFT - (ilog2(STRTAB_L1_DESC_DWORDS) + 3);
 	size = min(size, smmu->sid_bits - STRTAB_SPLIT);
-	if (size + STRTAB_SPLIT < smmu->sid_bits)
+	cfg->num_l1_ents = 1 << size;
+
+	size += STRTAB_SPLIT;
+	if (size < smmu->sid_bits)
 		dev_warn(smmu->dev,
 			 "2-level strtab only covers %u/%u bits of SID\n",
-			 size + STRTAB_SPLIT, smmu->sid_bits);
+			 size, smmu->sid_bits);

-	cfg->num_l1_ents = 1 << size;
-	size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
-	strtab = dma_zalloc_coherent(smmu->dev, size, &cfg->strtab_dma,
+	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
+	strtab = dma_zalloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
 				     GFP_KERNEL);
 	if (!strtab) {
 		dev_err(smmu->dev,
@@ -2056,8 +2058,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	ret = arm_smmu_init_l1_strtab(smmu);
 	if (ret)
 		dma_free_coherent(smmu->dev,
-				  cfg->num_l1_ents *
-				  (STRTAB_L1_DESC_DWORDS << 3),
+				  l1size,
 				  strtab,
 				  cfg->strtab_dma);
 	return ret;
--
1.8.0
