From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 02 Jan 2010 11:20:28 +0000
Subject: [PATCH 03/18] ARM: PNX4008: provide clock enable/disable methods and
	initialization
In-Reply-To: <20100102111849.GA2529@n2100.arm.linux.org.uk>
References: <20100102111849.GA2529@n2100.arm.linux.org.uk>
Message-ID: <12dbb787fbb3361f82c50e1c6d0223f01a90fcd2.1262431163.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pnx4008/clock.c |   35 +++++++++++++++++++++++------------
 arch/arm/mach-pnx4008/clock.h |    4 +++-
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pnx4008/clock.c b/arch/arm/mach-pnx4008/clock.c
index 9cf106e..2714f9f 100644
--- a/arch/arm/mach-pnx4008/clock.c
+++ b/arch/arm/mach-pnx4008/clock.c
@@ -57,18 +57,19 @@ static void propagate_rate(struct clk *clk)
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
+	return 0;
 }
 
 static inline void clk_reg_disable1(struct clk *clk)
@@ -814,7 +815,9 @@ static void local_clk_disable(struct clk *clk)
 		return;
 
 	if (!(--clk->usecount)) {
-		if (!(clk->flags & FIXED_RATE) && clk->rate && clk->set_rate)
+		if (clk->disable)
+			clk->disable(clk);
+		else if (!(clk->flags & FIXED_RATE) && clk->rate && clk->set_rate)
 			clk->set_rate(clk, 0);
 		if (clk->parent)
 			local_clk_disable(clk->parent);
@@ -832,8 +835,10 @@ static int local_clk_enable(struct clk *clk)
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
@@ -961,15 +966,21 @@ static int __init clk_init(void)
 
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
index 933e181..39720d6 100644
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
1.6.2.5
