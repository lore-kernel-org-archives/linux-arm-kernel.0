From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 20 Apr 2016 17:34:35 +0800
Subject: [RESEND PATCH 3/8] clk: core: support clocks which requires parents
 on (part 1)
In-Reply-To: <1461144880-8724-1-git-send-email-aisheng.dong@nxp.com>
References: <1461144880-8724-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1461144880-8724-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freescale i.MX7D platform, all clocks operations, including
enable/disable, rate change and re-parent, requires its parent
clock on. Current clock core can not support it well.
This patch introduce a new flag CLK_OPS_PARENT_ON to handle this
special case in clock core that enable its parent clock firstly for
each operation and disable it later after operation complete.

The patch part 1 fixes the possible disabling clocks while its parent
is off during kernel booting phase in clk_disable_unused_subtree().

Before the completion of kernel booting, clock tree is still not built
completely, there may be a case that the child clock is on but its
parent is off which could be caused by either HW initial reset state
or bootloader initialization.

Taking bootloader as an example, we may enable all clocks in HW by default.
And during kernel booting time, the parent clock could be disabled in its
driver probe due to calling clk_prepare_enable and clk_disable_unprepare.
Because it's child clock is only enabled in HW while its SW usecount
in clock tree is still 0, so clk_disable of parent clock will gate
the parent clock in both HW and SW usecount ultimately. Then there will
be a child clock is still on in HW but its parent is already off.

Later in clk_disable_unused(), this clock disable accessing while its
parent off will cause system hang due to the limitation of HW which
must require its parent on.

This patch simply enables the parent clock first before disabling
if flag CLK_OPS_PARENT_ON is set in clk_disable_unused_subtree().
This is a simple solution and only affects booting time.

After kernel booting up the clock tree is already created, there will
be no case that child is off but its parent is off.
So no need do this checking for normal clk_disable() later.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk.c            | 5 +++++
 include/linux/clk-provider.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9f944d4..1f054d1a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -765,6 +765,9 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_disable_unused_subtree(child);
 
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_prepare_enable(core->parent);
+
 	flags = clk_enable_lock();
 
 	if (core->enable_count)
@@ -789,6 +792,8 @@ static void clk_disable_unused_subtree(struct clk_core *core)
 
 unlock_out:
 	clk_enable_unlock(flags);
+	if (core->flags & CLK_OPS_PARENT_ON)
+		clk_core_disable_unprepare(core->parent);
 }
 
 static bool clk_ignore_unused;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 15628644..c878f9c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -33,6 +33,8 @@
 #define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
 #define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
 #define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
+/* parents need on during gate/ungate, set rate and re-parent */
+#define CLK_OPS_PARENT_ON	BIT(12)
 
 struct clk;
 struct clk_hw;
-- 
1.9.1
