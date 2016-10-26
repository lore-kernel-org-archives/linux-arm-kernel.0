From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 26 Oct 2016 11:37:39 +0100
Subject: [PATCH] iommu/arm-smmu: Expunge redundant iommu_present() checks
Message-ID: <fc2d2a1c58af73c74584bb830f50b4626b52ff63.1477478259.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first thing bus_set_iommu() does is check if iommu_ops are already
installed on the given bus, and immediately return -EBUSY if so. Since
the return value makes no difference as we ignore it anyway, there is
no need to redundantly duplicate that check by explicitly calling
iommu_present() beforehand.

This does bring the slight change that we may now end up calling
pci_request_acs() multiple times, but as that does nothing but set a
variable to 1, the impact should be effectively zero.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c841eb7a1a74..ef978db2bb54 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2000,17 +2000,13 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	arm_smmu_device_reset(smmu);
 
 	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+	bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
 #ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype))
-		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+	bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 #endif
 #ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		pci_request_acs();
-		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
-	}
+	pci_request_acs();
+	bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 #endif
 	return 0;
 }
-- 
1.9.1
