From: agross@codeaurora.org (Andy Gross)
Date: Wed, 23 Sep 2015 11:53:29 -0500
Subject: [Patch v2 10/10] regulator: qcom-smd: Add support for PMA8084
In-Reply-To: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
References: <1443027209-19444-1-git-send-email-agross@codeaurora.org>
Message-ID: <1443027209-19444-11-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support and documentation for the PMA8084 regulators
found on APQ8084 platforms.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../bindings/soc/qcom/qcom,smd-rpm-regulator.txt   |   35 ++++++++
 drivers/regulator/qcom_smd-regulator.c             |   95 ++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
index 05dfc1a..482f520 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
@@ -19,6 +19,7 @@ Regulator nodes are identified by their compatible:
 		    "qcom,rpm-pm8841-regulators"
 		    "qcom,rpm-pm8941-regulators"
 		    "qcom,rpm-pm8916-regulators"
+		    "qcom,rpm-pma8084-regulators"
 
 - vdd_s1-supply:
 - vdd_s2-supply:
@@ -64,6 +65,35 @@ Regulator nodes are identified by their compatible:
 	Definition: reference to regulator supplying the input pin, as
 		    described in the data sheet
 
+- vdd_s1-supply:
+- vdd_s2-supply:
+- vdd_s3-supply:
+- vdd_s4-supply:
+- vdd_s5-supply:
+- vdd_s6-supply:
+- vdd_s7-supply:
+- vdd_s8-supply:
+- vdd_s9-supply:
+- vdd_s10-supply:
+- vdd_s11-supply:
+- vdd_s12-supply:
+- vdd_l1_l11-supply:
+- vdd_l2_l3_l4_l27-supply:
+- vdd_l5_l7-supply:
+- vdd_l6_l12_l14_l15_l26-supply:
+- vdd_l8-supply:
+- vdd_l9_l10_l13_l20_l23_l24-supply:
+- vdd_l16_l25-supply:
+- vdd_l17-supply:
+- vdd_l18-supply:
+- vdd_l19-supply:
+- vdd_l21-supply:
+- vdd_l22-supply:
+	Usage: optional (pma8084 only)
+	Value type: <phandle>
+	Definition: reference to regulator supplying the input pin, as
+		    described in the data sheet
+
 The regulator node houses sub-nodes for each regulator within the device. Each
 sub-node is identified using the node's name, with valid values listed for each
 of the pmics below.
@@ -80,6 +110,11 @@ pm8916:
 	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
 	l14, l15, l16, l17, l18
 
+pma8084:
+	s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3, l4, l5,
+	l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
+	l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
+
 The content of each sub-node is defined by the standard binding for regulators -
 see regulator.txt.
 
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 0ba6712..0217561 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -153,6 +153,49 @@ static const struct regulator_ops rpm_switch_ops = {
 	.is_enabled = rpm_reg_is_enabled,
 };
 
+static const struct regulator_desc pma8084_hfsmps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(375000,  0,  95, 12500),
+		REGULATOR_LINEAR_RANGE(1550000, 96, 158, 25000),
+	},
+	.n_linear_ranges = 2,
+	.n_voltages = 159,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pma8084_ftsmps = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(350000,  0, 184, 5000),
+		REGULATOR_LINEAR_RANGE(700000, 185, 339, 10000),
+	},
+	.n_linear_ranges = 2,
+	.n_voltages = 340,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pma8084_pldo = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(750000,  0,  30, 25000),
+		REGULATOR_LINEAR_RANGE(1500000, 31, 99, 50000),
+	},
+	.n_linear_ranges = 2,
+	.n_voltages = 100,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pma8084_nldo = {
+	.linear_ranges = (struct regulator_linear_range[]) {
+		REGULATOR_LINEAR_RANGE(750000, 0, 63, 12500),
+	},
+	.n_linear_ranges = 1,
+	.n_voltages = 64,
+	.ops = &rpm_smps_ldo_ops,
+};
+
+static const struct regulator_desc pma8084_switch = {
+	.ops = &rpm_switch_ops,
+};
+
 static const struct regulator_desc pm8x41_hfsmps = {
 	.linear_ranges = (struct regulator_linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 375000,  0,  95, 12500),
@@ -335,10 +378,62 @@ static const struct rpm_regulator_data rpm_pm8941_regulators[] = {
 	{}
 };
 
+static const struct rpm_regulator_data rpm_pma8084_regulators[] = {
+	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pma8084_ftsmps, "vdd_s1" },
+	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pma8084_ftsmps, "vdd_s2" },
+	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pma8084_hfsmps, "vdd_s3" },
+	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pma8084_hfsmps, "vdd_s4" },
+	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pma8084_hfsmps, "vdd_s5" },
+	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pma8084_ftsmps, "vdd_s6" },
+	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pma8084_ftsmps, "vdd_s7" },
+	{ "s8", QCOM_SMD_RPM_SMPA, 8, &pma8084_ftsmps, "vdd_s8" },
+	{ "s9", QCOM_SMD_RPM_SMPA, 9, &pma8084_ftsmps, "vdd_s9" },
+	{ "s10", QCOM_SMD_RPM_SMPA, 10, &pma8084_ftsmps, "vdd_s10" },
+	{ "s11", QCOM_SMD_RPM_SMPA, 11, &pma8084_ftsmps, "vdd_s11" },
+	{ "s12", QCOM_SMD_RPM_SMPA, 12, &pma8084_ftsmps, "vdd_s12" },
+
+	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pma8084_nldo, "vdd_l1_l11" },
+	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pma8084_pldo, "vdd_l5_l7" },
+	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pma8084_pldo, "vdd_l5_l7" },
+	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pma8084_pldo, "vdd_l8" },
+	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pma8084_nldo, "vdd_l1_l11" },
+	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pma8084_pldo, "vdd_l16_l25" },
+	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pma8084_pldo, "vdd_l17" },
+	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pma8084_pldo, "vdd_l18" },
+	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pma8084_pldo, "vdd_l19" },
+	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pma8084_pldo, "vdd_l21" },
+	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pma8084_pldo, "vdd_l22" },
+	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
+	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pma8084_pldo, "vdd_l16_l25" },
+	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
+	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
+
+	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pma8084_switch },
+	{ "lvs2", QCOM_SMD_RPM_VSA, 2, &pma8084_switch },
+	{ "lvs3", QCOM_SMD_RPM_VSA, 3, &pma8084_switch },
+	{ "lvs4", QCOM_SMD_RPM_VSA, 4, &pma8084_switch },
+	{ "5vs1", QCOM_SMD_RPM_VSA, 5, &pma8084_switch },
+
+	{}
+};
+
 static const struct of_device_id rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
 	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
 	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
+	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rpm_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
