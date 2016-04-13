From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 13 Apr 2016 18:12:57 +0100
Subject: [PATCH 1/7] iommu/arm-smmu: Differentiate specific implementations
In-Reply-To: <cover.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
Message-ID: <cc1789284c5efa05514231fa3dede9d1d5f2df18.1460391217.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the inevitable reality of implementation-specific errata workarounds
begin to accrue alongside our integration quirk handling, it's about
time the driver had a decent way of keeping track. Extend the per-SMMU
data so we can identify specific implementations in an efficient and
firmware-agnostic manner.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e933679..2d5f357 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -278,6 +278,10 @@ enum arm_smmu_arch_version {
 	ARM_SMMU_V2,
 };
 
+enum arm_smmu_implementation {
+	GENERIC_SMMU,
+};
+
 struct arm_smmu_smr {
 	u8				idx;
 	u16				mask;
@@ -315,6 +319,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
 	u32				options;
 	enum arm_smmu_arch_version	version;
+	enum arm_smmu_implementation	model;
 
 	u32				num_context_banks;
 	u32				num_s2_context_banks;
@@ -1735,13 +1740,24 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+struct arm_smmu_match_data {
+	enum arm_smmu_arch_version version;
+	enum arm_smmu_implementation model;
+};
+
+#define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
+static struct arm_smmu_match_data name = { .version = ver, .model = imp }
+
+ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
+ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
+
 static const struct of_device_id arm_smmu_of_match[] = {
-	{ .compatible = "arm,smmu-v1", .data = (void *)ARM_SMMU_V1 },
-	{ .compatible = "arm,smmu-v2", .data = (void *)ARM_SMMU_V2 },
-	{ .compatible = "arm,mmu-400", .data = (void *)ARM_SMMU_V1 },
-	{ .compatible = "arm,mmu-401", .data = (void *)ARM_SMMU_V1 },
-	{ .compatible = "arm,mmu-500", .data = (void *)ARM_SMMU_V2 },
-	{ .compatible = "cavium,smmu-v2", .data = (void *)ARM_SMMU_V2 },
+	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
+	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
+	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
+	{ .compatible = "arm,mmu-401", .data = &smmu_generic_v1 },
+	{ .compatible = "arm,mmu-500", .data = &smmu_generic_v2 },
+	{ .compatible = "cavium,smmu-v2", .data = &smmu_generic_v2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
@@ -1749,6 +1765,7 @@ MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
+	const struct arm_smmu_match_data *data;
 	struct resource *res;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
@@ -1764,7 +1781,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	smmu->dev = dev;
 
 	of_id = of_match_node(arm_smmu_of_match, dev->of_node);
-	smmu->version = (enum arm_smmu_arch_version)of_id->data;
+	data = of_id->data;
+	smmu->version = data->version;
+	smmu->model = data->model;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	smmu->base = devm_ioremap_resource(dev, res);
-- 
2.7.3.dirty
