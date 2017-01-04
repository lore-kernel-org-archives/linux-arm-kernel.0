From: eric.auger@redhat.com (Eric Auger)
Date: Wed,  4 Jan 2017 13:32:16 +0000
Subject: [PATCH v5 07/17] iommu: Implement reserved_regions iommu-group sysfs
 file
In-Reply-To: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
References: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483536746-2725-8-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new iommu-group sysfs attribute file is introduced. It contains
the list of reserved regions for the iommu-group. Each reserved
region is described on a separate line:
- first field is the start IOVA address,
- second is the end IOVA address,

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- add cast to long long int when printing to avoid warning on
  i386
- change S_IRUGO into 0444
- remove sort. The list is natively sorted now.

The file layout is inspired of /sys/bus/pci/devices/BDF/resource.
I also read Documentation/filesystems/sysfs.txt so I expect this
to be frowned upon.
---
 drivers/iommu/iommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a2d51b3..15756d8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -211,8 +211,32 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(iommu_get_group_resv_regions);
 
+static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
+					     char *buf)
+{
+	struct iommu_resv_region *region, *next;
+	struct list_head group_resv_regions;
+	char *str = buf;
+
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(group, &group_resv_regions);
+
+	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
+		str += sprintf(str, "0x%016llx 0x%016llx\n",
+			       (long long int)region->start,
+			       (long long int)(region->start +
+						region->length - 1));
+		kfree(region);
+	}
+
+	return (str - buf);
+}
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
+static IOMMU_GROUP_ATTR(reserved_regions, 0444,
+			iommu_group_show_resv_regions, NULL);
+
 static void iommu_group_release(struct kobject *kobj)
 {
 	struct iommu_group *group = to_iommu_group(kobj);
@@ -227,6 +251,8 @@ static void iommu_group_release(struct kobject *kobj)
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
 
+	iommu_group_remove_file(group, &iommu_group_attr_reserved_regions);
+
 	kfree(group->name);
 	kfree(group);
 }
@@ -290,6 +316,11 @@ struct iommu_group *iommu_group_alloc(void)
 	 */
 	kobject_put(&group->kobj);
 
+	ret = iommu_group_create_file(group,
+				      &iommu_group_attr_reserved_regions);
+	if (ret)
+		return ERR_PTR(ret);
+
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
-- 
1.9.1
