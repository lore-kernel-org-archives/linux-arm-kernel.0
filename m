From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 26 May 2017 15:38:20 +0800
Subject: [PATCH v2 2/3] clk: hi3660: add clocks for video encoder,
 decoder and ISP
In-Reply-To: <20170526073821.25971-1-guodong.xu@linaro.org>
References: <20170526073821.25971-1-guodong.xu@linaro.org>
Message-ID: <20170526073821.25971-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen Jun <chenjun14@huawei.com>

This patch adds more clocks for hi3660, including:
 - video encoder and decoder
 - ISP (Image Signal Processing)

Signed-off-by: Chen Jun <chenjun14@huawei.com>
Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/clk/hisilicon/clk-hi3660.c       | 40 ++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/hi3660-clock.h | 17 ++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 143ce0c..67c4d44 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -47,9 +47,14 @@ static const struct hisi_fixed_factor_clock hi3660_crg_fixed_factor_clks[] = {
 	{ HI3660_CLK_GATE_SPI2, "clk_gate_spi2", "clk_ppll0", 1, 8, 0, },
 	{ HI3660_PCIEPHY_REF, "clk_pciephy_ref", "clk_div_pciephy", 1, 1, 0, },
 	{ HI3660_CLK_ABB_USB, "clk_abb_usb", "clk_gate_usb_tcxo_en", 1, 1, 0 },
+	{ HI3660_VENC_VOLT_HOLD, "venc_volt_hold", "peri_volt_hold", 1, 1, 0, },
+	{ HI3660_CLK_FAC_ISP_SNCLK, "clk_isp_snclk_fac", "clk_isp_snclk_angt",
+	  1, 10, 0, },
 };
 
 static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
+	{ HI3660_PERI_VOLT_HOLD, "peri_volt_hold", "clkin_sys",
+	  CLK_SET_RATE_PARENT, 0x0, 0, 0, },
 	{ HI3660_HCLK_GATE_SDIO0, "hclk_gate_sdio0", "clk_div_sysbus",
 	  CLK_SET_RATE_PARENT, 0x0, 21, 0, },
 	{ HI3660_HCLK_GATE_SD, "hclk_gate_sd", "clk_div_sysbus",
@@ -120,6 +125,10 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
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
@@ -148,6 +157,12 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x40, 17, 0, },
 	{ HI3660_CLK_GATE_SDIO0, "clk_gate_sdio0", "clk_mux_sdio_sys",
 	  CLK_SET_RATE_PARENT, 0x40, 19, 0, },
+	{ HI3660_CLK_GATE_ISP_SNCLK0, "clk_gate_isp_snclk0",
+	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 16, 0, },
+	{ HI3660_CLK_GATE_ISP_SNCLK1, "clk_gate_isp_snclk1",
+	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 17, 0, },
+	{ HI3660_CLK_GATE_ISP_SNCLK2, "clk_gate_isp_snclk2",
+	  "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 18, 0, },
 	{ HI3660_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_sysbus",
 	  CLK_SET_RATE_PARENT, 0x50, 21, 0, },
 	{ HI3660_PCLK_GATE_DSI0, "pclk_gate_dsi0", "clk_div_cfgbus",
@@ -171,6 +186,10 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_clks[] = {
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
@@ -195,6 +214,8 @@ static const struct hisi_gate_clock hi3660_crgctrl_gate_clks[] = {
 	  CLK_SET_RATE_PARENT, 0xf8, 3, CLK_GATE_HIWORD_MASK, },
 	{ HI3660_CLK_320M_PLL_GT, "clk_320m_pll_gt", "clk_mux_320m",
 	  CLK_SET_RATE_PARENT, 0xf8, 10, 0, },
+	{ HI3660_CLK_ANGT_ISP_SNCLK, "clk_isp_snclk_angt", "clk_div_a53hpm",
+	  CLK_SET_RATE_PARENT, 0x108, 2, CLK_GATE_HIWORD_MASK, },
 	{ HI3660_AUTODIV_EMMC0BUS, "autodiv_emmc0bus", "autodiv_sysbus",
 	  CLK_SET_RATE_PARENT, 0x404, 1, CLK_GATE_HIWORD_MASK, },
 	{ HI3660_AUTODIV_SYSBUS, "autodiv_sysbus", "clk_div_sysbus",
@@ -239,6 +260,10 @@ static const char *const
 clk_mux_spi_p[] = {"clkin_sys", "clk_div_spi",};
 static const char *const
 clk_mux_i2c_p[] = {"clkin_sys", "clk_div_i2c",};
+static const char *const
+clk_mux_venc_p[] = {"clk_ppll0", "clk_ppll1", "clk_ppll3", "clk_ppll3",};
+static const char *const
+clk_mux_isp_snclk_p[] = {"clkin_sys", "clk_isp_snclk_div"};
 
 static const struct hisi_mux_clock hi3660_crgctrl_mux_clks[] = {
 	{ HI3660_CLK_MUX_SYSBUS, "clk_mux_sysbus", clk_mux_sysbus_p,
@@ -283,6 +308,12 @@ static const struct hisi_mux_clock hi3660_crgctrl_mux_clks[] = {
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
@@ -292,6 +323,9 @@ static const struct hisi_mux_clock hi3660_crgctrl_mux_clks[] = {
 	{ HI3660_CLK_MUX_320M, "clk_mux_320m", clk_mux_pll02p,
 	  ARRAY_SIZE(clk_mux_pll02p), CLK_SET_RATE_PARENT, 0x100, 0, 1,
 	  CLK_MUX_HIWORD_MASK, },
+	{ HI3660_CLK_MUX_ISP_SNCLK, "clk_isp_snclk_mux", clk_mux_isp_snclk_p,
+	  ARRAY_SIZE(clk_mux_isp_snclk_p), CLK_SET_RATE_PARENT, 0x108, 3, 1,
+	  CLK_MUX_HIWORD_MASK, },
 	{ HI3660_CLK_MUX_IOPERI, "clk_mux_ioperi", clk_mux_ioperi_p,
 	  ARRAY_SIZE(clk_mux_ioperi_p), CLK_SET_RATE_PARENT, 0x108, 10, 1,
 	  CLK_MUX_HIWORD_MASK, },
@@ -318,6 +352,10 @@ static const struct hisi_divider_clock hi3660_crgctrl_divider_clks[] = {
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
@@ -334,6 +372,8 @@ static const struct hisi_divider_clock hi3660_crgctrl_divider_clks[] = {
 	  CLK_SET_RATE_PARENT, 0xec, 14, 1, CLK_DIVIDER_HIWORD_MASK, 0, },
 	{ HI3660_CLK_DIV_AOMM, "clk_div_aomm", "clk_aomm_andgt",
 	  CLK_SET_RATE_PARENT, 0x100, 7, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
+	{ HI3660_CLK_DIV_ISP_SNCLK, "clk_isp_snclk_div", "clk_isp_snclk_fac",
+	  CLK_SET_RATE_PARENT, 0x108, 0, 2, CLK_DIVIDER_HIWORD_MASK, 0, },
 	{ HI3660_CLK_DIV_IOPERI, "clk_div_ioperi", "clk_mux_ioperi",
 	  CLK_SET_RATE_PARENT, 0x108, 11, 4, CLK_DIVIDER_HIWORD_MASK, 0, },
 };
diff --git a/include/dt-bindings/clock/hi3660-clock.h b/include/dt-bindings/clock/hi3660-clock.h
index 1c00b7f..adb768d 100644
--- a/include/dt-bindings/clock/hi3660-clock.h
+++ b/include/dt-bindings/clock/hi3660-clock.h
@@ -154,6 +154,23 @@
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
+#define HI3660_CLK_FAC_ISP_SNCLK	150
+#define HI3660_CLK_GATE_ISP_SNCLK0	151
+#define HI3660_CLK_GATE_ISP_SNCLK1	152
+#define HI3660_CLK_GATE_ISP_SNCLK2	153
+#define HI3660_CLK_ANGT_ISP_SNCLK	154
+#define HI3660_CLK_MUX_ISP_SNCLK	155
+#define HI3660_CLK_DIV_ISP_SNCLK	156
 
 /* clk in pmuctrl */
 #define HI3660_GATE_ABB_192		0
-- 
2.10.2
