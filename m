From: eric.auger@redhat.com (Eric Auger)
Date: Thu, 19 Jan 2017 20:57:54 +0000
Subject: [PATCH v9 09/18] iommu/amd: Declare MSI and HT regions as reserved
 IOVA regions
In-Reply-To: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
References: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1484859483-2866-10-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch registers the MSI and HT regions as non mappable
reserved regions. They will be exposed in the iommu-group sysfs.

For direct-mapped regions let's also use iommu_alloc_resv_region().

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v6 -> v7:
- use IOMMU_RESV_RESERVED

v5: creation
---
 drivers/iommu/amd_iommu.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5f7ea4f..d109e41 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3164,6 +3164,7 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
+	struct iommu_resv_region *region;
 	struct unity_map_entry *entry;
 	int devid;
 
@@ -3172,28 +3173,42 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	list_for_each_entry(entry, &amd_iommu_unity_map, list) {
-		struct iommu_resv_region *region;
+		size_t length;
+		int prot = 0;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
-		region = kzalloc(sizeof(*region), GFP_KERNEL);
+		length = entry->address_end - entry->address_start;
+		if (entry->prot & IOMMU_PROT_IR)
+			prot |= IOMMU_READ;
+		if (entry->prot & IOMMU_PROT_IW)
+			prot |= IOMMU_WRITE;
+
+		region = iommu_alloc_resv_region(entry->address_start,
+						 length, prot,
+						 IOMMU_RESV_DIRECT);
 		if (!region) {
 			pr_err("Out of memory allocating dm-regions for %s\n",
 				dev_name(dev));
 			return;
 		}
-
-		region->start = entry->address_start;
-		region->length = entry->address_end - entry->address_start;
-		region->type = IOMMU_RESV_DIRECT;
-		if (entry->prot & IOMMU_PROT_IR)
-			region->prot |= IOMMU_READ;
-		if (entry->prot & IOMMU_PROT_IW)
-			region->prot |= IOMMU_WRITE;
-
 		list_add_tail(&region->list, head);
 	}
+
+	region = iommu_alloc_resv_region(MSI_RANGE_START,
+					 MSI_RANGE_END - MSI_RANGE_START + 1,
+					 0, IOMMU_RESV_RESERVED);
+	if (!region)
+		return;
+	list_add_tail(&region->list, head);
+
+	region = iommu_alloc_resv_region(HT_RANGE_START,
+					 HT_RANGE_END - HT_RANGE_START + 1,
+					 0, IOMMU_RESV_RESERVED);
+	if (!region)
+		return;
+	list_add_tail(&region->list, head);
 }
 
 static void amd_iommu_put_resv_regions(struct device *dev,
-- 
1.9.1
