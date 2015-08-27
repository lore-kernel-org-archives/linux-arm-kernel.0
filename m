From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Aug 2015 18:39:18 +0200
Subject: [PATCH 5/8] clk: imx35: retain early UART clocks during kernel init
In-Reply-To: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
References: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1440693561-28095-6-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx35.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 69138ba3dec7..7b2aaf123d3b 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -84,6 +84,14 @@ enum mx35_clks {
 
 static struct clk *clk[clk_max];
 
+static void __init imx35_uart_disable_cb(void)
+{
+	clk_disable_unprepare(clk[ipg]);
+	clk_disable_unprepare(clk[uart1_gate]);
+	clk_disable_unprepare(clk[uart2_gate]);
+	clk_disable_unprepare(clk[uart3_gate]);
+}
+
 int __init mx35_clocks_init(void)
 {
 	void __iomem *base;
@@ -292,6 +300,14 @@ int __init mx35_clocks_init(void)
 	 */
 	clk_prepare_enable(clk[scc_gate]);
 
+	if (imx_clk_keep_uart()) {
+		clk_prepare_enable(clk[ipg]);
+		clk_prepare_enable(clk[uart1_gate]);
+		clk_prepare_enable(clk[uart2_gate]);
+		clk_prepare_enable(clk[uart3_gate]);
+		imx_clk_set_uart_disable_callback(imx35_uart_disable_cb);
+	}
+
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
 	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT, GPT_TYPE_IMX31);
-- 
2.5.0
