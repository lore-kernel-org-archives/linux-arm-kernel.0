From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Fri, 11 Oct 2013 15:24:46 +0200
Subject: [PATCH 1/2] ARM: SMMU: add devices attached to the SMMU to an IOMMU
 group
Message-ID: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IOMMU groups are expected by certain users of the IOMMU API,
e.g. VFIO. Add new devices found by the SMMU driver to an IOMMU
group to satisfy those users.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/iommu/arm-smmu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0f45a48..8b71332 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1502,6 +1502,8 @@ static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *child, *parent, *smmu;
 	struct arm_smmu_master *master = NULL;
+	struct iommu_group *group;
+	int ret;
 
 	spin_lock(&arm_smmu_devices_lock);
 	list_for_each_entry(parent, &arm_smmu_devices, list) {
@@ -1534,13 +1536,27 @@ static int arm_smmu_add_device(struct device *dev)
 	if (!master)
 		return -ENODEV;
 
+	group = iommu_group_get(dev);
+
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group)) {
+			dev_err(dev, "Failed to allocate IOMMU group\n");
+			return PTR_ERR(group);
+		}
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
 	dev->archdata.iommu = smmu;
-	return 0;
+
+	return ret;
 }
 
 static void arm_smmu_remove_device(struct device *dev)
 {
 	dev->archdata.iommu = NULL;
+	iommu_group_remove_device(dev);
 }
 
 static struct iommu_ops arm_smmu_ops = {
-- 
1.8.1.2
