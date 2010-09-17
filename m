From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:31 +0200
Subject: [PATCH 13/16] ARM: mx5/clock-mx51: add spi clocks
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-13-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Wang <jason77.wang@gmail.com>

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51.c |   57 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 0e39698..68aef2d 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -764,6 +764,42 @@ static struct clk kpp_clk = {
 	.id = 0,
 };
 
+/* eCSPI */
+static unsigned long clk_ecspi_get_rate(struct clk *clk)
+{
+	u32 reg, pred, podf;
+
+	reg = __raw_readl(MXC_CCM_CSCDR2);
+
+	pred = (reg & MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK) >>
+			MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET;
+	podf = (reg & MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK) >>
+			MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET;
+
+	return DIV_ROUND_CLOSEST(clk_get_rate(clk->parent),
+			(pred + 1) * (podf + 1));
+}
+
+static int clk_ecspi_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 reg, mux;
+
+	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
+			&lp_apm_clk);
+
+	reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_CSPI_CLK_SEL_MASK;
+	reg |= mux << MXC_CCM_CSCMR1_CSPI_CLK_SEL_OFFSET;
+	__raw_writel(reg, MXC_CCM_CSCMR1);
+
+	return 0;
+}
+
+static struct clk ecspi_main_clk = {
+	.parent = &pll3_sw_clk,
+	.get_rate = clk_ecspi_get_rate,
+	.set_parent = clk_ecspi_set_parent,
+};
+
 #define DEFINE_CLOCK_FULL(name, i, er, es, gr, sr, e, d, p, s)		\
 	static struct clk name = {					\
 		.id		= i,					\
@@ -816,6 +852,24 @@ DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
 DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
 	NULL,  NULL, &ipg_clk, NULL);
 
+/* eCSPI */
+DEFINE_CLOCK_FULL(ecspi1_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
+		NULL, NULL, _clk_ccgr_enable_inrun, _clk_ccgr_disable,
+		&ipg_clk, &spba_clk);
+DEFINE_CLOCK(ecspi1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG10_OFFSET,
+		NULL, NULL, &ecspi_main_clk, &ecspi1_ipg_clk);
+DEFINE_CLOCK_FULL(ecspi2_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG11_OFFSET,
+		NULL, NULL, _clk_ccgr_enable_inrun, _clk_ccgr_disable,
+		&ipg_clk, &aips_tz2_clk);
+DEFINE_CLOCK(ecspi2_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG12_OFFSET,
+		NULL, NULL, &ecspi_main_clk, &ecspi2_ipg_clk);
+
+/* CSPI */
+DEFINE_CLOCK(cspi_ipg_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG9_OFFSET,
+		NULL, NULL, &ipg_clk, &aips_tz2_clk);
+DEFINE_CLOCK(cspi_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
+		NULL, NULL, &ipg_clk, &cspi_ipg_clk);
+
 #define _REGISTER_CLOCK(d, n, c) \
        { \
 		.dev_id = d, \
@@ -839,6 +893,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
+	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
+	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
+	_REGISTER_CLOCK("imx51-cspi.0", NULL, cspi_clk)
 };
 
 static void clk_tree_init(void)
-- 
1.7.2.3
