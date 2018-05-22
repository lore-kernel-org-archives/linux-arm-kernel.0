From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 22 May 2018 11:25:59 +0800
Subject: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
Message-ID: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6UL has GPIO clock gates in CCM CCGR, add
them into clock tree for clock management.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c             |  5 +++++
 include/dt-bindings/clock/imx6ul-clock.h | 31 ++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index ba563ba..3ea2d97 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -360,6 +360,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
 	if (clk_on_imx6ull())
 		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		 base + 0x80,	18);
+	clks[IMX6UL_CLK_GPIO2]		= imx_clk_gate2("gpio2",	"ipg",		base + 0x68,	30);
 
 	/* CCGR1 */
 	clks[IMX6UL_CLK_ECSPI1]		= imx_clk_gate2("ecspi1",	"ecspi_podf",	base + 0x6c,	0);
@@ -376,6 +377,8 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPT1_SERIAL]	= imx_clk_gate2("gpt1_serial",	"perclk",	base + 0x6c,	22);
 	clks[IMX6UL_CLK_UART4_IPG]	= imx_clk_gate2("uart4_ipg",	"ipg",		base + 0x6c,	24);
 	clks[IMX6UL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serial",	"uart_podf",	base + 0x6c,	24);
+	clks[IMX6UL_CLK_GPIO1]		= imx_clk_gate2("gpio1",	"ipg",		base + 0x6c,	26);
+	clks[IMX6UL_CLK_GPIO5]		= imx_clk_gate2("gpio5",	"ipg",		base + 0x6c,	30);
 
 	/* CCGR2 */
 	if (clk_on_imx6ull()) {
@@ -389,6 +392,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_I2C3]		= imx_clk_gate2("i2c3",		"perclk",	base + 0x70,	10);
 	clks[IMX6UL_CLK_OCOTP]		= imx_clk_gate2("ocotp",	"ipg",		base + 0x70,	12);
 	clks[IMX6UL_CLK_IOMUXC]		= imx_clk_gate2("iomuxc",	"lcdif_podf",	base + 0x70,	14);
+	clks[IMX6UL_CLK_GPIO3]		= imx_clk_gate2("gpio3",	"ipg",		base + 0x70,	26);
 	clks[IMX6UL_CLK_LCDIF_APB]	= imx_clk_gate2("lcdif_apb",	"axi",		base + 0x70,	28);
 	clks[IMX6UL_CLK_PXP]		= imx_clk_gate2("pxp",		"axi",		base + 0x70,	30);
 
@@ -405,6 +409,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_UART6_IPG]	= imx_clk_gate2("uart6_ipg",	"ipg",		base + 0x74,	6);
 	clks[IMX6UL_CLK_UART6_SERIAL]	= imx_clk_gate2("uart6_serial",	"uart_podf",	base + 0x74,	6);
 	clks[IMX6UL_CLK_LCDIF_PIX]	= imx_clk_gate2("lcdif_pix",	"lcdif_podf",	base + 0x74,	10);
+	clks[IMX6UL_CLK_GPIO4]		= imx_clk_gate2("gpio4",	"ipg",		base + 0x74,	12);
 	clks[IMX6UL_CLK_QSPI]		= imx_clk_gate2("qspi1",	"qspi1_podf",	base + 0x74,	14);
 	clks[IMX6UL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74,	16);
 	clks[IMX6UL_CLK_MMDC_P0_FAST]	= imx_clk_gate("mmdc_p0_fast", "mmdc_podf", base + 0x74,	20);
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index 9564597..1291328 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -242,20 +242,25 @@
 #define IMX6UL_CLK_CKO2_PODF		229
 #define IMX6UL_CLK_CKO2			230
 #define IMX6UL_CLK_CKO			231
+#define IMX6UL_CLK_GPIO1		232
+#define IMX6UL_CLK_GPIO2		233
+#define IMX6UL_CLK_GPIO3		234
+#define IMX6UL_CLK_GPIO4		235
+#define IMX6UL_CLK_GPIO5		236
 
 /* For i.MX6ULL */
-#define IMX6ULL_CLK_ESAI_PRED		232
-#define IMX6ULL_CLK_ESAI_PODF		233
-#define IMX6ULL_CLK_ESAI_EXTAL		234
-#define IMX6ULL_CLK_ESAI_MEM		235
-#define IMX6ULL_CLK_ESAI_IPG		236
-#define IMX6ULL_CLK_DCP_CLK		237
-#define IMX6ULL_CLK_EPDC_PRE_SEL	238
-#define IMX6ULL_CLK_EPDC_SEL		239
-#define IMX6ULL_CLK_EPDC_PODF		240
-#define IMX6ULL_CLK_EPDC_ACLK		241
-#define IMX6ULL_CLK_EPDC_PIX		242
-#define IMX6ULL_CLK_ESAI_SEL		243
-#define IMX6UL_CLK_END			244
+#define IMX6ULL_CLK_ESAI_PRED		237
+#define IMX6ULL_CLK_ESAI_PODF		238
+#define IMX6ULL_CLK_ESAI_EXTAL		239
+#define IMX6ULL_CLK_ESAI_MEM		240
+#define IMX6ULL_CLK_ESAI_IPG		241
+#define IMX6ULL_CLK_DCP_CLK		242
+#define IMX6ULL_CLK_EPDC_PRE_SEL	243
+#define IMX6ULL_CLK_EPDC_SEL		244
+#define IMX6ULL_CLK_EPDC_PODF		245
+#define IMX6ULL_CLK_EPDC_ACLK		246
+#define IMX6ULL_CLK_EPDC_PIX		247
+#define IMX6ULL_CLK_ESAI_SEL		248
+#define IMX6UL_CLK_END			249
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.7.4
