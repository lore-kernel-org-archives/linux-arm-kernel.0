From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Apr 2015 17:34:10 +0200
Subject: [PATCH 1/4] clk: Propagate prepare and enable when reparenting orphans
In-Reply-To: <1427988853-9549-1-git-send-email-heiko@sntech.de>
References: <1427988853-9549-1-git-send-email-heiko@sntech.de>
Message-ID: <1427988853-9549-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

With the existing code, if you find a parent for an orhpan that has
already been prepared / enabled, you won't enable the parent.  That
can cause later problems since the clock tree isn't in a consistent
state.  Fix by propagating the prepare and enable.

NOTE: this does bring up the question about whether the enable of the
orphan actually made sense.  If the orphan's parent wasn't enabled by
default (by the bootloader or the default state of the hardware) then
the original enable of the orphan probably didn't do what the caller
though it would.  Some users of the orphan might have preferred an
EPROBE_DEFER be returned until we had a full path to a root clock.
This patch doesn't address those concerns and really just syncs up the
state.

Tested on rk3288-evb-rk808 by temporarily considering "sclk_tsadc" as
a critical clock (to simulate a driver enabling it at bootup).

Before:

   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 xin32k                                   0            0       32768          0 0
    sclk_hdmi_cec                         0            0       32768          0 0
    sclk_otg_adp                          0            0       32768          0 0
    sclk_tsadc                            1            1         993          0 0

After:

   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
----------------------------------------------------------------------------------------
 xin32k                                   1            1       32768          0 0
    sclk_hdmi_cec                         0            0       32768          0 0
    sclk_otg_adp                          0            0       32768          0 0
    sclk_tsadc                            1            1         993          0 0

Note that xin32k on rk808 is a clock that cannot be disabled in
hardware (it's an always on clock), so really all we needed to do was
to sync up the state.

Signed-off-by: Doug Anderson <dianders@chromium.org>

Adapted to recent clk->clk_core changes and move orphan handling to
a separate function as the main clk_core_reparent function is already
also used in other contexts.
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/clk.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f85c8e2..512323f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2011,6 +2011,27 @@ static void clk_core_reparent(struct clk_core *clk,
 	__clk_recalc_rates(clk, POST_RATE_CHANGE);
 }
 
+static void clk_core_reparent_orphan(struct clk_core *clk,
+				     struct clk_core *new_parent)
+{
+	clk_core_reparent(clk, new_parent);
+
+	if (clk->prepare_count) {
+		unsigned long flags;
+
+		if (clk_core_prepare(new_parent)) {
+			pr_err("%s: could not prepare new parent %s\n",
+			       __func__, clk->name);
+			return;
+		}
+
+		flags = clk_enable_lock();
+		if (clk->enable_count)
+			clk_core_enable(new_parent);
+		clk_enable_unlock(flags);
+	}
+}
+
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
 {
 	if (!hw)
@@ -2404,13 +2425,13 @@ static int __clk_init(struct device *dev, struct clk *clk_user)
 		if (orphan->num_parents && orphan->ops->get_parent) {
 			i = orphan->ops->get_parent(orphan->hw);
 			if (!strcmp(clk->name, orphan->parent_names[i]))
-				clk_core_reparent(orphan, clk);
+				clk_core_reparent_orphan(orphan, clk);
 			continue;
 		}
 
 		for (i = 0; i < orphan->num_parents; i++)
 			if (!strcmp(clk->name, orphan->parent_names[i])) {
-				clk_core_reparent(orphan, clk);
+				clk_core_reparent_orphan(orphan, clk);
 				break;
 			}
 	 }
-- 
2.1.4
