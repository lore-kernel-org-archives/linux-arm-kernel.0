From: fabien.lahoudere@collabora.co.uk (Fabien Lahoudere)
Date: Mon, 19 Sep 2016 12:30:00 +0200
Subject: [PATCH v2 1/1] clk: imx53: Add clocks configuration
In-Reply-To: <20160918002451.GE15478@tiger>
References: <20160918002451.GE15478@tiger>
Message-ID: <1474281002-18868-1-git-send-email-fabien.lahoudere@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kalle Kankare <kalle.kankare@vincit.fi>

Add clocks configuration for CSI, FIRI and IEEE1588.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/clk/imx/clk-imx51-imx53.c      | 20 ++++++++++++++++++++
 include/dt-bindings/clock/imx5-clock.h | 15 ++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index 29d4c44..1e3c9ea 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -126,6 +126,7 @@ static const char *spdif0_com_sel[] = { "spdif0_podf", "ssi1_root_gate", };
 static const char *mx51_spdif1_com_sel[] = { "spdif1_podf", "ssi2_root_gate", };
 static const char *step_sels[] = { "lp_apm", };
 static const char *cpu_podf_sels[] = { "pll1_sw", "step_sel" };
+static const char *ieee1588_sels[] = { "pll3_sw", "pll4_sw", "dummy" /* usbphy2_clk */, "dummy" /* fec_phy_clk */ };
 
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
@@ -543,6 +544,25 @@ static void __init mx53_clocks_init(struct device_node *np)
 	clk[IMX5_CLK_I2C3_GATE]		= imx_clk_gate2("i2c3_gate", "per_root", MXC_CCM_CCGR1, 22);
 	clk[IMX5_CLK_SATA_GATE]		= imx_clk_gate2("sata_gate", "ipg", MXC_CCM_CCGR4, 2);
 
+	clk[IMX5_CLK_FIRI_SEL]		= imx_clk_mux("firi_sel", MXC_CCM_CSCMR2, 12, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_FIRI_PRED]		= imx_clk_divider("firi_pred", "firi_sel", MXC_CCM_CSCDR3, 6, 3);
+	clk[IMX5_CLK_FIRI_PODF]		= imx_clk_divider("firi_podf", "firi_pred", MXC_CCM_CSCDR3, 0, 6);
+	clk[IMX5_CLK_FIRI_SERIAL_GATE]	= imx_clk_gate2("firi_serial_gate", "firi_podf", MXC_CCM_CCGR1, 28);
+	clk[IMX5_CLK_FIRI_IPG_GATE]	= imx_clk_gate2("firi_ipg_gate", "ipg", MXC_CCM_CCGR1, 26);
+
+	clk[IMX5_CLK_CSI0_MCLK1_SEL]	= imx_clk_mux("csi0_mclk1_sel", MXC_CCM_CSCMR2, 22, 2,
+						standard_pll_sel, ARRAY_SIZE(standard_pll_sel));
+	clk[IMX5_CLK_CSI0_MCLK1_PRED]	= imx_clk_divider("csi0_mclk1_pred", "csi0_mclk1_sel", MXC_CCM_CSCDR4, 6, 3);
+	clk[IMX5_CLK_CSI0_MCLK1_PODF]	= imx_clk_divider("csi0_mclk1_podf", "csi0_mclk1_pred", MXC_CCM_CSCDR4, 0, 6);
+	clk[IMX5_CLK_CSI0_MCLK1_GATE]	= imx_clk_gate2("csi0_mclk1_serial_gate", "csi0_mclk1_podf", MXC_CCM_CCGR6, 4);
+
+	clk[IMX5_CLK_IEEE1588_SEL]	= imx_clk_mux("ieee1588_sel", MXC_CCM_CSCMR2, 14, 2,
+						ieee1588_sels, ARRAY_SIZE(ieee1588_sels));
+	clk[IMX5_CLK_IEEE1588_PRED]	= imx_clk_divider("ieee1588_pred", "ieee1588_sel", MXC_CCM_CSCDR2, 6, 3);
+	clk[IMX5_CLK_IEEE1588_PODF]	= imx_clk_divider("ieee1588_podf", "ieee1588_pred", MXC_CCM_CSCDR2, 0, 6);
+	clk[IMX5_CLK_IEEE1588_GATE]	= imx_clk_gate2("ieee1588_serial_gate", "ieee1588_podf", MXC_CCM_CCGR7, 6);
+
 	clk[IMX5_CLK_CKO1_SEL]		= imx_clk_mux("cko1_sel", MXC_CCM_CCOSR, 0, 4,
 						mx53_cko1_sel, ARRAY_SIZE(mx53_cko1_sel));
 	clk[IMX5_CLK_CKO1_PODF]		= imx_clk_divider("cko1_podf", "cko1_sel", MXC_CCM_CCOSR, 4, 3);
diff --git a/include/dt-bindings/clock/imx5-clock.h b/include/dt-bindings/clock/imx5-clock.h
index f4b7478..d382fc7 100644
--- a/include/dt-bindings/clock/imx5-clock.h
+++ b/include/dt-bindings/clock/imx5-clock.h
@@ -201,6 +201,19 @@
 #define IMX5_CLK_STEP_SEL		189
 #define IMX5_CLK_CPU_PODF_SEL		190
 #define IMX5_CLK_ARM			191
-#define IMX5_CLK_END			192
+#define IMX5_CLK_FIRI_PRED		192
+#define IMX5_CLK_FIRI_SEL		193
+#define IMX5_CLK_FIRI_PODF		194
+#define IMX5_CLK_FIRI_SERIAL_GATE	195
+#define IMX5_CLK_FIRI_IPG_GATE		196
+#define IMX5_CLK_CSI0_MCLK1_PRED	197
+#define IMX5_CLK_CSI0_MCLK1_SEL		198
+#define IMX5_CLK_CSI0_MCLK1_PODF	199
+#define IMX5_CLK_CSI0_MCLK1_GATE	200
+#define IMX5_CLK_IEEE1588_PRED		201
+#define IMX5_CLK_IEEE1588_SEL		202
+#define IMX5_CLK_IEEE1588_PODF		203
+#define IMX5_CLK_IEEE1588_GATE		204
+#define IMX5_CLK_END			205
 
 #endif /* __DT_BINDINGS_CLOCK_IMX5_H */
-- 
2.1.4
