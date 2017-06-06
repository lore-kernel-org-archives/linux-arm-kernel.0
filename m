From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue,  6 Jun 2017 16:17:45 +0530
Subject: [PATCH v2 2/2] acpi/iort: numa: Add numa node mapping for smmuv3
 devices
In-Reply-To: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <1496746065-11082-3-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add code to parse proximity domain in SMMUv3 IORT table to
set numa node mapping for smmuv3 devices.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/acpi/arm64/iort.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bba2b59..b4f328f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -882,6 +882,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
 }
 
+/*
+ * set numa proximity domain for smmv3 device
+ */
+static void  __init iort_set_proximity(struct acpi_iort_node *node,
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
@@ -1002,6 +1019,9 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
 	if (!pdev)
 		return -ENOMEM;
 
+	if (node->type == ACPI_IORT_NODE_SMMU_V3)
+		iort_set_proximity(node, &pdev->dev);
+
 	count = ops->iommu_count_resources(node);
 
 	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
-- 
1.8.1.4
