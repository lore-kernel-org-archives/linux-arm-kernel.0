From: nwatters@codeaurora.org (Nate Watterson)
Date: Thu, 29 Jun 2017 18:18:15 -0400
Subject: [PATCH v2] iommu/arm-smmu-v3: Implement shutdown method
Message-ID: <1498774696-16037-1-git-send-email-nwatters@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shutdown method disables the SMMU to avoid corrupting a new kernel
started with kexec.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 7 +++++++
 drivers/iommu/arm-smmu.c    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..3d8ac29 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2765,9 +2765,15 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_device_disable(smmu);
+
 	return 0;
 }
 
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
+{
+	arm_smmu_device_remove(pdev);
+}
+
 static struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
@@ -2781,6 +2787,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
+	.shutdown = arm_smmu_device_shutdown,
 };
 module_platform_driver(arm_smmu_driver);
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7ec30b0..af50bab 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2319,6 +2319,11 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
+{
+	arm_smmu_device_remove(pdev);
+}
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu",
@@ -2326,6 +2331,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
+	.shutdown = arm_smmu_device_shutdown,
 };
 module_platform_driver(arm_smmu_driver);
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
