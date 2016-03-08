From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  8 Mar 2016 09:33:39 -0300
Subject: [PATCH] clk: imx6sx: Register SAI clocks as shared clocks
Message-ID: <1457440419-5494-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

SAIx and SAIx_IPG share the same bit fields in the CCM registers, so
we should better register them via imx_clk_gate2_shared(). 

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/clk/imx/clk-imx6sx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index fea125e..97e742a 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -134,6 +134,8 @@ static u32 share_count_esai;
 static u32 share_count_ssi1;
 static u32 share_count_ssi2;
 static u32 share_count_ssi3;
+static u32 share_count_sai1;
+static u32 share_count_sai2;
 
 static struct clk ** const uart_clks[] __initconst = {
 	&clks[IMX6SX_CLK_UART_IPG],
@@ -469,10 +471,10 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_SSI3]         = imx_clk_gate2_shared("ssi3",          "ssi3_podf",  base + 0x7c, 22, &share_count_ssi3);
 	clks[IMX6SX_CLK_UART_IPG]     = imx_clk_gate2("uart_ipg",      "ipg",               base + 0x7c, 24);
 	clks[IMX6SX_CLK_UART_SERIAL]  = imx_clk_gate2("uart_serial",   "uart_podf",         base + 0x7c, 26);
-	clks[IMX6SX_CLK_SAI1_IPG]     = imx_clk_gate2("sai1_ipg",      "ipg",               base + 0x7c, 28);
-	clks[IMX6SX_CLK_SAI2_IPG]     = imx_clk_gate2("sai2_ipg",      "ipg",               base + 0x7c, 30);
-	clks[IMX6SX_CLK_SAI1]         = imx_clk_gate2("sai1",          "ssi1_podf",         base + 0x7c, 28);
-	clks[IMX6SX_CLK_SAI2]         = imx_clk_gate2("sai2",          "ssi2_podf",         base + 0x7c, 30);
+	clks[IMX6SX_CLK_SAI1_IPG]     = imx_clk_gate2_shared("sai1_ipg", "ipg",             base + 0x7c, 28, &share_count_sai1);
+	clks[IMX6SX_CLK_SAI2_IPG]     = imx_clk_gate2_shared("sai2_ipg", "ipg",             base + 0x7c, 30, &share_count_sai2);
+	clks[IMX6SX_CLK_SAI1]         = imx_clk_gate2_shared("sai1",	"ssi1_podf",        base + 0x7c, 28, &share_count_sai1);
+	clks[IMX6SX_CLK_SAI2]         = imx_clk_gate2_shared("sai2",	"ssi2_podf",        base + 0x7c, 30, &share_count_sai2);
 
 	/* CCGR6 */
 	clks[IMX6SX_CLK_USBOH3]       = imx_clk_gate2("usboh3",        "ipg",               base + 0x80, 0);
-- 
1.9.1
