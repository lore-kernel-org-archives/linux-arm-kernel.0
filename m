From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 29 Feb 2016 13:46:15 +0000
Subject: [PATCH 06/12] iommu/arm-smmu: Streamline SMMU data lookup
In-Reply-To: <cover.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Message-ID: <dea9c65414a1134bbe74dee79a055bf2222d8adc.1456514380.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify things by stashing our SMMU instance data in drvdata, so that
we don't need to go off hunting for it in the driver model callbacks.
Watch out, arm_smmu_devices list, your days are numbered!

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2409e3b..514ae2d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1836,6 +1836,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
+	platform_set_drvdata(pdev, smmu);
 	INIT_LIST_HEAD(&smmu->list);
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
@@ -1860,24 +1861,17 @@ out_put_masters:
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 	int i;
-	struct device *dev = &pdev->dev;
-	struct arm_smmu_device *curr, *smmu = NULL;
 	struct rb_node *node;
 
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(curr, &arm_smmu_devices, list) {
-		if (curr->dev == dev) {
-			smmu = curr;
-			list_del(&smmu->list);
-			break;
-		}
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-
 	if (!smmu)
 		return -ENODEV;
 
+	spin_lock(&arm_smmu_devices_lock);
+	list_del(&smmu->list);
+	spin_unlock(&arm_smmu_devices_lock);
+
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master
 			= container_of(node, struct arm_smmu_master, node);
@@ -1885,7 +1879,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	}
 
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
-		dev_err(dev, "removing device with active domains!\n");
+		dev_err(&pdev->dev, "removing device with active domains!\n");
 
 	for (i = 0; i < smmu->num_global_irqs; ++i)
 		free_irq(smmu->irqs[i], smmu);
-- 
2.7.2.333.g70bd996.dirty
