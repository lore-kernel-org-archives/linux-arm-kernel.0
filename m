From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Aug 2015 18:39:19 +0200
Subject: [PATCH 6/8] clk: imx5: retain early UART clocks during kernel init
In-Reply-To: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
References: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1440693561-28095-7-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx51-imx53.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index a7e4f394be0d..701d1d912a4b 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -130,6 +130,20 @@ static const char *cpu_podf_sels[] = { "pll1_sw", "step_sel" };
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
 
+static void __init imx5_uart_disable_cb(void)
+{
+	clk_disable_unprepare(clk[IMX5_CLK_UART1_IPG_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART1_PER_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART2_IPG_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART2_PER_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART3_IPG_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART3_PER_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART4_IPG_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART4_PER_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART5_IPG_GATE]);
+	clk_disable_unprepare(clk[IMX5_CLK_UART5_PER_GATE]);
+}
+
 static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 {
 	clk[IMX5_CLK_DUMMY]		= imx_clk_fixed("dummy", 0);
@@ -310,6 +324,20 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk_prepare_enable(clk[IMX5_CLK_TMAX1]);
 	clk_prepare_enable(clk[IMX5_CLK_TMAX2]); /* esdhc2, fec */
 	clk_prepare_enable(clk[IMX5_CLK_TMAX3]); /* esdhc1, esdhc4 */
+
+	if (imx_clk_keep_uart()) {
+		clk_prepare_enable(clk[IMX5_CLK_UART1_IPG_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART1_PER_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART2_IPG_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART2_PER_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART3_IPG_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART3_PER_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART4_IPG_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART4_PER_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART5_IPG_GATE]);
+		clk_prepare_enable(clk[IMX5_CLK_UART5_PER_GATE]);
+		imx_clk_set_uart_disable_callback(imx5_uart_disable_cb);
+	}
 }
 
 static void __init mx50_clocks_init(struct device_node *np)
-- 
2.5.0
