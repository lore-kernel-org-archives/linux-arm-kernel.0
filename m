From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 14:23:13 +0200
Subject: [PATCH 4/4] mx51: add resources for SD/MMC on i.MX51
In-Reply-To: <20101012093225.GF29673@pengutronix.d>
References: <20101012093225.GF29673@pengutronix.d>
Message-ID: <1286886193-28960-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the attached patch allows SD to work on i.MX51 with Wolfram's drivers
Tested on i.MX51.

Based on original patch from: Richard Zhu <r65037@freescale.com>
Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/clock-mx51.c    |  104 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx5/devices-imx51.h |    9 +++
 2 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 9a39492..f2aae92 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -41,6 +41,36 @@ static struct clk usboh3_clk;
 
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
+/* calculate best pre and post dividers to get the required divider */
+static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post,
+	u32 max_pre, u32 max_post)
+{
+	if (div >= max_pre * max_post) {
+		*pre = max_pre;
+		*post = max_post;
+	} else if (div >= max_pre) {
+		u32 min_pre, temp_pre, old_err, err;
+		min_pre = DIV_ROUND_UP(div, max_post);
+		old_err = max_pre;
+		for (temp_pre = max_pre; temp_pre >= min_pre; temp_pre--) {
+			err = div % temp_pre;
+			if (err == 0) {
+				*pre = temp_pre;
+				break;
+			}
+			err = temp_pre - err;
+			if (err < old_err) {
+				old_err = err;
+				*pre = temp_pre;
+			}
+		}
+		*post = DIV_ROUND_UP(div, *pre);
+	} else {
+		*pre = div;
+		*post = 1;
+	}
+}
+
 static void _clk_ccgr_setclk(struct clk *clk, unsigned mode)
 {
 	u32 reg = __raw_readl(clk->enable_reg);
@@ -787,6 +817,20 @@ static struct clk emi_slow_clk = {
 		.secondary	= s,			\
 	}
 
+#define DEFINE_CLOCK_MAX(name, i, er, es, pfx, p, s)	\
+	static struct clk name = {			\
+		.id		= i,			\
+		.enable_reg	= er,			\
+		.enable_shift	= es,			\
+		.get_rate	= pfx##_get_rate,	\
+		.set_rate	= pfx##_set_rate,	\
+		.set_parent	= pfx##_set_parent,	\
+		.enable		= _clk_max_enable,	\
+		.disable	= _clk_max_disable,	\
+		.parent		= p,			\
+		.secondary	= s,			\
+	}
+
 #define CLK_GET_RATE(name, nr, bitsname)				\
 static unsigned long clk_##name##_get_rate(struct clk *clk)		\
 {									\
@@ -817,6 +861,37 @@ static int clk_##name##_set_parent(struct clk *clk, struct clk *parent)	\
 	return 0;							\
 }
 
+#define CLK_SET_RATE(name, nr, bitsname)				\
+static int clk_##name##_set_rate(struct clk *clk, unsigned long rate)	\
+{									\
+	u32 reg, div, parent_rate;					\
+	u32 pre = 0, post = 0;						\
+									\
+	parent_rate = clk_get_rate(clk->parent);			\
+	div = parent_rate / rate;					\
+									\
+	if ((parent_rate / div) != rate)				\
+		return -EINVAL;						\
+									\
+	__calc_pre_post_dividers(div, &pre, &post,			\
+		(MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_MASK >>	\
+		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_OFFSET) + 1,	\
+		(MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_MASK >>	\
+		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_OFFSET) + 1);\
+									\
+	/* Set sdhc1 clock divider */					\
+	reg = __raw_readl(MXC_CCM_CSCDR##nr) &				\
+		~(MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_MASK	\
+		| MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_MASK);	\
+	reg |= (post - 1) <<						\
+		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_OFFSET;	\
+	reg |= (pre - 1) <<						\
+		MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_OFFSET;	\
+	__raw_writel(reg, MXC_CCM_CSCDR##nr);				\
+									\
+	return 0;							\
+}
+
 /* UART */
 CLK_GET_RATE(uart, 1, UART)
 CLK_SET_PARENT(uart, 1, UART)
@@ -847,6 +922,15 @@ static struct clk ecspi_main_clk = {
 	.set_parent = clk_ecspi_set_parent,
 };
 
+/* eSDHC */
+CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC1)
+CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC1)
+CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC1)
+
+CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
+CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
+CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
+
 #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
 	static struct clk name = {					\
 		.id		= i,					\
@@ -935,6 +1019,16 @@ DEFINE_CLOCK(cspi_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
 DEFINE_CLOCK(sdma_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG15_OFFSET,
 		NULL, NULL, &ahb_clk, NULL);
 
+/* eSDHC */
+DEFINE_CLOCK_FULL(esdhc1_ipg_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG0_OFFSET,
+	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+DEFINE_CLOCK_MAX(esdhc1_clk, 0, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG1_OFFSET,
+	clk_esdhc1, &pll2_sw_clk, &esdhc1_ipg_clk);
+DEFINE_CLOCK_FULL(esdhc2_ipg_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG2_OFFSET,
+	NULL,  NULL, _clk_max_enable, _clk_max_disable, &ipg_clk, NULL);
+DEFINE_CLOCK_MAX(esdhc2_clk, 1, MXC_CCM_CCGR3, MXC_CCM_CCGRx_CG3_OFFSET,
+	clk_esdhc2, &pll2_sw_clk, &esdhc2_ipg_clk);
+
 #define _REGISTER_CLOCK(d, n, c) \
        { \
 		.dev_id = d, \
@@ -968,6 +1062,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
 	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
 	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
 };
 
 static void clk_tree_init(void)
@@ -1011,6 +1107,14 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
 	/* set the usboh3_clk parent to pll2_sw_clk */
 	clk_set_parent(&usboh3_clk, &pll2_sw_clk);
 
+	/* Set SDHC parents to be PLL2 */
+	clk_set_parent(&esdhc1_clk, &pll2_sw_clk);
+	clk_set_parent(&esdhc2_clk, &pll2_sw_clk);
+
+	/* set SDHC root clock as 166.25MHZ*/
+	clk_set_rate(&esdhc1_clk, 166250000);
+	clk_set_rate(&esdhc2_clk, 166250000);
+
 	/* System timer */
 	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
 		MX51_MXC_INT_GPT);
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index c233379..547432d 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -36,3 +36,12 @@ extern const struct imx_spi_imx_data imx51_cspi_data __initconst;
 extern const struct imx_spi_imx_data imx51_ecspi_data[] __initconst;
 #define imx51_add_ecspi(id, pdata)	\
 	imx_add_spi_imx(&imx51_ecspi_data[id], pdata)
+
+#define imx51_add_esdhc0(pdata)	\
+	imx_add_esdhc(0, MX51_MMC_SDHC1_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC1, pdata)
+#define imx51_add_esdhc1(pdata)	\
+	imx_add_esdhc(1, MX51_MMC_SDHC2_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC2, pdata)
+#define imx51_add_esdhc2(pdata)	\
+	imx_add_esdhc(2, MX51_MMC_SDHC3_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC3, pdata)
+#define imx51_add_esdhc3(pdata)	\
+	imx_add_esdhc(3, MX51_MMC_SDHC4_BASE_ADDR, SZ_16K, MX51_MXC_INT_MMC_SDHC4, pdata)
-- 
1.7.0.4
