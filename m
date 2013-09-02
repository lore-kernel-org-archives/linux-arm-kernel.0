From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 02 Sep 2013 10:28:39 +0900
Subject: [PATCH] iommu/arm-smmu: use devm_ioremap_resource() instead of
 devm_request_and_ioremap()
Message-ID: <005201cea77b$c0e14d90$42a3e8b0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_ioremap_resource() because devm_request_and_ioremap() is
obsoleted by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/iommu/arm-smmu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f417e89..31c709c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1786,9 +1786,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 
 	smmu->size = resource_size(res);
-	smmu->base = devm_request_and_ioremap(dev, res);
-	if (!smmu->base)
-		return -EADDRNOTAVAIL;
+	smmu->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(smmu->base))
+		return PTR_ERR(smmu->base);
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
-- 
1.7.10.4
