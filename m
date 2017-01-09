From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  9 Jan 2017 13:45:56 +0000
Subject: [PATCH v7 05/19] iommu: iommu_alloc_resv_region
In-Reply-To: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
References: <1483969570-3154-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1483969570-3154-6-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new helper serving the purpose to allocate a reserved
region. This will be used in iommu driver implementing reserved
region callbacks.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- add INIT_LIST_HEAD(&region->list)
- use int for prot param and add int type param
- remove implementation outside of CONFIG_IOMMU_API
---
 drivers/iommu/iommu.c | 18 ++++++++++++++++++
 include/linux/iommu.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1cee5c3..927878d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1575,6 +1575,24 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 		ops->put_resv_regions(dev, list);
 }
 
+struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
+						  size_t length,
+						  int prot, int type)
+{
+	struct iommu_resv_region *region;
+
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	INIT_LIST_HEAD(&region->list);
+	region->start = start;
+	region->length = length;
+	region->prot = prot;
+	region->type = type;
+	return region;
+}
+
 /* Request that a device is direct mapped by the IOMMU */
 int iommu_request_dm_for_dev(struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 233a6bf..f6bb55d3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -244,6 +244,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
+extern struct iommu_resv_region *
+iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot, int type);
 
 extern int iommu_attach_group(struct iommu_domain *domain,
 			      struct iommu_group *group);
-- 
1.9.1
