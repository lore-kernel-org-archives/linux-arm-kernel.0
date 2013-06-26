From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:28:25 +0300
Subject: [PATCH 22/23] iommu/tegra: smmu: Support Multiple ASID
Message-ID: <1372238906-9346-23-git-send-email-hdoyu@nvidia.com>
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
 drivers/iommu/tegra-smmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 96dbef3..9018151 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -904,7 +904,18 @@ enum {
 static int smmu_iommu_add_device(struct device *dev)
 {
 	int err;
-	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
+	u64 swgids;
+	struct dma_iommu_mapping *map = NULL;
+
+	swgids = tegra_smmu_of_get_swgids(dev);
+	switch (swgids) {
+	case SWGID(PPCS):
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
+	dev_dbg(dev, "Attached to map %p, swgids:%08llx\n", map, swgids);
 	return 0;
 }
 
-- 
1.8.1.5
