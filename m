From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 31 Aug 2012 14:21:29 +0200
Subject: [PATCH 2/4] clk: ux500: Support for prmcu_rate clock
In-Reply-To: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
References: <1346415691-13371-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1346415691-13371-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The prmcu_rate clock is not gateable and has a rate which
only can be fetched.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/clk-prcmu.c |   14 ++++++++++++++
 drivers/clk/ux500/clk.h       |    5 +++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index 1d779ad..930cdfe 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -153,6 +153,11 @@ static struct clk_ops clk_prcmu_gate_ops = {
 	.recalc_rate = clk_prcmu_recalc_rate,
 };
 
+static struct clk_ops clk_prcmu_rate_ops = {
+	.is_enabled = clk_prcmu_is_enabled,
+	.recalc_rate = clk_prcmu_recalc_rate,
+};
+
 static struct clk_ops clk_prcmu_opp_gate_ops = {
 	.prepare = clk_prcmu_opp_prepare,
 	.unprepare = clk_prcmu_opp_unprepare,
@@ -228,6 +233,15 @@ struct clk *clk_reg_prcmu_gate(const char *name,
 			&clk_prcmu_gate_ops);
 }
 
+struct clk *clk_reg_prcmu_rate(const char *name,
+			       const char *parent_name,
+			       u8 cg_sel,
+			       unsigned long flags)
+{
+	return clk_reg_prcmu(name, parent_name, cg_sel, 0, flags,
+			&clk_prcmu_rate_ops);
+}
+
 struct clk *clk_reg_prcmu_opp_gate(const char *name,
 				   const char *parent_name,
 				   u8 cg_sel,
diff --git a/drivers/clk/ux500/clk.h b/drivers/clk/ux500/clk.h
index 32085aa..836d7d1 100644
--- a/drivers/clk/ux500/clk.h
+++ b/drivers/clk/ux500/clk.h
@@ -35,6 +35,11 @@ struct clk *clk_reg_prcmu_gate(const char *name,
 			       u8 cg_sel,
 			       unsigned long flags);
 
+struct clk *clk_reg_prcmu_rate(const char *name,
+			       const char *parent_name,
+			       u8 cg_sel,
+			       unsigned long flags);
+
 struct clk *clk_reg_prcmu_opp_gate(const char *name,
 				   const char *parent_name,
 				   u8 cg_sel,
-- 
1.7.10
