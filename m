From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 22 Jun 2018 14:32:33 +0800
Subject: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
Message-ID: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Reference Manual Rev.0, 06/2017,
there are GPIO LPCGs defined in CCM CCGRs,
add them into clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sll.c             | 6 ++++++
 include/dt-bindings/clock/imx6sll-clock.h | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 3651c77..6270645 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -253,6 +253,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_DCP]		= imx_clk_gate2("dcp", "ahb", base + 0x68, 10);
 	clks[IMX6SLL_CLK_UART2_IPG]	= imx_clk_gate2("uart2_ipg", "ipg", base + 0x68, 28);
 	clks[IMX6SLL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf", base + 0x68, 28);
+	clks[IMX6SLL_CLK_GPIO2]		= imx_clk_gate2("gpio2", "ipg", base + 0x68, 30);
 
 	/* CCGR1 */
 	clks[IMX6SLL_CLK_ECSPI1]	= imx_clk_gate2("ecspi1",	"ecspi_podf", base + 0x6c, 0);
@@ -267,13 +268,17 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_GPT_SERIAL]	= imx_clk_gate2("gpt1_serial",	"perclk", base + 0x6c, 22);
 	clks[IMX6SLL_CLK_UART4_IPG]	= imx_clk_gate2("uart4_ipg",	"ipg", base + 0x6c, 24);
 	clks[IMX6SLL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serail",	"uart_podf", base + 0x6c, 24);
+	clks[IMX6SLL_CLK_GPIO1]		= imx_clk_gate2("gpio1",	"ipg", base + 0x6c, 26);
+	clks[IMX6SLL_CLK_GPIO5]		= imx_clk_gate2("gpio5",	"ipg", base + 0x6c, 30);
 
 	/* CCGR2 */
+	clks[IMX6SLL_CLK_GPIO6]		= imx_clk_gate2("gpio6",	"ipg",    base + 0x70, 0);
 	clks[IMX6SLL_CLK_CSI]		= imx_clk_gate2("csi",		"axi",    base + 0x70,	2);
 	clks[IMX6SLL_CLK_I2C1]		= imx_clk_gate2("i2c1",		"perclk", base + 0x70,	6);
 	clks[IMX6SLL_CLK_I2C2]		= imx_clk_gate2("i2c2",		"perclk", base + 0x70,	8);
 	clks[IMX6SLL_CLK_I2C3]		= imx_clk_gate2("i2c3",		"perclk", base + 0x70,	10);
 	clks[IMX6SLL_CLK_OCOTP]		= imx_clk_gate2("ocotp",	"ipg",    base + 0x70,	12);
+	clks[IMX6SLL_CLK_GPIO3]		= imx_clk_gate2("gpio3",	"ipg",    base + 0x70,	26);
 	clks[IMX6SLL_CLK_LCDIF_APB]	= imx_clk_gate2("lcdif_apb",	"axi",    base + 0x70,	28);
 	clks[IMX6SLL_CLK_PXP]		= imx_clk_gate2("pxp",		"axi",    base + 0x70,	30);
 
@@ -283,6 +288,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_EPDC_AXI]	= imx_clk_gate2("epdc_aclk",	"axi",		base + 0x74, 4);
 	clks[IMX6SLL_CLK_EPDC_PIX]	= imx_clk_gate2("epdc_pix",	"epdc_podf",	base + 0x74, 4);
 	clks[IMX6SLL_CLK_LCDIF_PIX]	= imx_clk_gate2("lcdif_pix",	"lcdif_podf",	base + 0x74, 10);
+	clks[IMX6SLL_CLK_GPIO4]		= imx_clk_gate2("gpio4",	"ipg",		base + 0x74, 12);
 	clks[IMX6SLL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74, 16);
 	clks[IMX6SLL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf",  base + 0x74,	20, CLK_IS_CRITICAL);
 	clks[IMX6SLL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg", "ipg",	   base + 0x74,	24, CLK_IS_CRITICAL);
diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
index 151111e..1036475 100644
--- a/include/dt-bindings/clock/imx6sll-clock.h
+++ b/include/dt-bindings/clock/imx6sll-clock.h
@@ -197,6 +197,13 @@
 #define IMX6SLL_CLK_EXTERN_AUDIO_PODF   171
 #define IMX6SLL_CLK_EXTERN_AUDIO        172
 
-#define IMX6SLL_CLK_END			173
+#define IMX6SLL_CLK_GPIO1               173
+#define IMX6SLL_CLK_GPIO2               174
+#define IMX6SLL_CLK_GPIO3               175
+#define IMX6SLL_CLK_GPIO4               176
+#define IMX6SLL_CLK_GPIO5               177
+#define IMX6SLL_CLK_GPIO6               178
+
+#define IMX6SLL_CLK_END			179
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SLL_H */
-- 
2.7.4
