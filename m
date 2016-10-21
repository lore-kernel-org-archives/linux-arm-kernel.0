From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 21 Oct 2016 22:44:26 +0530
Subject: [PATCH 4/4] iommu/arm-smmu: Add the device_link between masters and
 smmu
In-Reply-To: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1477070066-15044-5-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device link between master and its smmu is added so that
the smmu gets runtime enabled/disabled when the master needs it.
This is done from add_device callback which gets called once
when the master is added to the smmu group.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 578cdc2..71ce4b6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1470,6 +1470,15 @@ static int arm_smmu_add_device(struct device *dev)
 		goto out_free;
 	pm_runtime_put_sync(smmu->dev);
 
+	/*
+	 * Establish the link between smmu and master, so that the
+	 * smmu gets runtime enabled/disabled as per the master's
+	 * needs.
+	 */
+
+	device_link_add(dev, smmu->dev, DEVICE_LINK_AVAILABLE,
+			DEVICE_LINK_PM_RUNTIME);
+
 	return 0;
 
 out_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
