From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Fri,  5 May 2017 17:38:08 +0530
Subject: [PATCH v3 4/7] iommu/arm-smmu-v3: For ACPI based device probing,
 set  PAGE0_REGS_ONLY option for ThunderX2 SMMUv3 implementation.
In-Reply-To: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1493986091-30521-5-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Enable PAGE0_REGS_ONLY option for Cavium ThunderX2 SMMUv3 model.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f027676..8f7d8ad 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2625,6 +2625,14 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 }
 
 #ifdef CONFIG_ACPI
+static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
+{
+	if (model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
+		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
+
+	dev_notice(smmu->dev, "option mask 0x%x\n", smmu->options);
+}
+
 static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 				      struct arm_smmu_device *smmu)
 {
@@ -2637,6 +2645,8 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	/* Retrieve SMMUv3 specific data */
 	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	acpi_smmu_get_options(iort_smmu->model, smmu);
+
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-- 
1.8.3.1
