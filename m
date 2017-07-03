From: adriana.reus@nxp.com (Adriana Reus)
Date: Mon,  3 Jul 2017 17:28:03 +0300
Subject: [RFC 2/2] clk: imx: Remove enabling uart clocks from ccm driver.
In-Reply-To: <1499092083-2852-1-git-send-email-adriana.reus@nxp.com>
References: <1499092083-2852-1-git-send-email-adriana.reus@nxp.com>
Message-ID: <1499092083-2852-3-git-send-email-adriana.reus@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove uart clock enable functionality from ccm driver and
leave uart clocks enabling and setup to the serial driver.

This functionality was introduced by patch
"b9af68f clk: imx7d: retain early UART clocks during kernel init"
to ensure that for earlycon and earlyprink we have the uart port enabled
even if the bootloader does not enable it.

However, on imx7d uart root clocks are recommended to be gated when
changing frequency and if the CLK_SET_RATE_GATE is set for these clocks
this means that the serial driver will fail to re-parent or set_frequency
via device tree attributes on them because the ccm driver has them all in use.

Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index e1c31f5..374ec0f 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -392,17 +392,6 @@ static int const clks_init_on[] __initconst = {
 
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clks[IMX7D_UART1_ROOT_CLK],
-	&clks[IMX7D_UART2_ROOT_CLK],
-	&clks[IMX7D_UART3_ROOT_CLK],
-	&clks[IMX7D_UART4_ROOT_CLK],
-	&clks[IMX7D_UART5_ROOT_CLK],
-	&clks[IMX7D_UART6_ROOT_CLK],
-	&clks[IMX7D_UART7_ROOT_CLK],
-	NULL
-};
-
 static void __init imx7d_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -897,10 +886,5 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	/* use old gpt clk setting, gpt1 root clk must be twice as gpt counter freq */
 	clk_set_parent(clks[IMX7D_GPT1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
 
-	/* set uart module clock's parent clock source that must be great then 80MHz */
-	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
-
-	imx_register_uart_clocks(uart_clks);
-
 }
 CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
-- 
2.7.4
