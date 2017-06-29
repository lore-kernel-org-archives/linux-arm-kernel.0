From: nwatters@codeaurora.org (Nate Watterson)
Date: Thu, 29 Jun 2017 13:40:15 -0400
Subject: [PATCH] iommu/arm-smmu-v3: Implement shutdown method
Message-ID: <1498758015-7072-1-git-send-email-nwatters@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shutdown method disables the SMMU and its interrupts to avoid
potentially corrupting a new kernel started with kexec.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..907d576 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2765,9 +2765,19 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_device_disable(smmu);
+
+	/* Disable IRQs */
+	arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				ARM_SMMU_IRQ_CTRLACK);
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
@@ -2781,6 +2791,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
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
