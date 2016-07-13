From: van.freenix@gmail.com (Peng Fan)
Date: Wed, 13 Jul 2016 10:13:08 +0800
Subject: [PATCH V2] iommu: arm-smmu: drop devm_free_irq when driver detach
Message-ID: <1468375988-15596-1-git-send-email-van.freenix@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to call devm_free_irq when driver detach.
devres_release_all which is called after 'drv->remove' will
release all managed resources.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---

V2:
 Fix compile warning. Add Robin's Reviewed-by TAG.

 drivers/iommu/arm-smmu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 860652e..b7ef1d8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2018,7 +2018,6 @@ out_put_masters:
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
-	int i;
 	struct device *dev = &pdev->dev;
 	struct arm_smmu_device *curr, *smmu = NULL;
 	struct rb_node *node;
@@ -2045,9 +2044,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(dev, "removing device with active domains!\n");
 
-	for (i = 0; i < smmu->num_global_irqs; ++i)
-		devm_free_irq(smmu->dev, smmu->irqs[i], smmu);
-
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
-- 
2.6.2
