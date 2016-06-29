From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 21:52:11 +0800
Subject: [PATCH RFC 3/7] clk: add set_parent_hw and set_parent_done
In-Reply-To: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467208335-29876-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce set_parent_hw and set_parent_done to support setting
parent in early kernel booting where we still can't schedule.

Change the input source of this clock hw; This callback
is intended to do the hw part setting of @set_parent work. It
should cooperate with @set_parent_done callback to do the whole
set parent work. The clock core will check @set_parent_done
in either sleep or polling way according to system state to
decide whether the whole set rate work is done.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c            | 26 +++++++++++++++++++++++++-
 include/linux/clk-provider.h | 14 ++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0d031b280c9a..9369dbb71118 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1236,14 +1236,38 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
 	unsigned long flags;
 	int ret = 0;
 	struct clk_core *old_parent;
+	unsigned long timeout;
 
 	old_parent = __clk_set_parent_before(core, parent);
 
 	trace_clk_set_parent(core, parent);
 
 	/* change clock input source */
-	if (parent && core->ops->set_parent)
+	if (parent && core->ops->set_parent) {
 		ret = core->ops->set_parent(core->hw, p_index);
+	} else if (parent && core->ops->set_parent_hw) {
+		ret = core->ops->set_parent_hw(core->hw, p_index);
+		if (!ret && core->ops->set_parent_done) {
+			timeout = jiffies + msecs_to_jiffies(10);
+			while (!core->ops->set_parent_done(core->hw)) {
+				if (time_after(jiffies, timeout)) {
+					pr_err("%s: clock %s set parent timeout\n",
+						__func__, core->name);
+					ret = -ETIMEDOUT;
+					break;
+				}
+				if (system_state == SYSTEM_BOOTING)
+					/*
+					 * Busy loop as we can't
+					 * schedule in early boot
+					 */
+					continue;
+				else
+					usleep_range(core->delay_min,
+						     core->delay_max);
+			}
+		}
+	}
 
 	trace_clk_set_parent_complete(core, parent);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3dcb99ad6bd2..16fa75cdd656 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -146,6 +146,18 @@ struct clk_rate_request {
  *		array index into the value programmed into the hardware.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_parent_hw: Change the input source of this clock hw;  This callback
+ *		is intended to do the hw part setting of @set_parent work. It
+ *		should cooperate with @set_parent_done callback to do the whole
+ *		set parent work. The clock core will check @set_parent_done
+ *		in either sleep or polling way according to system state to
+ *		decide whether the whole set rate work is done. Optional
+ *		if @set_parent is used. This function must not sleep.
+ *
+ * @set_parent_done: Queries the hardware to determine if the set parent is
+ *		done. Optional, if this op is not set then the set parent
+ *		simply return. This function must not sleep.
+ *
  * @get_parent:	Queries the hardware to determine the parent of a clock.  The
  *		return value is a u8 which specifies the index corresponding to
  *		the parent clock.  This index can be applied to either the
@@ -243,6 +255,8 @@ struct clk_ops {
 	int		(*determine_rate)(struct clk_hw *hw,
 					  struct clk_rate_request *req);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
+	int		(*set_parent_hw)(struct clk_hw *hw, u8 index);
+	int		(*set_parent_done)(struct clk_hw *hw);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate);
-- 
1.9.1
