From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Aug 2015 18:39:21 +0200
Subject: [PATCH 8/8] clk: imx7d: retain early UART clocks during kernel init
In-Reply-To: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
References: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1440693561-28095-9-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx7d.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 71f3a94b472c..8daef5202841 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -363,6 +363,17 @@ static const char *pll_video_bypass_sel[] = { "pll_video_main", "pll_video_main_
 
 static struct clk_onecell_data clk_data;
 
+static void __init imx7d_uart_disable_cb(void)
+{
+	clk_disable_unprepare(clks[IMX7D_UART1_ROOT_CLK]);
+	clk_disable_unprepare(clks[IMX7D_UART2_ROOT_CLK]);
+	clk_disable_unprepare(clks[IMX7D_UART3_ROOT_CLK]);
+	clk_disable_unprepare(clks[IMX7D_UART4_ROOT_CLK]);
+	clk_disable_unprepare(clks[IMX7D_UART5_ROOT_CLK]);
+	clk_disable_unprepare(clks[IMX7D_UART6_ROOT_CLK]);
+	clk_disable_unprepare(clks[IMX7D_UART7_ROOT_CLK]);
+}
+
 static void __init imx7d_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -856,5 +867,16 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	/* set uart module clock's parent clock source that must be great then 80MHz */
 	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
+	if (imx_clk_keep_uart()) {
+		clk_prepare_enable(clks[IMX7D_UART1_ROOT_CLK]);
+		clk_prepare_enable(clks[IMX7D_UART2_ROOT_CLK]);
+		clk_prepare_enable(clks[IMX7D_UART3_ROOT_CLK]);
+		clk_prepare_enable(clks[IMX7D_UART4_ROOT_CLK]);
+		clk_prepare_enable(clks[IMX7D_UART5_ROOT_CLK]);
+		clk_prepare_enable(clks[IMX7D_UART6_ROOT_CLK]);
+		clk_prepare_enable(clks[IMX7D_UART7_ROOT_CLK]);
+		imx_clk_set_uart_disable_callback(imx7d_uart_disable_cb);
+	}
+
 }
 CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
-- 
2.5.0
