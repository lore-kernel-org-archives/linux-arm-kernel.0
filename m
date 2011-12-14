From: mturquette@ti.com (Mike Turquette)
Date: Tue, 13 Dec 2011 20:31:24 -0800
Subject: [PATCH 2/6] omap: clk: .round_rate for propagating to parents
In-Reply-To: <1323837088-2469-1-git-send-email-mturquette@ti.com>
References: <1323837088-2469-1-git-send-email-mturquette@ti.com>
Message-ID: <1323837088-2469-3-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces omap2_passthrough_round_rate which is a new
.round_rate that works with the generic struct clk_ops defined in
include/linux/clk.h.

The purpose of this .round_rate is to allow an OMAP clk to make no
changes to its own dividers (if applicable) and instead defer the rate
change up to the clk's parent.

Not-signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clkt_clksel.c |    8 ++++++++
 arch/arm/mach-omap2/clock.h       |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index ad3befb..0f151ce 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -438,6 +438,14 @@ long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
 	return omap2_clksel_round_rate_div(oclk, target_rate, &new_div);
 }
 
+long omap2_passthrough_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate)
+{
+	*parent_rate = target_rate;
+
+	return clk->rate;
+}
+
 /**
  * omap2_clksel_set_rate() - program clock rate in hardware
  * @clk: struct clk * to program rate
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e03060e..05f8a00 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -86,6 +86,8 @@ struct clk *omap2_init_clksel_parent(struct clk *clk);
 unsigned long omap2_clksel_recalc(struct clk *clk);
 long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate,
 		unsigned long *parent_rate);
+long omap2_passthrough_round_rate(struct clk *clk, unsigned long target_rate,
+		unsigned long *parent_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 int omap2_clksel_set_parent(struct clk *clk, struct clk *new_parent);
 
-- 
1.7.5.4
