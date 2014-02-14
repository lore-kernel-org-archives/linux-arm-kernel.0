From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 14 Feb 2014 17:15:00 -0300
Subject: [PATCH 1/4] clk: mvebu: do not copy the contents of clk_corediv_desc
In-Reply-To: <1392408903-31237-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392408903-31237-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392408903-31237-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clk/mvebu/clk-corediv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index 7162615..fb79375 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -31,13 +31,13 @@ struct clk_corediv_desc {
 struct clk_corediv {
 	struct clk_hw hw;
 	void __iomem *reg;
-	struct clk_corediv_desc desc;
+	const struct clk_corediv_desc *desc;
 	spinlock_t lock;
 };
 
 static struct clk_onecell_data clk_data;
 
-static const struct clk_corediv_desc mvebu_corediv_desc[] __initconst = {
+static const struct clk_corediv_desc mvebu_corediv_desc[] = {
 	{ .mask = 0x3f, .offset = 8, .fieldbit = 1 }, /* NAND clock */
 };
 
@@ -46,7 +46,7 @@ static const struct clk_corediv_desc mvebu_corediv_desc[] __initconst = {
 static int clk_corediv_is_enabled(struct clk_hw *hwclk)
 {
 	struct clk_corediv *corediv = to_corediv_clk(hwclk);
-	struct clk_corediv_desc *desc = &corediv->desc;
+	const struct clk_corediv_desc *desc = corediv->desc;
 	u32 enable_mask = BIT(desc->fieldbit) << CORE_CLK_DIV_ENABLE_OFFSET;
 
 	return !!(readl(corediv->reg) & enable_mask);
@@ -55,7 +55,7 @@ static int clk_corediv_is_enabled(struct clk_hw *hwclk)
 static int clk_corediv_enable(struct clk_hw *hwclk)
 {
 	struct clk_corediv *corediv = to_corediv_clk(hwclk);
-	struct clk_corediv_desc *desc = &corediv->desc;
+	const struct clk_corediv_desc *desc = corediv->desc;
 	unsigned long flags = 0;
 	u32 reg;
 
@@ -73,7 +73,7 @@ static int clk_corediv_enable(struct clk_hw *hwclk)
 static void clk_corediv_disable(struct clk_hw *hwclk)
 {
 	struct clk_corediv *corediv = to_corediv_clk(hwclk);
-	struct clk_corediv_desc *desc = &corediv->desc;
+	const struct clk_corediv_desc *desc = corediv->desc;
 	unsigned long flags = 0;
 	u32 reg;
 
@@ -90,7 +90,7 @@ static unsigned long clk_corediv_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
 	struct clk_corediv *corediv = to_corediv_clk(hwclk);
-	struct clk_corediv_desc *desc = &corediv->desc;
+	const struct clk_corediv_desc *desc = corediv->desc;
 	u32 reg, div;
 
 	reg = readl(corediv->reg + CORE_CLK_DIV_RATIO_OFFSET);
@@ -117,7 +117,7 @@ static int clk_corediv_set_rate(struct clk_hw *hwclk, unsigned long rate,
 			    unsigned long parent_rate)
 {
 	struct clk_corediv *corediv = to_corediv_clk(hwclk);
-	struct clk_corediv_desc *desc = &corediv->desc;
+	const struct clk_corediv_desc *desc = corediv->desc;
 	unsigned long flags = 0;
 	u32 reg, div;
 
@@ -202,7 +202,7 @@ static void __init mvebu_corediv_clk_init(struct device_node *node)
 		init.ops = &corediv_ops;
 		init.flags = 0;
 
-		corediv[i].desc = mvebu_corediv_desc[i];
+		corediv[i].desc = mvebu_corediv_desc + i;
 		corediv[i].reg = base;
 		corediv[i].hw.init = &init;
 
-- 
1.8.1.5
