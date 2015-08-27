From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Aug 2015 18:39:15 +0200
Subject: [PATCH 2/8] clk: imx25: retain early UART clocks during kernel init
In-Reply-To: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
References: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1440693561-28095-3-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx25.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index ec1a4c1dacf1..4322ef409cc6 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -86,6 +86,16 @@ enum mx25_clks {
 
 static struct clk *clk[clk_max];
 
+static void __init imx25_uart_disable_cb(void)
+{
+	clk_disable_unprepare(clk[uart_ipg_per]);
+	clk_disable_unprepare(clk[uart1_ipg]);
+	clk_disable_unprepare(clk[uart2_ipg]);
+	clk_disable_unprepare(clk[uart3_ipg]);
+	clk_disable_unprepare(clk[uart4_ipg]);
+	clk_disable_unprepare(clk[uart5_ipg]);
+}
+
 static int __init __mx25_clocks_init(unsigned long osc_rate,
 				     void __iomem *ccm_base)
 {
@@ -233,6 +243,16 @@ static int __init __mx25_clocks_init(unsigned long osc_rate,
 	 */
 	clk_set_parent(clk[cko_sel], clk[ipg]);
 
+	if (imx_clk_keep_uart()) {
+		clk_prepare_enable(clk[uart_ipg_per]);
+		clk_prepare_enable(clk[uart1_ipg]);
+		clk_prepare_enable(clk[uart2_ipg]);
+		clk_prepare_enable(clk[uart3_ipg]);
+		clk_prepare_enable(clk[uart4_ipg]);
+		clk_prepare_enable(clk[uart5_ipg]);
+		imx_clk_set_uart_disable_callback(imx25_uart_disable_cb);
+	}
+
 	return 0;
 }
 
-- 
2.5.0
