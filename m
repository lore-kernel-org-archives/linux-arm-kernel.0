From: thommyj@gmail.com (Thommy Jakobsson)
Date: Thu,  9 Jun 2016 12:43:21 +0200
Subject: [PATCH v3 2/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <1465469001-2352-1-git-send-email-thommyj@gmail.com>
References: <5757FD62.2010403@arm.com>
 <1465469001-2352-1-git-send-email-thommyj@gmail.com>
Message-ID: <1465469001-2352-3-git-send-email-thommyj@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use upper half word in StreamID cell from DT as a StreamID mask. This is
useful for reducing number of SMRs used for a master with many StreamIDs.
For example the ZynqMPSoC mirrors 6bits from the AXI ID into the StreamID
for FPGA blocks, but only allows 48 register groups for stream matching.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
---
 drivers/iommu/arm-smmu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9345a3f..ffedd96 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -305,6 +305,7 @@ struct arm_smmu_smr {
 struct arm_smmu_master_cfg {
 	int				num_streamids;
 	u16				streamids[MAX_MASTER_STREAMIDS];
+	u16				streammasks[MAX_MASTER_STREAMIDS];
 	struct arm_smmu_smr		*smrs;
 };
 
@@ -347,6 +348,7 @@ struct arm_smmu_device {
 
 	u32				num_mapping_groups;
 	DECLARE_BITMAP(smr_map, ARM_SMMU_MAX_SMRS);
+	u16				supported_mask;
 
 	unsigned long			va_size;
 	unsigned long			ipa_size;
@@ -540,7 +542,10 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 	master->cfg.num_streamids	= masterspec->args_count;
 
 	for (i = 0; i < master->cfg.num_streamids; ++i) {
-		u16 streamid = masterspec->args[i];
+		u16 streamid = (masterspec->args[i] >> SMR_ID_SHIFT) &
+				SMR_ID_MASK;
+		u16 mask     = (masterspec->args[i] >> SMR_MASK_SHIFT) &
+				SMR_MASK_MASK;
 
 		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
 		     (streamid >= smmu->num_mapping_groups)) {
@@ -550,6 +555,14 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
 			return -ERANGE;
 		}
 		master->cfg.streamids[i] = streamid;
+
+		if ((smmu->supported_mask | mask) != smmu->supported_mask) {
+			dev_err(dev,
+				"unsupported mask, 0x%04x used for master device %s\n",
+				mask, masterspec->np->name);
+			return -ERANGE;
+		}
+		master->cfg.streammasks[i] = mask;
 	}
 	return insert_smmu_master(smmu, master);
 }
@@ -1106,7 +1119,7 @@ static int arm_smmu_master_configure_smrs(struct arm_smmu_device *smmu,
 
 		smrs[i] = (struct arm_smmu_smr) {
 			.idx	= idx,
-			.mask	= 0, /* We don't currently share SMRs */
+			.mask	= cfg->streammasks[i],
 			.id	= cfg->streamids[i],
 		};
 	}
@@ -1735,6 +1748,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 				mask, sid);
 			return -ENODEV;
 		}
+		smmu->supported_mask = mask;
 
 		dev_notice(smmu->dev,
 			   "\tstream matching with %u register groups, mask 0x%x",
-- 
1.9.1
