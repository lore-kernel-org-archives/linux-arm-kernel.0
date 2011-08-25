From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 25 Aug 2011 14:17:36 +0100
Subject: [PATCH 04/11] clk: Add simple gated clock
In-Reply-To: <1314191759-16941-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1314191759-16941-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110825131736.GE2838@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Jeremy,

On Wed, Aug 24, 2011 at 02:15:52PM +0100, Mark Brown wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I've just ported my (currently out-of-tree) platform to use the common 
struct clk and it all works nicely (if I add a naive implementation of 
clk_set_parent()).

Our platform has gateable clocks where bits in the control register are 
set to disable the clocks rather than enable them.  I've used the patch 
below to add support for that.

Jamie

8<----

Subject: [PATCH] clk: allow gateable clocks to work with both polarities

Some devices (picoxcell in particular) have gateable clocks where the
control register is a set-to-disable register.  Create a new set of
clock ops that can use struct clk_gate with this register configuration.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/clk/clk-gate.c |   45 +++++++++++++++++++++++++++++++++++++--------
 include/linux/clk.h    |    3 ++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 833e0da..30926e9 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -10,7 +10,7 @@ static unsigned long clk_gate_get_rate(struct clk_hw *clk)
 	return clk_get_rate(clk_get_parent(clk->clk));
 }
 
-static int clk_gate_enable(struct clk_hw *clk)
+static void clk_gate_set_bit(struct clk_hw *clk)
 {
 	struct clk_gate *gate = to_clk_gate(clk);
 	u32 reg;
@@ -18,11 +18,9 @@ static int clk_gate_enable(struct clk_hw *clk)
 	reg = __raw_readl(gate->reg);
 	reg |= 1 << gate->bit_idx;
 	__raw_writel(reg, gate->reg);
-
-	return 0;
 }
 
-static void clk_gate_disable(struct clk_hw *clk)
+static void clk_gate_clear_bit(struct clk_hw *clk)
 {
 	struct clk_gate *gate = to_clk_gate(clk);
 	u32 reg;
@@ -32,10 +30,41 @@ static void clk_gate_disable(struct clk_hw *clk)
 	__raw_writel(reg, gate->reg);
 }
 
-struct clk_hw_ops clk_gate_ops = {
+static int clk_gate_enable_set(struct clk_hw *clk)
+{
+	clk_gate_set_bit(clk);
+
+	return 0;
+}
+
+static void clk_gate_disable_clear(struct clk_hw *clk)
+{
+	clk_gate_clear_bit(clk);
+}
+
+struct clk_hw_ops clk_gate_set_enable_ops = {
+	.recalc_rate = clk_gate_get_rate,
+	.enable = clk_gate_enable_set,
+	.disable = clk_gate_disable_clear,
+};
+EXPORT_SYMBOL_GPL(clk_gate_set_enable_ops);
+
+static int clk_gate_enable_clear(struct clk_hw *clk)
+{
+	clk_gate_clear_bit(clk);
+
+	return 0;
+}
+
+static void clk_gate_disable_set(struct clk_hw *clk)
+{
+	clk_gate_set_bit(clk);
+}
+
+struct clk_hw_ops clk_gate_set_disable_ops = {
 	.recalc_rate = clk_gate_get_rate,
-	.enable = clk_gate_enable,
-	.disable = clk_gate_disable,
+	.enable = clk_gate_enable_clear,
+	.disable = clk_gate_disable_set,
 };
-EXPORT_SYMBOL_GPL(clk_gate_ops);
+EXPORT_SYMBOL_GPL(clk_gate_set_disable_ops);
 
diff --git a/include/linux/clk.h b/include/linux/clk.h
index cb1879b..d30314a 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -132,7 +132,8 @@ struct clk_gate {
 	u8		bit_idx;
 };
 
-extern struct clk_hw_ops clk_gate_ops;
+extern struct clk_hw_ops clk_gate_set_enable_ops;
+extern struct clk_hw_ops clk_gate_set_disable_ops;
 
 #endif /* CONFIG_GENERIC_CLK_GATE */
 
-- 
1.7.4.1
