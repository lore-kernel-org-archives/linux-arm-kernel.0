From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue,  8 Aug 2017 15:18:43 +0800
Subject: [PATCH v3 6/9] clk: rockchip: support more clks for rv1108
In-Reply-To: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
References: <1502176547-30817-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1502176723-32275-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the description of the missing clock,
make the clock more complete.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rv1108.c | 279 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 276 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 9c6bad0da140..5cb7699305f5 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -145,6 +145,18 @@ enum rv1108_plls {
 PNAME(mux_i2s_out_p)		= { "i2s0_pre", "xin12m" };
 PNAME(mux_i2s1_p)		= { "i2s1_src", "i2s1_frac", "xin12m" };
 PNAME(mux_i2s2_p)		= { "i2s2_src", "i2s2_frac", "xin12m" };
+PNAME(mux_wifi_src_p)	= { "gpll", "xin24m" };
+PNAME(mux_cifout_src_p)	= { "hdmiphy", "gpll" };
+PNAME(mux_cifout_p)	= { "sclk_cifout_src", "xin24m" };
+PNAME(mux_sclk_cif0_src_p)		= { "pclk_vip", "clk_cif0_chn_out", "pclkin_cvbs2cif" };
+PNAME(mux_sclk_cif1_src_p)		= { "pclk_vip", "clk_cif1_chn_out", "pclkin_cvbs2cif" };
+PNAME(mux_sclk_cif2_src_p)		= { "pclk_vip", "clk_cif2_chn_out", "pclkin_cvbs2cif" };
+PNAME(mux_sclk_cif3_src_p)		= { "pclk_vip", "clk_cif3_chn_out", "pclkin_cvbs2cif" };
+PNAME(mux_dsp_src_p)		= { "dpll", "gpll", "apll", "usb480m" };
+PNAME(mux_dclk_hdmiphy_p)	= { "hdmiphy", "xin24m" };
+PNAME(mux_dclk_vop_p)	= { "dclk_hdmiphy", "dclk_vop_src" };
+PNAME(mux_hdmi_cec_src_p)		= { "dpll", "gpll", "xin24m" };
+PNAME(mux_cvbs_src_p)		= { "apll", "io_cvbs_clkin", "hdmiphy", "gpll" };
 
 static struct rockchip_pll_clock rv1108_pll_clks[] __initdata = {
 	[apll] = PLL(pll_rk3399, PLL_APLL, "apll", mux_pll_p, 0, RV1108_PLL_CON(0),
@@ -212,8 +224,53 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(11), 1, GFLAGS),
 
 	/* PD_RKVENC */
+	COMPOSITE(0, "aclk_rkvenc_pre", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(37), 6, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(8), 8, GFLAGS),
+	FACTOR_GATE(0, "hclk_rkvenc_pre", "aclk_rkvenc_pre", 0, 1, 4,
+			RV1108_CLKGATE_CON(8), 10, GFLAGS),
+	COMPOSITE(SCLK_VENC_CORE, "clk_venc_core", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(37), 14, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(8), 9, GFLAGS),
+	GATE(ACLK_RKVENC, "aclk_rkvenc", "aclk_rkvenc_pre", 0,
+			RV1108_CLKGATE_CON(19), 8, GFLAGS),
+	GATE(HCLK_RKVENC, "hclk_rkvenc", "hclk_rkvenc_pre", 0,
+			RV1108_CLKGATE_CON(19), 9, GFLAGS),
+	GATE(0, "aclk_rkvenc_niu", "aclk_rkvenc_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(19), 11, GFLAGS),
+	GATE(0, "hclk_rkvenc_niu", "hclk_rkvenc_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(19), 10, GFLAGS),
 
 	/* PD_RKVDEC */
+	COMPOSITE(SCLK_HEVC_CORE, "sclk_hevc_core", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(36), 6, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(8), 2, GFLAGS),
+	FACTOR_GATE(0, "hclk_rkvdec_pre", "sclk_hevc_core", 0, 1, 4,
+			RV1108_CLKGATE_CON(8), 10, GFLAGS),
+	COMPOSITE(SCLK_HEVC_CABAC, "clk_hevc_cabac", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(35), 14, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(8), 1, GFLAGS),
+
+	COMPOSITE(0, "aclk_rkvdec_pre", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(35), 6, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(8), 0, GFLAGS),
+	COMPOSITE(0, "aclk_vpu_pre", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(36), 14, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(8), 3, GFLAGS),
+	GATE(ACLK_RKVDEC, "aclk_rkvdec", "aclk_rkvdec_pre", 0,
+			RV1108_CLKGATE_CON(19), 0, GFLAGS),
+	GATE(ACLK_VPU, "aclk_vpu", "aclk_vpu_pre", 0,
+			RV1108_CLKGATE_CON(19), 1, GFLAGS),
+	GATE(HCLK_RKVDEC, "hclk_rkvdec", "hclk_rkvdec_pre", 0,
+			RV1108_CLKGATE_CON(19), 2, GFLAGS),
+	GATE(HCLK_VPU, "hclk_vpu", "hclk_rkvdec_pre", 0,
+			RV1108_CLKGATE_CON(19), 3, GFLAGS),
+	GATE(0, "aclk_rkvdec_niu", "aclk_rkvdec_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(19), 4, GFLAGS),
+	GATE(0, "hclk_rkvdec_niu", "hclk_rkvdec_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(19), 5, GFLAGS),
+	GATE(0, "aclk_vpu_niu", "aclk_vpu_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(19), 6, GFLAGS),
 
 	/* PD_PMU_wrapper */
 	COMPOSITE_NOMUX(0, "pmu_24m_ena", "gpll", CLK_IGNORE_UNUSED,
@@ -243,6 +300,114 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(8), 13, GFLAGS),
 
 	/*
+	 * Clock-Architecture Diagram 3
+	 */
+	COMPOSITE(SCLK_WIFI, "sclk_wifi", mux_wifi_src_p, 0,
+			RV1108_CLKSEL_CON(28), 15, 1, MFLAGS, 8, 6, DFLAGS,
+			RV1108_CLKGATE_CON(9), 8, GFLAGS),
+	COMPOSITE_NODIV(0, "sclk_cifout_src", mux_cifout_src_p, 0,
+			RV1108_CLKSEL_CON(40), 8, 1, MFLAGS,
+			RV1108_CLKGATE_CON(9), 11, GFLAGS),
+	COMPOSITE_NOGATE(SCLK_CIFOUT, "sclk_cifout", mux_cifout_p, 0,
+			RV1108_CLKSEL_CON(40), 12, 1, MFLAGS, 0, 5, DFLAGS),
+	COMPOSITE_NOMUX(SCLK_MIPI_CSI_OUT, "sclk_mipi_csi_out", "xin24m", 0,
+			RV1108_CLKSEL_CON(41), 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 12, GFLAGS),
+
+	GATE(0, "pclk_acodecphy", "pclk_top_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(14), 6, GFLAGS),
+	GATE(0, "pclk_usbgrf", "pclk_top_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(14), 14, GFLAGS),
+
+	GATE(ACLK_CIF0, "aclk_cif0", "aclk_vio1_pre", 0,
+			RV1108_CLKGATE_CON(18), 10, GFLAGS),
+	GATE(HCLK_CIF0, "hclk_cif0", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(18), 10, GFLAGS),
+	COMPOSITE_NODIV(SCLK_CIF0, "sclk_cif0", mux_sclk_cif0_src_p, 0,
+			RV1108_CLKSEL_CON(31), 0, 2, MFLAGS,
+			RV1108_CLKGATE_CON(7), 9, GFLAGS),
+	GATE(ACLK_CIF1, "aclk_cif1", "aclk_vio1_pre", 0,
+			RV1108_CLKGATE_CON(17), 6, GFLAGS),
+	GATE(HCLK_CIF1, "hclk_cif1", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(17), 7, GFLAGS),
+	COMPOSITE_NODIV(SCLK_CIF1, "sclk_cif1", mux_sclk_cif1_src_p, 0,
+			RV1108_CLKSEL_CON(31), 2, 2, MFLAGS,
+			RV1108_CLKGATE_CON(7), 10, GFLAGS),
+	GATE(ACLK_CIF2, "aclk_cif2", "aclk_vio1_pre", 0,
+			RV1108_CLKGATE_CON(17), 8, GFLAGS),
+	GATE(HCLK_CIF2, "hclk_cif2", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(17), 9, GFLAGS),
+	COMPOSITE_NODIV(SCLK_CIF2, "sclk_cif2", mux_sclk_cif2_src_p, 0,
+			RV1108_CLKSEL_CON(31), 4, 2, MFLAGS,
+			RV1108_CLKGATE_CON(7), 11, GFLAGS),
+	GATE(ACLK_CIF3, "aclk_cif3", "aclk_vio1_pre", 0,
+			RV1108_CLKGATE_CON(17), 10, GFLAGS),
+	GATE(HCLK_CIF3, "hclk_cif3", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(17), 11, GFLAGS),
+	COMPOSITE_NODIV(SCLK_CIF3, "sclk_cif3", mux_sclk_cif3_src_p, 0,
+			RV1108_CLKSEL_CON(31), 6, 2, MFLAGS,
+			RV1108_CLKGATE_CON(7), 12, GFLAGS),
+	GATE(0, "pclk_cif1to4", "pclk_vip", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(7), 8, GFLAGS),
+
+	/* PD_DSP_wrapper */
+	COMPOSITE(SCLK_DSP, "sclk_dsp", mux_dsp_src_p, 0,
+			RV1108_CLKSEL_CON(42), 8, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 0, GFLAGS),
+	GATE(0, "clk_dsp_sys_wd", "sclk_dsp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 0, GFLAGS),
+	GATE(0, "clk_dsp_epp_wd", "sclk_dsp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 1, GFLAGS),
+	GATE(0, "clk_dsp_edp_wd", "sclk_dsp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 2, GFLAGS),
+	GATE(0, "clk_dsp_iop_wd", "sclk_dsp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 3, GFLAGS),
+	GATE(0, "clk_dsp_free", "sclk_dsp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 13, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_DSP_IOP, "sclk_dsp_iop", "sclk_dsp", 0,
+			RV1108_CLKSEL_CON(44), 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 1, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_DSP_EPP, "sclk_dsp_epp", "sclk_dsp", 0,
+			RV1108_CLKSEL_CON(44), 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 2, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_DSP_EDP, "sclk_dsp_edp", "sclk_dsp", 0,
+			RV1108_CLKSEL_CON(45), 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 3, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_DSP_EDAP, "sclk_dsp_edap", "sclk_dsp", 0,
+			RV1108_CLKSEL_CON(45), 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 4, GFLAGS),
+	GATE(0, "pclk_dsp_iop_niu", "sclk_dsp_iop", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 4, GFLAGS),
+	GATE(0, "aclk_dsp_epp_niu", "sclk_dsp_epp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 5, GFLAGS),
+	GATE(0, "aclk_dsp_edp_niu", "sclk_dsp_edp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 6, GFLAGS),
+	GATE(0, "pclk_dsp_dbg_niu", "sclk_dsp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 7, GFLAGS),
+	GATE(0, "aclk_dsp_edap_niu", "sclk_dsp_edap", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 14, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_DSP_PFM, "sclk_dsp_pfm", "sclk_dsp", 0,
+			RV1108_CLKSEL_CON(43), 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 5, GFLAGS),
+	COMPOSITE_NOMUX(PCLK_DSP_CFG, "pclk_dsp_cfg", "sclk_dsp", 0,
+			RV1108_CLKSEL_CON(43), 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(9), 6, GFLAGS),
+	GATE(0, "pclk_dsp_cfg_niu", "pclk_dsp_cfg", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 8, GFLAGS),
+	GATE(0, "pclk_dsp_pfm_mon", "pclk_dsp_cfg", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 9, GFLAGS),
+	GATE(0, "pclk_intc", "pclk_dsp_cfg", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 10, GFLAGS),
+	GATE(0, "pclk_dsp_grf", "pclk_dsp_cfg", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 11, GFLAGS),
+	GATE(0, "pclk_mailbox", "pclk_dsp_cfg", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 12, GFLAGS),
+	GATE(0, "aclk_dsp_epp_perf", "sclk_dsp_epp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(16), 15, GFLAGS),
+	GATE(0, "aclk_dsp_edp_perf", "sclk_dsp_edp", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(11), 8, GFLAGS),
+
+	/*
 	 * Clock-Architecture Diagram 4
 	 */
 	COMPOSITE(0, "aclk_vio0_2wrap_occ", mux_pll_src_4plls_p, CLK_IGNORE_UNUSED,
@@ -253,9 +418,18 @@ enum rv1108_plls {
 	COMPOSITE_NOMUX(0, "hclk_vio_pre", "aclk_vio0_pre", 0,
 			RV1108_CLKSEL_CON(29), 0, 5, DFLAGS,
 			RV1108_CLKGATE_CON(7), 2, GFLAGS),
+	GATE(HCLK_VIO, "hclk_vio", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(17), 2, GFLAGS),
 	COMPOSITE_NOMUX(0, "pclk_vio_pre", "aclk_vio0_pre", 0,
 			RV1108_CLKSEL_CON(29), 8, 5, DFLAGS,
 			RV1108_CLKGATE_CON(7), 3, GFLAGS),
+	GATE(PCLK_VIO, "pclk_vio", "pclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(17), 3, GFLAGS),
+	COMPOSITE(0, "aclk_vio1_pre", mux_pll_src_4plls_p, CLK_IGNORE_UNUSED,
+			RV1108_CLKSEL_CON(28), 14, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(6), 1, GFLAGS),
+	GATE(ACLK_VIO1, "aclk_vio1", "aclk_vio1_pre", 0,
+			RV1108_CLKGATE_CON(17), 1, GFLAGS),
 
 	INVERTER(0, "pclk_vip", "ext_vip",
 			RV1108_CLKSEL_CON(31), 8, IFLAGS),
@@ -267,16 +441,71 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(6), 5, GFLAGS),
 	GATE(0, "dclk_hdmiphy_src_dpll", "dpll", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(6), 4, GFLAGS),
-	COMPOSITE_NOGATE(0, "dclk_hdmiphy", mux_dclk_hdmiphy_pre_p, 0,
+	COMPOSITE_NOGATE(0, "dclk_hdmiphy_pre", mux_dclk_hdmiphy_pre_p, 0,
 			RV1108_CLKSEL_CON(32), 6, 2, MFLAGS, 8, 6, DFLAGS),
-
+	COMPOSITE_NOGATE(DCLK_VOP_SRC, "dclk_vop_src", mux_dclk_hdmiphy_pre_p, 0,
+			RV1108_CLKSEL_CON(32), 6, 1, MFLAGS, 0, 6, DFLAGS),
+	MUX(DCLK_HDMIPHY, "dclk_hdmiphy", mux_dclk_hdmiphy_p, CLK_SET_RATE_PARENT,
+			RV1108_CLKSEL_CON(32), 15, 1, MFLAGS),
+	MUX(DCLK_VOP, "dclk_vop", mux_dclk_vop_p, CLK_SET_RATE_PARENT,
+			RV1108_CLKSEL_CON(32), 7, 1, MFLAGS),
+	GATE(ACLK_VOP, "aclk_vop", "aclk_vio0_pre", 0,
+			RV1108_CLKGATE_CON(18), 0, GFLAGS),
+	GATE(HCLK_VOP, "hclk_vop", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(18), 1, GFLAGS),
+	GATE(ACLK_IEP, "aclk_iep", "aclk_vio0_pre", 0,
+			RV1108_CLKGATE_CON(18), 2, GFLAGS),
+	GATE(HCLK_IEP, "hclk_iep", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(18), 3, GFLAGS),
+
+	GATE(ACLK_RGA, "aclk_rga", "aclk_vio1_pre", 0,
+			RV1108_CLKGATE_CON(18), 4, GFLAGS),
+	GATE(HCLK_RGA, "hclk_rga", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(18), 5, GFLAGS),
+	COMPOSITE(SCLK_RGA, "sclk_rga", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(33), 6, 2, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(6), 6, GFLAGS),
+
+	COMPOSITE(SCLK_CVBS_HOST, "sclk_cvbs_host", mux_cvbs_src_p, 0,
+			RV1108_CLKSEL_CON(33), 13, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(6), 7, GFLAGS),
+	FACTOR(0, "sclk_cvbs_27m", "sclk_cvbs_host", 0, 1, 2),
+
+	GATE(SCLK_HDMI_SFR, "sclk_hdmi_sfr", "xin24m", 0,
+			RV1108_CLKGATE_CON(6), 8, GFLAGS),
+
+	COMPOSITE(SCLK_HDMI_CEC, "sclk_hdmi_cec", mux_hdmi_cec_src_p, 0,
+			RV1108_CLKSEL_CON(34), 14, 2, MFLAGS, 0, 14, DFLAGS,
+			RV1108_CLKGATE_CON(6), 9, GFLAGS),
+	GATE(PCLK_MIPI_DSI, "pclk_mipi_dsi", "pclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(18), 8, GFLAGS),
+	GATE(PCLK_HDMI_CTRL, "pclk_hdmi_ctrl", "pclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(18), 9, GFLAGS),
+
+	GATE(ACLK_ISP, "aclk_isp", "aclk_vio1_pre", 0,
+			RV1108_CLKGATE_CON(18), 12, GFLAGS),
+	GATE(HCLK_ISP, "hclk_isp", "hclk_vio_pre", 0,
+			RV1108_CLKGATE_CON(18), 11, GFLAGS),
+	COMPOSITE(SCLK_ISP, "sclk_isp", mux_pll_src_4plls_p, 0,
+			RV1108_CLKSEL_CON(30), 14, 2, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(6), 3, GFLAGS),
+
+	GATE(0, "clk_dsiphy24m", "xin24m", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(9), 10, GFLAGS),
+	GATE(0, "pclk_vdacphy", "pclk_top_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(14), 9, GFLAGS),
+	GATE(0, "pclk_mipi_dsiphy", "pclk_top_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(14), 11, GFLAGS),
+	GATE(0, "pclk_mipi_csiphy", "pclk_top_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(14), 12, GFLAGS),
 	/*
 	 * Clock-Architecture Diagram 5
 	 */
 
 	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
 
-	COMPOSITE(0, "i2s0_src", mux_pll_src_2plls_p, 0,
+
+	COMPOSITE(SCLK_I2S0_SRC, "i2s0_src", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(5), 8, 1, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(2), 0, GFLAGS),
 	COMPOSITE_FRACMUX(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
@@ -337,6 +566,27 @@ enum rv1108_plls {
 	GATE(0, "pclk_timer", "pclk_bus_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(13), 4, GFLAGS),
 
+	GATE(HCLK_I2S0_8CH, "hclk_i2s0_8ch", "hclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(12), 7, GFLAGS),
+	GATE(HCLK_I2S1_2CH, "hclk_i2s1_2ch", "hclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(12), 8, GFLAGS),
+	GATE(HCLK_I2S2_2CH, "hclk_i2s2_2ch", "hclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(12), 9, GFLAGS),
+
+	GATE(HCLK_CRYPTO_MST, "hclk_crypto_mst", "hclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(12), 10, GFLAGS),
+	GATE(HCLK_CRYPTO_SLV, "hclk_crypto_slv", "hclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(12), 11, GFLAGS),
+	COMPOSITE(SCLK_CRYPTO, "sclk_crypto", mux_pll_src_2plls_p, 0,
+			RV1108_CLKSEL_CON(11), 7, 1, MFLAGS, 0, 5, DFLAGS,
+			RV1108_CLKGATE_CON(2), 12, GFLAGS),
+
+	COMPOSITE(SCLK_SPI, "sclk_spi", mux_pll_src_2plls_p, 0,
+			RV1108_CLKSEL_CON(11), 15, 1, MFLAGS, 8, 5, DFLAGS,
+			RV1108_CLKGATE_CON(3), 0, GFLAGS),
+	GATE(PCLK_SPI, "pclk_spi", "pclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(13), 5, GFLAGS),
+
 	COMPOSITE(0, "uart0_src", mux_pll_src_dpll_gpll_usb480m_p, CLK_IGNORE_UNUSED,
 			RV1108_CLKSEL_CON(13), 12, 2, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(3), 1, GFLAGS),
@@ -397,6 +647,20 @@ enum rv1108_plls {
 
 	GATE(0, "pclk_grf", "pclk_bus_pre", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(14), 0, GFLAGS),
+	GATE(PCLK_EFUSE0, "pclk_efuse0", "pclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(12), 12, GFLAGS),
+	GATE(PCLK_EFUSE1, "pclk_efuse1", "pclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(12), 13, GFLAGS),
+	GATE(PCLK_TSADC, "pclk_tsadc", "pclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(13), 13, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_TSADC, "sclk_tsadc", "xin24m", 0,
+			RV1108_CLKSEL_CON(21), 0, 10, DFLAGS,
+			RV1108_CLKGATE_CON(3), 11, GFLAGS),
+	GATE(PCLK_SARADC, "pclk_saradc", "pclk_bus_pre", 0,
+			RV1108_CLKGATE_CON(13), 14, GFLAGS),
+	COMPOSITE_NOMUX(SCLK_SARADC, "sclk_saradc", "xin24m", 0,
+			RV1108_CLKSEL_CON(22), 0, 10, DFLAGS,
+			RV1108_CLKGATE_CON(3), 12, GFLAGS),
 
 	GATE(ACLK_DMAC, "aclk_dmac", "aclk_bus_pre", 0,
 	     RV1108_CLKGATE_CON(12), 2, GFLAGS),
@@ -424,6 +688,10 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(12), 6, GFLAGS),
 	GATE(0, "timer_clk", "xin24m", CLK_IGNORE_UNUSED,
 			RV1108_CLKGATE_CON(0), 11, GFLAGS),
+	GATE(0, "pclk_mschniu", "pclk_ddr_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(14), 2, GFLAGS),
+	GATE(0, "pclk_ddrphy", "pclk_ddr_pre", CLK_IGNORE_UNUSED,
+			RV1108_CLKGATE_CON(14), 4, GFLAGS),
 
 	/*
 	 * Clock-Architecture Diagram 6
@@ -473,6 +741,11 @@ enum rv1108_plls {
 			RV1108_CLKGATE_CON(5), 3, GFLAGS),
 	GATE(HCLK_NANDC, "hclk_nandc", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 3, GFLAGS),
 
+	GATE(HCLK_HOST0, "hclk_host0", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 6, GFLAGS),
+	GATE(0, "hclk_host0_arb", "hclk_periph", CLK_IGNORE_UNUSED, RV1108_CLKGATE_CON(15), 7, GFLAGS),
+	GATE(HCLK_OTG, "hclk_otg", "hclk_periph", 0, RV1108_CLKGATE_CON(15), 8, GFLAGS),
+	GATE(0, "hclk_otg_pmu", "hclk_periph", CLK_IGNORE_UNUSED, RV1108_CLKGATE_CON(15), 9, GFLAGS),
+	GATE(SCLK_USBPHY, "clk_usbphy", "xin24m", CLK_IGNORE_UNUSED, RV1108_CLKGATE_CON(5), 5, GFLAGS),
 	COMPOSITE(SCLK_SFC, "sclk_sfc", mux_pll_src_2plls_p, 0,
 			RV1108_CLKSEL_CON(27), 7, 2, MFLAGS, 0, 7, DFLAGS,
 			RV1108_CLKGATE_CON(5), 4, GFLAGS),
-- 
1.9.1
