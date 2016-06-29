From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 21:52:09 +0800
Subject: [PATCH RFC 1/7] clk: add prepare_hw and prepare_done support
In-Reply-To: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467208335-29876-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce prepare_hw and prepare_done to support calling
clk_prepare_enable in early kernel booting where we still
can't schedule.

The prepare_hw callback is intended to do the hw part
initialization of prepare work. It should cooperate with
prepare_done callback to do the whole prepare work.
The clock core will check @prepare_done in sleep or
polling way according to system state to decide whether the
whole prepare work is done.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c            | 57 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h | 32 +++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d584004f7af7..7dcb34c75a9f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -60,6 +61,8 @@ struct clk_core {
 	bool			orphan;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
+	unsigned long		delay_min;
+	unsigned long		delay_max;
 	unsigned long		min_rate;
 	unsigned long		max_rate;
 	unsigned long		accuracy;
@@ -566,6 +569,8 @@ EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest);
 
 static void clk_core_unprepare(struct clk_core *core)
 {
+	unsigned long timeout;
+
 	lockdep_assert_held(&prepare_lock);
 
 	if (!core)
@@ -584,8 +589,30 @@ static void clk_core_unprepare(struct clk_core *core)
 
 	trace_clk_unprepare(core);
 
-	if (core->ops->unprepare)
+	if (core->ops->unprepare) {
 		core->ops->unprepare(core->hw);
+	} else if (core->ops->unprepare_hw) {
+		core->ops->unprepare_hw(core->hw);
+		if (core->ops->unprepare_done) {
+			timeout = jiffies + msecs_to_jiffies(10);
+			while (!core->ops->unprepare_done(core->hw)) {
+				if (time_after(jiffies, timeout)) {
+					pr_err("%s: clock %s unprepare timeout\n",
+						__func__, core->name);
+					break;
+				}
+				if (system_state == SYSTEM_BOOTING)
+					/*
+					 * Busy loop as we can't schedule in
+					 * early boot
+					 */
+					continue;
+				else
+					usleep_range(core->delay_min,
+						     core->delay_max);
+			}
+		}
+	}
 
 	trace_clk_unprepare_complete(core);
 	clk_core_unprepare(core->parent);
@@ -615,6 +642,7 @@ EXPORT_SYMBOL_GPL(clk_unprepare);
 
 static int clk_core_prepare(struct clk_core *core)
 {
+	unsigned long timeout;
 	int ret = 0;
 
 	lockdep_assert_held(&prepare_lock);
@@ -629,8 +657,31 @@ static int clk_core_prepare(struct clk_core *core)
 
 		trace_clk_prepare(core);
 
-		if (core->ops->prepare)
+		if (core->ops->prepare) {
 			ret = core->ops->prepare(core->hw);
+		} else if (core->ops->prepare_hw) {
+			ret = core->ops->prepare_hw(core->hw);
+			if (!ret && core->ops->prepare_done) {
+				timeout = jiffies + msecs_to_jiffies(10);
+				while (!core->ops->prepare_done(core->hw)) {
+					if (time_after(jiffies, timeout)) {
+						pr_err("%s: clock %s prepare timeout\n",
+							__func__, core->name);
+						ret = -ETIMEDOUT;
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
 
 		trace_clk_prepare_complete(core);
 
@@ -2490,6 +2541,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	core->hw = hw;
 	core->flags = hw->init->flags;
 	core->num_parents = hw->init->num_parents;
+	core->delay_min = hw->init->delay_min;
+	core->delay_max = hw->init->delay_max;
 	core->min_rate = 0;
 	core->max_rate = ULONG_MAX;
 	hw->core = core;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index fb39d5add173..b37174360f1c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -72,10 +72,34 @@ struct clk_rate_request {
  *		do any initialisation that may sleep. Called with
  *		prepare_lock held.
  *
+ * @prepare_hw:	Prepare the clock hw for enabling. This callback is intended
+ *		to do the hw part initialization of prepare work. It should
+ *		cooperate with @prepare_done callback to do the whole prepare
+ *		work. The clock core will check @prepare_done in sleep or
+ *		polling way according to system state to decide whether the
+ *		whole prepare work is done. Optional if @prepare is used.
+ *		This function must not sleep.
+ *
+ * @prepare_done: Queries the hardware to determine if the clock hw is prepared.
+ *		Optional, if this op is not set then the prepare simply return.
+ *		This function must not sleep.
+ *
  * @unprepare:	Release the clock from its prepared state. This will typically
  *		undo any work done in the @prepare callback. Called with
  *		prepare_lock held.
  *
+ * @unprepare_hw: Release the clock from its prepared hw state. This will
+ *		typically undo any work done in the @prepare_hw callback.
+ *		It should cooperate with @unprepare_done callback to
+ *		do the whole unprepare work. The clock core will check
+ *		@unprepare_done in either sleep or polling way according to
+ *		system state to decide whether the whole unprepare work is done.
+ *		Optional if @prepare is used. This function must not sleep.
+ *
+ * @unprepare_done: Queries the hardware to determine if the clock hw
+ *		is unprepared. Optional, if this op is not set then the
+ *		unprepare simply return. This function must not sleep.
+ *
  * @is_prepared: Queries the hardware to determine if the clock is prepared.
  *		This function is allowed to sleep. Optional, if this op is not
  *		set then the prepare count will be used.
@@ -189,7 +213,11 @@ struct clk_rate_request {
  */
 struct clk_ops {
 	int		(*prepare)(struct clk_hw *hw);
+	int		(*prepare_hw)(struct clk_hw *hw);
+	int		(*prepare_done)(struct clk_hw *hw);
 	void		(*unprepare)(struct clk_hw *hw);
+	void		(*unprepare_hw)(struct clk_hw *hw);
+	int		(*unprepare_done)(struct clk_hw *hw);
 	int		(*is_prepared)(struct clk_hw *hw);
 	void		(*unprepare_unused)(struct clk_hw *hw);
 	int		(*enable)(struct clk_hw *hw);
@@ -226,6 +254,8 @@ struct clk_ops {
  * @parent_names: array of string names for all possible parents
  * @num_parents: number of possible parents
  * @flags: framework-level hints and quirks
+ * @delay_min: min delays in us for clock hw prepare
+ * @delay_max: max delays in us for clock hw prepare
  */
 struct clk_init_data {
 	const char		*name;
@@ -233,6 +263,8 @@ struct clk_init_data {
 	const char		* const *parent_names;
 	u8			num_parents;
 	unsigned long		flags;
+	unsigned int		delay_min;
+	unsigned int		delay_max;
 };
 
 /**
-- 
1.9.1
