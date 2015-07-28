From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 28 Jul 2015 21:19:44 +0800
Subject: [PATCH V3 4/5] clk: core: add CLK_OPS_PARENT_ON flags to support
 clocks require parent on
In-Reply-To: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
References: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1438089585-30103-5-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freescale i.MX7D platform, all clocks operations, including
enable/disable, rate change and re-parent, requires its parent
clock on. Current clock core can not support it well.
This patch introduce a new flag CLK_OPS_PARENT_ON to handle this
special case in clock core that enable its parent clock firstly for
each operation and disable it later after operation complete.

This patch fixes disaling clocks while its parent is off.
This is a special case that is caused by a state mis-align between
HW and SW in clock tree during booting.
Usually in uboot, we may enable all clocks in HW by default.
And during kernel booting time, the parent clock could be disabled in its
driver probe due to calling clk_prepare_enable and clk_disable_unprepare.
Because it's child clock is only enabled in HW while its SW usecount
in clock tree is still 0, so clk_disable of parent clock will gate
the parent clock in both HW and SW usecount ultimately.
Then there will be a clock is on in HW while its parent is disabled.

Later when clock core does clk_disable_unused, this clock disable
will cause system hang due to the limitation of operation requiring
its parent clock on.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/clk/clk.c            | 5 +++++
 include/linux/clk-provider.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ac158c4..cf31dc4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -754,6 +754,9 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_disable_unused_subtree(child);
 
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_prepare_enable(core->parent);
+
 	flags = clk_enable_lock();
 
 	if (core->enable_count)
@@ -778,6 +781,8 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 
 unlock_out:
 	clk_enable_unlock(flags);
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_disable_unprepare(core->parent);
 }
 
 static bool clk_ignore_unused;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 06a56e5..006fafb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -31,6 +31,11 @@
 #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
 #define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
 #define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
+/*
+ * parent clock must be on across any operation including
+ * clock gate/ungate, rate change and re-parent
+ */
+#define CLK_OPS_PARENT_ON	BIT(10)
 
 struct clk;
 struct clk_hw;
-- 
1.9.1
