From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Wed, 14 Mar 2018 13:44:33 +0530
Subject: [PATCH v10 4/5] iommu/arm-smmu: Add the device_link between masters
 and smmu
In-Reply-To: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
References: <20180314081434.30875-1-vivek.gautam@codeaurora.org>
Message-ID: <20180314081434.30875-5-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sricharan R <sricharan@codeaurora.org>

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---

Changes since v9:
 - Using device_link_del_dev() to delete the device link, instead of
   doing it in two steps - device_link_find() to first find the link, and
   then calling device_link_del().

 drivers/iommu/arm-smmu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 56a04ae80bf3..4cf270ffd449 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1460,10 +1460,31 @@ static int arm_smmu_add_device(struct device *dev)
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	if (pm_runtime_enabled(smmu->dev)) {
+		struct device_link *link;
+
+		/*
+		 * Establish the link between smmu and master, so that the
+		 * smmu gets runtime enabled/disabled as per the master's
+		 * needs.
+		 */
+		link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+		if (!link) {
+			dev_warn(smmu->dev,
+				 "Unable to add link to the consumer %s\n",
+				 dev_name(dev));
+			ret = -ENODEV;
+			goto out_unlink;
+		}
+	}
+
 	arm_smmu_rpm_put(smmu);
 
 	return 0;
 
+out_unlink:
+	iommu_device_unlink(&smmu->iommu, dev);
+	arm_smmu_master_free_smes(fwspec);
 out_rpm_put:
 	arm_smmu_rpm_put(smmu);
 out_cfg_free:
@@ -1486,6 +1507,9 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	if (pm_runtime_enabled(smmu->dev))
+		device_link_del_dev(dev, smmu->dev);
+
 	ret = arm_smmu_rpm_get(smmu);
 	if (ret < 0)
 		return;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
