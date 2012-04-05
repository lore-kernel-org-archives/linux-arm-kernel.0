From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 5 Apr 2012 13:43:25 +0530
Subject: [PATCH] clk: clk-gate: Create clk_gate_endisable()
Message-ID: <4ebf23ae95f3c404668583b6c7e2ff1dc186e984.1333613520.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch tries to remove duplicate code for clk_gate clocks. This creates
another routine clk_gate_endisable() which will take care of enable/disable
clock with knowledge of CLK_GATE_SET_TO_DISABLE flag.

It works on following logic:

For enabling clock, enable = 1
	set2dis = 1	-> clear bit	-> set = 0
	set2dis = 0	-> set bit	-> set = 1

For disabling clock, enable = 0
	set2dis = 1	-> set bit	-> set = 1
	set2dis = 0	-> clear bit	-> set = 0

So, result is always: enable xor set2dis.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk-gate.c |   54 ++++++++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index b5902e2..b35eef9 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -28,32 +28,38 @@
 
 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
 
-static void clk_gate_set_bit(struct clk_gate *gate)
+/*
+ * It works on following logic:
+ *
+ * For enabling clock, enable = 1
+ *	set2dis = 1	-> clear bit	-> set = 0
+ *	set2dis = 0	-> set bit	-> set = 1
+ *
+ * For disabling clock, enable = 0
+ *	set2dis = 1	-> set bit	-> set = 1
+ *	set2dis = 0	-> clear bit	-> set = 0
+ *
+ * So, result is always: enable xor set2dis.
+ */
+static void clk_gate_endisable(struct clk_hw *hw, int enable)
 {
-	u32 reg;
+	struct clk_gate *gate = to_clk_gate(hw);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
 	unsigned long flags = 0;
+	u32 reg;
+
+	set ^= enable;
 
 	if (gate->lock)
 		spin_lock_irqsave(gate->lock, flags);
 
 	reg = readl(gate->reg);
-	reg |= BIT(gate->bit_idx);
-	writel(reg, gate->reg);
-
-	if (gate->lock)
-		spin_unlock_irqrestore(gate->lock, flags);
-}
-
-static void clk_gate_clear_bit(struct clk_gate *gate)
-{
-	u32 reg;
-	unsigned long flags = 0;
 
-	if (gate->lock)
-		spin_lock_irqsave(gate->lock, flags);
+	if (set)
+		reg |= BIT(gate->bit_idx);
+	else
+		reg &= ~BIT(gate->bit_idx);
 
-	reg = readl(gate->reg);
-	reg &= ~BIT(gate->bit_idx);
 	writel(reg, gate->reg);
 
 	if (gate->lock)
@@ -62,12 +68,7 @@ static void clk_gate_clear_bit(struct clk_gate *gate)
 
 static int clk_gate_enable(struct clk_hw *hw)
 {
-	struct clk_gate *gate = to_clk_gate(hw);
-
-	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
-		clk_gate_clear_bit(gate);
-	else
-		clk_gate_set_bit(gate);
+	clk_gate_endisable(hw, 1);
 
 	return 0;
 }
@@ -75,12 +76,7 @@ EXPORT_SYMBOL_GPL(clk_gate_enable);
 
 static void clk_gate_disable(struct clk_hw *hw)
 {
-	struct clk_gate *gate = to_clk_gate(hw);
-
-	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
-		clk_gate_set_bit(gate);
-	else
-		clk_gate_clear_bit(gate);
+	clk_gate_endisable(hw, 0);
 }
 EXPORT_SYMBOL_GPL(clk_gate_disable);
 
-- 
1.7.9
