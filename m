From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:49 +0300
Subject: [PATCH v2 14/22] iommu/tegra: smmu: Register platform_device to IOMMU
 dynamically
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-15-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register platform_devices to IOMMU dynamically via
ops->{add,remove}_device().

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/iommu/tegra-smmu.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1617c90..35f4a16 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -39,6 +39,7 @@
 
 #include <asm/page.h>
 #include <asm/cacheflush.h>
+#include <asm/dma-iommu.h>
 
 enum smmu_hwgrp {
 	HWGRP_AFI,
@@ -949,6 +950,40 @@ static void smmu_iommu_domain_destroy(struct iommu_domain *domain)
 	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
 }
 
+/*
+ * ASID[0] for the system default
+ * ASID[1] for PPCS, which has SDMMC
+ * ASID[2][3].. open for drivers, first come, first served.
+ */
+enum {
+	SYSTEM_DEFAULT,
+	SYSTEM_PROTECTED,
+};
+
+static int smmu_iommu_add_device(struct device *dev)
+{
+	int err;
+	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
+
+	if (!map)
+		goto out;
+
+	err = arm_iommu_attach_device(dev, map);
+	if (err) {
+		dev_err(dev, "Failed to attach to map %p\n", map);
+		return err;
+	}
+out:
+	dev_dbg(dev, "Attached to map %p\n", map);
+	return 0;
+}
+
+static void smmu_iommu_remove_device(struct device *dev)
+{
+	dev_dbg(dev, "Detaching from map %p\n", to_dma_iommu_mapping(dev));
+	arm_iommu_detach_device(dev);
+}
+
 static struct iommu_ops smmu_iommu_ops = {
 	.domain_init	= smmu_iommu_domain_init,
 	.domain_destroy	= smmu_iommu_domain_destroy,
@@ -958,6 +993,8 @@ static struct iommu_ops smmu_iommu_ops = {
 	.unmap		= smmu_iommu_unmap,
 	.iova_to_phys	= smmu_iommu_iova_to_phys,
 	.domain_has_cap	= smmu_iommu_domain_has_cap,
+	.add_device	= smmu_iommu_add_device,
+	.remove_device	= smmu_iommu_remove_device,
 	.pgsize_bitmap	= SMMU_IOMMU_PGSIZES,
 };
 
-- 
1.7.9.5
