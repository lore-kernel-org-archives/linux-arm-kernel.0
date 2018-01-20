From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 20 Jan 2018 15:36:25 +0100
Subject: [PATCH] ARM-SMMU: Delete error messages for a failed memory
 allocation in three functions
Message-ID: <c3e91414-dd5b-2889-d86c-b19aff56571b@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 20 Jan 2018 15:30:17 +0100

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iommu/arm-smmu-v3.c | 9 +++------
 drivers/iommu/arm-smmu.c    | 9 +++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f122071688fd..5c2a7103d494 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2134,10 +2134,8 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
 	void *strtab = smmu->strtab_cfg.strtab;
 
 	cfg->l1_desc = devm_kzalloc(smmu->dev, size, GFP_KERNEL);
-	if (!cfg->l1_desc) {
-		dev_err(smmu->dev, "failed to allocate l1 stream table desc\n");
+	if (!cfg->l1_desc)
 		return -ENOMEM;
-	}
 
 	for (i = 0; i < cfg->num_l1_ents; ++i) {
 		arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
@@ -2828,10 +2826,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	bool bypass;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
-	if (!smmu) {
-		dev_err(dev, "failed to allocate arm_smmu_device\n");
+	if (!smmu)
 		return -ENOMEM;
-	}
+
 	smmu->dev = dev;
 
 	if (dev->of_node) {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 78d4c6b8f1ba..a4da4a870a2e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2048,10 +2048,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	int num_irqs, i, err;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
-	if (!smmu) {
-		dev_err(dev, "failed to allocate arm_smmu_device\n");
+	if (!smmu)
 		return -ENOMEM;
-	}
+
 	smmu->dev = dev;
 
 	if (dev->of_node)
@@ -2084,10 +2083,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	smmu->irqs = devm_kzalloc(dev, sizeof(*smmu->irqs) * num_irqs,
 				  GFP_KERNEL);
-	if (!smmu->irqs) {
-		dev_err(dev, "failed to allocate %d irqs\n", num_irqs);
+	if (!smmu->irqs)
 		return -ENOMEM;
-	}
 
 	for (i = 0; i < num_irqs; ++i) {
 		int irq = platform_get_irq(pdev, i);
-- 
2.15.1
