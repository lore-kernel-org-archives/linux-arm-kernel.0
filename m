From: sricharan@codeaurora.org (Sricharan R)
Date: Tue,  9 Aug 2016 04:19:10 +0530
Subject: [PATCH 8/8] drivers: iommu: arm-smmu: Set iommu_ops in probe
In-Reply-To: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1470696550-3416-9-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iommu_ops should be set after the iommu is probed.
This ensures that the iommu is really ready when master's
iommu ops are set during their probe or else deferred.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5f12005..5e11bae 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2071,6 +2071,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "mmu-masters"))
 		arm_smmu_probe_mmu_masters(smmu);
 	arm_smmu_device_reset(smmu);
+	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
 	return 0;
 
 out_free_irqs:
@@ -2160,21 +2161,7 @@ module_exit(arm_smmu_exit);
 
 static int __init arm_smmu_of_init(struct device_node *np)
 {
-	struct arm_smmu_device *smmu;
-	struct platform_device *pdev;
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (!pdev)
-		return -ENODEV;
-
-	smmu = platform_get_drvdata(pdev);
-	of_iommu_set_ops(np, &arm_smmu_ops);
-
-	return 0;
+	return arm_smmu_init();
 }
 IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", arm_smmu_of_init);
 IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", arm_smmu_of_init);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
