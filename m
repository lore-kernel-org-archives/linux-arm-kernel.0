From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:56 +0300
Subject: [PATCH v2 21/22] iommu/tegra: smmu: Support Multiple ASID
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-22-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support Multiple Address Space(AS). Tegra SMMU can have multiple
ASes. We reserve 2 of them for static assignment, AS[0] for system
default, AS[1] for AHB clusters as protected domain from others, where
there are many traditional pheripheral devices like USB, SD/MMC. They
should be isolated from some smart devices like host1x for system
robustness. Even if smart devices behaves wrongly, the traditional
devices(SD/MMC, USB) wouldn't be affected, and the system could
continue most likely.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 8a9434e..1945815 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -904,7 +904,18 @@ enum {
 static int smmu_iommu_add_device(struct device *dev)
 {
 	int err;
-	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
+	u64 swgroup;
+	struct dma_iommu_mapping *map = NULL;
+
+	swgroup = smmu_of_get_memory_client(dev);
+	switch (swgroup) {
+	case TEGRA_SWGROUP_BIT(PPCS):
+		map = smmu_handle->map[SYSTEM_PROTECTED];
+		break;
+	default:
+		map = smmu_handle->map[SYSTEM_DEFAULT];
+		break;
+	}
 
 	if (!map)
 		goto out;
@@ -915,7 +926,7 @@ static int smmu_iommu_add_device(struct device *dev)
 		return err;
 	}
 out:
-	dev_dbg(dev, "Attached to map %p\n", map);
+	dev_dbg(dev, "Attached to map %p, swgroup:%08llx\n", map, swgroup);
 	return 0;
 }
 
-- 
1.7.9.5
