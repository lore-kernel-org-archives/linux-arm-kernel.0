From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 14:50:07 -0700
Subject: [PATCH 1/3] regulator: qcom_smd: Fix voltage ranges for pm8x41
In-Reply-To: <20160711215009.4519-1-sboyd@codeaurora.org>
References: <20160711215009.4519-1-sboyd@codeaurora.org>
Message-ID: <20160711215009.4519-2-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltage ranges listed here are wrong. The correct ranges can
be seen in the "native" spmi regulator driver
qcom_spmi-regulator.c at pldo_ranges[], ftsmps_ranges[] and
boost_ranges[] for the pldo, ftsmps, and boost type regulators.
Port these ranges over to the RPM SMD regulator driver so that we
list the appropriate set of supported voltages on pldos.

Doing this allows us to specify a voltage like 3075000 for l24,
whereas before that wasn't a supported voltage.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: da65e367b67e ("regulator: Regulator driver for the Qualcomm RPM")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/qcom_smd-regulator.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 6c7fe4778793..6aa6435b3922 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -221,29 +221,30 @@ static const struct regulator_desc pm8x41_hfsmps = {
 static const struct regulator_desc pm8841_ftsmps = {
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
 
 static const struct regulator_desc pm8941_boost = {
 	.linear_ranges = (struct regulator_linear_range[]) {
-		REGULATOR_LINEAR_RANGE(4000000, 0, 15, 100000),
+		REGULATOR_LINEAR_RANGE(4000000, 0, 30, 50000),
 	},
 	.n_linear_ranges = 1,
-	.n_voltages = 16,
+	.n_voltages = 31,
 	.ops = &rpm_smps_ldo_ops,
 };
 
 static const struct regulator_desc pm8941_pldo = {
 	.linear_ranges = (struct regulator_linear_range[]) {
-		REGULATOR_LINEAR_RANGE( 750000,  0,  30, 25000),
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
