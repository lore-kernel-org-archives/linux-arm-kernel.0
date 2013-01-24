From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 24 Jan 2013 17:45:56 +0100
Subject: [PATCH 4/4] clk: ux500: Support is_prepared callback for clk-prcmu
In-Reply-To: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
References: <1359045956-30741-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1359045956-30741-5-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

To be able to gate unused prcmu clocks from the clk_disable_unused sequence,
clk-prcmu now implements the is_prepared callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/clk-prcmu.c |  134 ++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index 74faa7e..9d83256 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -20,15 +20,23 @@
 struct clk_prcmu {
 	struct clk_hw hw;
 	u8 cg_sel;
+	int is_prepared;
 	int is_enabled;
+	int opp_requested;
 };
 
 /* PRCMU clock operations. */
 
 static int clk_prcmu_prepare(struct clk_hw *hw)
 {
+	int ret;
 	struct clk_prcmu *clk = to_clk_prcmu(hw);
-	return prcmu_request_clock(clk->cg_sel, true);
+
+	ret = prcmu_request_clock(clk->cg_sel, true);
+	if (!ret)
+		clk->is_prepared = 1;
+
+	return ret;;
 }
 
 static void clk_prcmu_unprepare(struct clk_hw *hw)
@@ -37,6 +45,14 @@ static void clk_prcmu_unprepare(struct clk_hw *hw)
 	if (prcmu_request_clock(clk->cg_sel, false))
 		pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
 			hw->init->name);
+	else
+		clk->is_prepared = 0;
+}
+
+static int clk_prcmu_is_prepared(struct clk_hw *hw)
+{
+	struct clk_prcmu *clk = to_clk_prcmu(hw);
+	return clk->is_prepared;
 }
 
 static int clk_prcmu_enable(struct clk_hw *hw)
@@ -79,58 +95,52 @@ static int clk_prcmu_set_rate(struct clk_hw *hw, unsigned long rate,
 	return prcmu_set_clock_rate(clk->cg_sel, rate);
 }
 
-static int request_ape_opp100(bool enable)
-{
-	static int reqs;
-	int err = 0;
-
-	if (enable) {
-		if (!reqs)
-			err = prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP,
-							"clock", 100);
-		if (!err)
-			reqs++;
-	} else {
-		reqs--;
-		if (!reqs)
-			prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP,
-						"clock");
-	}
-	return err;
-}
-
 static int clk_prcmu_opp_prepare(struct clk_hw *hw)
 {
 	int err;
 	struct clk_prcmu *clk = to_clk_prcmu(hw);
 
-	err = request_ape_opp100(true);
-	if (err) {
-		pr_err("clk_prcmu: %s failed to request APE OPP100 for %s.\n",
-			__func__, hw->init->name);
-		return err;
+	if (!clk->opp_requested) {
+		err = prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP,
+						(char *)__clk_get_name(hw->clk),
+						100);
+		if (err) {
+			pr_err("clk_prcmu: %s fail req APE OPP for %s.\n",
+				__func__, hw->init->name);
+			return err;
+		}
+		clk->opp_requested = 1;
 	}
 
 	err = prcmu_request_clock(clk->cg_sel, true);
-	if (err)
-		request_ape_opp100(false);
+	if (err) {
+		prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP,
+					(char *)__clk_get_name(hw->clk));
+		clk->opp_requested = 0;
+		return err;
+	}
 
-	return err;
+	clk->is_prepared = 1;
+	return 0;
 }
 
 static void clk_prcmu_opp_unprepare(struct clk_hw *hw)
 {
 	struct clk_prcmu *clk = to_clk_prcmu(hw);
 
-	if (prcmu_request_clock(clk->cg_sel, false))
-		goto out_error;
-	if (request_ape_opp100(false))
-		goto out_error;
-	return;
-
-out_error:
-	pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
-		hw->init->name);
+	if (prcmu_request_clock(clk->cg_sel, false)) {
+		pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
+			hw->init->name);
+		return;
+	}
+
+	if (clk->opp_requested) {
+		prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP,
+					(char *)__clk_get_name(hw->clk));
+		clk->opp_requested = 0;
+	}
+
+	clk->is_prepared = 0;
 }
 
 static int clk_prcmu_opp_volt_prepare(struct clk_hw *hw)
@@ -138,38 +148,49 @@ static int clk_prcmu_opp_volt_prepare(struct clk_hw *hw)
 	int err;
 	struct clk_prcmu *clk = to_clk_prcmu(hw);
 
-	err = prcmu_request_ape_opp_100_voltage(true);
-	if (err) {
-		pr_err("clk_prcmu: %s failed to request APE OPP VOLT for %s.\n",
-			__func__, hw->init->name);
-		return err;
+	if (!clk->opp_requested) {
+		err = prcmu_request_ape_opp_100_voltage(true);
+		if (err) {
+			pr_err("clk_prcmu: %s fail req APE OPP VOLT for %s.\n",
+				__func__, hw->init->name);
+			return err;
+		}
+		clk->opp_requested = 1;
 	}
 
 	err = prcmu_request_clock(clk->cg_sel, true);
-	if (err)
+	if (err) {
 		prcmu_request_ape_opp_100_voltage(false);
+		clk->opp_requested = 0;
+		return err;
+	}
 
-	return err;
+	clk->is_prepared = 1;
+	return 0;
 }
 
 static void clk_prcmu_opp_volt_unprepare(struct clk_hw *hw)
 {
 	struct clk_prcmu *clk = to_clk_prcmu(hw);
 
-	if (prcmu_request_clock(clk->cg_sel, false))
-		goto out_error;
-	if (prcmu_request_ape_opp_100_voltage(false))
-		goto out_error;
-	return;
-
-out_error:
-	pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
-		hw->init->name);
+	if (prcmu_request_clock(clk->cg_sel, false)) {
+		pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
+			hw->init->name);
+		return;
+	}
+
+	if (clk->opp_requested) {
+		prcmu_request_ape_opp_100_voltage(false);
+		clk->opp_requested = 0;
+	}
+
+	clk->is_prepared = 0;
 }
 
 static struct clk_ops clk_prcmu_scalable_ops = {
 	.prepare = clk_prcmu_prepare,
 	.unprepare = clk_prcmu_unprepare,
+	.is_prepared = clk_prcmu_is_prepared,
 	.enable = clk_prcmu_enable,
 	.disable = clk_prcmu_disable,
 	.is_enabled = clk_prcmu_is_enabled,
@@ -181,6 +202,7 @@ static struct clk_ops clk_prcmu_scalable_ops = {
 static struct clk_ops clk_prcmu_gate_ops = {
 	.prepare = clk_prcmu_prepare,
 	.unprepare = clk_prcmu_unprepare,
+	.is_prepared = clk_prcmu_is_prepared,
 	.enable = clk_prcmu_enable,
 	.disable = clk_prcmu_disable,
 	.is_enabled = clk_prcmu_is_enabled,
@@ -202,6 +224,7 @@ static struct clk_ops clk_prcmu_rate_ops = {
 static struct clk_ops clk_prcmu_opp_gate_ops = {
 	.prepare = clk_prcmu_opp_prepare,
 	.unprepare = clk_prcmu_opp_unprepare,
+	.is_prepared = clk_prcmu_is_prepared,
 	.enable = clk_prcmu_enable,
 	.disable = clk_prcmu_disable,
 	.is_enabled = clk_prcmu_is_enabled,
@@ -211,6 +234,7 @@ static struct clk_ops clk_prcmu_opp_gate_ops = {
 static struct clk_ops clk_prcmu_opp_volt_scalable_ops = {
 	.prepare = clk_prcmu_opp_volt_prepare,
 	.unprepare = clk_prcmu_opp_volt_unprepare,
+	.is_prepared = clk_prcmu_is_prepared,
 	.enable = clk_prcmu_enable,
 	.disable = clk_prcmu_disable,
 	.is_enabled = clk_prcmu_is_enabled,
@@ -242,7 +266,9 @@ static struct clk *clk_reg_prcmu(const char *name,
 	}
 
 	clk->cg_sel = cg_sel;
+	clk->is_prepared = 1;
 	clk->is_enabled = 1;
+	clk->opp_requested = 0;
 	/* "rate" can be used for changing the initial frequency */
 	if (rate)
 		prcmu_set_clock_rate(cg_sel, rate);
-- 
1.7.10
