From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Thu,  8 Jun 2017 10:14:19 +0530
Subject: [PATCH v3 2/2] acpi/iort: numa: Add numa node mapping for smmuv3
 devices
In-Reply-To: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1496897059-8272-3-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to parse proximity domain in SMMUv3 IORT table to
set numa node mapping for smmuv3 devices.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/acpi/arm64/iort.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bba2b59..e804386 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -882,6 +882,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
 }
 
+/*
+ * set numa proximity domain for smmuv3 device
+ */
+static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
+		struct device *dev)
+{
+	struct acpi_iort_smmu_v3 *smmu;
+
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
+	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
+		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
+		pr_info("SMMUV3[%llx] Mapped to Proximity domain %d\n",
+			smmu->base_address,
+			smmu->pxm);
+	}
+}
+
 static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu *smmu;
@@ -951,20 +968,24 @@ struct iort_iommu_config {
 	int (*iommu_count_resources)(struct acpi_iort_node *node);
 	void (*iommu_init_resources)(struct resource *res,
 				     struct acpi_iort_node *node);
+	void (*iommu_set_proximity)(struct acpi_iort_node *node,
+				     struct device *dev);
 };
 
 static const struct iort_iommu_config iort_arm_smmu_v3_cfg __initconst = {
 	.name = "arm-smmu-v3",
 	.iommu_is_coherent = arm_smmu_v3_is_coherent,
 	.iommu_count_resources = arm_smmu_v3_count_resources,
-	.iommu_init_resources = arm_smmu_v3_init_resources
+	.iommu_init_resources = arm_smmu_v3_init_resources,
+	.iommu_set_proximity = arm_smmu_v3_set_proximity
 };
 
 static const struct iort_iommu_config iort_arm_smmu_cfg __initconst = {
 	.name = "arm-smmu",
 	.iommu_is_coherent = arm_smmu_is_coherent,
 	.iommu_count_resources = arm_smmu_count_resources,
-	.iommu_init_resources = arm_smmu_init_resources
+	.iommu_init_resources = arm_smmu_init_resources,
+	.iommu_set_proximity = NULL
 };
 
 static __init
@@ -1002,6 +1023,9 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
 	if (!pdev)
 		return -ENOMEM;
 
+	if (ops->iommu_set_proximity)
+		ops->iommu_set_proximity(node, &pdev->dev);
+
 	count = ops->iommu_count_resources(node);
 
 	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
-- 
1.8.1.4
