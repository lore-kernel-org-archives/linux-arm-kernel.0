From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 14:50:08 -0700
Subject: [PATCH 2/3] regulator: qcom_smd: Fix voltage ranges for pma8084
 ftsmps and pldo
In-Reply-To: <20160711215009.4519-1-sboyd@codeaurora.org>
References: <20160711215009.4519-1-sboyd@codeaurora.org>
Message-ID: <20160711215009.4519-3-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltage ranges listed here are wrong. The pma8084 pldo
supports three different overlapping voltage ranges with
differing step sizes and the pma8084 ftsmps supports two. These
ranges can be seen in the "native" spmi regulator driver
(qcom_spmi-regulator.c) at pldo_ranges[] and ftsmps_ranges[]
respectively. Port these ranges over to the RPM SMD regulator
driver so that we list the appropriate set of supported voltages
on these types of regulators.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: ee01d0c91ef1 ("regulator: qcom-smd: Add support for PMA8084")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/qcom_smd-regulator.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 6aa6435b3922..891ae44a49c2 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -178,20 +178,21 @@ static const struct regulator_desc pma8084_hfsmps = {
 static const struct regulator_desc pma8084_ftsmps = {
 	.linear_ranges = (struct regulator_linear_range[]) {
 		REGULATOR_LINEAR_RANGE(350000,  0, 184, 5000),
-		REGULATOR_LINEAR_RANGE(700000, 185, 339, 10000),
+		REGULATOR_LINEAR_RANGE(1280000, 185, 261, 10000),
 	},
 	.n_linear_ranges = 2,
-	.n_voltages = 340,
+	.n_voltages = 262,
 	.ops = &rpm_smps_ldo_ops,
 };
 
 static const struct regulator_desc pma8084_pldo = {
 	.linear_ranges = (struct regulator_linear_range[]) {
-		REGULATOR_LINEAR_RANGE(750000,  0,  30, 25000),
-		REGULATOR_LINEAR_RANGE(1500000, 31, 99, 50000),
+		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
+		REGULATOR_LINEAR_RANGE(1550000, 64, 126, 25000),
+		REGULATOR_LINEAR_RANGE(3100000, 127, 163, 50000),
 	},
-	.n_linear_ranges = 2,
-	.n_voltages = 100,
+	.n_linear_ranges = 3,
+	.n_voltages = 164,
 	.ops = &rpm_smps_ldo_ops,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
