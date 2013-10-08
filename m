From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  8 Oct 2013 16:12:35 +0530
Subject: [PATCH 1/1] iommu: arm-smmu: Use devm_ioremap_resource
Message-ID: <1381228955-24313-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_request_and_ioremap is deprecated. Use devm_ioremap_resource
instead.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iommu/arm-smmu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 181c9ba..b564930 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1787,9 +1787,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
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
1.7.9.5
