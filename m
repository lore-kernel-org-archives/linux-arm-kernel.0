From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Fri,  5 May 2017 17:38:06 +0530
Subject: [PATCH v3 2/7] iommu/arm-smmu-v3: Do resource size checks based on
 SMMU
In-Reply-To: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1493986091-30521-3-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

With implementations supporting only page 0 register space,
resource size can be 64k as well and hence perform size checks
based on SMMU option PAGE0_REGS_ONLY.

For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
platform_get_resource call, so that SMMU options are set beforehand.

Signed-off-by:  Linu Cherian <linu.cherian@cavium.com>
Signed-off-by:  Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 drivers/iommu/arm-smmu-v3.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 107b4a6..f027676 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2672,6 +2672,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	return ret;
 }
 
+static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
+{
+	if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
+		return SZ_64K;
+	else
+		return SZ_128K;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -2688,9 +2696,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	if (dev->of_node) {
+		ret = arm_smmu_device_dt_probe(pdev, smmu);
+	} else {
+		ret = arm_smmu_device_acpi_probe(pdev, smmu);
+		if (ret == -ENODEV)
+			return ret;
+	}
+
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) + 1 < SZ_128K) {
+	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
@@ -2717,14 +2733,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (irq > 0)
 		smmu->gerr_irq = irq;
 
-	if (dev->of_node) {
-		ret = arm_smmu_device_dt_probe(pdev, smmu);
-	} else {
-		ret = arm_smmu_device_acpi_probe(pdev, smmu);
-		if (ret == -ENODEV)
-			return ret;
-	}
-
 	/* Set bypass mode according to firmware probing result */
 	bypass = !!ret;
 
-- 
1.8.3.1
