From: tomasz.nowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Tue, 19 Dec 2017 16:20:21 +0100
Subject: [PATCH V1 1/1] iommu: Make sure device's ID array elements are unique
In-Reply-To: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
References: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
Message-ID: <1513696821-32291-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While iterating over DMA aliases for a PCI device, for some rare cases
(i.e. PCIe-to-PCI/X bridges) we may get exactly the same ID as initial child
device. In turn, the same ID may get registered for a device multiple times.
Eventually IOMMU  driver may try to configure the same ID within domain
multiple times too which for some IOMMU drivers is illegal and causes kernel
panic.

Rule out ID duplication prior to device ID array registration.

CC: stable at vger.kernel.org	# v4.14+
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
---
 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3de5c0b..9b2c138 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1945,6 +1945,31 @@ void iommu_fwspec_free(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 
+static void iommu_fwspec_remove_ids_dup(struct device *dev, u32 *ids,
+					int *num_ids)
+{
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	int i, j, k, valid_ids = *num_ids;
+
+	for (i = 0; i < valid_ids; i++) {
+		for (j = 0; j < fwspec->num_ids; j++) {
+			if (ids[i] != fwspec->ids[j])
+				continue;
+
+			dev_info(dev, "found 0x%x ID duplication, skipped\n",
+				 ids[i]);
+
+			for (k = i + 1; k < valid_ids; k++)
+				ids[k - 1] = ids[k];
+
+			valid_ids--;
+			break;
+		}
+	}
+
+	*num_ids = valid_ids;
+}
+
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
@@ -1954,6 +1979,9 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	if (!fwspec)
 		return -EINVAL;
 
+	/* Rule out IDs already registered */
+	iommu_fwspec_remove_ids_dup(dev, ids, &num_ids);
+
 	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
 	if (size > sizeof(*fwspec)) {
 		fwspec = krealloc(dev->iommu_fwspec, size, GFP_KERNEL);
-- 
2.7.4
