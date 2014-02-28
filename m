From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 28 Feb 2014 16:37:09 +0100
Subject: [PATCH 1/2] iommu/arm-smmu: Replace list walk with platform driver
 data
In-Reply-To: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1393601830-4677-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of walking the list of registered SMMU devices at remove time to
locate the device being removed, set platform driver data at probe time
to point to the SMMU and retrieve the pointer at remove time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/arm-smmu.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d9ab39..c33a310 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1912,6 +1912,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	list_add(&smmu->list, &arm_smmu_devices);
 	spin_unlock(&arm_smmu_devices_lock);
 
+	platform_set_drvdata(pdev, smmu);
+
 	arm_smmu_device_reset(smmu);
 	return 0;
 
@@ -1937,22 +1939,13 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	int i;
 	struct device *dev = &pdev->dev;
-	struct arm_smmu_device *curr, *smmu = NULL;
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 	struct rb_node *node;
 
 	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(curr, &arm_smmu_devices, list) {
-		if (curr->dev == dev) {
-			smmu = curr;
-			list_del(&smmu->list);
-			break;
-		}
-	}
+	list_del(&smmu->list);
 	spin_unlock(&arm_smmu_devices_lock);
 
-	if (!smmu)
-		return -ENODEV;
-
 	if (smmu->parent_of_node)
 		of_node_put(smmu->parent_of_node);
 
-- 
1.8.3.2
