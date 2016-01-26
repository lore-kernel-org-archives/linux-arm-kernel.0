From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Jan 2016 18:06:35 +0000
Subject: [PATCH 2/4] iommu/arm-smmu: Allow disabling unmatched stream bypass
In-Reply-To: <cover.1453830752.git.robin.murphy@arm.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
Message-ID: <10ebf5a136a787da54ffd1d6167953f82f01a834.1453830752.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Borrow the disable_bypass parameter from the SMMUv3 driver as a handy
debugging/security feature so that unmatched stream IDs (i.e. devices
not attached to an IOMMU domain) may be configured to fault.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1f9093d..d1b7dc1 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -141,6 +141,8 @@
 #define ID2_PTFS_16K			(1 << 13)
 #define ID2_PTFS_64K			(1 << 14)
 
+#define sGFSR_USF			(1 << 1)
+
 /* Global TLB invalidation */
 #define ARM_SMMU_GR0_TLBIVMID		0x64
 #define ARM_SMMU_GR0_TLBIALLNSNH	0x68
@@ -263,6 +265,10 @@ static int force_stage;
 module_param_named(force_stage, force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed@a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
+static bool disable_bypass;
+module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
+MODULE_PARM_DESC(disable_bypass,
+	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
 enum arm_smmu_arch_version {
 	ARM_SMMU_V1 = 1,
@@ -704,8 +710,12 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	if (!gfsr)
 		return IRQ_NONE;
 
-	dev_err_ratelimited(smmu->dev,
-		"Unexpected global fault, this could be serious\n");
+	if (gfsr & sGFSR_USF)
+		dev_err_ratelimited(smmu->dev, "Unmatched stream fault: ID 0x%x\n",
+				    gfsynr1 & SMR_ID_MASK);
+	else
+		dev_err_ratelimited(smmu->dev,
+			"Unexpected global fault, this could be serious\n");
 	dev_err_ratelimited(smmu->dev,
 		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
 		gfsr, gfsynr0, gfsynr1, gfsynr2);
@@ -1111,9 +1121,9 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	 */
 	for (i = 0; i < cfg->num_streamids; ++i) {
 		u32 idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
+		u32 reg = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS;
 
-		writel_relaxed(S2CR_TYPE_BYPASS,
-			       gr0_base + ARM_SMMU_GR0_S2CR(idx));
+		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_S2CR(idx));
 	}
 
 	arm_smmu_master_free_smrs(smmu, cfg);
@@ -1476,11 +1486,11 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
 
-	/* Mark all SMRn as invalid and all S2CRn as bypass */
+	/* Mark all SMRn as invalid and all S2CRn as bypass unless overridden */
+	reg = disable_bypass ? S2CR_TYPE_FAULT : S2CR_TYPE_BYPASS;
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
 		writel_relaxed(0, gr0_base + ARM_SMMU_GR0_SMR(i));
-		writel_relaxed(S2CR_TYPE_BYPASS,
-			gr0_base + ARM_SMMU_GR0_S2CR(i));
+		writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
 
 	/* Make sure all context banks are disabled and clear CB_FSR  */
@@ -1502,8 +1512,12 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Disable TLB broadcasting. */
 	reg |= (sCR0_VMIDPNE | sCR0_PTM);
 
-	/* Enable client access, but bypass when no mapping is found */
-	reg &= ~(sCR0_CLIENTPD | sCR0_USFCFG);
+	/* Enable client access, handling unmatched streams as appropriate */
+	reg &= ~sCR0_CLIENTPD;
+	if (disable_bypass)
+		reg |= sCR0_USFCFG;
+	else
+		reg &= ~sCR0_USFCFG;
 
 	/* Disable forced broadcasting */
 	reg &= ~sCR0_FB;
-- 
2.7.0.25.gfc10eb5.dirty
