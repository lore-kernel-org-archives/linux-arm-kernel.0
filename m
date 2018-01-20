From: nwatters@codeaurora.org (Nate Watterson)
Date: Sat, 20 Jan 2018 13:08:04 -0500
Subject: [PATCH v2] iommu/arm-smmu-v3: limit reporting of MSI allocation
 failures
Message-ID: <1516471684-25052-1-git-send-email-nwatters@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the arm-smmu-v3 driver expects to allocate MSIs for all SMMUs
with FEAT_MSI set. This results in unwarranted "failed to allocate MSIs"
warnings being printed on systems where FW was either deliberately
configured to force the use of SMMU wired interrupts -or- is altogether
incapable of describing SMMU MSI topology (ACPI IORT prior to rev.C).

Remedy this by checking msi_domain before attempting to allocate SMMU
MSIs.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 744592d..00de028 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2328,10 +2328,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
 		return;
 
+	if (!dev->msi_domain) {
+		dev_info(smmu->dev, "msi_domain absent - falling back to wired irqs\n");
+		return;
+	}
+
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
 	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
-		dev_warn(dev, "failed to allocate MSIs\n");
+		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
 		return;
 	}
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
