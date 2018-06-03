From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun,  3 Jun 2018 11:00:47 +0800
Subject: [PATCH 4/4] clk: imx6ul: remove clks_init_on array
In-Reply-To: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1527994847-2363-4-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock framework will enable those clocks registered
with CLK_IS_CRITICAL flag, so no need to have
clks_init_on array during clock initialization now.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	This patch is based on "[V2,1/2] clk: imx6ul: add GPIO clock gates".
 drivers/clk/imx/clk-imx6ul.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 3ea2d97..d3f7f4d 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -79,12 +79,6 @@ static const char *cko_sels[] = { "cko1", "cko2", };
 static struct clk *clks[IMX6UL_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static int const clks_init_on[] __initconst = {
-	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2,
-	IMX6UL_CLK_AXI, IMX6UL_CLK_ARM, IMX6UL_CLK_ROM,
-	IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
-};
-
 static const struct clk_div_table clk_enet_ref_table[] = {
 	{ .val = 0, .div = 20, },
 	{ .val = 1, .div = 10, },
@@ -129,7 +123,6 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 
 	clks[IMX6UL_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
 
@@ -336,8 +329,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_AHB]		= imx_clk_busy_divider("ahb",	    "periph",	base +  0x14, 10, 3,  base + 0x48, 1);
 
 	/* CCGR0 */
-	clks[IMX6UL_CLK_AIPSTZ1]	= imx_clk_gate2("aips_tz1",	"ahb",		base + 0x68,	0);
-	clks[IMX6UL_CLK_AIPSTZ2]	= imx_clk_gate2("aips_tz2",	"ahb",		base + 0x68,	2);
+	clks[IMX6UL_CLK_AIPSTZ1]	= imx_clk_gate2_flags("aips_tz1", "ahb", base + 0x68, 0, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_AIPSTZ2]	= imx_clk_gate2_flags("aips_tz2", "ahb", base + 0x68, 2, CLK_IS_CRITICAL);
 	clks[IMX6UL_CLK_APBHDMA]	= imx_clk_gate2("apbh_dma",	"bch_podf",	base + 0x68,	4);
 	clks[IMX6UL_CLK_ASRC_IPG]	= imx_clk_gate2_shared("asrc_ipg",	"ahb",	base + 0x68,	6, &share_count_asrc);
 	clks[IMX6UL_CLK_ASRC_MEM]	= imx_clk_gate2_shared("asrc_mem",	"ahb",	base + 0x68,	6, &share_count_asrc);
@@ -412,9 +405,9 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPIO4]		= imx_clk_gate2("gpio4",	"ipg",		base + 0x74,	12);
 	clks[IMX6UL_CLK_QSPI]		= imx_clk_gate2("qspi1",	"qspi1_podf",	base + 0x74,	14);
 	clks[IMX6UL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	16);
-	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20);
-	clks[IMX6UL_CLK_MMDC_P0_IPG]	= imx_clk_gate2("mmdc_p0_ipg",	"ipg",		base + 0x74,	24);
-	clks[IMX6UL_CLK_AXI]		= imx_clk_gate("axi",	"axi_podf",	base + 0x74,	28);
+	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg",	"ipg",		base + 0x74,	24, CLK_IS_CRITICAL);
+	clks[IMX6UL_CLK_AXI]		= imx_clk_gate_flags("axi",	"axi_podf",	base + 0x74,	28, CLK_IS_CRITICAL);
 
 	/* CCGR4 */
 	clks[IMX6UL_CLK_PER_BCH]	= imx_clk_gate2("per_bch",	"bch_podf",	base + 0x78,	12);
@@ -428,7 +421,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPMI_APB]	= imx_clk_gate2("gpmi_apb",	"bch_podf",	base + 0x78,	30);
 
 	/* CCGR5 */
-	clks[IMX6UL_CLK_ROM]		= imx_clk_gate2("rom",		"ahb",		base + 0x7c,	0);
+	clks[IMX6UL_CLK_ROM]		= imx_clk_gate2_flags("rom",	"ahb",		base + 0x7c,	0,	CLK_IS_CRITICAL);
 	clks[IMX6UL_CLK_SDMA]		= imx_clk_gate2("sdma",		"ahb",		base + 0x7c,	6);
 	clks[IMX6UL_CLK_KPP]		= imx_clk_gate2("kpp",		"ipg",		base + 0x7c,	8);
 	clks[IMX6UL_CLK_WDOG2]		= imx_clk_gate2("wdog2",	"ipg",		base + 0x7c,	10);
@@ -502,10 +495,6 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clk_set_rate(clks[IMX6UL_CLK_ENET2_REF], 50000000);
 	clk_set_rate(clks[IMX6UL_CLK_CSI], 24000000);
 
-	/* keep all the clks on just for bringup */
-	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
-		clk_prepare_enable(clks[clks_init_on[i]]);
-
 	if (clk_on_imx6ull())
 		clk_prepare_enable(clks[IMX6UL_CLK_AIPSTZ3]);
 
-- 
2.7.4
