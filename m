From: ykk@rock-chips.com (Yakir Yang)
Date: Thu,  7 Jan 2016 12:37:27 +0800
Subject: [RFC PATCH v1 1/2] drm: rockchip: hdmi: add RK3229 HDMI support
In-Reply-To: <1452141288-9292-1-git-send-email-ykk@rock-chips.com>
References: <1452141288-9292-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1452141447-9441-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3229 integrate an DesignedWare HDMI2.0 controller and an INNO HDMI2.0 phy,
the max output resolution is 4K.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/bridge/dw-hdmi.c            |  33 ++-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 380 +++++++++++++++++++++++++---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h | 137 ++++++++++
 include/drm/bridge/dw_hdmi.h                |   5 +-
 4 files changed, 516 insertions(+), 39 deletions(-)
 create mode 100644 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h

diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index 6fbec99..60b1dcf 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -735,10 +735,12 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 {
 	unsigned res_idx;
 	u8 val, msec;
+	int ret;
 	const struct dw_hdmi_plat_data *pdata = hdmi->plat_data;
 	const struct dw_hdmi_mpll_config *mpll_config = pdata->mpll_cfg;
 	const struct dw_hdmi_curr_ctrl *curr_ctrl = pdata->cur_ctr;
 	const struct dw_hdmi_phy_config *phy_config = pdata->phy_config;
+	int mpixelclock = hdmi->hdmi_data.video_mode.mpixelclock;
 
 	if (prep)
 		return -EINVAL;
@@ -758,27 +760,38 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi, unsigned char prep,
 		return -EINVAL;
 	}
 
+	if (hdmi->plat_data->extphy_config) {
+		/* gen2 tx power off */
+		dw_hdmi_phy_gen2_txpwron(hdmi, 0);
+		dw_hdmi_phy_gen2_pddq(hdmi, 1);
+
+		ret = hdmi->plat_data->extphy_config(hdmi->plat_data, res_idx,
+						     mpixelclock);
+		/* gen2 tx power on */
+		dw_hdmi_phy_gen2_txpwron(hdmi, 1);
+		dw_hdmi_phy_gen2_pddq(hdmi, 0);
+
+		return ret;
+	}
+
 	/* PLL/MPLL Cfg - always match on final entry */
 	for (; mpll_config->mpixelclock != ~0UL; mpll_config++)
-		if (hdmi->hdmi_data.video_mode.mpixelclock <=
-		    mpll_config->mpixelclock)
+		if (mpixelclock <= mpll_config->mpixelclock)
 			break;
 
 	for (; curr_ctrl->mpixelclock != ~0UL; curr_ctrl++)
-		if (hdmi->hdmi_data.video_mode.mpixelclock <=
-		    curr_ctrl->mpixelclock)
+		if (mpixelclock <= curr_ctrl->mpixelclock)
 			break;
 
 	for (; phy_config->mpixelclock != ~0UL; phy_config++)
-		if (hdmi->hdmi_data.video_mode.mpixelclock <=
-		    phy_config->mpixelclock)
+		if (mpixelclock <= phy_config->mpixelclock)
 			break;
 
 	if (mpll_config->mpixelclock == ~0UL ||
 	    curr_ctrl->mpixelclock == ~0UL ||
 	    phy_config->mpixelclock == ~0UL) {
 		dev_err(hdmi->dev, "Pixel clock %d - unsupported by HDMI\n",
-			hdmi->hdmi_data.video_mode.mpixelclock);
+			mpixelclock);
 		return -EINVAL;
 	}
 
@@ -1476,14 +1489,16 @@ dw_hdmi_connector_mode_valid(struct drm_connector *connector,
 {
 	struct dw_hdmi *hdmi = container_of(connector,
 					   struct dw_hdmi, connector);
+	struct dw_hdmi_plat_data *plat_data = hdmi->plat_data;
 	enum drm_mode_status mode_status = MODE_OK;
 
 	/* We don't support double-clocked modes */
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		return MODE_BAD;
 
-	if (hdmi->plat_data->mode_valid)
-		mode_status = hdmi->plat_data->mode_valid(connector, mode);
+	if (plat_data->mode_valid)
+		mode_status = plat_data->mode_valid(plat_data, mode);
+
 
 	return mode_status;
 }
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index c65ce8c..424d548 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -7,6 +7,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
@@ -21,18 +22,135 @@
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_vop.h"
 
-#define GRF_SOC_CON6                    0x025c
-#define HDMI_SEL_VOP_LIT                (1 << 4)
+#include "dw_hdmi-rockchip.h"
 
 struct rockchip_hdmi {
 	struct device *dev;
 	struct regmap *regmap;
 	struct drm_encoder encoder;
+	struct dw_hdmi_plat_data plat_data;
+
+	void __iomem *extphy_regbase;
+	struct clk *extphy_pclk;
 };
 
 #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
 
-static const struct dw_hdmi_mpll_config rockchip_mpll_cfg[] = {
+static const struct extphy_config_tab rk3229_extphy_cfg[] = {
+	{ .mpixelclock = 165000000,
+	  .pre_emphasis = 0, .slopeboost = 0, .clk_level = 4,
+	  .data0_level = 4, 4, 4,
+	},
+
+	{ .mpixelclock = 225000000,
+	  .pre_emphasis = 0, .slopeboost = 0, .clk_level = 6,
+	  .data0_level = 6, 6, 6,
+	},
+
+	{ .mpixelclock = 340000000,
+	  .pre_emphasis = 1, .slopeboost = 0, .clk_level = 6,
+	  .data0_level = 10, 10, 10,
+	},
+
+	{ .mpixelclock = 594000000,
+	  .pre_emphasis = 1, .slopeboost = 0, .clk_level = 7,
+	  .data0_level = 10, 10, 10,
+	},
+
+	{ .mpixelclock = ~0UL},
+};
+
+static const struct extphy_pll_config_tab rk3229_extphy_pll_cfg[] = {
+	{
+		.mpixelclock = 27000000, .param = {
+			{ .pll_nd = 1, .pll_nf = 45,
+			  .tmsd_divider_a = 3, 1, 1,
+			  .pclk_divider_a = 1, 3, 3, 4,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 1, .ppll_nf = 40, .ppll_no = 8,
+			},
+			{ .pll_nd = 1, .pll_nf = 45,
+			  .tmsd_divider_a = 0, 3, 3,
+			  .pclk_divider_a = 1, 3, 3, 4,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 1, .ppll_nf = 40, .ppll_no = 8,
+			},
+		},
+	}, {
+		.mpixelclock = 59400000, .param = {
+			{ .pll_nd = 2, .pll_nf = 99,
+			  .tmsd_divider_a = 3, 1, 1,
+			  .pclk_divider_a = 1, 3, 2, 2,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 1, .ppll_nf = 40, .ppll_no = 8,
+			},
+			{ .pll_nd = 2, .pll_nf = 99,
+			  .tmsd_divider_a = 1, 1, 1,
+			  .pclk_divider_a = 1, 3, 2, 2,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 1, .ppll_nf = 40, .ppll_no = 8,
+			},
+		},
+	}, {
+		.mpixelclock = 74250000, .param = {
+			{ .pll_nd = 2, .pll_nf = 99,
+			  .tmsd_divider_a = 1, 1, 1,
+			  .pclk_divider_a = 1, 2, 2, 2,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 1, .ppll_nf = 40, .ppll_no = 8,
+			},
+			{ .pll_nd = 4, .pll_nf = 495,
+			  .tmsd_divider_a = 1, 2, 2,
+			  .pclk_divider_a = 1, 3, 3, 4,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 2, .ppll_nf = 40, .ppll_no = 4,
+			},
+		},
+	}, {
+		.mpixelclock = 148500000, .param = {
+			{ .pll_nd = 2, .pll_nf = 99,
+			  .tmsd_divider_a = 1, 0, 0,
+			  .pclk_divider_a = 1, 2, 1, 1,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 2, .ppll_nf = 40, .ppll_no = 4,
+			},
+			{ .pll_nd = 4, .pll_nf = 495,
+			  .tmsd_divider_a = 0, 2, 2,
+			  .pclk_divider_a = 1, 3, 2, 2,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 4, .ppll_nf = 40, .ppll_no = 2,
+			},
+		},
+	}, {
+		.mpixelclock = 297000000, .param = {
+			{ .pll_nd = 2, .pll_nf = 99,
+			  .tmsd_divider_a = 0, 0, 0,
+			  .pclk_divider_a = 1, 0, 1, 1,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 4, .ppll_nf = 40, .ppll_no = 2,
+			},
+			{ .pll_nd = 4, .pll_nf = 495,
+			  .tmsd_divider_a = 1, 2, 0,
+			  .pclk_divider_a = 1, 3, 1, 1,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 8, .ppll_nf = 40, .ppll_no = 1,
+			},
+		},
+	}, {
+		.mpixelclock = 594000000, .param = {
+			{ .pll_nd = 1, .pll_nf = 99,
+			  .tmsd_divider_a = 0, 2, 0,
+			  .pclk_divider_a = 1, 0, 1, 1,
+			  .vco_div_5 = 0,
+			  .ppll_nd = 8, .ppll_nf = 40, .ppll_no = 1,
+			},
+		}
+	}, {
+		.mpixelclock = ~0UL,
+	}
+};
+
+static const struct dw_hdmi_mpll_config rk3288_mpll_cfg[] = {
 	{
 		27000000, {
 			{ 0x00b3, 0x0000},
@@ -112,7 +230,7 @@ static const struct dw_hdmi_mpll_config rockchip_mpll_cfg[] = {
 	}
 };
 
-static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
+static const struct dw_hdmi_curr_ctrl rk3288_cur_ctr[] = {
 	/*      pixelclk    bpp8    bpp10   bpp12 */
 	{
 		40000000,  { 0x0018, 0x0018, 0x0018 },
@@ -133,7 +251,7 @@ static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 	}
 };
 
-static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
+static const struct dw_hdmi_phy_config rk3288_phy_config[] = {
 	/*pixelclk   symbol   term   vlev*/
 	{ 74250000,  0x8009, 0x0004, 0x0272},
 	{ 148500000, 0x802b, 0x0004, 0x028d},
@@ -141,9 +259,158 @@ static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 	{ ~0UL,	     0x0000, 0x0000, 0x0000}
 };
 
+static int hdmi_ext_phy_write(struct rockchip_hdmi *hdmi, unsigned short data,
+			      unsigned char addr)
+{
+	writel_relaxed(data, hdmi->extphy_regbase + (addr) * 0x04);
+	return 0;
+}
+
+static unsigned int hdmi_phy_i2c_read(struct rockchip_hdmi *hdmi,
+				      unsigned char addr)
+{
+	return readl_relaxed(hdmi->extphy_regbase + (addr) * 0x04);
+}
+
+static int rk3229_extphy_config(struct dw_hdmi_plat_data *plat_data,
+				  int res, int pixelclock)
+{
+	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(plat_data);
+	const struct extphy_pll_config_tab *mpll = rk3229_extphy_pll_cfg;
+	const struct extphy_config_tab *ctrl = rk3229_extphy_cfg;
+	unsigned long timeout;
+	int i, stat;
+
+	/* Find out the extphy MPLL configure parameters */
+	for (i = 0; mpll[i].mpixelclock != ~0UL; i++)
+		if (pixelclock == mpll[i].mpixelclock)
+			break;
+	if (mpll[i].mpixelclock == ~0UL) {
+		dev_err(hdmi->dev, "Extphy couldn't support %dHz\n", pixelclock);
+		return -EINVAL;
+	}
+
+	regmap_write(hdmi->regmap, RK3229_GRF_SOC_CON2,
+		     RK3229_PLL_POWER_DOWN | RK3229_PLL_PDATA_DEN);
+
+	/*
+	 * Configure external phy PLL registers.
+	 */
+	stat = ((mpll[i].param[res].pll_nf >> 1) & EXT_PHY_PLL_FB_BIT8_MASK) |
+	       ((mpll[i].param[res].vco_div_5 & 1) << 5) |
+	       (mpll[i].param[res].pll_nd & EXT_PHY_PLL_PRE_DIVIDER_MASK);
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PLL_PRE_DIVIDER);
+
+	hdmi_ext_phy_write(hdmi, mpll[i].param[res].pll_nf, EXT_PHY_PLL_FB_DIVIDER);
+
+	stat = (mpll[i].param[res].pclk_divider_a & EXT_PHY_PCLK_DIVIDERA_MASK) |
+	       ((mpll[i].param[res].pclk_divider_b & 3) << 5);
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PCLK_DIVIDER1);
+
+	stat = (mpll[i].param[res].pclk_divider_d & EXT_PHY_PCLK_DIVIDERD_MASK) |
+	       ((mpll[i].param[res].pclk_divider_c & 3) << 5);
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PCLK_DIVIDER2);
+
+	stat = ((mpll[i].param[res].tmsd_divider_c & 3) << 4) |
+	       ((mpll[i].param[res].tmsd_divider_a & 3) << 2) |
+	       (mpll[i].param[res].tmsd_divider_b & 3);
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_TMDSCLK_DIVIDER);
+
+	hdmi_ext_phy_write(hdmi, mpll[i].param[res].ppll_nf, EXT_PHY_PPLL_FB_DIVIDER);
+
+	if (mpll[i].param[res].ppll_no == 1) {
+		hdmi_ext_phy_write(hdmi, 0, EXT_PHY_PPLL_POST_DIVIDER);
+
+		stat = 0x20 | mpll[i].param[res].ppll_nd;
+		hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PPLL_PRE_DIVIDER);
+	} else {
+		stat = ((mpll[i].param[res].ppll_no / 2) - 1) << 4;
+		hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PPLL_POST_DIVIDER);
+
+		stat = 0xe0 | mpll[i].param[res].ppll_nd;
+		hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PPLL_PRE_DIVIDER);
+	}
+
+
+	/* Find out the extphy driver configure parameters */
+	for (i = 0; ctrl[i].mpixelclock != ~0UL; i++)
+		if (pixelclock <= ctrl[i].mpixelclock)
+			break;
+	if (ctrl[i].mpixelclock == ~0UL) {
+		dev_err(hdmi->dev, "Extphy couldn't support %dHz\n", pixelclock);
+		return -EINVAL;
+	}
+
+	/*
+	 * Configure the extphy driver registers.
+	 */
+	if (ctrl[i].slopeboost) {
+		hdmi_ext_phy_write(hdmi, 0xff, EXT_PHY_SIGNAL_CTRL);
+
+		stat = (ctrl[i].slopeboost - 1) & 3;
+		stat = (stat << 6) | (stat << 4) | (stat << 2) | stat;
+		hdmi_ext_phy_write(hdmi, stat, EXT_PHY_SLOPEBOOST);
+	} else
+		hdmi_ext_phy_write(hdmi, 0x0f, EXT_PHY_SIGNAL_CTRL);
+
+	stat = ctrl[i].pre_emphasis & 3;
+	stat = (stat << 4) | (stat << 2) | stat;
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PREEMPHASIS);
+
+	stat = ((ctrl[i].clk_level & 0xf) << 4) | (ctrl[i].data2_level & 0xf);
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_LEVEL1);
+
+	stat = ((ctrl[i].data1_level & 0xf) << 4) | (ctrl[i].data0_level & 0xf);
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_LEVEL2);
+
+	hdmi_ext_phy_write(hdmi, 0x22, 0xf3);
+
+	stat = clk_get_rate(hdmi->extphy_pclk) / 100000;
+	hdmi_ext_phy_write(hdmi, ((stat >> 8) & 0xff) | 0x80, EXT_PHY_TERM_CAL);
+	hdmi_ext_phy_write(hdmi,  stat & 0xff, EXT_PHY_TERM_CAL_DIV_L);
+
+	if (pixelclock > 340000000)
+		stat = EXT_PHY_AUTO_R100_OHMS;
+	else if (pixelclock > 200000000)
+		stat = EXT_PHY_AUTO_R50_OHMS;
+	else
+		stat = EXT_PHY_AUTO_ROPEN_CIRCUIT;
+	hdmi_ext_phy_write(hdmi, stat | 0x20, EXT_PHY_TERM_RESIS_AUTO);
+	hdmi_ext_phy_write(hdmi, (stat >> 8) & 0xff, EXT_PHY_TERM_CAL);
+
+	stat = (pixelclock > 200000000) ? 0 : 0x11;
+	hdmi_ext_phy_write(hdmi, stat, EXT_PHY_PLL_BW);
+	hdmi_ext_phy_write(hdmi, 0x27, EXT_PHY_PPLL_BW);
+
+	regmap_write(hdmi->regmap, RK3229_GRF_SOC_CON2, RK3229_PLL_POWER_UP);
+
+	/* Detect whether PLL is lock or not */
+	timeout = jiffies + msecs_to_jiffies(100);
+	while (!time_after(jiffies, timeout)) {
+		usleep_range(1000, 2000);
+		stat = hdmi_phy_i2c_read(hdmi, EXT_PHY_PPLL_POST_DIVIDER);
+		if (stat & EXT_PHY_PPLL_LOCK_STATUS_MASK)
+			break;
+	}
+
+	regmap_write(hdmi->regmap, RK3229_GRF_SOC_CON2, RK3229_PLL_PDATA_EN);
+
+	if ((stat & EXT_PHY_PPLL_LOCK_STATUS_MASK) == 0) {
+		dev_err(hdmi->dev, "EXT PHY PLL not locked\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 {
 	struct device_node *np = hdmi->dev->of_node;
+	struct platform_device *pdev;
+	struct resource *iores;
+	int ret;
+
+	pdev = container_of(hdmi->dev, struct platform_device, dev);
 
 	hdmi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 	if (IS_ERR(hdmi->regmap)) {
@@ -151,24 +418,62 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 		return PTR_ERR(hdmi->regmap);
 	}
 
+	if (hdmi->plat_data.dev_type == RK3229_HDMI) {
+		iores = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!iores)
+			return -ENXIO;
+
+		hdmi->extphy_regbase = devm_ioremap_resource(hdmi->dev, iores);
+		if (IS_ERR(hdmi->extphy_regbase)) {
+			dev_err(hdmi->dev, "failed to map extphy regbase\n");
+			return PTR_ERR(hdmi->extphy_regbase);
+		}
+
+		hdmi->extphy_pclk = devm_clk_get(hdmi->dev, "extphy");
+		if (IS_ERR(hdmi->extphy_pclk)) {
+			dev_err(hdmi->dev, "failed to get extphy clock\n");
+			return PTR_ERR(hdmi->extphy_pclk);
+		}
+
+		ret = clk_prepare_enable(hdmi->extphy_pclk);
+		if (ret) {
+			dev_err(hdmi->dev, "failed to enable extphy clk: %d\n",
+				ret);
+			return ret;
+		}
+
+		regmap_write(hdmi->regmap, RK3229_GRF_SOC_CON6,
+			     RK3229_IO_3V_DOMAIN);
+
+		regmap_write(hdmi->regmap, RK3229_GRF_SOC_CON2,
+			     RK3229_DDC_MASK_EN);
+	}
+
 	return 0;
 }
 
 static enum drm_mode_status
-dw_hdmi_rockchip_mode_valid(struct drm_connector *connector,
+dw_hdmi_rockchip_mode_valid(const struct dw_hdmi_plat_data *plat_data,
 			    struct drm_display_mode *mode)
 {
-	const struct dw_hdmi_mpll_config *mpll_cfg = rockchip_mpll_cfg;
 	int pclk = mode->clock * 1000;
 	bool valid = false;
 	int i;
 
-	for (i = 0; mpll_cfg[i].mpixelclock != (~0UL); i++) {
-		if (pclk == mpll_cfg[i].mpixelclock) {
-			valid = true;
-			break;
+	if (plat_data->dev_type == RK3288_HDMI)
+		for (i = 0; rk3288_mpll_cfg[i].mpixelclock != (~0UL); i++)
+			if (pclk == rk3288_mpll_cfg[i].mpixelclock) {
+				valid = true;
+				break;
+			}
+
+	if (plat_data->dev_type == RK3229_HDMI)
+		for (i = 0; rk3229_extphy_pll_cfg[i].mpixelclock != ~0UL; i++) {
+			if (pclk == rk3229_extphy_pll_cfg[i].mpixelclock) {
+				valid = true;
+				break;
+			}
 		}
-	}
 
 	return (valid) ? MODE_OK : MODE_BAD;
 }
@@ -198,21 +503,29 @@ static void dw_hdmi_rockchip_encoder_mode_set(struct drm_encoder *encoder,
 static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
 {
 	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
+	int out_mode = ROCKCHIP_OUT_MODE_AAAA;
 	u32 val;
 	int mux;
 
+	if (hdmi->plat_data.dev_type == RK3229_HDMI)
+		out_mode = ROCKCHIP_OUT_MODE_P888;
+
 	rockchip_drm_crtc_mode_config(encoder->crtc, DRM_MODE_CONNECTOR_HDMIA,
-				      ROCKCHIP_OUT_MODE_AAAA);
+				      out_mode);
 
-	mux = rockchip_drm_encoder_get_mux_id(hdmi->dev->of_node, encoder);
-	if (mux)
-		val = HDMI_SEL_VOP_LIT | (HDMI_SEL_VOP_LIT << 16);
-	else
-		val = HDMI_SEL_VOP_LIT << 16;
+	if (hdmi->plat_data.dev_type == RK3288_HDMI) {
+		mux = rockchip_drm_encoder_get_mux_id(hdmi->dev->of_node,
+						      encoder);
+		if (mux)
+			val = RK3288_HDMI_SEL_VOP_LIT |
+			      (RK3288_HDMI_SEL_VOP_LIT << 16);
+		else
+			val = RK3288_HDMI_SEL_VOP_LIT << 16;
 
-	regmap_write(hdmi->regmap, GRF_SOC_CON6, val);
-	dev_dbg(hdmi->dev, "vop %s output to hdmi\n",
-		(mux) ? "LIT" : "BIG");
+		regmap_write(hdmi->regmap, RK3288_GRF_SOC_CON6, val);
+
+		dev_dbg(hdmi->dev, "vop %s output to hdmi\n", (mux) ? "LIT" : "BIG");
+	}
 }
 
 static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
@@ -222,17 +535,26 @@ static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_fun
 	.disable    = dw_hdmi_rockchip_encoder_disable,
 };
 
-static const struct dw_hdmi_plat_data rockchip_hdmi_drv_data = {
+static const struct dw_hdmi_plat_data rk3288_hdmi_drv_data = {
 	.mode_valid = dw_hdmi_rockchip_mode_valid,
-	.mpll_cfg   = rockchip_mpll_cfg,
-	.cur_ctr    = rockchip_cur_ctr,
-	.phy_config = rockchip_phy_config,
+	.mpll_cfg   = rk3288_mpll_cfg,
+	.cur_ctr    = rk3288_cur_ctr,
+	.phy_config = rk3288_phy_config,
 	.dev_type   = RK3288_HDMI,
 };
 
+static const struct dw_hdmi_plat_data rk3229_hdmi_drv_data = {
+	.mode_valid = dw_hdmi_rockchip_mode_valid,
+	.extphy_config = rk3229_extphy_config,
+	.dev_type   = RK3229_HDMI,
+};
+
 static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
 	{ .compatible = "rockchip,rk3288-dw-hdmi",
-	  .data = &rockchip_hdmi_drv_data
+	  .data = &rk3288_hdmi_drv_data
+	},
+	{ .compatible = "rockchip,rk3229-dw-hdmi",
+	  .data = &rk3229_hdmi_drv_data
 	},
 	{},
 };
@@ -242,7 +564,6 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 				 void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	const struct dw_hdmi_plat_data *plat_data;
 	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
@@ -259,7 +580,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return -ENOMEM;
 
 	match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
-	plat_data = match->data;
+	hdmi->plat_data = *(struct dw_hdmi_plat_data *)(match->data);
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
 
@@ -293,7 +614,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
 			 DRM_MODE_ENCODER_TMDS, NULL);
 
-	return dw_hdmi_bind(dev, master, data, encoder, iores, irq, plat_data);
+	return dw_hdmi_bind(dev, master, data, encoder, iores, irq,
+			    &hdmi->plat_data);
 }
 
 static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h
new file mode 100644
index 0000000..aca2543
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.h
@@ -0,0 +1,137 @@
+#ifndef __DW_HDMI_ROCKCHIP__
+#define __DW_HDMI_ROCKCHIP__
+
+struct extphy_config_tab {
+	u32 mpixelclock;
+	int pre_emphasis;
+	int slopeboost;
+	int clk_level;
+	int data0_level;
+	int data1_level;
+	int data2_level;
+};
+
+struct extphy_pll_config_tab {
+	unsigned long mpixelclock;
+	struct {
+		u8	pll_nd;
+		u16	pll_nf;
+		u8	tmsd_divider_a;
+		u8	tmsd_divider_b;
+		u8	tmsd_divider_c;
+		u8	pclk_divider_a;
+		u8	pclk_divider_b;
+		u8	pclk_divider_c;
+		u8	pclk_divider_d;
+		u8	vco_div_5;
+		u8	ppll_nd;
+		u8	ppll_nf;
+		u8	ppll_no;
+	} param[DW_HDMI_RES_MAX];
+};
+
+#define RK3288_GRF_SOC_CON6			0x025c
+#define RK3288_HDMI_SEL_VOP_LIT			(1 << 4)
+
+#define RK3229_GRF_SOC_CON6			0x0418
+#define RK3229_IO_3V_DOMAIN			((7 << 4) | (7 << (4 + 16)))
+
+#define RK3229_GRF_SOC_CON2			0x0408
+#define RK3229_DDC_MASK_EN			((3 << 13) | (3 << (13 + 16)))
+
+#define RK3229_PLL_POWER_DOWN			(BIT(12) | BIT(12 + 16))
+#define RK3229_PLL_POWER_UP			BIT(12 + 16)
+#define RK3229_PLL_PDATA_DEN			BIT(11 + 16)
+#define RK3229_PLL_PDATA_EN			(BIT(11) | BIT(11 + 16))
+
+/* PHY Defined for RK322X */
+#define EXT_PHY_CONTROL				0
+#define EXT_PHY_ANALOG_RESET_MASK		0x80
+#define EXT_PHY_DIGITAL_RESET_MASK		0x40
+#define EXT_PHY_PCLK_INVERT_MASK		0x08
+#define EXT_PHY_PREPCLK_INVERT_MASK		0x04
+#define EXT_PHY_TMDSCLK_INVERT_MASK		0x02
+#define EXT_PHY_SRC_SELECT_MASK			0x01
+
+#define EXT_PHY_TERM_CAL			0x03
+#define EXT_PHY_TERM_CAL_EN_MASK		0x80
+#define EXT_PHY_TERM_CAL_DIV_H_MASK		0x7f
+
+#define EXT_PHY_TERM_CAL_DIV_L			0x04
+
+#define EXT_PHY_PLL_PRE_DIVIDER			0xe2
+#define EXT_PHY_PLL_FB_BIT8_MASK		0x80
+#define EXT_PHY_PLL_PCLK_DIV5_EN_MASK		0x20
+#define EXT_PHY_PLL_PRE_DIVIDER_MASK		0x1f
+
+#define EXT_PHY_PLL_FB_DIVIDER			0xe3
+
+#define EXT_PHY_PCLK_DIVIDER1			0xe4
+#define EXT_PHY_PCLK_DIVIDERB_MASK		0x60
+#define EXT_PHY_PCLK_DIVIDERA_MASK		0x1f
+
+#define EXT_PHY_PCLK_DIVIDER2			0xe5
+#define EXT_PHY_PCLK_DIVIDERC_MASK		0x60
+#define EXT_PHY_PCLK_DIVIDERD_MASK		0x1f
+
+#define EXT_PHY_TMDSCLK_DIVIDER			0xe6
+#define EXT_PHY_TMDSCLK_DIVIDERC_MASK		0x30
+#define EXT_PHY_TMDSCLK_DIVIDERA_MASK		0x0c
+#define EXT_PHY_TMDSCLK_DIVIDERB_MASK		0x03
+
+#define EXT_PHY_PLL_BW				0xe7
+
+#define EXT_PHY_PPLL_PRE_DIVIDER		0xe9
+#define EXT_PHY_PPLL_ENABLE_MASK		0xc0
+#define EXT_PHY_PPLL_PRE_DIVIDER_MASK		0x1f
+
+#define EXT_PHY_PPLL_FB_DIVIDER			0xea
+
+#define EXT_PHY_PPLL_POST_DIVIDER		0xeb
+#define EXT_PHY_PPLL_FB_DIVIDER_BIT8_MASK	0x80
+#define EXT_PHY_PPLL_POST_DIVIDER_MASK		0x30
+#define EXT_PHY_PPLL_LOCK_STATUS_MASK		0x01
+
+#define EXT_PHY_PPLL_BW				0xec
+
+#define EXT_PHY_SIGNAL_CTRL			0xee
+#define EXT_PHY_TRANSITION_CLK_EN_MASK		0x80
+#define EXT_PHY_TRANSITION_D0_EN_MASK		0x40
+#define EXT_PHY_TRANSITION_D1_EN_MASK		0x20
+#define EXT_PHY_TRANSITION_D2_EN_MASK		0x10
+#define EXT_PHY_LEVEL_CLK_EN_MASK		0x08
+#define EXT_PHY_LEVEL_D0_EN_MASK		0x04
+#define EXT_PHY_LEVEL_D1_EN_MASK		0x02
+#define EXT_PHY_LEVEL_D2_EN_MASK		0x01
+
+#define EXT_PHY_SLOPEBOOST			0xef
+#define EXT_PHY_SLOPEBOOST_CLK_MASK		0x03
+#define EXT_PHY_SLOPEBOOST_D0_MASK		0x0c
+#define EXT_PHY_SLOPEBOOST_D1_MASK		0x30
+#define EXT_PHY_SLOPEBOOST_D2_MASK		0xc0
+
+#define EXT_PHY_PREEMPHASIS			0xf0
+#define EXT_PHY_PREEMPHASIS_D0_MASK		0x03
+#define EXT_PHY_PREEMPHASIS_D1_MASK		0x0c
+#define EXT_PHY_PREEMPHASIS_D2_MASK		0x30
+
+#define EXT_PHY_LEVEL1				0xf1
+#define EXT_PHY_LEVEL_CLK_MASK			0xf0
+#define EXT_PHY_LEVEL_D2_MASK			0x0f
+
+#define EXT_PHY_LEVEL2				0xf2
+#define EXT_PHY_LEVEL_D1_MASK			0xf0
+#define EXT_PHY_LEVEL_D0_MASK			0x0f
+
+#define EXT_PHY_TERM_RESIS_AUTO			0xf4
+#define EXT_PHY_AUTO_R50_OHMS			0
+#define EXT_PHY_AUTO_R75_OHMS			(1 << 2)
+#define EXT_PHY_AUTO_R100_OHMS			(2 << 2)
+#define EXT_PHY_AUTO_ROPEN_CIRCUIT		(3 << 2)
+
+#define EXT_PHY_TERM_RESIS_MANUAL_CLK		0xfb
+#define EXT_PHY_TERM_RESIS_MANUAL_D2		0xfc
+#define EXT_PHY_TERM_RESIS_MANUAL_D1		0xfd
+#define EXT_PHY_TERM_RESIS_MANUAL_D0		0xfe
+
+#endif /* __DW_HDMI_ROCKCHIP__ */
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index bae79f3..44084e8 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -24,6 +24,7 @@ enum {
 enum dw_hdmi_devtype {
 	IMX6Q_HDMI,
 	IMX6DL_HDMI,
+	RK3229_HDMI,
 	RK3288_HDMI,
 };
 
@@ -52,8 +53,10 @@ struct dw_hdmi_plat_data {
 	const struct dw_hdmi_mpll_config *mpll_cfg;
 	const struct dw_hdmi_curr_ctrl *cur_ctr;
 	const struct dw_hdmi_phy_config *phy_config;
-	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
+	enum drm_mode_status (*mode_valid)(const struct dw_hdmi_plat_data *plat_data,
 					   struct drm_display_mode *mode);
+	int (*extphy_config)(struct dw_hdmi_plat_data *plat_data,
+			     int bpp, int pixelclock);
 };
 
 void dw_hdmi_unbind(struct device *dev, struct device *master, void *data);
-- 
2.1.2
