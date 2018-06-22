From: 2chakrass@gmail.com (Chakra Divi)
Date: Fri, 22 Jun 2018 08:25:19 +0530
Subject: [PATCH] Fix for clk disable issue on imx6ul
Message-ID: <1529636119-4076-1-git-send-email-chakra@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

isiot engicam board is not booting after the
commit cf091ee994ec266e33c3a305d6fc8c5ccb1f8acd
done by <robin@protonic.nl>. Modified the
commit to support imx6ul based SOMs too along
with imx6ull processors

Signed-off-by: Chakra Divi <chakra@openedev.com>
---
 drivers/clk/imx/clk-imx6ul.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index ba563ba..69ec9f0 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -80,7 +80,7 @@ static struct clk *clks[IMX6UL_CLK_END];
 static struct clk_onecell_data clk_data;
 
 static int const clks_init_on[] __initconst = {
-	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2,
+	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2, IMX6UL_CLK_AIPSTZ3,
 	IMX6UL_CLK_AXI, IMX6UL_CLK_ARM, IMX6UL_CLK_ROM,
 	IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
 };
@@ -358,7 +358,9 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPT2_SERIAL]	= imx_clk_gate2("gpt2_serial",	"perclk",	base + 0x68,	26);
 	clks[IMX6UL_CLK_UART2_IPG]	= imx_clk_gate2("uart2_ipg",	"ipg",		base + 0x68,	28);
 	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
-	if (clk_on_imx6ull())
+	if (clk_on_imx6ul())
+		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		base + 0x68,	30);
+	else if (clk_on_imx6ull())
 		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		 base + 0x80,	18);
 
 	/* CCGR1 */
-- 
2.7.4
