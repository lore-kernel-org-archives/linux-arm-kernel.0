From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun,  3 Jun 2018 11:00:44 +0800
Subject: [PATCH 1/4] clk: imx6q: remove clks_init_on array
Message-ID: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6q.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b9ea703..8754c61 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -96,12 +96,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
 static struct clk *clk[IMX6QDL_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static unsigned int const clks_init_on[] __initconst = {
-	IMX6QDL_CLK_MMDC_CH0_AXI,
-	IMX6QDL_CLK_ROM,
-	IMX6QDL_CLK_ARM,
-};
-
 static struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
@@ -417,7 +411,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *anatop_base, *base;
-	int i;
 	int ret;
 
 	clk[IMX6QDL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
@@ -794,7 +787,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "mlb_podf",   base + 0x74, 18);
 	else
 		clk[IMX6QDL_CLK_MLB] = imx_clk_gate2("mlb",            "axi",               base + 0x74, 18);
-	clk[IMX6QDL_CLK_MMDC_CH0_AXI] = imx_clk_gate2("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20);
+	clk[IMX6QDL_CLK_MMDC_CH0_AXI] = imx_clk_gate2_flags("mmdc_ch0_axi",  "mmdc_ch0_axi_podf", base + 0x74, 20, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_MMDC_CH1_AXI] = imx_clk_gate2("mmdc_ch1_axi",  "mmdc_ch1_axi_podf", base + 0x74, 22);
 	clk[IMX6QDL_CLK_OCRAM]        = imx_clk_gate2("ocram",         "ahb",               base + 0x74, 28);
 	clk[IMX6QDL_CLK_OPENVG_AXI]   = imx_clk_gate2("openvg_axi",    "axi",               base + 0x74, 30);
@@ -808,7 +801,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[IMX6QDL_CLK_GPMI_BCH]     = imx_clk_gate2("gpmi_bch",      "usdhc4",            base + 0x78, 26);
 	clk[IMX6QDL_CLK_GPMI_IO]      = imx_clk_gate2("gpmi_io",       "enfc",              base + 0x78, 28);
 	clk[IMX6QDL_CLK_GPMI_APB]     = imx_clk_gate2("gpmi_apb",      "usdhc3",            base + 0x78, 30);
-	clk[IMX6QDL_CLK_ROM]          = imx_clk_gate2("rom",           "ahb",               base + 0x7c, 0);
+	clk[IMX6QDL_CLK_ROM]          = imx_clk_gate2_flags("rom",     "ahb",               base + 0x7c, 0, CLK_IS_CRITICAL);
 	clk[IMX6QDL_CLK_SATA]         = imx_clk_gate2("sata",          "ahb",               base + 0x7c, 4);
 	clk[IMX6QDL_CLK_SDMA]         = imx_clk_gate2("sdma",          "ahb",               base + 0x7c, 6);
 	clk[IMX6QDL_CLK_SPBA]         = imx_clk_gate2("spba",          "ipg",               base + 0x7c, 12);
@@ -878,9 +871,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	 */
 	clk_set_parent(clk[IMX6QDL_CLK_ENFC_SEL], clk[IMX6QDL_CLK_PLL2_PFD2_396M]);
 
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clk[clks_init_on[i]]);
-
 	if (IS_ENABLED(CONFIG_USB_MXS_PHY)) {
 		clk_prepare_enable(clk[IMX6QDL_CLK_USBPHY1_GATE]);
 		clk_prepare_enable(clk[IMX6QDL_CLK_USBPHY2_GATE]);
-- 
2.7.4
