From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri,  4 Sep 2015 18:00:14 +0200
Subject: [PATCH v2 3/8] clk: imx27: retain early UART clocks during kernel init
In-Reply-To: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
References: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1441382419-4343-4-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx27.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index d9d50d54ef2a..720adc5d7c24 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -47,6 +47,15 @@ static const char *ssi_sel_clks[] = { "spll_gate", "mpll", };
 static struct clk *clk[IMX27_CLK_MAX];
 static struct clk_onecell_data clk_data;
 
+static struct clk **uart_clks[] __initdata = { &clk[IMX27_CLK_PER1_GATE],
+					       &clk[IMX27_CLK_UART1_IPG_GATE],
+					       &clk[IMX27_CLK_UART2_IPG_GATE],
+					       &clk[IMX27_CLK_UART3_IPG_GATE],
+					       &clk[IMX27_CLK_UART4_IPG_GATE],
+					       &clk[IMX27_CLK_UART5_IPG_GATE],
+					       &clk[IMX27_CLK_UART6_IPG_GATE],
+					       NULL };
+
 static void __init _mx27_clocks_init(unsigned long fref)
 {
 	BUG_ON(!ccm);
@@ -163,6 +172,8 @@ static void __init _mx27_clocks_init(unsigned long fref)
 
 	clk_prepare_enable(clk[IMX27_CLK_EMI_AHB_GATE]);
 
+	imx_register_uart_clocks(uart_clks);
+
 	imx_print_silicon_rev("i.MX27", mx27_revision());
 }
 
-- 
2.5.0
