From: dianders@chromium.org (Doug Anderson)
Date: Fri,  7 Nov 2014 10:51:52 -0800
Subject: [PATCH] clk: Propagate prepare and enable when reparenting orphans
Message-ID: <1415386312-23741-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 drivers/clk/clk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4896ae9..a3d3d58 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1650,6 +1650,17 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
 	clk_reparent(clk, new_parent);
 	__clk_recalc_accuracies(clk);
 	__clk_recalc_rates(clk, POST_RATE_CHANGE);
+
+	if (clk->prepare_count) {
+		unsigned long flags;
+
+		__clk_prepare(new_parent);
+
+		flags = clk_enable_lock();
+		if (clk->enable_count)
+			__clk_enable(new_parent);
+		clk_enable_unlock(flags);
+	}
 }
 
 /**
-- 
2.1.0.rc2.206.gedb03e5
