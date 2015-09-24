From: agross@codeaurora.org (Andy Gross)
Date: Thu, 24 Sep 2015 14:18:55 -0500
Subject: [Patch v3 06/10] regulators: qcom-smd: Add PM8916 support
In-Reply-To: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
References: <1443122339-13917-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443122339-13917-7-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support and documentation for the PM8916 regulators
found on MSM8916 platforms.

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../bindings/soc/qcom/qcom,smd-rpm-regulator.txt   |   18 ++++++
 drivers/regulator/qcom_smd-regulator.c             |   64 ++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
index 7084474..e74ffe1 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
@@ -17,6 +17,7 @@ Regulator nodes are identified by their compatible:
 	Value type: <string>
 	Definition: must be one of:
 		    "qcom,rpm-pm8841-regulators"
+		    "qcom,rpm-pm8916-regulators"
 		    "qcom,rpm-pm8941-regulators"
 
 - vdd_s1-supply:
@@ -35,6 +36,19 @@ Regulator nodes are identified by their compatible:
 - vdd_s1-supply:
 - vdd_s2-supply:
 - vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_l1_l2_l3-supply:
+- vdd_l4_l5_l6-supply:
+- vdd_l7-supply:
+- vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18-supply:
+	Usage: optional (pm8916 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
 - vdd_l1_l3-supply:
 - vdd_l2_lvs1_2_3-supply:
 - vdd_l4_l11-supply:
@@ -57,6 +71,10 @@ of the pmics below.
 pm8841:
 	s1, s2, s3, s4, s5, s6, s7, s8
 
+pm8916:
+	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
+	l14, l15, l16, l17, l18
+
 pm8941:
 	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
 	l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2,
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 9c6167d..e9b07cc3 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -211,6 +211,43 @@ static const struct regulator_desc pm8941_switch = {
 	.ops = &rpm_switch_ops,
 };
 
+static const struct regulator_desc pm8916_pldo = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(750000, 0, 208, 12500),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 209,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8916_nldo = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(375000, 0, 93, 12500),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 94,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8916_buck_lvo_smps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(375000, 0, 95, 12500),
+		REGULATOR_LINEAR_RANGE(750000, 96, 127, 25000),
+	},
+	.n_linear_ranges = 2,
+	.n_voltages = 128,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pm8916_buck_hvo_smps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(1550000, 0, 31, 25000),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 32,
+	.ops = &rpm_smps_ldo_ops,
+};
+
 struct rpm_regulator_data {
 	const char *name;
 	u32 type;
@@ -231,6 +268,32 @@ static const struct rpm_regulator_data rpm_pm8841_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pm8916_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8916_buck_lvo_smps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8916_buck_lvo_smps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm8916_buck_lvo_smps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm8916_buck_hvo_smps, "vdd_s4" },
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8916_nldo, "vdd_l1_l2_l3" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8916_nldo, "vdd_l1_l2_l3" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8916_nldo, "vdd_l1_l2_l3" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8916_pldo, "vdd_l4_l5_l6" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8916_pldo, "vdd_l4_l5_l6" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8916_pldo, "vdd_l4_l5_l6" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8916_pldo, "vdd_l7" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8916_pldo, "vdd_l8_l9_l10_l11_l12_l13_l14_l15_l16_l17_l18"},
+	{}
+};
+
 static const struct rpm_regulator_data rpm_pm8941_regulators[] = {
 	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pm8x41_hfsmps, "vdd_s1" },
 	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8x41_hfsmps, "vdd_s2" },
@@ -274,6 +337,7 @@ static const struct rpm_regulator_data rpm_pm8941_regulators[] = {
 
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
+	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
 	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
 	{}
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
