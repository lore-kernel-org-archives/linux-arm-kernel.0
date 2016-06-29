From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 21:52:10 +0800
Subject: [PATCH RFC 2/7] clk: add set_rate_hw and set_rate_done
In-Reply-To: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467208335-29876-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce set_rate_hw and set_rate_done to support setting rate
in early kernel booting where we still can't schedule.

Change the rate of this clock hw. This callback is intended
to do the hw part setting of @set_rate work. It should
cooperate with @set_rate_done callback to do the whole
set rate work. The clock core will check @set_rate_done in
either sleep or polling way according to system state to
decide whether the whole set rate work is done.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c            | 32 ++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h | 15 +++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7dcb34c75a9f..0d031b280c9a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1471,8 +1471,10 @@ static void clk_change_rate(struct clk_core *core)
 	struct hlist_node *tmp;
 	unsigned long old_rate;
 	unsigned long best_parent_rate = 0;
+	unsigned long timeout;
 	bool skip_set_rate = false;
 	struct clk_core *old_parent;
+	int ret;
 
 	old_rate = core->rate;
 
@@ -1509,8 +1511,34 @@ static void clk_change_rate(struct clk_core *core)
 
 	trace_clk_set_rate(core, core->new_rate);
 
-	if (!skip_set_rate && core->ops->set_rate)
-		core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
+	if (!skip_set_rate) {
+		if (core->ops->set_rate) {
+			core->ops->set_rate(core->hw, core->new_rate,
+					    best_parent_rate);
+		} else if (core->ops->set_rate_hw) {
+			ret = core->ops->set_rate_hw(core->hw, core->new_rate,
+						     best_parent_rate);
+			if (!ret && core->ops->set_rate_done) {
+				timeout = jiffies + msecs_to_jiffies(10);
+				while (!core->ops->set_rate_done(core->hw)) {
+					if (time_after(jiffies, timeout)) {
+						pr_err("%s: clock %s set rate timeout\n",
+							__func__, core->name);
+						break;
+					}
+					if (system_state == SYSTEM_BOOTING)
+						/*
+						 * Busy loop as we can't
+						 * schedule in early boot
+						 */
+						continue;
+					else
+						usleep_range(core->delay_min,
+							     core->delay_max);
+				}
+			}
+		}
+	}
 
 	trace_clk_set_rate_complete(core, core->new_rate);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b37174360f1c..3dcb99ad6bd2 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -162,6 +162,18 @@ struct clk_rate_request {
  *		which is likely helpful for most .set_rate implementation.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_rate_hw: Change the rate of this clock hw. This callback is intended
+ *		to do the hw part setting of @set_rate work. It should
+ *		cooperate with @set_rate_done callback to do the whole
+ *		set rate work. The clock core will check @set_rate_done in
+ *		either sleep or polling way according to system state to
+ *		decide whether the whole set rate work is done. Optional
+ *		if @set_rate is used. This function must not sleep.
+ *
+ * @set_rate_done: Queries the hardware to determine if the clock hw is
+ *		prepared. Optional, if this op is not set then the set rate
+ *		simply return. This function must not sleep.
+ *
  * @set_rate_and_parent: Change the rate and the parent of this clock. The
  *		requested rate is specified by the second argument, which
  *		should typically be the return of .round_rate call.  The
@@ -234,6 +246,9 @@ struct clk_ops {
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate);
+	int		(*set_rate_hw)(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate);
+	int		(*set_rate_done)(struct clk_hw *hw);
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
 				    unsigned long rate,
 				    unsigned long parent_rate, u8 index);
-- 
1.9.1
