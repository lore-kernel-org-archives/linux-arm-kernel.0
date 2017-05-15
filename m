From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon, 15 May 2017 13:54:22 +0800
Subject: [PATCH 2/3] clk: hi3660: add clocks for video encoder and decoder
In-Reply-To: <20170515055423.1803-1-guodong.xu@linaro.org>
References: <20170515055423.1803-1-guodong.xu@linaro.org>
Message-ID: <20170515055423.1803-2-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Jun <chenjun14@huawei.com>

This patch adds clocks for video encoder and decoder.

Signed-off-by: Chen Jun <chenjun14@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/clk/hisilicon/clk-hi3660.c       | 23 +++++++++++++++++++++++
 include/dt-bindings/clock/hi3660-clock.h | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 143ce0c..ffc765a 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -47,9 +47,12 @@ static const struct hisi_fixed_factor_clock hi3660_crg_fixed_factor_clks[] = {
 	{ HI3660_CLK_GATE_SPI2, "clk_gate_spi2", "clk_ppll0", 1, 8, 0, },
 	{ HI3660_PCIEPHY_REF, "clk_pciephy_ref", "clk_div_pciephy", 1, 1, 0, },
 	{ HI3660_CLK_ABB_USB, "clk_abb_usb", "clk_gate_usb_tcxo_en", 1, 1, 0 },
+	{ HI3660_VENC_VOLT_HOLD, "venc_volt_hold", "peri_volt_hold", 1, 1, 0, },
 };
 
 static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
+	{ HI3660_PERI_VOLT_HOLD, "peri_volt_hold", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x0, 0, 0, },
 	{ HI3660_HCLK_GATE_SDIO0, "hclk_gate_sdio0", "clk_div_sysbus",
 	  CLK_SET_RATE_PARENT, 0x0, 21, 0, },
 	{ HI3660_HCLK_GATE_SD, "hclk_gate_sd", "clk_div_sysbus",
@@ -120,6 +123,10 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x20, 27, 0, },
 	{ HI3660_CLK_GATE_DMAC, "clk_gate_dmac", "clk_div_sysbus",
 	  CLK_SET_RATE_PARENT, 0x30, 1, 0, },
+	{ HI3660_CLK_GATE_VENC, "clk_gate_venc", "clk_div_venc",
+	  CLK_SET_RATE_PARENT, 0x30, 10, 0, },
+	{ HI3660_CLK_GATE_VDEC, "clk_gate_vdec", "clk_div_vdec",
+	  CLK_SET_RATE_PARENT, 0x30, 11, 0, },
 	{ HI3660_PCLK_GATE_DSS, "pclk_gate_dss", "clk_div_cfgbus",
 	  CLK_SET_RATE_PARENT, 0x30, 12, 0, },
 	{ HI3660_ACLK_GATE_DSS, "aclk_gate_dss", "clk_gate_vivobus",
@@ -171,6 +178,10 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_clks[] = {
 	  CLK_SET_RATE_PARENT, 0xf0, 7, CLK_GATE_HIWORD_MASK, },
 	{ HI3660_CLK_ANDGT_EDC0, "clk_andgt_edc0", "clk_mux_edc0",
 	  CLK_SET_RATE_PARENT, 0xf0, 8, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_VDEC, "clk_andgt_vdec", "clk_mux_vdec",
+	  CLK_SET_RATE_PARENT, 0xf0, 15, CLK_GATE_HIWORD_MASK, },
+	{ HI3660_CLK_ANDGT_VENC, "clk_andgt_venc", "clk_mux_venc",
+	  CLK_SET_RATE_PARENT, 0xf4, 0, CLK_GATE_HIWORD_MASK, },
 	{ HI3660_CLK_GATE_UFSPHY_GT, "clk_gate_ufsphy_gt", "clk_div_ufsperi",
 	  CLK_SET_RATE_PARENT, 0xf4, 1, CLK_GATE_HIWORD_MASK, },
 	{ HI3660_CLK_ANDGT_MMC, "clk_andgt_mmc", "clk_mux_mmc_pll",
@@ -239,6 +250,8 @@ static const char *const
 clk_mux_spi_p[] = {"clkin_sys", "clk_div_spi",};
 static const char *const
 clk_mux_i2c_p[] = {"clkin_sys", "clk_div_i2c",};
+static const char *const
+clk_mux_venc_p[] = {"clk_ppll0", "clk_ppll1", "clk_ppll3", "clk_ppll3",};
 
 static const struct hisi_mux_clock hi3660_crgctrl_mux_clks[] = {
 	{ HI3660_CLK_MUX_SYSBUS, "clk_mux_sysbus", clk_mux_sysbus_p,
@@ -283,6 +296,12 @@ static const struct hisi_mux_clock hi3660_crgctrl_mux_clks[] = {
 	{ HI3660_CLK_MUX_SDIO_PLL, "clk_mux_sdio_pll", clk_mux_pll_p,
 	  ARRAY_SIZE(clk_mux_pll_p), CLK_SET_RATE_PARENT, 0xc0, 4, 2,
 	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_VENC, "clk_mux_venc", clk_mux_venc_p,
+	  ARRAY_SIZE(clk_mux_venc_p), CLK_SET_RATE_PARENT, 0xc8, 11, 2,
+	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_VDEC, "clk_mux_vdec", clk_mux_pll0123_p,
+	  ARRAY_SIZE(clk_mux_pll0123_p), CLK_SET_RATE_PARENT, 0xcc, 5, 2,
+	  CLK_MUX_HIWORD_MASK, },
 	{ HI3660_CLK_MUX_VIVOBUS, "clk_mux_vivobus", clk_mux_pll0123_p,
 	  ARRAY_SIZE(clk_mux_pll0123_p), CLK_SET_RATE_PARENT, 0xd0, 12, 2,
 	  CLK_MUX_HIWORD_MASK, },
@@ -318,6 +337,10 @@ static const struct hisi_divider_clock hi3660_crgctrl_divider_clks[] = {
 	  CLK_SET_RATE_PARENT, 0xc0, 8, 6, CLK_DIVIDER_HIWORD_MASK, 0, },
 	{ HI3660_CLK_DIV_SPI, "clk_div_spi", "clk_andgt_spi",
 	  CLK_SET_RATE_PARENT, 0xc4, 12, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_VENC, "clk_div_venc", "clk_andgt_venc",
+	  CLK_SET_RATE_PARENT, 0xc8, 6, 5, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_VDEC, "clk_div_vdec", "clk_andgt_vdec",
+	  CLK_SET_RATE_PARENT, 0xcc, 0, 5, CLK_DIVIDER_HIWORD_MASK, 0, },
 	{ HI3660_CLK_DIV_VIVOBUS, "clk_div_vivobus", "clk_vivobus_andgt",
 	  CLK_SET_RATE_PARENT, 0xd0, 7, 5, CLK_DIVIDER_HIWORD_MASK, 0, },
 	{ HI3660_CLK_DIV_I2C, "clk_div_i2c", "clk_div_320m",
diff --git a/include/dt-bindings/clock/hi3660-clock.h b/include/dt-bindings/clock/hi3660-clock.h
index 1c00b7f..2cf01b4 100644
--- a/include/dt-bindings/clock/hi3660-clock.h
+++ b/include/dt-bindings/clock/hi3660-clock.h
@@ -154,6 +154,16 @@
 #define HI3660_CLK_DIV_UFSPERI		137
 #define HI3660_CLK_DIV_AOMM		138
 #define HI3660_CLK_DIV_IOPERI		139
+#define HI3660_VENC_VOLT_HOLD		140
+#define HI3660_PERI_VOLT_HOLD		141
+#define HI3660_CLK_GATE_VENC		142
+#define HI3660_CLK_GATE_VDEC		143
+#define HI3660_CLK_ANDGT_VENC		144
+#define HI3660_CLK_ANDGT_VDEC		145
+#define HI3660_CLK_MUX_VENC		146
+#define HI3660_CLK_MUX_VDEC		147
+#define HI3660_CLK_DIV_VENC		148
+#define HI3660_CLK_DIV_VDEC		149
 
 /* clk in pmuctrl */
 #define HI3660_GATE_ABB_192		0
-- 
2.10.2
