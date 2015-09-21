From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 21 Sep 2015 18:54:02 +0200
Subject: [PATCH v4 6/8] clk: imx5: retain early UART clocks during kernel init
In-Reply-To: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
References: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1442854444-4460-7-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx51-imx53.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index a7e4f394be0d..c6770348d2ab 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -130,6 +130,20 @@ static const char *cpu_podf_sels[] = { "pll1_sw", "step_sel" };
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
 
+static struct clk ** const uart_clks[] __initconst = {
+	&clk[IMX5_CLK_UART1_IPG_GATE],
+	&clk[IMX5_CLK_UART1_PER_GATE],
+	&clk[IMX5_CLK_UART2_IPG_GATE],
+	&clk[IMX5_CLK_UART2_PER_GATE],
+	&clk[IMX5_CLK_UART3_IPG_GATE],
+	&clk[IMX5_CLK_UART3_PER_GATE],
+	&clk[IMX5_CLK_UART4_IPG_GATE],
+	&clk[IMX5_CLK_UART4_PER_GATE],
+	&clk[IMX5_CLK_UART5_IPG_GATE],
+	&clk[IMX5_CLK_UART5_PER_GATE],
+	NULL
+};
+
 static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 {
 	clk[IMX5_CLK_DUMMY]		= imx_clk_fixed("dummy", 0);
@@ -310,6 +324,8 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk_prepare_enable(clk[IMX5_CLK_TMAX1]);
 	clk_prepare_enable(clk[IMX5_CLK_TMAX2]); /* esdhc2, fec */
 	clk_prepare_enable(clk[IMX5_CLK_TMAX3]); /* esdhc1, esdhc4 */
+
+	imx_register_uart_clocks(uart_clks);
 }
 
 static void __init mx50_clocks_init(struct device_node *np)
-- 
2.5.1
