From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 21 Sep 2015 18:53:58 +0200
Subject: [PATCH v4 2/8] clk: imx25: retain early UART clocks during kernel init
In-Reply-To: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
References: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1442854444-4460-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx25.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index ec1a4c1dacf1..c4c141cab444 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -86,6 +86,16 @@ enum mx25_clks {
 
 static struct clk *clk[clk_max];
 
+static struct clk ** const uart_clks[] __initconst = {
+	&clk[uart_ipg_per],
+	&clk[uart1_ipg],
+	&clk[uart2_ipg],
+	&clk[uart3_ipg],
+	&clk[uart4_ipg],
+	&clk[uart5_ipg],
+	NULL
+};
+
 static int __init __mx25_clocks_init(unsigned long osc_rate,
 				     void __iomem *ccm_base)
 {
@@ -233,6 +243,8 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
 	 */
 	clk_set_parent(clk[cko_sel], clk[ipg]);
 
+	imx_register_uart_clocks(uart_clks);
+
 	return 0;
 }
 
-- 
2.5.1
