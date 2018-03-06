From: jitendra.bhivare@broadcom.com (Jitendra Bhivare)
Date: Tue,  6 Mar 2018 10:29:28 +0530
Subject: [RFC 5/5] iommu/arm-smmu: Allow direct mapping for MSI region
In-Reply-To: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
Message-ID: <1520312368-7068-6-git-send-email-jitendra.bhivare@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current ARM SMMU virtualizes MSI addresses to IOVA space.

In iProc SoCs, MSI needs to be steered. Allow reserving MSI address range
using DT node entry as direct region.

Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 78d4c6b..7b34980 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1533,8 +1533,11 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
+	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
 	struct iommu_resv_region *region;
-	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	struct of_iommu_resv_region of_region;
+	int index = 0, prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
 					 prot, IOMMU_RESV_SW_MSI);
@@ -1543,6 +1546,15 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 	list_add_tail(&region->list, head);
 
+	if (!of_get_resv_region(smmu->dev->of_node, "msi", &index,
+				&of_region)) {
+		region = iommu_alloc_resv_region(of_region.bus_addr,
+						 of_region.size,
+						 of_region.prot,
+						 IOMMU_RESV_DIRECT);
+		if (region)
+			list_add_tail(&region->list, head);
+	}
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-- 
2.7.4
