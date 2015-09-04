From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri,  4 Sep 2015 18:00:13 +0200
Subject: [PATCH v2 2/8] clk: imx25: retain early UART clocks during kernel init
In-Reply-To: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
References: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1441382419-4343-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx25.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index ec1a4c1dacf1..e55acea762fb 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -86,6 +86,14 @@ enum mx25_clks {
 
 static struct clk *clk[clk_max];
 
+static struct clk **uart_clks[] __initdata = { &clk[uart_ipg_per],
+					       &clk[uart1_ipg],
+					       &clk[uart2_ipg],
+					       &clk[uart3_ipg],
+					       &clk[uart4_ipg],
+					       &clk[uart5_ipg],
+					       NULL };
+
 static int __init __mx25_clocks_init(unsigned long osc_rate,
 				     void __iomem *ccm_base)
 {
@@ -233,6 +241,8 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
 	 */
 	clk_set_parent(clk[cko_sel], clk[ipg]);
 
+	imx_register_uart_clocks(uart_clks);
+
 	return 0;
 }
 
-- 
2.5.0
