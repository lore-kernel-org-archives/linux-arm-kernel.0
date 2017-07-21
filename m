From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 21 Jul 2017 13:12:38 +0100
Subject: [PATCH 4/4] iommu: Finish making iommu_group support mandatory
In-Reply-To: <cover.1500637633.git.robin.murphy@arm.com>
References: <cover.1500637633.git.robin.murphy@arm.com>
Message-ID: <c696938d2fc3b09a3569bdea448fd0fbdc1ec5f0.1500637633.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all the drivers properly implementing the IOMMU API support
groups (I'm ignoring the etnaviv GPU MMUs which seemingly only do just
enough to convince the ARM DMA mapping ops), we can remove the FIXME
workarounds from the core code. In the process, it also seems logical to
make the .device_group callback non-optional for drivers calling
iommu_group_get_for_dev() - the current callers all implement it anyway,
and it doesn't make sense for any future callers not to either.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f6ea160afed..af69bf7e035a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1005,11 +1005,10 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (group)
 		return group;
 
-	group = ERR_PTR(-EINVAL);
-
-	if (ops && ops->device_group)
-		group = ops->device_group(dev);
+	if (!ops)
+		return ERR_PTR(-EINVAL);
 
+	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		return ERR_PTR(-EINVAL);
 
@@ -1298,12 +1297,8 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	int ret;
 
 	group = iommu_group_get(dev);
-	/* FIXME: Remove this when groups a mandatory for iommu drivers */
-	if (group == NULL)
-		return __iommu_attach_device(domain, dev);
-
 	/*
-	 * We have a group - lock it to make sure the device-count doesn't
+	 * Lock the group to make sure the device-count doesn't
 	 * change while we are attaching
 	 */
 	mutex_lock(&group->mutex);
@@ -1336,9 +1331,6 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 	struct iommu_group *group;
 
 	group = iommu_group_get(dev);
-	/* FIXME: Remove this when groups a mandatory for iommu drivers */
-	if (group == NULL)
-		return __iommu_detach_device(domain, dev);
 
 	mutex_lock(&group->mutex);
 	if (iommu_group_device_count(group) != 1) {
@@ -1360,9 +1352,6 @@ struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 	struct iommu_group *group;
 
 	group = iommu_group_get(dev);
-	/* FIXME: Remove this when groups a mandatory for iommu drivers */
-	if (group == NULL)
-		return NULL;
 
 	domain = group->domain;
 
-- 
2.12.2.dirty
