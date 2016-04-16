From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 17 Apr 2016 02:55:06 +0800
Subject: [PATCH 2/2] clk: sunxi: add prediv table for a31 ahb1 clock
In-Reply-To: <1460832906-24064-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1460832906-24064-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1460832906-24064-3-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For ahb1 clock, move mshift and mwidth to parent specific width and shift.
getter differentiates parents with prediv, with non-zero prediv width.

Also, removed unused ahb1 recalc function, it's now handled in generic
factors recalc.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 91de0a0..5a5f26b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -282,8 +282,6 @@ static void sun5i_a13_get_ahb_factors(struct factors_request *req)
 	req->p = div;
 }
 
-#define SUN6I_AHB1_PARENT_PLL6	3
-
 /**
  * sun6i_a31_get_ahb_factors() - calculates m, p factors for AHB
  * AHB rate is calculated as follows
@@ -307,7 +305,7 @@ static void sun6i_get_ahb1_factors(struct factors_request *req)
 	div = DIV_ROUND_UP(req->parent_rate, req->rate);
 
 	/* calculate pre-divider if parent is pll6 */
-	if (req->parent_index == SUN6I_AHB1_PARENT_PLL6) {
+	if (req->prediv_width) {
 		if (div < 4)
 			calcp = 0;
 		else if (div / 2 < 4)
@@ -329,22 +327,6 @@ static void sun6i_get_ahb1_factors(struct factors_request *req)
 }
 
 /**
- * sun6i_ahb1_recalc() - calculates AHB clock rate from m, p factors and
- *			 parent index
- */
-static void sun6i_ahb1_recalc(struct factors_request *req)
-{
-	req->rate = req->parent_rate;
-
-	/* apply pre-divider first if parent is pll6 */
-	if (req->parent_index == SUN6I_AHB1_PARENT_PLL6)
-		req->rate /= req->m + 1;
-
-	/* clk divider */
-	req->rate >>= req->p;
-}
-
-/**
  * sun4i_get_apb1_factors() - calculates m, p factors for APB1
  * APB1 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
@@ -474,12 +456,17 @@ static const struct clk_factors_config sun5i_a13_ahb_config = {
 };
 
 static const struct clk_factors_config sun6i_ahb1_config = {
-	.mshift = 6,
-	.mwidth = 2,
 	.pshift = 4,
 	.pwidth = 2,
 };
 
+static const struct clk_factors_prediv sun6i_ahb1_prediv[] = {
+	{.parent_index = 0, .shift = 0, .width = 0 },	/* LOSC  */
+	{.parent_index = 1, .shift = 0, .width = 0 },	/* OSC24MHz */
+	{.parent_index = 2, .shift = 0, .width = 0 },	/* AXI */
+	{.parent_index = 3, .shift = 6, .width = 2 }	/* PLL6/Pre_div */
+};
+
 static const struct clk_factors_config sun4i_apb1_config = {
 	.mshift = 0,
 	.mwidth = 5,
@@ -551,8 +538,8 @@ static const struct factors_data sun6i_ahb1_data __initconst = {
 	.mux = 12,
 	.muxmask = BIT(1) | BIT(0),
 	.table = &sun6i_ahb1_config,
+	.prediv_table = sun6i_ahb1_prediv,
 	.getter = sun6i_get_ahb1_factors,
-	.recalc = sun6i_ahb1_recalc,
 };
 
 static const struct factors_data sun4i_apb1_data __initconst = {
-- 
1.9.1
