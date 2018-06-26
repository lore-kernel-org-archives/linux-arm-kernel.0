From: sgoel@codeaurora.org (Sameer Goel)
Date: Mon, 25 Jun 2018 20:30:39 -0600
Subject: [PATCH v2 1/1] iommu/arm-smmu-v3: Set GBPA to abort all transactions
Message-ID: <1529980239-1950-1-git-send-email-sgoel@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set SMMU_GBPA to abort all incoming translations during the SMMU reset
when SMMUEN==0.

This prevents a race condition where a stray DMA from the crashed primary
kernel can try to access an IOVA address as an invalid PA when SMMU is
disabled during reset in the crash kernel.

Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d64710..5fedb8e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2395,6 +2395,20 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	if (reg & CR0_SMMUEN)
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 
+	/*
+	 * Abort all incoming translations. This can happen in a kdump case
+	 * where SMMU is initialized when a prior DMA is pending. Just
+	 * disabling the SMMU in this case might result in writes to invalid
+	 * PAs. Do this only if bypass is not set.
+	 */
+	if(!bypass || disable_bypass) {
+		ret = arm_smmu_update_gbpa(smmu, 1, GBPA_ABORT);
+		if (ret) {
+			dev_err(smmu->dev, "GBPA not responding to update\n");
+			return ret;
+		}
+	}
+
 	ret = arm_smmu_device_disable(smmu);
 	if (ret)
 		return ret;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
