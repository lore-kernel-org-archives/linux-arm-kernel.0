From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 7 Jul 2015 11:30:20 +0800
Subject: [PATCH v2 7/9] iommu/arm-smmu: remove arm_smmu_devices
In-Reply-To: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1436239822-14132-8-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can be replaced by of_iommu_list(in of_iommu.c).

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c569539..39c55f6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -604,10 +604,6 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };

-/* Our list of SMMU instances */
-static DEFINE_SPINLOCK(arm_smmu_devices_lock);
-static LIST_HEAD(arm_smmu_devices);
-
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -2675,11 +2671,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_free_structures;

-	/* Record our private device structure */
-	INIT_LIST_HEAD(&smmu->list);
-	spin_lock(&arm_smmu_devices_lock);
-	list_add(&smmu->list, &arm_smmu_devices);
-	spin_unlock(&arm_smmu_devices_lock);
 	platform_set_drvdata(pdev, smmu);
 	of_iommu_set_ops(smmu->dev->of_node, &arm_smmu_ops);

@@ -2692,19 +2683,10 @@ out_free_structures:

 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
-	struct arm_smmu_device *curr, *smmu = NULL;
+	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;

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
+	smmu = find_smmu_by_node(dev->of_node);
 	if (!smmu)
 		return -ENODEV;

--
1.8.0
