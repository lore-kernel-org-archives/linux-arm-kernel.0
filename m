From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri,  4 Sep 2015 18:00:16 +0200
Subject: [PATCH v2 5/8] clk: imx35: retain early UART clocks during kernel init
In-Reply-To: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
References: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1441382419-4343-6-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx35.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 69138ba3dec7..d337819f89c8 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -84,6 +84,12 @@ enum mx35_clks {
 
 static struct clk *clk[clk_max];
 
+static struct clk **uart_clks[] __initdata = { &clk[ipg],
+					       &clk[uart1_gate],
+					       &clk[uart2_gate],
+					       &clk[uart3_gate],
+					       NULL };
+
 int __init mx35_clocks_init(void)
 {
 	void __iomem *base;
@@ -292,6 +298,8 @@ int __init mx35_clocks_init(void)
 	 */
 	clk_prepare_enable(clk[scc_gate]);
 
+	imx_register_uart_clocks(uart_clks);
+
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
 	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT, GPT_TYPE_IMX31);
-- 
2.5.0
