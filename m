From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  7 Nov 2014 16:26:18 +0100
Subject: [PATCH] iommu/arm-smmu: Play nice on non-ARM/SMMU systems
Message-ID: <1415373978-16203-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Currently the driver registers IOMMU bus operations for all busses even
if no ARM SMMU is present on a system. Depending on the driver probing
order this prevents the driver for the real IOMMU to register itself as
the bus-wide IOMMU.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f794922..e154826d8b1d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2072,8 +2072,20 @@ static struct platform_driver arm_smmu_driver = {
 
 static int __init arm_smmu_init(void)
 {
+	struct device_node *np;
 	int ret;
 
+	/*
+	 * Play nice with systems that don't have an ARM SMMU by checking that
+	 * an ARM SMMU exists in the system before proceeding with the driver
+	 * and IOMMU bus operation registration.
+	 */
+	np = of_find_matching_node(NULL, arm_smmu_of_match);
+	if (!np)
+		return 0;
+
+	of_node_put(np);
+
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
 		return ret;
-- 
2.1.3
