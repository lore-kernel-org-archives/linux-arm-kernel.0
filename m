From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 1 Nov 2016 11:02:23 +0800
Subject: [PATCH 3/3] clk: imx: clk-imx6ul: add clk support for imx6ull
In-Reply-To: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
References: <1477969343-19887-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1477969343-19887-4-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bai Ping <ping.bai@nxp.com>

imx6ull is the derived SoC from imx6ul

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/clk/imx/clk-imx6ul.c             | 74 +++++++++++++++++++++++++++-----
 include/dt-bindings/clock/imx6ul-clock.h | 15 ++++++-
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index d1d7787..ceb99a7 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -64,6 +64,11 @@ static const char *perclk_sels[] = { "ipg", "osc", };
 static const char *lcdif_sels[] = { "lcdif_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
 static const char *csi_sels[] = { "osc", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
 static const char *sim_sels[] = { "sim_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
+/* epdc_pre_sels, epdc_sels, esai_sels only exists on i.MX6ULL */
+static const char *epdc_pre_sels[] = { "pll2_bus", "pll3_usb_otg", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd2_508m", };
+static const char *esai_sels[] = { "pll4_audio_div", "pll3_pfd2_508m", "pll5_video_div", "pll3_usb_otg", };
+static const char *epdc_sels[] = { "epdc_podf", "ipp_di0", "ipp_di1", "ldb_di0", "ldb_di1", };
+
 
 static struct clk *clks[IMX6UL_CLK_END];
 static struct clk_onecell_data clk_data;
@@ -102,6 +107,17 @@ static u32 share_count_audio;
 static u32 share_count_sai1;
 static u32 share_count_sai2;
 static u32 share_count_sai3;
+static u32 share_count_esai;
+
+static inline int clk_on_imx6ul(void)
+{
+	return of_machine_is_compatible("fsl,imx6ul");
+}
+
+static inline int clk_on_imx6ull(void)
+{
+	return of_machine_is_compatible("fsl,imx6ull");
+}
 
 static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 {
@@ -238,12 +254,19 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_QSPI1_SEL]	  = imx_clk_mux("qspi1_sel",    base + 0x1c, 7,  3, qspi1_sels, ARRAY_SIZE(qspi1_sels));
 	clks[IMX6UL_CLK_PERCLK_SEL]	  = imx_clk_mux("perclk_sel",	base + 0x1c, 6,  1, perclk_sels, ARRAY_SIZE(perclk_sels));
 	clks[IMX6UL_CLK_CAN_SEL]	  = imx_clk_mux("can_sel",	base + 0x20, 8,  2, can_sels, ARRAY_SIZE(can_sels));
+	if (clk_on_imx6ull())
+		clks[IMX6UL_CLK_ESAI_SEL]	  = imx_clk_mux("esai_sel",	base + 0x20, 19, 2, esai_sels, ARRAY_SIZE(esai_sels));
 	clks[IMX6UL_CLK_UART_SEL]	  = imx_clk_mux("uart_sel",	base + 0x24, 6,  1, uart_sels, ARRAY_SIZE(uart_sels));
 	clks[IMX6UL_CLK_ENFC_SEL]	  = imx_clk_mux("enfc_sel",	base + 0x2c, 15, 3, enfc_sels, ARRAY_SIZE(enfc_sels));
 	clks[IMX6UL_CLK_LDB_DI0_SEL]	  = imx_clk_mux("ldb_di0_sel",	base + 0x2c, 9,  3, ldb_di0_sels, ARRAY_SIZE(ldb_di0_sels));
 	clks[IMX6UL_CLK_SPDIF_SEL]	  = imx_clk_mux("spdif_sel",	base + 0x30, 20, 2, spdif_sels, ARRAY_SIZE(spdif_sels));
-	clks[IMX6UL_CLK_SIM_PRE_SEL]	  = imx_clk_mux("sim_pre_sel",	base + 0x34, 15, 3, sim_pre_sels, ARRAY_SIZE(sim_pre_sels));
-	clks[IMX6UL_CLK_SIM_SEL]	  = imx_clk_mux("sim_sel",	base + 0x34, 9, 3, sim_sels, ARRAY_SIZE(sim_sels));
+	if (clk_on_imx6ul()) {
+		clks[IMX6UL_CLK_SIM_PRE_SEL] 	  = imx_clk_mux("sim_pre_sel",	base + 0x34, 15, 3, sim_pre_sels, ARRAY_SIZE(sim_pre_sels));
+		clks[IMX6UL_CLK_SIM_SEL]	  = imx_clk_mux("sim_sel", 	base + 0x34, 9, 3, sim_sels, ARRAY_SIZE(sim_sels));
+	} else if (clk_on_imx6ull()) {
+		clks[IMX6UL_CLK_EPDC_PRE_SEL]	  = imx_clk_mux("epdc_pre_sel",	base + 0x34, 15, 3, epdc_pre_sels, ARRAY_SIZE(epdc_pre_sels));
+		clks[IMX6UL_CLK_EPDC_SEL]	  = imx_clk_mux("epdc_sel",	base + 0x34, 9, 3, epdc_sels, ARRAY_SIZE(epdc_sels));
+	}
 	clks[IMX6UL_CLK_ECSPI_SEL]	  = imx_clk_mux("ecspi_sel",	base + 0x38, 18, 1, ecspi_sels, ARRAY_SIZE(ecspi_sels));
 	clks[IMX6UL_CLK_LCDIF_PRE_SEL]	  = imx_clk_mux("lcdif_pre_sel", base + 0x38, 15, 3, lcdif_pre_sels, ARRAY_SIZE(lcdif_pre_sels));
 	clks[IMX6UL_CLK_LCDIF_SEL]	  = imx_clk_mux("lcdif_sel",	base + 0x38, 9, 3, lcdif_sels, ARRAY_SIZE(lcdif_sels));
@@ -276,6 +299,10 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_SAI3_PODF]	= imx_clk_divider("sai3_podf",	   "sai3_pred",		base + 0x28, 16, 6);
 	clks[IMX6UL_CLK_SAI1_PRED]	= imx_clk_divider("sai1_pred",	   "sai1_sel",		base + 0x28, 6,	 3);
 	clks[IMX6UL_CLK_SAI1_PODF]	= imx_clk_divider("sai1_podf",	   "sai1_pred",		base + 0x28, 0,	 6);
+	if (clk_on_imx6ull()) {
+		clks[IMX6UL_CLK_ESAI_PRED]	= imx_clk_divider("esai_pred",     "esai_sel",		base + 0x28, 9,  3);
+		clks[IMX6UL_CLK_ESAI_PODF]	= imx_clk_divider("esai_podf",     "esai_pred",		base + 0x28, 25, 3);
+	}
 	clks[IMX6UL_CLK_ENFC_PRED]	= imx_clk_divider("enfc_pred",	   "enfc_sel",		base + 0x2c, 18, 3);
 	clks[IMX6UL_CLK_ENFC_PODF]	= imx_clk_divider("enfc_podf",	   "enfc_pred",		base + 0x2c, 21, 6);
 	clks[IMX6UL_CLK_SAI2_PRED]	= imx_clk_divider("sai2_pred",	   "sai2_sel",		base + 0x2c, 6,	 3);
@@ -298,9 +325,15 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_APBHDMA]	= imx_clk_gate2("apbh_dma",	"bch_podf",	base + 0x68,	4);
 	clks[IMX6UL_CLK_ASRC_IPG]	= imx_clk_gate2_shared("asrc_ipg",	"ahb",	base + 0x68,	6, &share_count_asrc);
 	clks[IMX6UL_CLK_ASRC_MEM]	= imx_clk_gate2_shared("asrc_mem",	"ahb",	base + 0x68,	6, &share_count_asrc);
-	clks[IMX6UL_CLK_CAAM_MEM]	= imx_clk_gate2("caam_mem",	"ahb",		base + 0x68,	8);
-	clks[IMX6UL_CLK_CAAM_ACLK]	= imx_clk_gate2("caam_aclk",	"ahb",		base + 0x68,	10);
-	clks[IMX6UL_CLK_CAAM_IPG]	= imx_clk_gate2("caam_ipg",	"ipg",		base + 0x68,	12);
+	if (clk_on_imx6ul()) {
+		clks[IMX6UL_CLK_CAAM_MEM]	= imx_clk_gate2("caam_mem",	"ahb",		base + 0x68,	8);
+		clks[IMX6UL_CLK_CAAM_ACLK]	= imx_clk_gate2("caam_aclk",	"ahb",		base + 0x68,	10);
+		clks[IMX6UL_CLK_CAAM_IPG]	= imx_clk_gate2("caam_ipg",	"ipg",		base + 0x68,	12);
+	} else if (clk_on_imx6ull()) {
+		clks[IMX6UL_CLK_DCP_CLK]	= imx_clk_gate2("dcp",		"ahb",		base + 0x68,	10);
+		clks[IMX6UL_CLK_ENET]		= imx_clk_gate2("enet",		"ipg",		base + 0x68,	12);
+		clks[IMX6UL_CLK_ENET_AHB]	= imx_clk_gate2("enet_ahb",	"ahb",		base + 0x68,	12);
+	}
 	clks[IMX6UL_CLK_CAN1_IPG]	= imx_clk_gate2("can1_ipg",	"ipg",		base + 0x68,	14);
 	clks[IMX6UL_CLK_CAN1_SERIAL]	= imx_clk_gate2("can1_serial",	"can_podf",	base + 0x68,	16);
 	clks[IMX6UL_CLK_CAN2_IPG]	= imx_clk_gate2("can2_ipg",	"ipg",		base + 0x68,	18);
@@ -309,7 +342,10 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPT2_SERIAL]	= imx_clk_gate2("gpt2_serial",	"perclk",	base + 0x68,	26);
 	clks[IMX6UL_CLK_UART2_IPG]	= imx_clk_gate2("uart2_ipg",	"ipg",		base + 0x68,	28);
 	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
-	clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		base + 0x68,	30);
+	if (clk_on_imx6ul())
+		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		base + 0x68,	30);
+	else if (clk_on_imx6ull())
+		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		 base + 0x80,	18);
 
 	/* CCGR1 */
 	clks[IMX6UL_CLK_ECSPI1]		= imx_clk_gate2("ecspi1",	"ecspi_podf",	base + 0x6c,	0);
@@ -328,6 +364,11 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serail",	"uart_podf",	base + 0x6c,	24);
 
 	/* CCGR2 */
+	if (clk_on_imx6ull()) {
+		clks[IMX6UL_CLK_ESAI_EXTAL]	= imx_clk_gate2_shared("esai_extal",	"esai_podf",	base + 0x70,	0, &share_count_esai);
+		clks[IMX6UL_CLK_ESAI_IPG]	= imx_clk_gate2_shared("esai_ipg",	"ahb",		base + 0x70,	0, &share_count_esai);
+		clks[IMX6UL_CLK_ESAI_MEM]	= imx_clk_gate2_shared("esai_mem",	"ahb",		base + 0x70,	0, &share_count_esai);
+	}
 	clks[IMX6UL_CLK_CSI]		= imx_clk_gate2("csi",		"csi_podf",		base + 0x70,	2);
 	clks[IMX6UL_CLK_I2C1]		= imx_clk_gate2("i2c1",		"perclk",	base + 0x70,	6);
 	clks[IMX6UL_CLK_I2C2]		= imx_clk_gate2("i2c2",		"perclk",	base + 0x70,	8);
@@ -340,8 +381,13 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	/* CCGR3 */
 	clks[IMX6UL_CLK_UART5_IPG]	= imx_clk_gate2("uart5_ipg",	"ipg",		base + 0x74,	2);
 	clks[IMX6UL_CLK_UART5_SERIAL]	= imx_clk_gate2("uart5_serial",	"uart_podf",	base + 0x74,	2);
-	clks[IMX6UL_CLK_ENET]		= imx_clk_gate2("enet",		"ipg",		base + 0x74,	4);
-	clks[IMX6UL_CLK_ENET_AHB]	= imx_clk_gate2("enet_ahb",	"ahb",		base + 0x74,	4);
+	if (clk_on_imx6ul()) {
+		clks[IMX6UL_CLK_ENET]		= imx_clk_gate2("enet",		"ipg",		base + 0x74,	4);
+		clks[IMX6UL_CLK_ENET_AHB]	= imx_clk_gate2("enet_ahb",	"ahb",		base + 0x74,	4);
+	} else if (clk_on_imx6ull()) {
+		clks[IMX6UL_CLK_EPDC_ACLK]	= imx_clk_gate2("epdc_aclk",	"axi",		base + 0x74,	4);
+		clks[IMX6UL_CLK_EPDC_PIX]	= imx_clk_gate2("epdc_pix",	"epdc_podf",	base + 0x74,	4);
+	}
 	clks[IMX6UL_CLK_UART6_IPG]	= imx_clk_gate2("uart6_ipg",	"ipg",		base + 0x74,	6);
 	clks[IMX6UL_CLK_UART6_SERIAL]	= imx_clk_gate2("uart6_serial",	"uart_podf",	base + 0x74,	6);
 	clks[IMX6UL_CLK_LCDIF_PIX]	= imx_clk_gate2("lcdif_pix",	"lcdif_podf",	base + 0x74,	10);
@@ -385,8 +431,10 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_USBOH3]		= imx_clk_gate2("usboh3",	"ipg",		 base + 0x80,	0);
 	clks[IMX6UL_CLK_USDHC1]		= imx_clk_gate2("usdhc1",	"usdhc1_podf",	 base + 0x80,	2);
 	clks[IMX6UL_CLK_USDHC2]		= imx_clk_gate2("usdhc2",	"usdhc2_podf",	 base + 0x80,	4);
-	clks[IMX6UL_CLK_SIM1]		= imx_clk_gate2("sim1",		"sim_sel",	 base + 0x80,	6);
-	clks[IMX6UL_CLK_SIM2]		= imx_clk_gate2("sim2",		"sim_sel",	 base + 0x80,	8);
+	if (clk_on_imx6ul()) {
+		clks[IMX6UL_CLK_SIM1]		= imx_clk_gate2("sim1",		"sim_sel",	 base + 0x80,	6);
+		clks[IMX6UL_CLK_SIM2]		= imx_clk_gate2("sim2",		"sim_sel",	 base + 0x80,	8);
+	}
 	clks[IMX6UL_CLK_EIM]		= imx_clk_gate2("eim",		"eim_slow_podf", base + 0x80,	10);
 	clks[IMX6UL_CLK_PWM8]		= imx_clk_gate2("pwm8",		"perclk",	 base + 0x80,	16);
 	clks[IMX6UL_CLK_UART8_IPG]	= imx_clk_gate2("uart8_ipg",	"ipg",		 base + 0x80,	14);
@@ -430,6 +478,7 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clk_set_rate(clks[IMX6UL_CLK_ENET_REF], 50000000);
 	clk_set_rate(clks[IMX6UL_CLK_ENET2_REF], 50000000);
 	clk_set_rate(clks[IMX6UL_CLK_CSI], 24000000);
+	clk_set_rate(clks[IMX6UL_CLK_PLL3_PFD2], 320000000);
 
 	/* keep all the clks on just for bringup */
 	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
@@ -441,7 +490,10 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	}
 
 	clk_set_parent(clks[IMX6UL_CLK_CAN_SEL], clks[IMX6UL_CLK_PLL3_60M]);
-	clk_set_parent(clks[IMX6UL_CLK_SIM_PRE_SEL], clks[IMX6UL_CLK_PLL3_USB_OTG]);
+	if (clk_on_imx6ul())
+		clk_set_parent(clks[IMX6UL_CLK_SIM_PRE_SEL], clks[IMX6UL_CLK_PLL3_USB_OTG]);
+	else if (clk_on_imx6ull())
+		clk_set_parent(clks[IMX6UL_CLK_EPDC_PRE_SEL], clks[IMX6UL_CLK_PLL3_PFD2]);
 
 	clk_set_parent(clks[IMX6UL_CLK_ENFC_SEL], clks[IMX6UL_CLK_PLL2_PFD2]);
 }
diff --git a/include/dt-bindings/clock/imx6ul-clock.h b/include/dt-bindings/clock/imx6ul-clock.h
index fd8aee8..563fd5b 100644
--- a/include/dt-bindings/clock/imx6ul-clock.h
+++ b/include/dt-bindings/clock/imx6ul-clock.h
@@ -236,6 +236,19 @@
 #define IMX6UL_CLK_PLL3_120M		223
 #define IMX6UL_CLK_KPP			224
 
-#define IMX6UL_CLK_END			225
+/* For i.MX6ULL */
+#define IMX6UL_CLK_ESAI_PRED		225
+#define IMX6UL_CLK_ESAI_PODF		226
+#define IMX6UL_CLK_ESAI_EXTAL		227
+#define IMX6UL_CLK_ESAI_MEM		228
+#define IMX6UL_CLK_ESAI_IPG		229
+#define IMX6UL_CLK_DCP_CLK		230
+#define IMX6UL_CLK_EPDC_PRE_SEL		231
+#define IMX6UL_CLK_EPDC_SEL		232
+#define IMX6UL_CLK_EPDC_PODF		233
+#define IMX6UL_CLK_EPDC_ACLK		234
+#define IMX6UL_CLK_EPDC_PIX		235
+#define IMX6UL_CLK_ESAI_SEL		236
+#define IMX6UL_CLK_END			237
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6UL_H */
-- 
2.7.4
