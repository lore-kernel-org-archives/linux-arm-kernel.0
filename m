From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Tue, 24 Sep 2013 17:06:55 +0200
Subject: [PATCH 1/7] iommu/arm-smmu: Switch to arch_initcall for driver
 registration
In-Reply-To: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380035221-11576-2-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should ensure that arm-smmu is initialized before other drivers
start handling devices that propably need smmu support.

Also remove module_exit function as we most likely never want to
unload this driver.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index be56846..97b764b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1975,13 +1975,7 @@ static int __init arm_smmu_init(void)
 	return 0;
 }
 
-static void __exit arm_smmu_exit(void)
-{
-	return platform_driver_unregister(&arm_smmu_driver);
-}
-
-module_init(arm_smmu_init);
-module_exit(arm_smmu_exit);
+arch_initcall(arm_smmu_init);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-- 
1.7.9.5
