From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon,  7 Sep 2015 17:09:32 +0200
Subject: [PATCH v3 7/8] clk: imx6: retain early UART clocks during kernel init
In-Reply-To: <1441638573-6701-1-git-send-email-l.stach@pengutronix.de>
References: <1441638573-6701-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1441638573-6701-8-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure to keep UART clocks enabled during kernel init if
earlyprintk or earlycon are active.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx6q.c  | 8 ++++++++
 drivers/clk/imx/clk-imx6sl.c | 8 ++++++++
 drivers/clk/imx/clk-imx6sx.c | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index d046f8e43de8..4221c038a3ba 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -130,6 +130,12 @@ static inline int clk_on_imx6dl(void)
 	return of_machine_is_compatible("fsl,imx6dl");
 }
 
+static struct clk ** const uart_clks[] __initconst = {
+	&clk[IMX6QDL_CLK_UART_IPG],
+	&clk[IMX6QDL_CLK_UART_SERIAL],
+	NULL
+};
+
 static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -534,5 +540,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	/* All existing boards with PCIe use LVDS1 */
 	if (IS_ENABLED(CONFIG_PCI_IMX6))
 		clk_set_parent(clk[IMX6QDL_CLK_LVDS1_SEL], clk[IMX6QDL_CLK_SATA_REF_100M]);
+
+	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index a0d4cf26cfa9..3c3333faae8e 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -184,6 +184,12 @@ void imx6sl_set_wait_clk(bool enter)
 		imx6sl_enable_pll_arm(false);
 }
 
+static struct clk ** const uart_clks[] __initconst = {
+	&clks[IMX6SL_CLK_UART],
+	&clks[IMX6SL_CLK_UART_SERIAL],
+	NULL
+};
+
 static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -439,5 +445,7 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SL_CLK_LCDIF_AXI_SEL],
 		       clks[IMX6SL_CLK_PLL2_PFD2]);
+
+	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 5b95c2c2bf52..f0ad8bbc12f8 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -135,6 +135,12 @@ static u32 share_count_ssi1;
 static u32 share_count_ssi2;
 static u32 share_count_ssi3;
 
+static struct clk ** const uart_clks[] __initconst = {
+	&clks[IMX6SX_CLK_UART_IPG],
+	&clks[IMX6SX_CLK_UART_SERIAL],
+	NULL
+};
+
 static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -557,5 +563,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SX_CLK_QSPI1_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
 	clk_set_parent(clks[IMX6SX_CLK_QSPI2_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
+
+	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
-- 
2.5.0
