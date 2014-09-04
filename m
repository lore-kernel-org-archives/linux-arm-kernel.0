From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:49:59 +0100
Subject: [PATCH 1/7] iommu/arm-smmu: allow translation stage to be forced on
 the cmdline
In-Reply-To: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409849405-17347-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When debugging and testing code on an SMMU that supports nested
translation, it can be useful to restrict the driver to a particular
stage of translation.

This patch adds a module parameter to the ARM SMMU driver to allow this
by restricting the ability of the probe() code to detect support for
only the specified stage.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a83cc2a2a2ca..958ae8194afe 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -326,6 +326,11 @@
 
 #define FSYNR0_WNR			(1 << 4)
 
+static int force_stage;
+module_param_named(force_stage, force_stage, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(force_stage,
+	"Force SMMU mappings to be installed@a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
+
 struct arm_smmu_smr {
 	u8				idx;
 	u16				mask;
@@ -1716,6 +1721,13 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 #endif
+
+	/* Restrict available stages based on module parameter */
+	if (force_stage == 1)
+		id &= ~(ID0_S2TS | ID0_NTS);
+	else if (force_stage == 2)
+		id &= ~(ID0_S1TS | ID0_NTS);
+
 	if (id & ID0_S1TS) {
 		smmu->features |= ARM_SMMU_FEAT_TRANS_S1;
 		dev_notice(smmu->dev, "\tstage 1 translation\n");
@@ -1732,8 +1744,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	}
 
 	if (!(smmu->features &
-		(ARM_SMMU_FEAT_TRANS_S1 | ARM_SMMU_FEAT_TRANS_S2 |
-		 ARM_SMMU_FEAT_TRANS_NESTED))) {
+		(ARM_SMMU_FEAT_TRANS_S1 | ARM_SMMU_FEAT_TRANS_S2))) {
 		dev_err(smmu->dev, "\tno translation support!\n");
 		return -ENODEV;
 	}
-- 
2.1.0
