From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  3 Nov 2016 17:39:07 +0000
Subject: [PATCH v2] iommu/arm-smmu: Don't inadvertently reject multiple SMMUv3s
Message-ID: <22ac6cba7386e133a97af729526f4e6457745554.1478194747.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now delay installing our per-bus iommu_ops until we know an SMMU has
successfully probed, as they don't serve much purpose beforehand, and
doing so also avoids fights between multiple IOMMU drivers in a single
kernel. However, the upshot of passing the return value of bus_set_iommu()
back from our probe function is that if there happens to be more than
one SMMUv3 device in a system, the second and subsequent probes will
wind up returning -EBUSY to the driver core and getting torn down again.

Avoid re-setting ops if ours are already installed, so that any genuine
failures stand out.

Fixes: 08d4ca2a672b ("iommu/arm-smmu: Support non-PCI devices with SMMUv3")
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 15c01c3cd540..e6f9b2d745ca 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2636,17 +2636,26 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	/* And we're up. Go go go! */
 	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
 #ifdef CONFIG_PCI
-	pci_request_acs();
-	ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
-	if (ret)
-		return ret;
+	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
+		pci_request_acs();
+		ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+		if (ret)
+			return ret;
+	}
 #endif
 #ifdef CONFIG_ARM_AMBA
-	ret = bus_set_iommu(&amba_bustype, &arm_smmu_ops);
-	if (ret)
-		return ret;
+	if (amba_bustype.iommu_ops != &arm_smmu_ops) {
+		ret = bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+		if (ret)
+			return ret;
+	}
 #endif
-	return bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+	if (platform_bus_type.iommu_ops != &arm_smmu_ops) {
+		ret = bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+		if (ret)
+			return ret;
+	}
+	return 0;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
-- 
2.10.2.dirty
