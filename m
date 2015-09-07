From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon,  7 Sep 2015 17:09:29 +0200
Subject: [PATCH v3 4/8] clk: imx31: retain early UART clocks during kernel init
In-Reply-To: <1441638573-6701-1-git-send-email-l.stach@pengutronix.de>
References: <1441638573-6701-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1441638573-6701-5-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx31.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index fe66c40b7be2..e283142f123a 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -62,6 +62,16 @@ enum mx31_clks {
 static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
+static struct clk ** const uart_clks[] __initconst = {
+	&clk[ipg],
+	&clk[uart1_gate],
+	&clk[uart2_gate],
+	&clk[uart3_gate],
+	&clk[uart4_gate],
+	&clk[uart5_gate],
+	NULL
+};
+
 int __init mx31_clocks_init(unsigned long fref)
 {
 	void __iomem *base;
@@ -199,6 +209,8 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
 
+	imx_register_uart_clocks(uart_clks);
+
 	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, GPT_TYPE_IMX31);
 
 	return 0;
-- 
2.5.0
