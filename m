From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 22 Dec 2009 00:21:56 +0100
Subject: [PATCH 3/10] ARM: PNX4008: provide clock enable/disable methods and
	initialization
Message-ID: <083DF309106F364B939360100EC290F804F592E903@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-pnx4008/clock.c |   36 ++++++++++++++++++++++++------------
 arch/arm/mach-pnx4008/clock.h |    4 +++-
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index b1380f1..2c58342 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -57,18 +57,20 @@ static void propagate_rate(struct clk *clk)
 	}
 }
 
-static inline void clk_reg_disable(struct clk *clk)
+static void clk_reg_disable(struct clk *clk)
 {
 	if (clk->enable_reg)
 		__raw_writel(__raw_readl(clk->enable_reg) &
 			     ~(1 << clk->enable_shift), clk->enable_reg);
 }
 
-static inline void clk_reg_enable(struct clk *clk)
+static int clk_reg_enable(struct clk *clk)
 {
 	if (clk->enable_reg)
 		__raw_writel(__raw_readl(clk->enable_reg) |
 			     (1 << clk->enable_shift), clk->enable_reg);
+
+	return 0;
 }
 
 static inline void clk_reg_disable1(struct clk *clk)
@@ -814,7 +816,9 @@ static void local_clk_disable(struct clk *clk)
 		return;
 
 	if (!(--clk->usecount)) {
-		if (!(clk->flags & FIXED_RATE) && clk->rate && clk->set_rate)
+		if (clk->disable)
+			clk->disable(clk);
+		else if (!(clk->flags & FIXED_RATE) && clk->rate && clk->set_rate)
 			clk->set_rate(clk, 0);
 
 		if (clk->parent)
@@ -833,8 +837,10 @@ static int local_clk_enable(struct clk *clk)
 				goto out;
 		}
 
-		if (!(clk->flags & FIXED_RATE) && !clk->rate && clk->set_rate
-		    && clk->user_rate)
+		if (clk->enable)
+			ret = clk->enable(clk);
+		else if (!(clk->flags & FIXED_RATE) && !clk->rate && clk->set_rate
+			    && clk->user_rate)
 			ret = clk->set_rate(clk, clk->user_rate);
 
 		if (ret != 0 && clk->parent) {
@@ -962,15 +968,21 @@ static int __init clk_init(void)
 
 	for (clkp = onchip_clks; clkp < onchip_clks + ARRAY_SIZE(onchip_clks);
 	     clkp++) {
-		if (((*clkp)->flags & NEEDS_INITIALIZATION)
-		    && ((*clkp)->set_rate)) {
-			(*clkp)->user_rate = (*clkp)->rate;
-			local_set_rate((*clkp), (*clkp)->user_rate);
-			if ((*clkp)->set_parent)
-				(*clkp)->set_parent((*clkp), (*clkp)->parent);
+		struct clk *clk = *clkp;
+		if (clk->flags & NEEDS_INITIALIZATION) {
+			if (clk->set_rate) {
+				clk->user_rate = clk->rate;
+				local_set_rate(clk, clk->user_rate);
+				if (clk->set_parent)
+					clk->set_parent(clk, clk->parent);
+			}
+			if (clk->enable && clk->usecount)
+				clk->enable(clk);
+			if (clk->disable && !clk->usecount)
+				clk->disable(clk);
 		}
 		pr_debug("%s: clock %s, rate %ld\n",
-			__func__, (*clkp)->name, (*clkp)->rate);
+			__func__, clk->name, clk->rate);
 	}
 
 	local_clk_enable(&ck_pll4);
diff --git a/arch/arm/mach-pnx4008/clock.h b/arch/arm/mach-pnx4008/clock.h
index 933e181..f299921 100644
--- a/arch/arm/mach-pnx4008/clock.h
+++ b/arch/arm/mach-pnx4008/clock.h
@@ -27,9 +27,11 @@ struct clk {
 	u8 enable_shift1;
 	u32 enable_reg1;
 	u32 parent_switch_reg;
-	 u32(*round_rate) (struct clk *, u32);
+	u32(*round_rate) (struct clk *, u32);
 	int (*set_rate) (struct clk *, u32);
 	int (*set_parent) (struct clk * clk, struct clk * parent);
+	int (*enable)(struct clk *);
+	void (*disable)(struct clk *);
 };
 
 /* Flags */
-- 
1.6.0.6
