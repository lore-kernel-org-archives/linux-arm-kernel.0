From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 11 Apr 2018 12:55:09 -0600
Subject: [PATCH 1/2] iommu: Gracefully allow drivers to not attach to a
 default domain
In-Reply-To: <20180411185510.11594-1-jcrouse@codeaurora.org>
References: <20180411185510.11594-1-jcrouse@codeaurora.org>
Message-ID: <20180411185510.11594-2-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide individual device drivers the chance to gracefully refuse
to attach a device to the default domain. If the attach_device
op returns -ENOTSUPP don't print a error message and don't set
group->domain but still return success from iommu_group_add_dev().

This allows all the usual APIs to work and the next domain to try
to attach will take group->domain for itself and everything will
proceed as normal.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 drivers/iommu/iommu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 69fef991c651..2403cce138d2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -592,7 +592,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	if (group->domain)
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
-	if (ret)
+	if (ret && ret != -ENOTSUPP)
 		goto err_put_group;
 
 	/* Notify any listeners about change to group. */
@@ -617,7 +617,9 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 err_free_device:
 	kfree(device);
-	pr_err("Failed to add device %s to group %d: %d\n", dev_name(dev), group->id, ret);
+	if (ret != -ENOTSUPP)
+		pr_err("Failed to add device %s to group %d: %d\n",
+			dev_name(dev), group->id, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
@@ -1039,8 +1041,16 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	ret = iommu_group_add_device(group, dev);
 	if (ret) {
-		iommu_group_put(group);
-		return ERR_PTR(ret);
+		/*
+		 * If the driver chooses not to bind the device, reset
+		 * group->domain so a new domain can be added later
+		 */
+		if (ret == -ENOTSUPP)
+			group->domain = NULL;
+		else {
+			iommu_group_put(group);
+			return ERR_PTR(ret);
+		}
 	}
 
 	return group;
-- 
2.16.1
