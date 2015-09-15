From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Tue, 15 Sep 2015 17:37:11 +0800
Subject: [PATCH RFC 5/8] drm: hisilicon: fill interface function of
 encoder\connector part
In-Reply-To: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
Message-ID: <1442309834-21420-6-git-send-email-kong.kongxinwei@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the adv7533 module which is connecting hisilicon SOC
by dsi module. while using DSI module and adv7533 module to implement the
encoder/connector interface of DRM\KMS.

Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
Signed-off-by: Yu Gong <gongyu@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/Kconfig              |  10 +
 drivers/gpu/drm/hisilicon/hisi_drm_connector.c |  34 ++
 drivers/gpu/drm/hisilicon/hisi_drm_connector.h |   8 +
 drivers/gpu/drm/hisilicon/hisi_drm_dsi.c       | 670 +++++++++++++++++++++++++
 drivers/gpu/drm/hisilicon/hisi_drm_encoder.c   |  52 ++
 drivers/gpu/drm/hisilicon/hisi_drm_encoder.h   |  19 +
 drivers/gpu/drm/hisilicon/hisi_dsi_reg.h       |  91 ++++
 7 files changed, 884 insertions(+)
 create mode 100644 drivers/gpu/drm/hisilicon/hisi_dsi_reg.h

diff --git a/drivers/gpu/drm/hisilicon/Kconfig b/drivers/gpu/drm/hisilicon/Kconfig
index 60b42e4..105dbcb 100644
--- a/drivers/gpu/drm/hisilicon/Kconfig
+++ b/drivers/gpu/drm/hisilicon/Kconfig
@@ -7,3 +7,13 @@ config DRM_HISI
 	  Choose this option if you have a hisilicon terminal chipset.
 	  If M is selected the module will be called hisi-drm.
 
+if DRM_HISI
+
+config DRM_HISI_HAS_SLAVE_ENCODER
+	bool "Support slave encoder output"
+	default y
+	help
+	  Support slave encoder output device such as DSI interface connecting
+	  HDMI converter by i2c.
+
+endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_connector.c b/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
index 62efdc7..57ab2e8 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_connector.c
@@ -23,8 +23,21 @@
 int hisi_drm_connector_mode_valid(struct drm_connector *connector,
 				  struct drm_display_mode *mode)
 {
+	struct hisi_connector *hconnector = to_hisi_connector(connector);
+	struct drm_encoder *encoder = hconnector->encoder;
+	struct hisi_connector_funcs *ops = hconnector->ops;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
 	int ret = MODE_OK;
 
+	if (ops->modes_valid)
+		ops->modes_valid(connector);
+
+	if (sfuncs && sfuncs->mode_valid) {
+		ret = sfuncs->mode_valid(encoder, mode);
+		if (ret != MODE_OK)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -39,8 +52,19 @@ hisi_drm_best_encoder(struct drm_connector *connector)
 
 int hisi_drm_get_modes(struct drm_connector *connector)
 {
+	struct hisi_connector *hconnector = to_hisi_connector(connector);
+	struct hisi_connector_funcs *ops = hconnector->ops;
+	struct drm_encoder *encoder = hconnector->encoder;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
 	int count = 0;
 
+	if (ops->get_modes) {
+		count += ops->get_modes(connector);
+	} else {
+		if (sfuncs && sfuncs->get_modes)
+			count += sfuncs->get_modes(encoder, connector);
+	}
+
 	return count;
 }
 
@@ -59,8 +83,18 @@ void hisi_drm_connector_destroy(struct drm_connector *connector)
 enum drm_connector_status
 hisi_drm_detect(struct drm_connector *connector, bool force)
 {
+	struct hisi_connector *hconnector = to_hisi_connector(connector);
+	struct drm_encoder *encoder = hconnector->encoder;
+	struct hisi_connector_funcs *ops = hconnector->ops;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
 	enum drm_connector_status status = connector_status_unknown;
 
+	if (ops->detect)
+		ops->detect(connector);
+
+	if (sfuncs && sfuncs->detect)
+		status = sfuncs->detect(encoder, connector);
+
 	return status;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_connector.h b/drivers/gpu/drm/hisilicon/hisi_drm_connector.h
index 114391c..a8b8409 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_connector.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_connector.h
@@ -13,9 +13,17 @@
 #ifndef __HISI_DRM_CONNECTOR_H__
 #define __HISI_DRM_CONNECTOR_H__
 
+struct hisi_connector_funcs {
+	enum drm_connector_status
+		(*detect) (struct drm_connector *connector);
+	int (*get_modes)(struct drm_connector *connector);
+	int (*modes_valid)(struct drm_connector *connector);
+};
+
 struct hisi_connector {
 	struct drm_connector connector;
 	struct drm_encoder *encoder;
+	void *ops;
 };
 
 void hisi_drm_connector_init(struct drm_device *dev,
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
index 046fd8e..8509ced 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_dsi.c
@@ -12,18 +12,72 @@
 
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <video/videomode.h>
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_encoder_slave.h>
 
 #include "hisi_drm_encoder.h"
 #include "hisi_drm_connector.h"
+#include "hisi_dsi_reg.h"
 
+#define encoder_to_dsi(encoder) \
+	container_of(encoder, struct hisi_dsi, hisi_encoder.base.base)
+
+#define MAX_TX_ESC_CLK		   (10)
 #define DSI_24BITS_1               (5)
+#define DSI_NON_BURST_SYNC_PULSES  (0)
+#define DSI_BURST_MODE    DSI_NON_BURST_SYNC_PULSES
+
+#define ROUND(x, y) ((x) / (y) + ((x) % (y) * 10 / (y) >= 5 ? 1 : 0))
+
+#define DEFAULT_MIPI_CLK_RATE   19200000
+#define DEFAULT_MIPI_CLK_PERIOD_PS (1000000000 / (DEFAULT_MIPI_CLK_RATE / 1000))
+
+#define R(x) ((u32)((((u64)(x) * (u64)1000 * (u64)dsi->vm.pixelclock) / \
+	      phy->lane_byte_clk_kHz)))
+
+struct mipi_phy_register {
+	u32 clk_t_lpx;
+	u32 clk_t_hs_prepare;
+	u32 clk_t_hs_zero;
+	u32 clk_t_hs_trial;
+	u32 clk_t_wakeup;
+	u32 data_t_lpx;
+	u32 data_t_hs_prepare;
+	u32 data_t_hs_zero;
+	u32 data_t_hs_trial;
+	u32 data_t_ta_go;
+	u32 data_t_ta_get;
+	u32 data_t_wakeup;
+	u32 hstx_ckg_sel;
+	u32 pll_fbd_div5f;
+	u32 pll_fbd_div1f;
+	u32 pll_fbd_2p;
+	u32 pll_enbwt;
+	u32 pll_fbd_p;
+	u32 pll_fbd_s;
+	u32 pll_pre_div1p;
+	u32 pll_pre_p;
+	u32 pll_vco_750M;
+	u32 pll_lpf_rs;
+	u32 pll_lpf_cs;
+	u32 clklp2hs_time;
+	u32 clkhs2lp_time;
+	u32 lp2hs_time;
+	u32 hs2lp_time;
+	u32 clk_to_data_delay;
+	u32 data_to_clk_delay;
+	u32 lane_byte_clk_kHz;
+	u32 clk_division;
+	u32 burst_mode;
+};
 
 struct hisi_dsi {
 	struct hisi_encoder hisi_encoder;
 	struct hisi_connector hisi_connector;
+	struct mipi_phy_register phy;
+	struct videomode vm;
 
 	u32 lanes;
 	u32 format;
@@ -35,6 +89,10 @@ struct hisi_dsi {
 
 struct hisi_dsi_context {
 	struct hisi_dsi dsi;
+#ifdef CONFIG_DRM_HISI_HAS_SLAVE_ENCODER
+	struct i2c_client *client;
+	struct drm_i2c_encoder_driver *drm_i2c_driver;
+#endif
 	struct clk *dsi_cfg_clk;
 	struct drm_device *dev;
 
@@ -42,6 +100,578 @@ struct hisi_dsi_context {
 	int nominal_pixel_clk_kHz;
 };
 
+struct dsi_phy_seq_info {
+	u32 min_range_kHz;
+	u32 max_range_kHz;
+	u32 pll_vco_750M;
+	u32 hstx_ckg_sel;
+};
+
+struct dsi_phy_seq_info dphy_seq_info[] = {
+	{   46000,    62000,   1,    7 },
+	{   62000,    93000,   0,    7 },
+	{   93000,   125000,   1,    6 },
+	{  125000,   187000,   0,    6 },
+	{  187000,   250000,   1,    5 },
+	{  250000,   375000,   0,    5 },
+	{  375000,   500000,   1,    4 },
+	{  500000,   750000,   0,    4 },
+	{  750000,  1000000,   1,    0 },
+	{ 1000000,  1500000,   0,    0 }
+};
+
+void set_dsi_phy_rate_equal_or_faster(u32 *phy_freq_kHz,
+				      struct mipi_phy_register *phy)
+{
+	u32 ui = 0;
+	u32 cfg_clk_ps = DEFAULT_MIPI_CLK_PERIOD_PS;
+	u32 i = 0;
+	u32 q_pll = 1;
+	u32 m_pll = 0;
+	u32 n_pll = 0;
+	u32 r_pll = 1;
+	u32 m_n = 0;
+	u32 m_n_int = 0;
+	u64 f_kHz;
+	u64 temp;
+
+	do {
+		f_kHz = *phy_freq_kHz;
+
+		/* Find the PLL clock range from the table */
+		for (i = 0; i < ARRAY_SIZE(dphy_seq_info); i++)
+			if (f_kHz > dphy_seq_info[i].min_range_kHz &&
+			    f_kHz <= dphy_seq_info[i].max_range_kHz)
+				break;
+
+		if (i == ARRAY_SIZE(dphy_seq_info)) {
+			DRM_ERROR("%lldkHz out of range\n", f_kHz);
+			return;
+		}
+
+		phy->pll_vco_750M = dphy_seq_info[i].pll_vco_750M;
+		phy->hstx_ckg_sel = dphy_seq_info[i].hstx_ckg_sel;
+
+		if (phy->hstx_ckg_sel <= 7 &&
+		    phy->hstx_ckg_sel >= 4)
+			q_pll = 0x10 >> (7 - phy->hstx_ckg_sel);
+
+		temp = f_kHz * (u64)q_pll * (u64)cfg_clk_ps;
+		m_n_int = temp / (u64)1000000000;
+		m_n = (temp % (u64)1000000000) / (u64)100000000;
+
+		if (m_n_int % 2 == 0) {
+			if (m_n * 6 >= 50) {
+				n_pll = 2;
+				m_pll = (m_n_int + 1) * n_pll;
+			} else if (m_n * 6 >= 30) {
+				n_pll = 3;
+				m_pll = m_n_int * n_pll + 2;
+			} else {
+				n_pll = 1;
+				m_pll = m_n_int * n_pll;
+			}
+		} else {
+			if (m_n * 6 >= 50) {
+				n_pll = 1;
+				m_pll = (m_n_int + 1) * n_pll;
+			} else if (m_n * 6 >= 30) {
+				n_pll = 1;
+				m_pll = (m_n_int + 1) * n_pll;
+			} else if (m_n * 6 >= 10) {
+				n_pll = 3;
+				m_pll = m_n_int * n_pll + 1;
+			} else {
+				n_pll = 2;
+				m_pll = m_n_int * n_pll;
+			}
+		}
+
+		if (n_pll == 1) {
+			phy->pll_fbd_p = 0;
+			phy->pll_pre_div1p = 1;
+		} else {
+			phy->pll_fbd_p = n_pll;
+			phy->pll_pre_div1p = 0;
+		}
+
+		if (phy->pll_fbd_2p <= 7 && phy->pll_fbd_2p >= 4)
+			r_pll = 0x10 >> (7 - phy->pll_fbd_2p);
+
+		if (m_pll == 2) {
+			phy->pll_pre_p = 0;
+			phy->pll_fbd_s = 0;
+			phy->pll_fbd_div1f = 0;
+			phy->pll_fbd_div5f = 1;
+		} else if (m_pll >= 2 * 2 * r_pll && m_pll <= 2 * 4 * r_pll) {
+			phy->pll_pre_p = m_pll / (2 * r_pll);
+			phy->pll_fbd_s = 0;
+			phy->pll_fbd_div1f = 1;
+			phy->pll_fbd_div5f = 0;
+		} else if (m_pll >= 2 * 5 * r_pll && m_pll <= 2 * 150 * r_pll) {
+			if (((m_pll / (2 * r_pll)) % 2) == 0) {
+				phy->pll_pre_p =
+					(m_pll / (2 * r_pll)) / 2 - 1;
+				phy->pll_fbd_s =
+					(m_pll / (2 * r_pll)) % 2 + 2;
+			} else {
+				phy->pll_pre_p =
+					(m_pll / (2 * r_pll)) / 2;
+				phy->pll_fbd_s =
+					(m_pll / (2 * r_pll)) % 2;
+			}
+			phy->pll_fbd_div1f = 0;
+			phy->pll_fbd_div5f = 0;
+		} else {
+			phy->pll_pre_p = 0;
+			phy->pll_fbd_s = 0;
+			phy->pll_fbd_div1f = 0;
+			phy->pll_fbd_div5f = 1;
+		}
+
+		f_kHz = (u64)1000000000 * (u64)m_pll /
+			((u64)cfg_clk_ps * (u64)n_pll * (u64)q_pll);
+
+		if (f_kHz >= *phy_freq_kHz)
+			break;
+
+		(*phy_freq_kHz) += 10;
+
+	} while (1);
+
+	*phy_freq_kHz = f_kHz;
+	ui = 1000000 / f_kHz;
+
+	phy->clk_t_lpx = ROUND(50, 8 * ui);
+	phy->clk_t_hs_prepare = ROUND(133, 16 * ui) - 1;
+
+	phy->clk_t_hs_zero = ROUND(262, 8 * ui);
+	phy->clk_t_hs_trial = 2 * (ROUND(60, 8 * ui) - 1);
+	phy->clk_t_wakeup = ROUND(1000000, (cfg_clk_ps / 1000) - 1);
+	if (phy->clk_t_wakeup > 0xff)
+		phy->clk_t_wakeup = 0xff;
+	phy->data_t_wakeup = phy->clk_t_wakeup;
+	phy->data_t_lpx = phy->clk_t_lpx;
+	phy->data_t_hs_prepare = ROUND(125 + 10 * ui, 16 * ui) - 1;
+	phy->data_t_hs_zero = ROUND(105 + 6 * ui, 8 * ui);
+	phy->data_t_hs_trial = 2 * (ROUND(60 + 4 * ui, 8 * ui) - 1);
+	phy->data_t_ta_go = 3;
+	phy->data_t_ta_get = 4;
+
+	phy->pll_enbwt = 1;
+	phy->clklp2hs_time = ROUND(407, 8 * ui) + 12;
+	phy->clkhs2lp_time = ROUND(105 + 12 * ui, 8 * ui);
+	phy->lp2hs_time = ROUND(240 + 12 * ui, 8 * ui) + 1;
+	phy->hs2lp_time = phy->clkhs2lp_time;
+	phy->clk_to_data_delay = 1 + phy->clklp2hs_time;
+	phy->data_to_clk_delay = ROUND(60 + 52 * ui, 8 * ui) +
+				phy->clkhs2lp_time;
+
+	phy->lane_byte_clk_kHz = f_kHz / 8;
+	phy->clk_division = phy->lane_byte_clk_kHz / MAX_TX_ESC_CLK;
+	if (phy->lane_byte_clk_kHz % MAX_TX_ESC_CLK)
+		phy->clk_division++;
+
+	phy->burst_mode = DSI_BURST_MODE;
+}
+
+int dsi_mipi_init(struct hisi_dsi *dsi)
+{
+	struct hisi_dsi_context *ctx = dsi->ctx;
+	struct mipi_phy_register *phy = &dsi->phy;
+	void __iomem *base = ctx->base;
+
+	u32 i = 0;
+	u32 hline_time = 0;
+	u32 hsa_time = 0;
+	u32 hbp_time = 0;
+	u32 pixel_clk_kHz;
+	u32 delay_count = 0;
+	int refresh_nom, refresh_real;
+	int htot, vtot, blc_hactive;
+	int tmp, tmp1, val;
+	bool is_ready = false;
+
+	/* reset Core */
+	writel(PWR_UP_OFF, base + PWR_UP);
+
+	/* set lanes value */
+	val = (dsi->lanes - 1);
+	val |= PHY_STOP_WAIT_TIME << 8;
+	writel(val, base + PHY_IF_CFG);
+
+	/* set phy clk division */
+	writel(phy->clk_division, base + CLKMGR_CFG);
+
+	/* clean up phy set param */
+	writel(0x00, base + PHY_RSTZ);
+	writel(0x00, base + PHY_TST_CTRL0);
+	writel(0x01, base + PHY_TST_CTRL0);
+	writel(0x00, base + PHY_TST_CTRL0);
+
+	/* clock lane Timing control - TLPX */
+	dsi_phy_tst_set(base, CLK_LPX_ADDR, phy->clk_t_lpx);
+
+	/* clock lane Timing control - THS-PREPARE */
+	dsi_phy_tst_set(base, CLK_HS_PRE_ADDR, phy->clk_t_hs_prepare);
+
+	/* clock lane Timing control - THS-ZERO */
+	dsi_phy_tst_set(base, CLK_HS_ZERO_ADDR, phy->clk_t_hs_zero);
+
+	/* clock lane Timing control - THS-TRAIL */
+	dsi_phy_tst_set(base, CLK_HS_TRIAL_ADDR, phy->clk_t_hs_trial);
+
+	/* clock lane Timing control - TWAKEUP */
+	dsi_phy_tst_set(base, CLK_WAKEUP_ADDR, phy->clk_t_wakeup);
+
+	/* data lane */
+	for (i = 0; i < dsi->lanes; i++) {
+		/* Timing control - TLPX*/
+		dsi_phy_tst_set(base, DATA_LPX_ADDR + (i << 4),
+				phy->data_t_lpx);
+
+		/* Timing control - THS-PREPARE */
+		dsi_phy_tst_set(base, DATA_HS_PRE_ADDR + (i << 4),
+				phy->data_t_hs_prepare);
+
+		/* Timing control - THS-ZERO */
+		dsi_phy_tst_set(base, DATA_HS_ZERO_ADDR + (i << 4),
+				phy->data_t_hs_zero);
+
+		/* Timing control - THS-TRAIL */
+		dsi_phy_tst_set(base, DATA_HS_TRIAL_ADDR + (i << 4),
+				phy->data_t_hs_trial);
+
+		/* Timing control - TTA-GO */
+		dsi_phy_tst_set(base, DATA_TA_GO_ADDR + (i << 4),
+				phy->data_t_ta_go);
+
+		/* Timing control - TTA-GET */
+		dsi_phy_tst_set(base, DATA_TA_GET_ADDR + (i << 4),
+				phy->data_t_ta_get);
+
+		/*  Timing control - TWAKEUP */
+		dsi_phy_tst_set(base, DATA_WAKEUP_ADDR + (i << 4),
+				phy->data_t_wakeup);
+	}
+
+	/* physical configuration I  */
+	dsi_phy_tst_set(base, HSTX_CKG_SEL_ADDR, phy->hstx_ckg_sel);
+
+	/* physical configuration pll II  */
+	val = (phy->pll_fbd_div5f << 5) + (phy->pll_fbd_div1f << 4) +
+				(phy->pll_fbd_2p << 1) + phy->pll_enbwt;
+	dsi_phy_tst_set(base, PLL_FBD_DPN_ADDR, val);
+
+	/* physical configuration pll II  */
+	dsi_phy_tst_set(base, PLL_FBD_P_ADDR, phy->pll_fbd_p);
+
+	/* physical configuration pll III  */
+	dsi_phy_tst_set(base, PLL_FBD_S_ADDR, phy->pll_fbd_s);
+
+	/*physical configuration pll IV*/
+	val = (phy->pll_pre_div1p << 7) + phy->pll_pre_p;
+	dsi_phy_tst_set(base, PLL_PRA_DP_ADDR, val);
+
+	/*physical configuration pll V*/
+	val = (phy->pll_vco_750M << 4) + (phy->pll_lpf_rs << 2) +
+					phy->pll_lpf_cs + BIT(5);
+	dsi_phy_tst_set(base, PLL_LPF_VOF_ADDR, val);
+
+	writel(0x04, base + PHY_RSTZ);
+	udelay(1);
+
+	writel(0x05, base + PHY_RSTZ);
+	udelay(1);
+
+	writel(0x07, base + PHY_RSTZ);
+	usleep_range(1000, 1500);
+
+	while (1) {
+		val = readl(base +  PHY_STATUS);
+		if ((0x01 & val) || delay_count > 100) {
+			is_ready = (delay_count < 100) ? true : false;
+			delay_count = 0;
+			break;
+		}
+
+		udelay(1);
+		++delay_count;
+	}
+
+	if (!is_ready)
+		DRM_INFO("phylock is not ready.\n");
+
+	while (1) {
+		val = readl(base + PHY_STATUS);
+		if ((BIT(2) & val) || delay_count > 100) {
+			is_ready = (delay_count < 100) ? true : false;
+			break;
+		}
+
+		udelay(1);
+		++delay_count;
+	}
+
+	if (!is_ready)
+		DRM_INFO("phystopstateclklane is not ready.\n");
+
+	/* DSI color mode setting */
+	writel(0, base + DPI_VCID);
+	writel(dsi->color_mode, base + DPI_COLOR_CODING);
+
+	/* DSI format and pol setting */
+	val = dsi->date_enable_pol;
+	val |= (dsi->vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ? 0 : 1) << 0x2;
+	val |= (dsi->vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ? 0 : 1) << 0x1;
+	writel(val, base +  DPI_CFG_POL);
+
+	if (dsi->format == MIPI_DSI_FMT_RGB666)
+		writel(dsi->color_mode | BIT(9), base + DPI_COLOR_CODING);
+
+	/*
+	 * The DSI IP accepts vertical timing using lines as normal,
+	 * but horizontal timing is a mixture of pixel-clocks for the
+	 * active region and byte-lane clocks for the blanking-related
+	 * timings.  hfp is specified as the total hline_time in byte-
+	 * lane clocks minus hsa, hbp and active.
+	 */
+
+	htot = dsi->vm.hactive + dsi->vm.hsync_len +
+		  dsi->vm.hfront_porch + dsi->vm.hback_porch;
+	vtot = dsi->vm.vactive + dsi->vm.vsync_len +
+		  dsi->vm.vfront_porch + dsi->vm.vback_porch;
+
+	pixel_clk_kHz = dsi->vm.pixelclock;
+
+	hsa_time = (dsi->vm.hsync_len * phy->lane_byte_clk_kHz) /
+		   pixel_clk_kHz;
+	hbp_time = (dsi->vm.hback_porch * phy->lane_byte_clk_kHz) /
+		   pixel_clk_kHz;
+	hline_time  = (((u64)htot * (u64)phy->lane_byte_clk_kHz)) /
+		      pixel_clk_kHz;
+	blc_hactive  = (((u64)dsi->vm.hactive *
+			(u64)phy->lane_byte_clk_kHz)) / pixel_clk_kHz;
+
+	if ((R(hline_time) / 1000) > htot)
+		hline_time--;
+
+	if ((R(hline_time) / 1000) < htot)
+		hline_time++;
+
+	/* all specified in byte-lane clocks */
+	writel(hsa_time, base + VID_HSA_TIME);
+	writel(hbp_time, base + VID_HBP_TIME);
+	writel(hline_time, base + VID_HLINE_TIME);
+
+	if (dsi->vm.vsync_len > 15)
+		dsi->vm.vsync_len = 15;
+
+	writel(dsi->vm.vsync_len, base + VID_VSA_LINES);
+	writel(dsi->vm.vback_porch, base + VID_VBP_LINES);
+	writel(dsi->vm.vfront_porch, base + VID_VFP_LINES);
+	writel(dsi->vm.vactive, base + VID_VACTIVE_LINES);
+	writel(dsi->vm.hactive, base + VID_PKT_SIZE);
+
+	refresh_nom = ((u64)ctx->nominal_pixel_clk_kHz * 1000000) /
+		      (htot * vtot);
+
+	tmp = 1000000000 / dsi->vm.pixelclock;
+	tmp1 = 1000000000 / phy->lane_byte_clk_kHz;
+
+	refresh_real = ((u64)dsi->vm.pixelclock * (u64)1000000000) /
+		      ((u64)R(hline_time) * (u64)vtot);
+
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
+		/*
+		 * we disable this since it affects downstream
+		 * DSI -> HDMI converter output
+		 */
+		writel(0x00, base + VID_MODE_CFG);
+
+		/*VSA/VBP/VFP max transfer byte in LP mode*/
+		writel(0x00, base + DPI_LP_CMD_TIM);
+		/* enable LP command transfer */
+		writel(0x00, base + VID_MODE_CFG);
+		/* config max read time */
+		writel(PHY_MAX_TIME, base + PHY_TMR_CFG);
+	}
+
+	/* Configure core's phy parameters */
+	writel(0xFFF, base + BTA_TO_CNT);
+
+	val = 0xFF;
+	val |= (phy->lp2hs_time) << 16;
+	val |= (phy->hs2lp_time) << 24;
+	writel(val, base + PHY_TMR_CFG);
+
+	val = phy->clklp2hs_time;
+	val |= (phy->clkhs2lp_time) << 16;
+	writel(val, base + PHY_TMR_LPCLK_CFG);
+
+	/* setting burst mode */
+	val = phy->clk_to_data_delay;
+	val |= (phy->data_to_clk_delay) << 8;
+	writel(val, base + NO_CONTINUE);
+	writel(0x00, base + VID_MODE_CFG);
+	writel(phy->burst_mode, base + VID_MODE_CFG);
+	writel(0x0, base + LPCLK_CTRL);
+
+	/* for dsi read */
+	writel(0x0, base + PCKHDL_CFG);
+
+	/* Enable EOTP TX; Enable EDPI */
+	if (dsi->mode_flags == MIPI_DSI_MODE_VIDEO)
+		writel(dsi->vm.hactive, base + EDPI_CMD_SIZE);
+
+	/* DSI and D-PHY Initialization */
+	writel(VIDEO_MODE, base + MODE_CFG);
+	writel(0x1, base + LPCLK_CTRL);
+
+	writel(PWR_UP_ON, base + PWR_UP);
+
+	return 0;
+}
+
+static void dsi_encoder_disable(struct drm_encoder *encoder)
+{
+	struct hisi_dsi *dsi = encoder_to_dsi(encoder);
+	struct hisi_dsi_context *ctx = dsi->ctx;
+	void __iomem *base = ctx->base;
+
+	writel(PWR_UP_OFF, base + PWR_UP);
+	writel(0x00, base + LPCLK_CTRL);
+	writel(0x00, base + PHY_RSTZ);
+	clk_disable_unprepare(ctx->dsi_cfg_clk);
+}
+
+static void dsi_encoder_enable(struct drm_encoder *encoder)
+{
+	struct hisi_dsi *dsi = encoder_to_dsi(encoder);
+	struct hisi_dsi_context *ctx = dsi->ctx;
+	int ret;
+
+	/* mipi dphy clock enable */
+	ret = clk_prepare_enable(ctx->dsi_cfg_clk);
+	if (ret) {
+		DRM_ERROR("fail to enable dsi_cfg_clk: %d\n", ret);
+		return;
+	}
+
+	ret = dsi_mipi_init(dsi);
+	if (ret) {
+		DRM_ERROR("failed to init mipi: %d!\n", ret);
+		return;
+	}
+}
+
+void dsi_encoder_mode_set(struct drm_encoder *encoder,
+			  struct drm_display_mode *mode,
+			  struct drm_display_mode *adjusted_mode)
+{
+	struct hisi_dsi *dsi = encoder_to_dsi(encoder);
+	struct hisi_dsi_context *ctx = dsi->ctx;
+	struct videomode *vm = &dsi->vm;
+	u32 dphy_freq_kHz;
+
+	vm->flags = 0;
+	vm->hactive = mode->hdisplay;
+	vm->vactive = mode->vdisplay;
+	vm->vfront_porch = mode->vsync_start - mode->vdisplay;
+	vm->vback_porch = mode->vtotal - mode->vsync_end;
+	vm->vsync_len = mode->vsync_end - mode->vsync_start;
+	vm->hfront_porch = mode->hsync_start - mode->hdisplay;
+	vm->hback_porch = mode->htotal - mode->hsync_end;
+	vm->hsync_len = mode->hsync_end - mode->hsync_start;
+
+	vm->pixelclock = adjusted_mode->clock;
+	ctx->nominal_pixel_clk_kHz = mode->clock;
+	dsi->lanes = 3 + !!(vm->pixelclock >= 115000);
+	dphy_freq_kHz = vm->pixelclock * 24 / dsi->lanes;
+
+	/* avoid a less-compatible DSI rate with 1.2GHz px PLL */
+	if (dphy_freq_kHz == 600000)
+		dphy_freq_kHz = 640000;
+
+	set_dsi_phy_rate_equal_or_faster(&dphy_freq_kHz, &dsi->phy);
+
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		vm->flags |= DISPLAY_FLAGS_HSYNC_HIGH;
+	else if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		vm->flags |= DISPLAY_FLAGS_HSYNC_LOW;
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		vm->flags |= DISPLAY_FLAGS_VSYNC_HIGH;
+	else if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		vm->flags |= DISPLAY_FLAGS_VSYNC_LOW;
+}
+
+static struct drm_display_mode mode_720p = {
+	.name		= "1280x720",
+	.vrefresh	= 60,
+	.clock		= 74250,
+	.hdisplay	= 1280,
+	.hsync_start	= 1390,
+	.hsync_end	= 1430,
+	.htotal		= 1650,
+	.vdisplay	= 720,
+	.vsync_start	= 725,
+	.vsync_end	= 730,
+	.vtotal		= 750,
+	.type		= DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER,
+	.flags		= DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+	.width_mm	= 735,
+	.height_mm	= 420,
+};
+
+/* 800x600 at 60 works well, so add to defaut modes */
+static struct drm_display_mode mode_800x600 = {
+	.name		= "800x600",
+	.vrefresh	= 60,
+	.clock		= 40000,
+	.hdisplay	= 800,
+	.hsync_start	= 840,
+	.hsync_end	= 968,
+	.htotal		= 1056,
+	.vdisplay	= 600,
+	.vsync_start	= 601,
+	.vsync_end	= 605,
+	.vtotal		= 628,
+	.type		= DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER,
+	.flags		= DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+	.width_mm	= 735,
+	.height_mm	= 420,
+};
+
+static int dsi_connector_get_modes(struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+
+	/* 1280x720 at 60: 720P */
+	mode = drm_mode_duplicate(connector->dev, &mode_720p);
+	if (!mode)
+		DRM_ERROR("failed to create a new display mode\n");
+
+	drm_mode_probed_add(connector, mode);
+
+	/* 800x600 at 60 */
+	mode = drm_mode_duplicate(connector->dev, &mode_800x600);
+	if (!mode)
+		DRM_ERROR("failed to create a new display mode\n");
+	drm_mode_probed_add(connector, mode);
+
+	return 2;
+}
+
+struct hisi_connector_funcs hisi_dsi_connector_ops = {
+	.get_modes = dsi_connector_get_modes,
+};
+
+struct hisi_encoder_funcs hisi_dsi_encoder_ops = {
+	.mode_set = dsi_encoder_mode_set,
+	.enable = dsi_encoder_enable,
+	.disable = dsi_encoder_disable,
+};
+
 static int hisi_dsi_bind(struct device *dev, struct device *master,
 			 void *data)
 {
@@ -52,8 +682,23 @@ static int hisi_dsi_bind(struct device *dev, struct device *master,
 
 	hisi_drm_encoder_init(ctx->dev, &ctx->dsi.hisi_encoder.base.base);
 
+#ifdef CONFIG_DRM_HISI_HAS_SLAVE_ENCODER
+	ret = ctx->drm_i2c_driver->encoder_init(ctx->client, ctx->dev,
+						&ctx->dsi.hisi_encoder.base);
+	if (ret) {
+		DRM_ERROR("fail to init drm i2c encoder\n");
+		return ret;
+	}
+
+	if (!ctx->dsi.hisi_encoder.base.slave_funcs) {
+		DRM_ERROR("failed check encoder function\n");
+		return -ENODEV;
+	}
+#endif
+
 	hisi_drm_connector_init(ctx->dev, &ctx->dsi.hisi_encoder.base.base,
 				&ctx->dsi.hisi_connector.connector);
+
 	return ret;
 }
 
@@ -102,6 +747,27 @@ static int hisi_dsi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_DRM_HISI_HAS_SLAVE_ENCODER
+	ctx->client = of_find_i2c_device_by_node(slave_node);
+	of_node_put(slave_node);
+	if (!ctx->client) {
+		DRM_ERROR("failed to find slave encoder i2c client\n");
+		return -EPROBE_DEFER;
+	}
+
+	if (!ctx->client->dev.driver) {
+		DRM_ERROR("%s: NULL client driver\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	ctx->drm_i2c_driver = to_drm_i2c_encoder_driver(
+		to_i2c_driver(ctx->client->dev.driver));
+	if (IS_ERR(ctx->drm_i2c_driver)) {
+		DRM_ERROR("failed to initialize encoder driver");
+		return -EPROBE_DEFER;
+	}
+#endif
+
 	dsi = &ctx->dsi;
 	dsi->ctx = ctx;
 	dsi->lanes = 3;
@@ -110,6 +776,10 @@ static int hisi_dsi_probe(struct platform_device *pdev)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
 
+	dsi->hisi_encoder.ops = &hisi_dsi_encoder_ops;
+	dsi->hisi_connector.encoder = &dsi->hisi_encoder.base.base;
+	dsi->hisi_connector.ops = &hisi_dsi_connector_ops;
+
 	return component_add(&pdev->dev, &hisi_dsi_ops);
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
index 89fc73d..acd73d8 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.c
@@ -15,18 +15,49 @@
 
 #include "hisi_drm_encoder.h"
 
+#define to_hisi_encoder(encoder) \
+	container_of(encoder, struct hisi_encoder, base.base)
+
 void hisi_drm_encoder_disable(struct drm_encoder *encoder)
 {
+	struct hisi_encoder *hencoder = to_hisi_encoder(encoder);
+	struct hisi_encoder_funcs *ops = hencoder->ops;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+
+	if (ops->enable)
+		ops->disable(encoder);
+
+	if (sfuncs && sfuncs->dpms)
+		sfuncs->dpms(encoder, DRM_MODE_DPMS_OFF);
 }
 
 void hisi_drm_encoder_enable(struct drm_encoder *encoder)
 {
+	struct hisi_encoder *hencoder = to_hisi_encoder(encoder);
+	struct hisi_encoder_funcs *ops = hencoder->ops;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+
+	if (ops->enable)
+		ops->enable(encoder);
+
+	if (sfuncs && sfuncs->dpms)
+		sfuncs->dpms(encoder, DRM_MODE_DPMS_ON);
 }
 
 void hisi_drm_encoder_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
 {
+	struct hisi_encoder *hencoder = to_hisi_encoder(encoder);
+	struct hisi_encoder_funcs *ops = hencoder->ops;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+
+	if (ops->mode_set)
+		ops->mode_set(encoder, mode, adjusted_mode);
+
+	if (sfuncs && sfuncs->mode_set)
+		sfuncs->mode_set(encoder, mode, adjusted_mode);
+
 }
 
 bool
@@ -34,13 +65,34 @@ hisi_drm_encoder_mode_fixup(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode,
 			    struct drm_display_mode *adjusted_mode)
 {
+	struct hisi_encoder *hencoder = to_hisi_encoder(encoder);
+	struct hisi_encoder_funcs *ops = hencoder->ops;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
 	bool ret = true;
 
+	if (ops->mode_fixup)
+		ops->mode_fixup(encoder, mode, adjusted_mode);
+
+	if (sfuncs && sfuncs->mode_fixup)
+		ret = sfuncs->mode_fixup(encoder, mode, adjusted_mode);
+
 	return ret;
 }
 
 void hisi_drm_encoder_destroy(struct drm_encoder *encoder)
 {
+	struct hisi_encoder *hencoder = to_hisi_encoder(encoder);
+	struct hisi_encoder_funcs *ops = hencoder->ops;
+	struct drm_encoder_slave_funcs *sfuncs = get_slave_funcs(encoder);
+
+	if (ops->destroy)
+		ops->destroy(encoder);
+
+	/*release*/
+	if (sfuncs && sfuncs->destroy)
+		sfuncs->destroy(encoder);
+
+	drm_encoder_cleanup(encoder);
 }
 
 static struct drm_encoder_helper_funcs hisi_encoder_helper_funcs = {
diff --git a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.h b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.h
index 31c04e4..06e4e22 100644
--- a/drivers/gpu/drm/hisilicon/hisi_drm_encoder.h
+++ b/drivers/gpu/drm/hisilicon/hisi_drm_encoder.h
@@ -13,10 +13,29 @@
 #ifndef __HISI_DRM_ENCODER_H__
 #define __HISI_DRM_ENCODER_H__
 
+struct hisi_encoder_funcs {
+	void (*destroy)(struct drm_encoder *encoder);
+	bool (*mode_fixup)(struct drm_encoder *encoder,
+			   const struct drm_display_mode *mode,
+			   struct drm_display_mode *adjusted_mode);
+	void (*mode_set)(struct drm_encoder *encoder,
+			 struct drm_display_mode *mode,
+			 struct drm_display_mode *adjusted_mode);
+	void (*enable)(struct drm_encoder *encoder);
+	void (*disable)(struct drm_encoder *encoder);
+};
+
 struct hisi_encoder {
 	struct drm_encoder_slave base;
+	void *ops;
 };
 
+static inline struct drm_encoder_slave_funcs *
+		get_slave_funcs(struct drm_encoder *enc)
+{
+	return to_encoder_slave(enc)->slave_funcs;
+}
+
 void hisi_drm_encoder_init(struct drm_device *dev, struct drm_encoder *encoder);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hisi_dsi_reg.h b/drivers/gpu/drm/hisilicon/hisi_dsi_reg.h
new file mode 100644
index 0000000..1ab949f
--- /dev/null
+++ b/drivers/gpu/drm/hisilicon/hisi_dsi_reg.h
@@ -0,0 +1,91 @@
+/*
+ *  Hisilicon Terminal SoCs drm driver
+ *
+ *  Copyright (c) 2014-2015 Hisilicon Limited.
+ *  Author:
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+#ifndef __HISI_DSI_REG_H__
+#define __HISI_DSI_REG_H__
+
+#define  PWR_UP_ON               (1)
+#define  PWR_UP_OFF              (0)
+#define  COMMAND_MODE            (1)
+#define  VIDEO_MODE              (0)
+#define  PHY_MAX_TIME            (0xFF)
+
+#define  PWR_UP                  (0x4)   /* Core power-up */
+#define  PHY_IF_CFG              (0xA4)  /* D-PHY interface configuration */
+#define  CLKMGR_CFG              (0x8)   /* the internal clock dividers */
+#define  PHY_RSTZ                (0xA0)  /* D-PHY reset control */
+#define  PHY_TST_CTRL0           (0xB4)  /* D-PHY test interface control 0 */
+#define  PHY_TST_CTRL1           (0xB8)  /* D-PHY test interface control 1 */
+#define  DPI_VCID                (0xC)   /* DPI virtual channel id */
+#define  DPI_COLOR_CODING        (0x10)  /* DPI color coding */
+#define  DPI_CFG_POL             (0x14)  /* DPI polarity configuration */
+#define  VID_HSA_TIME            (0x48)  /* Horizontal Sync Active time */
+#define  VID_HBP_TIME            (0x4C)  /* Horizontal Back Porch time */
+#define  VID_HLINE_TIME          (0x50)  /* Line time */
+#define  VID_VSA_LINES           (0x54)  /* Vertical Sync Active period */
+#define  VID_VBP_LINES           (0x58)  /* Vertical Back Porch period */
+#define  VID_VFP_LINES           (0x5C)  /* Vertical Front Porch period */
+#define  VID_VACTIVE_LINES       (0x60)  /* Vertical resolution */
+#define  VID_PKT_SIZE            (0x3C)  /* Video packet size */
+#define  VID_MODE_CFG            (0x38)  /* Video mode configuration */
+#define  DPI_LP_CMD_TIM          (0x18)  /* Low-power command timing config */
+#define  PHY_TMR_CFG             (0x9C)  /* Data lanes timing configuration */
+#define  BTA_TO_CNT              (0x8C)  /* Response timeout definition */
+#define  PHY_TMR_LPCLK_CFG       (0x98)  /* clock lane timing configuration */
+#define  NO_CONTINUE             (0xCC)
+#define  LPCLK_CTRL              (0x94)  /* Low-power in clock lane */
+#define  PCKHDL_CFG              (0x2C)  /* Packet handler configuration */
+#define  EDPI_CMD_SIZE           (0x64)  /* Size for eDPI packets */
+#define  MODE_CFG                (0x34)  /* Video or Command mode selection */
+#define  PHY_STATUS              (0xB0)  /* D-PHY PPI status interface */
+
+#define	PHY_STOP_WAIT_TIME      (0x30)
+#define CLK_LPX_ADDR		(0x10010)
+#define CLK_HS_PRE_ADDR		(0x10011)
+#define CLK_HS_ZERO_ADDR	(0x10012)
+#define CLK_HS_TRIAL_ADDR	(0x10013)
+#define CLK_WAKEUP_ADDR		(0x10014)
+#define DATA_LPX_ADDR		(0x10020)
+#define DATA_HS_PRE_ADDR        (0x10021)
+#define DATA_HS_ZERO_ADDR       (0x10022)
+#define DATA_HS_TRIAL_ADDR      (0x10023)
+#define DATA_TA_GO_ADDR         (0x10024)
+#define DATA_TA_GET_ADDR        (0x10025)
+#define DATA_WAKEUP_ADDR        (0x10026)
+#define HSTX_CKG_SEL_ADDR	(0x10060)
+#define PLL_FBD_DPN_ADDR	(0x10063)
+#define PLL_FBD_P_ADDR		(0x10064)
+#define PLL_FBD_S_ADDR		(0x10065)
+#define PLL_PRA_DP_ADDR		(0x10066)
+#define PLL_LPF_VOF_ADDR	(0x10067)
+
+static void dsi_phy_tst_set(void __iomem *base, u32 reg_addr,
+			    u32 reg_data)
+{
+	writel(reg_addr, base + PHY_TST_CTRL1);
+	/* reg addr written at first */
+	wmb();
+	writel(0x02, base + PHY_TST_CTRL0);
+	/* cmd1 sent for write */
+	wmb();
+	writel(0x00, base + PHY_TST_CTRL0);
+	/* cmd2 sent for write */
+	wmb();
+	writel(reg_data, base + PHY_TST_CTRL1);
+	/* Then write data */
+	wmb();
+	writel(0x02, base + PHY_TST_CTRL0);
+	/* cmd2 sent for write */
+	wmb();
+	writel(0x00, base + PHY_TST_CTRL0);
+}
+
+#endif /* __HISI_DRM_DSI_H__ */
-- 
1.9.1
