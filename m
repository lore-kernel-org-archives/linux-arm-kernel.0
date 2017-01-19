From: eric.auger@redhat.com (Eric Auger)
Date: Thu, 19 Jan 2017 20:57:48 +0000
Subject: [PATCH v9 03/18] iommu: Add a new type field in iommu_resv_region
In-Reply-To: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
References: <1484859483-2866-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1484859483-2866-4-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We introduce a new field to differentiate the reserved region
types and specialize the apply_resv_region implementation.

Legacy direct mapped regions have IOMMU_RESV_DIRECT type.
We introduce 2 new reserved memory types:
- IOMMU_RESV_MSI will characterize MSI regions that are mapped
- IOMMU_RESV_RESERVED characterize regions that cannot by mapped.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
Tested-by: Bharat Bhushan <bharat.bhushan@nxp.com>

---

v6 -> v7:
- rename IOMMU_RESV_NOMAP into IOMMU_RESV_RESERVED
---
 drivers/iommu/amd_iommu.c | 1 +
 include/linux/iommu.h     | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7a024f..5f7ea4f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3186,6 +3186,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 		region->start = entry->address_start;
 		region->length = entry->address_end - entry->address_start;
+		region->type = IOMMU_RESV_DIRECT;
 		if (entry->prot & IOMMU_PROT_IR)
 			region->prot |= IOMMU_READ;
 		if (entry->prot & IOMMU_PROT_IW)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index bfecb8b..233a6bf 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -117,18 +117,25 @@ enum iommu_attr {
 	DOMAIN_ATTR_MAX,
 };
 
+/* These are the possible reserved region types */
+#define IOMMU_RESV_DIRECT	(1 << 0)
+#define IOMMU_RESV_RESERVED	(1 << 1)
+#define IOMMU_RESV_MSI		(1 << 2)
+
 /**
  * struct iommu_resv_region - descriptor for a reserved memory region
  * @list: Linked list pointers
  * @start: System physical start address of the region
  * @length: Length of the region in bytes
  * @prot: IOMMU Protection flags (READ/WRITE/...)
+ * @type: Type of the reserved region
  */
 struct iommu_resv_region {
 	struct list_head	list;
 	phys_addr_t		start;
 	size_t			length;
 	int			prot;
+	int			type;
 };
 
 #ifdef CONFIG_IOMMU_API
-- 
1.9.1
