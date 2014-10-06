From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  7 Oct 2014 01:07:58 +0200
Subject: [PATCH v1 2/5] clk: pxa: declare init function and data __init
In-Reply-To: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
References: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1412636881-6211-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the clock descriptions are constant and only usefull at init time,
mark them as such by :
 - spliting clock description (desc) and clock private data (dynamic)
 - mark __initdata clock descriptions

This makes all the register and descriptions of the clocks to go after
kernel init phase.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa.c    | 42 +++++++++++++++++++++++++++---------------
 drivers/clk/pxa/clk-pxa.h    |  8 ++++----
 drivers/clk/pxa/clk-pxa27x.c |  2 +-
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index ef3c053..994fd6f 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -26,12 +26,20 @@ static struct clk_onecell_data onecell_data = {
 	.clk_num = CLK_MAX,
 };
 
-#define to_pxa_clk(_hw) container_of(_hw, struct pxa_clk_cken, hw)
+struct pxa_clk {
+	struct clk_hw hw;
+	struct clk_fixed_factor lp;
+	struct clk_fixed_factor hp;
+	struct clk_gate gate;
+	bool (*is_in_low_power)(void);
+};
+
+#define to_pxa_clk(_hw) container_of(_hw, struct pxa_clk, hw)
 
 static unsigned long cken_recalc_rate(struct clk_hw *hw,
 				      unsigned long parent_rate)
 {
-	struct pxa_clk_cken *pclk = to_pxa_clk(hw);
+	struct pxa_clk *pclk = to_pxa_clk(hw);
 	struct clk_fixed_factor *fix;
 
 	if (!pclk->is_in_low_power || pclk->is_in_low_power())
@@ -48,7 +56,7 @@ static struct clk_ops cken_rate_ops = {
 
 static u8 cken_get_parent(struct clk_hw *hw)
 {
-	struct pxa_clk_cken *pclk = to_pxa_clk(hw);
+	struct pxa_clk *pclk = to_pxa_clk(hw);
 
 	if (!pclk->is_in_low_power)
 		return 0;
@@ -69,23 +77,27 @@ void __init clkdev_pxa_register(int ckid, const char *con_id,
 		clk_register_clkdev(clk, con_id, dev_id);
 }
 
-int __init clk_pxa_cken_init(struct pxa_clk_cken *clks, int nb_clks)
+int __init clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks)
 {
 	int i;
-	struct pxa_clk_cken *pclk;
+	struct pxa_clk *pxa_clk;
 	struct clk *clk;
 
 	for (i = 0; i < nb_clks; i++) {
-		pclk = clks + i;
-		pclk->gate.lock = &lock;
-		clk = clk_register_composite(NULL, pclk->name,
-					     pclk->parent_names, 2,
-					     &pclk->hw, &cken_mux_ops,
-					     &pclk->hw, &cken_rate_ops,
-					     &pclk->gate.hw, &clk_gate_ops,
-					     pclk->flags);
-		clkdev_pxa_register(pclk->ckid, pclk->con_id, pclk->dev_id,
-				    clk);
+		pxa_clk = kzalloc(sizeof(*pxa_clk), GFP_KERNEL);
+		pxa_clk->is_in_low_power = clks[i].is_in_low_power;
+		pxa_clk->lp = clks[i].lp;
+		pxa_clk->hp = clks[i].hp;
+		pxa_clk->gate = clks[i].gate;
+		pxa_clk->gate.lock = &lock;
+		clk = clk_register_composite(NULL, clks[i].name,
+					     clks[i].parent_names, 2,
+					     &pxa_clk->hw, &cken_mux_ops,
+					     &pxa_clk->hw, &cken_rate_ops,
+					     &pxa_clk->gate.hw, &clk_gate_ops,
+					     clks[i].flags);
+		clkdev_pxa_register(clks[i].ckid, clks[i].con_id,
+				    clks[i].dev_id, clk);
 	}
 	return 0;
 }
diff --git a/drivers/clk/pxa/clk-pxa.h b/drivers/clk/pxa/clk-pxa.h
index 5fe219d..7b8d48e 100644
--- a/drivers/clk/pxa/clk-pxa.h
+++ b/drivers/clk/pxa/clk-pxa.h
@@ -25,7 +25,7 @@
 	static struct clk_ops name ## _rate_ops = {		\
 		.recalc_rate = name ## _get_rate,		\
 	};							\
-	static struct clk *clk_register_ ## name(void)		\
+	static struct clk * __init clk_register_ ## name(void)	\
 	{							\
 		return clk_register_composite(NULL, clk_name,	\
 			name ## _parents,			\
@@ -40,7 +40,7 @@
 	static struct clk_ops name ## _rate_ops = {		\
 		.recalc_rate = name ## _get_rate,		\
 	};							\
-	static struct clk *clk_register_ ## name(void)		\
+	static struct clk * __init clk_register_ ## name(void)	\
 	{							\
 		return clk_register_composite(NULL, clk_name,	\
 			name ## _parents,			\
@@ -66,7 +66,7 @@
  *  |    Clock   | --- | / div_hp  |
  *  +------------+     +-----------+
  */
-struct pxa_clk_cken {
+struct desc_clk_cken {
 	struct clk_hw hw;
 	int ckid;
 	const char *name;
@@ -102,6 +102,6 @@ static int dummy_clk_set_parent(struct clk_hw *hw, u8 index)
 
 extern void clkdev_pxa_register(int ckid, const char *con_id,
 				const char *dev_id, struct clk *clk);
-extern int clk_pxa_cken_init(struct pxa_clk_cken *clks, int nb_clks);
+extern int clk_pxa_cken_init(const struct desc_clk_cken *clks, int nb_clks);
 
 #endif
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 88b9fe1..32d3e02 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -111,7 +111,7 @@ PARENTS(pxa27x_membus) = { "lcd_base", "lcd_base" };
 	PXA_CKEN_1RATE(dev_id, con_id, bit, parents,			\
 		       &CKEN, CKEN_ ## bit, CLK_IGNORE_UNUSED)
 
-static struct pxa_clk_cken pxa27x_clocks[] = {
+static struct desc_clk_cken pxa27x_clocks[] __initdata = {
 	PXA27X_PBUS_CKEN("pxa2xx-uart.0", NULL, FFUART, 2, 42, 1),
 	PXA27X_PBUS_CKEN("pxa2xx-uart.1", NULL, BTUART, 2, 42, 1),
 	PXA27X_PBUS_CKEN("pxa2xx-uart.2", NULL, STUART, 2, 42, 1),
-- 
2.1.0
