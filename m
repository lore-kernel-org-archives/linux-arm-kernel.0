From: ohaugan@codeaurora.org (Olav Haugan)
Date: Mon, 18 Aug 2014 16:17:38 -0700
Subject: [PATCH v3 1/1] iommu/arm-smmu: Do not access non-existing S2CR
 registers
Message-ID: <1408403858-16766-1-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The number of S2CR registers is not properly set when stream
matching is not supported. Fix this and add check that we do not try to
access outside of the number of S2CR regisrers.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9fd8754d..a050f7a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -548,9 +548,16 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	master->of_node			= masterspec->np;
 	master->cfg.num_streamids	= masterspec->args_count;
 
-	for (i = 0; i < master->cfg.num_streamids; ++i)
+	for (i = 0; i < master->cfg.num_streamids; ++i) {
+		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
+		     (masterspec->args[i] >= smmu->num_mapping_groups)) {
+			dev_err(dev,
+				"stream ID for master device %s greater than maximum allowed (%d)\n",
+				masterspec->np->name, smmu->num_mapping_groups);
+			return -ENOSPC;
+		}
 		master->cfg.streamids[i] = masterspec->args[i];
-
+	}
 	return insert_smmu_master(smmu, master);
 }
 
@@ -1734,7 +1741,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
-		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
+		writel_relaxed(0, gr0_base + ARM_SMMU_GR0_SMR(i));
 		writel_relaxed(S2CR_TYPE_BYPASS,
 			gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
@@ -1875,6 +1882,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_notice(smmu->dev,
 			   "\tstream matching with %u register groups, mask 0x%x",
 			   smmu->num_mapping_groups, mask);
+	} else {
+		smmu->num_mapping_groups = (id >> ID0_NUMSIDB_SHIFT) &
+					   ID0_NUMSIDB_MASK;
 	}
 	smmu->idr[0] = id;
 
@@ -2011,6 +2021,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_device_cfg_probe(smmu);
+	if (err)
+		return err;
+
 	i = 0;
 	smmu->masters = RB_ROOT;
 	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
@@ -2027,10 +2041,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	dev_notice(dev, "registered %d master devices\n", i);
 
-	err = arm_smmu_device_cfg_probe(smmu);
-	if (err)
-		goto out_put_masters;
-
 	parse_driver_options(smmu);
 
 	if (smmu->version > 1 &&
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
