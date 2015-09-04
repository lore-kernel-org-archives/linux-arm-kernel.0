From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri,  4 Sep 2015 18:00:18 +0200
Subject: [PATCH v2 7/8] clk: imx6: retain early UART clocks during kernel init
In-Reply-To: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
References: <1441382419-4343-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1441382419-4343-8-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx6q.c  | 6 ++++++
 drivers/clk/imx/clk-imx6sl.c | 6 ++++++
 drivers/clk/imx/clk-imx6sx.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index d046f8e43de8..a8a9603f4d71 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -130,6 +130,10 @@ static inline int clk_on_imx6dl(void)
 	return of_machine_is_compatible("fsl,imx6dl");
 }
 
+static struct clk **uart_clks[] __initdata = { &clk[IMX6QDL_CLK_UART_IPG],
+					       &clk[IMX6QDL_CLK_UART_SERIAL],
+					       NULL };
+
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -534,5 +538,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	/* All existing boards with PCIe use LVDS1 */
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
 		clk_set_parent(clk[IMX6QDL_CLK_LVDS1_SEL], clk[IMX6QDL_CLK_SATA_REF_100M]);
+
+	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index a0d4cf26cfa9..cbad1bb7d3de 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -184,6 +184,10 @@ void imx6sl_set_wait_clk(bool enter)
 		imx6sl_enable_pll_arm(false);
 }
 
+static struct clk **uart_clks[] __initdata = { &clks[IMX6SL_CLK_UART],
+					       &clks[IMX6SL_CLK_UART_SERIAL],
+					       NULL };
+
 static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -439,5 +443,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SL_CLK_LCDIF_AXI_SEL],
 		       clks[IMX6SL_CLK_PLL2_PFD2]);
+
+	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 5b95c2c2bf52..b5bbcb2d3d8d 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -135,6 +135,10 @@ static u32 share_count_ssi1;
 static u32 share_count_ssi2;
 static u32 share_count_ssi3;
 
+static struct clk **uart_clks[] __initdata = { &clks[IMX6SX_CLK_UART_IPG],
+					       &clks[IMX6SX_CLK_UART_SERIAL],
+					       NULL };
+
 static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -557,5 +561,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SX_CLK_QSPI1_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
 	clk_set_parent(clks[IMX6SX_CLK_QSPI2_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
+
+	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
-- 
2.5.0
