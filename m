From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Feb 2016 10:47:32 +0530
Subject: [PATCH v2 4/4] iommu/arm-smmu: Add stub of_xlate() operation in
 SMMUv1/SMMUv2 driver
In-Reply-To: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1454908652-15317-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow use of large memory (> 4Gb) with 32bit devices we need to use
IOMMU based DMA mappings for such 32bit devices. The IOMMU dt-bindings
allows us do this by specifying 'iommus' attribute in 32bit device DT
node. Unfortunately, specifying 'iommus' attribute does not work with
current SMMUv1/SMMUv2 driver because it requires of_xlate() operation
to be implemented by the driver.

This patch adds a stub implementation of of_xlate() in SMMUv1/SMMUv2
driver to allow usage of 'iommus' attribute in DT for 32bit devices.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 02cd67d..8e090d8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1398,6 +1398,16 @@ static int arm_smmu_init_platform_device(struct device *dev,
 	return 0;
 }
 
+int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	/*
+	 * Nothing to do here because SMMU is already aware of all
+	 * MMU masters and their stream IDs using mmu-master attibute
+	 * SMMU DT node.
+	 */
+	return 0;
+}
+
 static int arm_smmu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
@@ -1495,6 +1505,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
+	.of_xlate		= arm_smmu_of_xlate,
 	.add_device		= arm_smmu_add_device,
 	.remove_device		= arm_smmu_remove_device,
 	.device_group		= arm_smmu_device_group,
-- 
1.9.1
