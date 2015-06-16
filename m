From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 11:11:22 -0700
Subject: [PATCH] regulator: qcom_spmi: Add missing braces for aligned code
Message-ID: <1434478282-13552-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/regulator/qcom_spmi-regulator.c:751:3-50: code aligned
with following code on line 753
drivers/regulator/qcom_spmi-regulator.c:584:3-41: code aligned
with following code on line 587

These lines where missing braces causing the break to always
be executed even when it shouldn't be. Fix it.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 162b86501a91..ff6ccc734565 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -580,11 +580,12 @@ static int spmi_regulator_select_voltage_same_range(struct spmi_regulator *vreg,
 	*selector = 0;
 	for (i = 0; i < vreg->set_points->count; i++) {
 		if (uV >= vreg->set_points->range[i].set_point_min_uV
-		    && uV <= vreg->set_points->range[i].set_point_max_uV)
+		    && uV <= vreg->set_points->range[i].set_point_max_uV) {
 			*selector +=
 			    (uV - vreg->set_points->range[i].set_point_min_uV)
 				/ vreg->set_points->range[i].step_uV;
 			break;
+		}
 
 		*selector += vreg->set_points->range[i].n_voltages;
 	}
@@ -747,10 +748,11 @@ static int spmi_regulator_common_list_voltage(struct regulator_dev *rdev,
 		return 0;
 
 	for (i = 0; i < vreg->set_points->count; i++) {
-		if (selector < vreg->set_points->range[i].n_voltages)
+		if (selector < vreg->set_points->range[i].n_voltages) {
 			uV = selector * vreg->set_points->range[i].step_uV
 				+ vreg->set_points->range[i].set_point_min_uV;
 			break;
+		}
 
 		selector -= vreg->set_points->range[i].n_voltages;
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
