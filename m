From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  9 Jan 2017 13:46:08 +0000
Subject: [PATCH v7 17/19] vfio/type1: Allow transparent MSI IOVA allocation
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483969570-3154-18-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When attaching a group to the container, check the group's
reserved regions and test whether the IOMMU translates MSI
transactions. If yes, we initialize an IOVA allocator through
the iommu_get_msi_cookie API. This will allow the MSI IOVAs
to be transparently allocated on MSI controller's compose().

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- test region's type: IOMMU_RESV_MSI
- restructure the code to prepare for safety assessment
- reword title
---
 drivers/vfio/vfio_iommu_type1.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 9266271..5651faf 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -39,6 +39,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/mdev.h>
 #include <linux/notifier.h>
+#include <linux/dma-iommu.h>
 
 #define DRIVER_VERSION  "0.2"
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
@@ -1181,6 +1182,28 @@ static struct vfio_group *find_iommu_group(struct vfio_domain *domain,
 	return NULL;
 }
 
+static bool vfio_iommu_has_resv_msi(struct iommu_group *group,
+				    phys_addr_t *base)
+{
+	struct list_head group_resv_regions;
+	struct iommu_resv_region *region, *next;
+	bool ret = false;
+
+	INIT_LIST_HEAD(&group_resv_regions);
+	iommu_get_group_resv_regions(group, &group_resv_regions);
+	list_for_each_entry(region, &group_resv_regions, list) {
+		if (region->type & IOMMU_RESV_MSI) {
+			*base = region->start;
+			ret = true;
+			goto out;
+		}
+	}
+out:
+	list_for_each_entry_safe(region, next, &group_resv_regions, list)
+		kfree(region);
+	return ret;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1189,6 +1212,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	struct vfio_domain *domain, *d;
 	struct bus_type *bus = NULL, *mdev_bus;
 	int ret;
+	bool resv_msi;
+	phys_addr_t resv_msi_base;
 
 	mutex_lock(&iommu->lock);
 
@@ -1258,6 +1283,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_domain;
 
+	resv_msi = vfio_iommu_has_resv_msi(iommu_group, &resv_msi_base);
+
 	INIT_LIST_HEAD(&domain->group_list);
 	list_add(&group->next, &domain->group_list);
 
@@ -1304,6 +1331,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
+	if (resv_msi && iommu_get_msi_cookie(domain->domain, resv_msi_base))
+		goto out_detach;
+
 	list_add(&domain->next, &iommu->domain_list);
 
 	mutex_unlock(&iommu->lock);
-- 
1.9.1
