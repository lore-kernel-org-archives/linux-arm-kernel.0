From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 27 Aug 2015 18:39:17 +0200
Subject: [PATCH 4/8] clk: imx31: retain early UART clocks during kernel init
In-Reply-To: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
References: <1440693561-28095-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1440693561-28095-5-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx31.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index fe66c40b7be2..c8da3b31f24d 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -62,6 +62,16 @@ enum mx31_clks {
 static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
+static void __init imx31_uart_disable_cb(void)
+{
+	clk_disable_unprepare(clk[ipg]);
+	clk_disable_unprepare(clk[uart1_gate]);
+	clk_disable_unprepare(clk[uart2_gate]);
+	clk_disable_unprepare(clk[uart3_gate]);
+	clk_disable_unprepare(clk[uart4_gate]);
+	clk_disable_unprepare(clk[uart5_gate]);
+}
+
 int __init mx31_clocks_init(unsigned long fref)
 {
 	void __iomem *base;
@@ -199,6 +209,16 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
 
+	if (imx_clk_keep_uart()) {
+		clk_prepare_enable(clk[ipg]);
+		clk_prepare_enable(clk[uart1_gate]);
+		clk_prepare_enable(clk[uart2_gate]);
+		clk_prepare_enable(clk[uart3_gate]);
+		clk_prepare_enable(clk[uart4_gate]);
+		clk_prepare_enable(clk[uart5_gate]);
+		imx_clk_set_uart_disable_callback(imx31_uart_disable_cb);
+	}
+
 	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, GPT_TYPE_IMX31);
 
 	return 0;
-- 
2.5.0
