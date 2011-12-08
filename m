From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 8 Dec 2011 09:28:34 +0800
Subject: [PATCH V2 2/2] ARM: mx51/53: add round_rate for esdhc clocks
In-Reply-To: <1323307714-21290-1-git-send-email-richard.zhao@linaro.org>
References: <1323307714-21290-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323307714-21290-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/clock-mx51-mx53.c |   42 ++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/clock-mx51-mx53.c b/arch/arm/mach-imx/clock-mx51-mx53.c
index 716533b..7df85ba 100644
--- a/arch/arm/mach-imx/clock-mx51-mx53.c
+++ b/arch/arm/mach-imx/clock-mx51-mx53.c
@@ -1013,20 +1013,6 @@ static struct clk mipi_hsp_clk = {
 		.secondary	= s,			\
 	}
 
-#define DEFINE_CLOCK_ESDHC(name, i, er, es, pfx, p, s)	\
-	static struct clk name = {			\
-		.id		= i,			\
-		.enable_reg	= er,			\
-		.enable_shift	= es,			\
-		.get_rate	= pfx##_get_rate,	\
-		.set_rate	= pfx##_set_rate,	\
-		.set_parent	= pfx##_set_parent,	\
-		.enable		= _clk_ccgr_enable,	\
-		.disable	= _clk_ccgr_disable,	\
-		.parent		= p,			\
-		.secondary	= s,			\
-	}
-
 #define CLK_GET_RATE(name, nr, bitsname)				\
 static unsigned long clk_##name##_get_rate(struct clk *clk)		\
 {									\
@@ -1088,6 +1074,25 @@ static int clk_##name##_set_rate(struct clk *clk, unsigned long rate)	\
 	return 0;							\
 }
 
+#define CLK_ROUND_RATE(name , nr, bitsname)				\
+static unsigned long clk_##name##_round_rate(struct clk *clk,		\
+						unsigned long rate)	\
+{									\
+	u32 div, parent_rate;						\
+	u32 pre = 0, post = 0;						\
+									\
+	parent_rate = clk_get_rate(clk->parent);			\
+	div = DIV_ROUND_UP(parent_rate, rate);				\
+									\
+	__calc_pre_post_dividers(div, &pre, &post,			\
+		(MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_MASK >>	\
+		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_OFFSET) + 1,	\
+		(MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_MASK >>	\
+		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_OFFSET) + 1);	\
+									\
+	return parent_rate / pre / post;				\
+}
+
 /* UART */
 CLK_GET_RATE(uart, 1, UART)
 CLK_SET_PARENT(uart, 1, UART)
@@ -1157,11 +1162,13 @@ static struct clk ecspi_main_clk = {
 CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC1)
 CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC1)
 CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC1)
+CLK_ROUND_RATE(esdhc1, 1, ESDHC1_MSHC1)
 
 /* mx51 specific */
 CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
 CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
 CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
+CLK_ROUND_RATE(esdhc2, 1, ESDHC2_MSHC2)
 
 static int clk_esdhc3_set_parent(struct clk *clk, struct clk *parent)
 {
@@ -1215,6 +1222,7 @@ static int clk_esdhc2_mx53_set_parent(struct clk *clk, struct clk *parent)
 CLK_GET_RATE(esdhc3_mx53, 1, ESDHC3_MX53)
 CLK_SET_PARENT(esdhc3_mx53, 1, ESDHC3_MX53)
 CLK_SET_RATE(esdhc3_mx53, 1, ESDHC3_MX53)
+CLK_ROUND_RATE(esdhc3_mx53, 1, ESDHC3_MX53)
 
 static int clk_esdhc4_mx53_set_parent(struct clk *clk, struct clk *parent)
 {
@@ -1342,7 +1350,7 @@ DEFINE_CLOCK(sdma_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG15_OFFSET,
 /* eSDHC */
 DEFINE_CLOCK_FULL(esdhc1_ipg_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG0_OFFSET,
 	NULL,  NULL, _clk_ccgr_enable, _clk_ccgr_disable, &ipg_clk, NULL);
-DEFINE_CLOCK_ESDHC(esdhc1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG1_OFFSET,
+DEFINE_CLOCK_CCGR(esdhc1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG1_OFFSET,
 	clk_esdhc1, &pll2_sw_clk, &esdhc1_ipg_clk);
 DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
 	NULL,  NULL, _clk_ccgr_enable, _clk_ccgr_disable, &ipg_clk, NULL);
@@ -1352,7 +1360,7 @@ DEFINE_CLOCK_FULL(esdhc4_ipg_clk, 3, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG6_OFFSET,
 	NULL,  NULL, _clk_ccgr_enable, _clk_ccgr_disable, &ipg_clk, NULL);
 
 /* mx51 specific */
-DEFINE_CLOCK_ESDHC(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
+DEFINE_CLOCK_CCGR(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
 	clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
 
 static struct clk esdhc3_clk = {
@@ -1388,7 +1396,7 @@ static struct clk esdhc2_mx53_clk = {
 	.secondary = &esdhc3_ipg_clk,
 };
 
-DEFINE_CLOCK_ESDHC(esdhc3_mx53_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG5_OFFSET,
+DEFINE_CLOCK_CCGR(esdhc3_mx53_clk, 2, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG5_OFFSET,
 	clk_esdhc3_mx53, &pll2_sw_clk, &esdhc2_ipg_clk);
 
 static struct clk esdhc4_mx53_clk = {
-- 
1.7.5.4
