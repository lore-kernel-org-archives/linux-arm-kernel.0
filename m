From: shameerali.kolothum.thodi@huawei.com (Shameer Kolothum)
Date: Tue, 16 Oct 2018 13:49:17 +0100
Subject: [PATCH v4 1/4] acpi: arm64: add iort support for PMCG
In-Reply-To: <20181016124920.24708-1-shameerali.kolothum.thodi@huawei.com>
References: <20181016124920.24708-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <20181016124920.24708-2-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Leeder <nleeder@codeaurora.org>

Add support for the SMMU Performance Monitor Counter Group
information from ACPI. This is in preparation for its use
in the SMMUv3 PMU driver.

Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 97 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 08f26db..c44d8f6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -356,7 +356,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
-		    node->type == ACPI_IORT_NODE_SMMU_V3) {
+		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
+		    node->type == ACPI_IORT_NODE_PMCG) {
 			*id_out = map->output_base;
 			return parent;
 		}
@@ -394,6 +395,8 @@ static int iort_get_id_mapping_index(struct acpi_iort_node *node)
 		}
 
 		return smmu->id_mapping_index;
+	case ACPI_IORT_NODE_PMCG:
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1216,14 +1219,23 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 	}
 }
 
-static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
+static void __init arm_smmu_v3_dma_configure(struct device *dev,
+					     struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
+	enum dev_dma_attr attr;
 
 	/* Retrieve SMMUv3 specific data */
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
-	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
+	attr = (smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE) ?
+			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	/* We expect the dma masks to be equivalent for all SMMUv3 set-ups */
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(dev, attr);
 }
 
 #if defined(CONFIG_ACPI_NUMA)
@@ -1299,20 +1311,64 @@ static void __init arm_smmu_init_resources(struct resource *res,
 	}
 }
 
-static bool __init arm_smmu_is_coherent(struct acpi_iort_node *node)
+static void __init arm_smmu_dma_configure(struct device *dev,
+					  struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu *smmu;
+	enum dev_dma_attr attr;
 
 	/* Retrieve SMMU specific data */
 	smmu = (struct acpi_iort_smmu *)node->node_data;
 
-	return smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK;
+	attr = (smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK) ?
+			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
+
+	/* We expect the dma masks to be equivalent for SMMU set-ups */
+	dev->dma_mask = &dev->coherent_dma_mask;
+
+	/* Configure DMA for the page table walker */
+	acpi_dma_configure(dev, attr);
+}
+
+static int __init arm_smmu_v3_pmcg_count_resources(struct acpi_iort_node *node)
+{
+	struct acpi_iort_pmcg *pmcg;
+
+	/* Retrieve PMCG specific data */
+	pmcg = (struct acpi_iort_pmcg *)node->node_data;
+
+	/*
+	 * There are always 2 memory resources.
+	 * If the overflow_gsiv is present then add that for a total of 3.
+	 */
+	return pmcg->overflow_gsiv ? 3 : 2;
+}
+
+static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
+					       struct acpi_iort_node *node)
+{
+	struct acpi_iort_pmcg *pmcg;
+
+	/* Retrieve PMCG specific data */
+	pmcg = (struct acpi_iort_pmcg *)node->node_data;
+
+	res[0].start = pmcg->page0_base_address;
+	res[0].end = pmcg->page0_base_address + SZ_4K - 1;
+	res[0].flags = IORESOURCE_MEM;
+	res[1].start = pmcg->page1_base_address;
+	res[1].end = pmcg->page1_base_address + SZ_4K - 1;
+	res[1].flags = IORESOURCE_MEM;
+
+	if (pmcg->overflow_gsiv)
+		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
+				       ACPI_EDGE_SENSITIVE, &res[2]);
 }
 
 struct iort_dev_config {
 	const char *name;
 	int (*dev_init)(struct acpi_iort_node *node);
-	bool (*dev_is_coherent)(struct acpi_iort_node *node);
+	void (*dev_dma_configure)(struct device *dev,
+				    struct acpi_iort_node *node);
 	int (*dev_count_resources)(struct acpi_iort_node *node);
 	void (*dev_init_resources)(struct resource *res,
 				     struct acpi_iort_node *node);
@@ -1322,7 +1378,7 @@ struct iort_dev_config {
 
 static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
 	.name = "arm-smmu-v3",
-	.dev_is_coherent = arm_smmu_v3_is_coherent,
+	.dev_dma_configure = arm_smmu_v3_dma_configure,
 	.dev_count_resources = arm_smmu_v3_count_resources,
 	.dev_init_resources = arm_smmu_v3_init_resources,
 	.dev_set_proximity = arm_smmu_v3_set_proximity,
@@ -1330,19 +1386,28 @@ static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
 
 static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
 	.name = "arm-smmu",
-	.dev_is_coherent = arm_smmu_is_coherent,
+	.dev_dma_configure = arm_smmu_dma_configure,
 	.dev_count_resources = arm_smmu_count_resources,
-	.dev_init_resources = arm_smmu_init_resources
+	.dev_init_resources = arm_smmu_init_resources,
+};
+
+static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
+	.name = "arm-smmu-v3-pmu",
+	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
+	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
 };
 
 static __init const struct iort_dev_config *iort_get_dev_cfg(
 			struct acpi_iort_node *node)
 {
+
 	switch (node->type) {
 	case ACPI_IORT_NODE_SMMU_V3:
 		return &iort_arm_smmu_v3_cfg;
 	case ACPI_IORT_NODE_SMMU:
 		return &iort_arm_smmu_cfg;
+	case ACPI_IORT_NODE_PMCG:
+		return &iort_arm_smmu_v3_pmcg_cfg;
 	default:
 		return NULL;
 	}
@@ -1360,7 +1425,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	struct fwnode_handle *fwnode;
 	struct platform_device *pdev;
 	struct resource *r;
-	enum dev_dma_attr attr;
 	int ret, count;
 
 	pdev = platform_device_alloc(ops->name, PLATFORM_DEVID_AUTO);
@@ -1398,12 +1462,6 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 	if (ret)
 		goto dev_put;
 
-	/*
-	 * We expect the dma masks to be equivalent for
-	 * all SMMUs set-ups
-	 */
-	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-
 	fwnode = iort_get_fwnode(node);
 
 	if (!fwnode) {
@@ -1413,11 +1471,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 	pdev->dev.fwnode = fwnode;
 
-	attr = ops->dev_is_coherent && ops->dev_is_coherent(node) ?
-			DEV_DMA_COHERENT : DEV_DMA_NON_COHERENT;
-
-	/* Configure DMA for the page table walker */
-	acpi_dma_configure(&pdev->dev, attr);
+	if (ops->dev_dma_configure)
+		ops->dev_dma_configure(&pdev->dev, node);
 
 	iort_set_device_domain(&pdev->dev, node);
 
-- 
2.7.4
