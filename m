From: nipun.gupta@nxp.com (Nipun Gupta)
Date: Thu, 2 Jun 2016 13:35:24 +0000
Subject: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <1464640806-3942-3-git-send-email-thommyj@gmail.com>
References: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
 <1464640806-3942-3-git-send-email-thommyj@gmail.com>
Message-ID: <DB5PR0401MB186309ACEF30FEA489C3CA97E6580@DB5PR0401MB1863.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Thommy Jakobsson
Sent: Tuesday, May 31, 2016 2:10 AM
To: linux-arm-kernel at lists.infradead.org
Cc: robin.murphy at arm.com; Thommy Jakobsson <thommyj@gmail.com>; will.deacon at arm.com
Subject: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs

Use DT bindings to allow masks to be added for a masters streamIDs. This is necessary for devices that have multiple IDs, or use dynamic signals to build up the ID. For example the ZynqMPSoC that mirrors 6bits from the AXI ID into the streamid.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
---
 drivers/iommu/arm-smmu.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index 9345a3f..14438f8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -305,6 +305,7 @@ struct arm_smmu_smr {  struct arm_smmu_master_cfg {
 	int				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
+	u16				streammasks[MAX_MASTER_STREAMIDS];
 	struct arm_smmu_smr		*smrs;
 };
 
@@ -554,6 +555,38 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	return insert_smmu_master(smmu, master);  }
 
+static int register_smmu_master_mask(struct arm_smmu_device *smmu,
+				     struct device *dev,
+				     struct of_phandle_args *masterspec) {
+	int i;
+	struct arm_smmu_master *master;
+
+	master = find_smmu_master(smmu, masterspec->np);
+	if (!master) {
+		dev_err(dev,
+			"mask phandle to %s, but no ID registred\n",
+			masterspec->np->name);
+		return -EINVAL;
+	}
+
+	if (masterspec->args_count != master->cfg.num_streamids) {
+		dev_err(dev,
+			"Different number of ids %d and masks %d not supported for master device %s\n",
+			master->cfg.num_streamids,
+			masterspec->args_count,
+			masterspec->np->name);
+		return -ENOSPC;
+	}
+
+	for (i = 0; i < master->cfg.num_streamids; ++i) {
+		u16 streammask = masterspec->args[i];
+
+		master->cfg.streamids[i] = streammask;
[Gupta Nipun] Should this not be 'master->cfg. streammasks[i] = streammask'

+	}
+	return 0;
+}
+
 static struct arm_smmu_device *find_smmu_for_device(struct device *dev)  {
 	struct arm_smmu_device *smmu;
@@ -1106,7 +1139,7 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 
 		smrs[i] = (struct arm_smmu_smr) {
 			.idx	= idx,
-			.mask	= 0, /* We don't currently share SMRs */
+			.mask	= cfg->streammasks[i],
 			.id	= cfg->streamids[i],
 		};
 	}
@@ -1972,6 +2005,17 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	dev_notice(dev, "registered %d master devices\n", i);
 
+	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters-mask",
+					   "#stream-id-cells", i,
+					   &masterspec)) {
[Gupta Nipun] I should start from 0 and should be incremented in the while loop.

+		err = register_smmu_master_mask(smmu, dev, &masterspec);
+		if (err) {
+			dev_err(dev, "failed to add mask for%s\n",
+				masterspec.np->name);
+			goto out_put_masters;
+		}
+
+	}
 	kfree(masterspec);
 
 	parse_driver_options(smmu);
--
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
