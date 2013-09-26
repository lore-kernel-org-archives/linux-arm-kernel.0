From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Fri, 27 Sep 2013 00:36:17 +0200
Subject: [PATCH 5/9] iommu/arm-smmu: Clear global and context bank fault
 status registers
In-Reply-To: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <1380234982-1677-6-git-send-email-andreas.herrmann@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After reset these registers have unknown values.
This might cause problems when evaluating SMMU_GFSR and/or SMMU_CB_FSR
in handlers for combined interrupts.

Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 drivers/iommu/arm-smmu.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index de9dd60..9d31ad9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -642,6 +642,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	stage1 = root_cfg->cbar != CBAR_TYPE_S2_TRANS;
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
 
+	/* clear fsr */
+	writel_relaxed(0xffffffff, cb_base + ARM_SMMU_CB_FSR);
+
 	/* CBAR */
 	reg = root_cfg->cbar;
 	if (smmu->version == 1)
@@ -1564,6 +1567,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	int i = 0;
 	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
 
+	/* clear global FSRs */
+	writel(0xffffffff, gr0_base + ARM_SMMU_GR0_sGFSR);
+
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
 		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
-- 
1.7.9.5
