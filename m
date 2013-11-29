From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 12:15:47 +0000
Subject: [PATCH 1/4] iommu/arm-smmu: add devices attached to the SMMU to an
 IOMMU group
In-Reply-To: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
References: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
Message-ID: <1385727350-20032-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antonios Motakis <a.motakis@virtualopensystems.com>

IOMMU groups are expected by certain users of the IOMMU API,
e.g. VFIO. Add new devices found by the SMMU driver to an IOMMU
group to satisfy those users.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e46a88700b68..879da20617fb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1494,6 +1494,13 @@ static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *child, *parent, *smmu;
 	struct arm_smmu_master *master = NULL;
+	struct iommu_group *group;
+	int ret;
+
+	if (dev->archdata.iommu) {
+		dev_warn(dev, "IOMMU driver already assigned to device\n");
+		return -EINVAL;
+	}
 
 	spin_lock(&arm_smmu_devices_lock);
 	list_for_each_entry(parent, &arm_smmu_devices, list) {
@@ -1526,13 +1533,23 @@ static int arm_smmu_add_device(struct device *dev)
 	if (!master)
 		return -ENODEV;
 
+	group = iommu_group_alloc();
+	if (IS_ERR(group)) {
+		dev_err(dev, "Failed to allocate IOMMU group\n");
+		return PTR_ERR(group);
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
1.8.2.2
