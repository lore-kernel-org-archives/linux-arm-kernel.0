From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 14:50:09 -0700
Subject: [PATCH 3/3] regulator: qcom_smd: Avoid overlapping linear voltage
 ranges
In-Reply-To: <20160711215009.4519-1-sboyd@codeaurora.org>
References: <20160711215009.4519-1-sboyd@codeaurora.org>
Message-ID: <20160711215009.4519-4-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm8x41_hfsmps ranges overlap. The first range is from 375000
to 1562500:

 375000 + (95 * 12500) == 1562500

and the second range starts at 1550000. Interestingly, the second
range ends at the correct value when it's set to be the
appropriate start value, 1575000:

 1575000 + ((158 - 96) * 25000) == 3125000

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: da65e367b67e ("regulator: Regulator driver for the Qualcomm RPM")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/qcom_smd-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 891ae44a49c2..8ed46a9a55c8 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -212,7 +212,7 @@ static const struct regulator_desc pma8084_switch = {
 static const struct regulator_desc pm8x41_hfsmps = {
 	.linear_ranges = (struct regulator_linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 375000,  0,  95, 12500),
-		REGULATOR_LINEAR_RANGE(1550000, 96, 158, 25000),
+		REGULATOR_LINEAR_RANGE(1575000, 96, 158, 25000),
 	},
 	.n_linear_ranges = 2,
 	.n_voltages = 159,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
