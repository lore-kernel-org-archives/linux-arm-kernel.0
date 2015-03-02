From: b.reynal@virtualopensystems.com (Baptiste Reynal)
Date: Mon,  2 Mar 2015 17:57:22 +0100
Subject: [PATCH 1/1] iommu/arm-smmu: fix ARM_SMMU_FEAT_TRANS_OPS condition
Message-ID: <1425315442-29584-1-git-send-email-b.reynal@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a fix to "iommu/arm-smmu: add support for iova_to_phys
through ATS1PR".
According to ARM documentation, translation registers are optional even
in SMMUv1, so ID0_S1TS needs to be checked to verify their presence.

Signed-off-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc13dd5..d4beca4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1556,7 +1556,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 
-	if (smmu->version == 1 || (!(id & ID0_ATOSNS) && (id & ID0_S1TS))) {
+	if ((id & ID0_S1TS) && ((smmu->version == 1) || (id & ID0_ATOSNS))) {
 		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
 		dev_notice(smmu->dev, "\taddress translation ops\n");
 	}
-- 
2.3.1
