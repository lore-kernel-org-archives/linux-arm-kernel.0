From: sricharan@codeaurora.org (Sricharan R)
Date: Tue, 16 May 2017 10:54:13 +0530
Subject: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
Message-ID: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While returning EPROBE_DEFER for iommu masters
take in to account of iommu nodes that could be
marked in DT as 'status=disabled', in which case
simply return NULL and let the master's probe
continue rather than deferring.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Tested-by: Will Deacon <will.deacon@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/of_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 9f44ee8..e6e9bec 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -118,6 +118,7 @@ static bool of_iommu_driver_present(struct device_node *np)
 
 	ops = iommu_ops_from_fwnode(fwnode);
 	if ((ops && !ops->of_xlate) ||
+	    !of_device_is_available(iommu_spec->np) ||
 	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
 		return NULL;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
