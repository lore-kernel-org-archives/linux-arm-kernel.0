From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 31 Oct 2013 16:38:05 +0530
Subject: [PATCH 3/5] iommu/arm-smmu: Use devm_ioremap_resource
In-Reply-To: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
References: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1383217687-12037-4-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While at it, propagate the error code.

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: linux-arm-kernel at lists.infradead.org
CC: iommu at lists.linux-foundation.org
CC: Will Deacon <will.deacon@arm.com>
CC: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/arm-smmu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2349d62..fe275b3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1790,9 +1790,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
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
