From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:19 +0300
Subject: [PATCH 16/23] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Message-ID: <1372238906-9346-17-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get "nvidia,swgroups" from DT, which indicates which HardWare
Accelerators(HWAs) can be available on specific Tegra SoC. Needed for
the unified SMMU driver.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 95c6c80..c67131e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -307,6 +307,8 @@ struct smmu_device {
 	struct device	*dev;
 	struct page *avp_vector_page;	/* dummy page shared by all AS's */
 
+	u64 swgroups;			/* swgroup ID bitmap */
+
 	/*
 	 * Register image savers for suspend/resume
 	 */
@@ -1210,6 +1212,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	int i, asids, err = 0;
 	dma_addr_t uninitialized_var(base);
 	size_t bytes, uninitialized_var(size);
+	u64 swgroups;
 
 	if (smmu_handle)
 		return -EIO;
@@ -1219,6 +1222,9 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
 		return -ENODEV;
 
+	if (of_property_read_u64(dev->of_node, "nvidia,swgroups", &swgroups))
+		return -ENODEV;
+
 	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
 					 sizeof(struct dma_iommu_mapping *));
 	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
@@ -1267,6 +1273,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	smmu->num_as = asids;
 	smmu->iovmm_base = base;
 	smmu->page_count = size;
+	smmu->swgroups = swgroups;
 
 	smmu->translation_enable_0 = ~0;
 	smmu->translation_enable_1 = ~0;
-- 
1.8.1.5
