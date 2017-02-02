From: sricharan@codeaurora.org (Sricharan R)
Date: Thu,  2 Feb 2017 22:40:20 +0530
Subject: [PATCH V2 3/3] iommu/arm-smmu: Add the device_link between masters
 and smmu
In-Reply-To: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1486055420-19671-4-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5170523..db4bb3c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1475,6 +1475,7 @@ static int arm_smmu_add_device(struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct device_link *link = NULL;
 	int i, ret;
 
 	if (using_legacy_binding) {
@@ -1528,6 +1529,16 @@ static int arm_smmu_add_device(struct device *dev)
 	if (ret)
 		goto out_free;
 
+	/*
+	 * Establish the link between smmu and master, so that the
+	 * smmu gets runtime enabled/disabled as per the master's
+	 * needs.
+	 */
+	link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+	if (!link)
+		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
+			 dev_name(smmu->dev), dev_name(dev));
+
 	return 0;
 
 out_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
