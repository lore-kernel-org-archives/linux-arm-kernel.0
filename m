From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Nov 2016 17:59:21 +0000
Subject: [PATCH v2 1/5] iommu: Allow taking a reference on a group directly
Message-ID: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iommu_group_get_for_dev() expects that the IOMMU driver's device_group
callback return a group with a reference held for the given device.
Whilst allocating a new group is fine, and pci_device_group() correctly
handles reusing an existing group, there is no general means for IOMMU
drivers doing their own group lookup to take additional references on an
existing group pointer without having to also store device pointers or
resort to elaborate trickery.

Add an IOMMU-driver-specific function to fill the hole.

Acked-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Fix the function name; clarify what exactly its callers are fixing.

 drivers/iommu/iommu.c | 13 +++++++++++++
 include/linux/iommu.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9a2f1960873b..9408c3145483 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -552,6 +552,19 @@ struct iommu_group *iommu_group_get(struct device *dev)
 EXPORT_SYMBOL_GPL(iommu_group_get);
 
 /**
+ * iommu_group_ref_get - Increment reference on a group
+ * @group: the group to use, must not be NULL
+ *
+ * This function is called by iommu drivers to take additional references on an
+ * existing group.  Returns the given group for convenience.
+ */
+struct iommu_group *iommu_group_ref_get(struct iommu_group *group)
+{
+	kobject_get(group->devices_kobj);
+	return group;
+}
+
+/**
  * iommu_group_put - Decrement group reference
  * @group: the group to use
  *
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21318af..431638110c6a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -253,6 +253,7 @@ extern void iommu_group_remove_device(struct device *dev);
 extern int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				    int (*fn)(struct device *, void *));
 extern struct iommu_group *iommu_group_get(struct device *dev);
+extern struct iommu_group *iommu_group_ref_get(struct iommu_group *group);
 extern void iommu_group_put(struct iommu_group *group);
 extern int iommu_group_register_notifier(struct iommu_group *group,
 					 struct notifier_block *nb);
-- 
2.10.2.dirty
