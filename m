From: shameerali.kolothum.thodi@huawei.com (shameer)
Date: Wed, 17 May 2017 10:12:05 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Enable ACPI based HiSilicon CMD_PREFETCH
 quirk(erratum 161010701)
Message-ID: <20170517091205.7752-1-shameerali.kolothum.thodi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HiSilicon SMMUv3 on Hip06/Hip07 platforms doesn't support CMD_PREFETCH
command. The dt based support for this quirk is already present in the
driver(hisilicon,broken-prefetch-cmd). This adds ACPI support for the
quirk using the IORT smmu model number.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: hanjun <guohanjun@huawei.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 drivers/iommu/arm-smmu-v3.c            | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 10f2ddd..d5d23d0 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -66,6 +66,7 @@ stable kernels.
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 |                |                 |                 |                             |
 | Hisilicon      | Hip0{5,6,7}     | #161010101      | HISILICON_ERRATUM_161010101 |
+| Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
 |                |                 |                 |                             |
 | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..abe4b88 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2605,6 +2605,20 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 }
 
 #ifdef CONFIG_ACPI
+static void parse_driver_acpi_options(struct acpi_iort_smmu_v3 *iort_smmu,
+				      struct arm_smmu_device *smmu)
+{
+	switch (iort_smmu->model) {
+	case ACPI_IORT_SMMU_HISILICON_HI161X:
+		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
+		break;
+	default:
+		break;
+	}
+
+	dev_notice(smmu->dev, "options set 0x%x\n", smmu->options);
+}
+
 static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 				      struct arm_smmu_device *smmu)
 {
@@ -2617,6 +2631,8 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 	/* Retrieve SMMUv3 specific data */
 	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
+	parse_driver_acpi_options(iort_smmu, smmu);
+
 	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-- 
1.9.1
