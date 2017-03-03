From: robin@protonic.nl (Robin van der Gracht)
Date: Fri,  3 Mar 2017 14:26:20 +0100
Subject: [PATCH] clk: imx: clk-imxul: The i.mx6ul has no aips_tx3 clock
Message-ID: <20170303132620.32156-1-robin@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock was mapped on CG15 (gpio2_clocks) in the CCRG0 register.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 drivers/clk/imx/clk-imx6ul.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 75c35fb..dbd6e59 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -73,7 +73,7 @@ static struct clk *clks[IMX6UL_CLK_END];
 static struct clk_onecell_data clk_data;
 
 static int const clks_init_on[] __initconst = {
-	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2, IMX6UL_CLK_AIPSTZ3,
+	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2,
 	IMX6UL_CLK_AXI, IMX6UL_CLK_ARM, IMX6UL_CLK_ROM,
 	IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
 };
@@ -341,9 +341,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPT2_SERIAL]	= imx_clk_gate2("gpt2_serial",	"perclk",	base + 0x68,	26);
 	clks[IMX6UL_CLK_UART2_IPG]	= imx_clk_gate2("uart2_ipg",	"ipg",		base + 0x68,	28);
 	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
-	if (clk_on_imx6ul())
-		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		base + 0x68,	30);
-	else if (clk_on_imx6ull())
+	if (clk_on_imx6ull())
 		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		 base + 0x80,	18);
 
 	/* CCGR1 */
@@ -482,6 +480,9 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
 		clk_prepare_enable(clks[clks_init_on[i]]);
 
+	if (clk_on_imx6ull())
+		clk_prepare_enable(clks[IMX6UL_CLK_AIPSTZ3]);
+
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clks[IMX6UL_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clks[IMX6UL_CLK_USBPHY2_GATE]);
-- 
2.9.3
