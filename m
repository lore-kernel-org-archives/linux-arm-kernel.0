From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 10:44:37 -0700
Subject: [PATCH] regulator: qcom_spmi: Always return a selector when asked
In-Reply-To: <5710BFE7.9060802@codeaurora.org>
References: <1459389470-29365-1-git-send-email-stephen.boyd@linaro.org>
 <1459389470-29365-3-git-send-email-stephen.boyd@linaro.org>
 <1459389470-29365-3-git-send-email-stephen.boyd@linaro.org>
Message-ID: <1460742277-2838-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I had a thinko in spmi_regulator_select_voltage_same_range() when
converting it to return selectors via the function's return value
instead of by modifying a pointer argument. I only tested
multi-range regulators so this passed through testing. Fix it by
returning the selector here.

Fixes: 1b5b19689278 ("regulator: qcom_spmi: Only use selector based regulator ops")
Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index f502f2cc65d8..84cce21e98cd 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -692,7 +692,7 @@ static int spmi_regulator_select_voltage_same_range(struct spmi_regulator *vreg,
 	if (selector >= vreg->set_points->n_voltages)
 		goto different_range;
 
-	return 0;
+	return selector;
 
 different_range:
 	return spmi_regulator_select_voltage(vreg, min_uV, max_uV);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
