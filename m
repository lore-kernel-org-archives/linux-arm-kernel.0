From: sandy.huang@rock-chips.com (Sandy Huang)
Date: Thu, 10 Aug 2017 17:55:59 +0800
Subject: [PATCH 3/3] drm/rockchip: Add support for Rockchip Soc LVDS
In-Reply-To: <1502358602-154097-1-git-send-email-hjc@rock-chips.com>
References: <1502358602-154097-1-git-send-email-hjc@rock-chips.com>
Message-ID: <3cd94985-0b9f-2a3b-4b14-abecf9ec994c@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry, it's a wrong email, send the v1 patch ,please ignore.

? 2017/8/10 17:49, Sandy Huang ??:
> This adds support for Rockchip soc lvds found on rk3288
> Based on the patches from Mark yao and Heiko Stuebner
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Signed-off-by: Mark yao <mark.yao@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/rockchip/Kconfig         |   9 +
>   drivers/gpu/drm/rockchip/Makefile        |   1 +
>   drivers/gpu/drm/rockchip/rockchip_lvds.c | 734 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_lvds.h | 112 +++++
>   4 files changed, 856 insertions(+)
>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.c
>   create mode 100644 drivers/gpu/drm/rockchip/rockchip_lvds.h
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 50c41c0..80672f4 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -59,3 +59,12 @@ config ROCKCHIP_INNO_HDMI
>   	  This selects support for Rockchip SoC specific extensions
>   	  for the Innosilicon HDMI driver. If you want to enable
>   	  HDMI on RK3036 based SoC, you should select this option.
> +
> +config ROCKCHIP_LVDS
> +	bool "Rockchip LVDS support"
> +	depends on DRM_ROCKCHIP
> +	help
> +	  Choose this option to enable support for Rockchip LVDS controllers.
> +	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
> +	  support LVDS, rgb, dual LVDS output mode. say Y to enable its
> +	  driver.
> diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
> index fa8dc9d..a881d2c 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -12,5 +12,6 @@ rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
>   rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
>   rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
>   rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) += rockchip_lvds.o
>   
>   obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> new file mode 100644
> index 0000000..a4ad3f0
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -0,0 +1,734 @@
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Author:
> + *      Mark Yao <mark.yao@rock-chips.com>
> + *      Sandy huang <hjc@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_dp_helper.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
> +
> +#include <linux/component.h>
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_graph.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <video/display_timing.h>
> +
> +#include "rockchip_drm_drv.h"
> +#include "rockchip_drm_vop.h"
> +#include "rockchip_lvds.h"
> +
> +#define DISPLAY_OUTPUT_RGB		0
> +#define DISPLAY_OUTPUT_LVDS		1
> +#define DISPLAY_OUTPUT_DUAL_LVDS	2
> +
> +#define connector_to_lvds(c) \
> +		container_of(c, struct rockchip_lvds, connector)
> +
> +#define encoder_to_lvds(c) \
> +		container_of(c, struct rockchip_lvds, encoder)
> +#define LVDS_CHIP(lvds)	((lvds)->soc_data->chip_type)
> +
> +/*
> + * @grf_offset: offset inside the grf regmap for setting the rockchip lvds
> + */
> +struct rockchip_lvds_soc_data {
> +	int chip_type;
> +	int grf_soc_con6;
> +	int grf_soc_con7;
> +
> +	bool has_vop_sel;
> +};
> +
> +struct rockchip_lvds {
> +	void *base;
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct regmap *grf;
> +	struct clk *pclk;
> +	const struct rockchip_lvds_soc_data *soc_data;
> +
> +	int output;
> +	int format;
> +
> +	struct drm_device *drm_dev;
> +	struct drm_panel *panel;
> +	struct drm_bridge *bridge;
> +	struct drm_connector connector;
> +	struct drm_encoder encoder;
> +
> +	struct mutex suspend_lock;
> +	int suspend;
> +	struct dev_pin_info *pins;
> +	struct drm_display_mode mode;
> +};
> +
> +static inline void lvds_writel(struct rockchip_lvds *lvds, u32 offset, u32 val)
> +{
> +	writel_relaxed(val, lvds->regs + offset);
> +	if ((lvds->output != DISPLAY_OUTPUT_LVDS) &&
> +	     (LVDS_CHIP(lvds) == RK3288_LVDS))
> +		writel_relaxed(val,
> +			       lvds->regs + offset + RK3288_LVDS_CH1_OFFSET);
> +}
> +
> +static inline int lvds_name_to_format(const char *s)
> +{
> +	if (!s)
> +		return -EINVAL;
> +
> +	if (strncmp(s, "jeida", 6) == 0)
> +		return LVDS_FORMAT_JEIDA;
> +	else if (strncmp(s, "vesa", 5) == 0)
> +		return LVDS_FORMAT_VESA;
> +
> +	return -EINVAL;
> +}
> +
> +static inline int lvds_name_to_output(const char *s)
> +{
> +	if (!s)
> +		return -EINVAL;
> +
> +	if (strncmp(s, "rgb", 3) == 0)
> +		return DISPLAY_OUTPUT_RGB;
> +	else if (strncmp(s, "lvds", 4) == 0)
> +		return DISPLAY_OUTPUT_LVDS;
> +	else if (strncmp(s, "duallvds", 8) == 0)
> +		return DISPLAY_OUTPUT_DUAL_LVDS;
> +
> +	return -EINVAL;
> +}
> +
> +static int rockchip_lvds_poweron(struct rockchip_lvds *lvds)
> +{
> +	int ret;
> +
> +	if (lvds->pclk) {
> +		ret = clk_enable(lvds->pclk);
> +		if (ret < 0) {
> +			dev_err(lvds->dev, "failed to enable lvds pclk %d\n", ret);
> +			return ret;
> +		}
> +	}
> +	ret = pm_runtime_get_sync(lvds->dev);
> +	if (ret < 0) {
> +		dev_err(lvds->dev, "failed to get pm runtime: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (lvds->output == DISPLAY_OUTPUT_RGB) {
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG0,
> +			    RK3288_LVDS_CH0_REG0_TTL_EN |
> +			    RK3288_LVDS_CH0_REG0_LANECK_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE4_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE3_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE2_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE1_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE0_EN);
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG2,
> +			    RK3288_LVDS_PLL_FBDIV_REG2(0x46));
> +
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG3,
> +			    RK3288_LVDS_PLL_FBDIV_REG3(0x46));
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG4,
> +			    RK3288_LVDS_CH0_REG4_LANECK_TTL_MODE |
> +			    RK3288_LVDS_CH0_REG4_LANE4_TTL_MODE |
> +			    RK3288_LVDS_CH0_REG4_LANE3_TTL_MODE |
> +			    RK3288_LVDS_CH0_REG4_LANE2_TTL_MODE |
> +			    RK3288_LVDS_CH0_REG4_LANE1_TTL_MODE |
> +			    RK3288_LVDS_CH0_REG4_LANE0_TTL_MODE);
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG5,
> +			    RK3288_LVDS_CH0_REG5_LANECK_TTL_DATA |
> +			    RK3288_LVDS_CH0_REG5_LANE4_TTL_DATA |
> +			    RK3288_LVDS_CH0_REG5_LANE3_TTL_DATA |
> +			    RK3288_LVDS_CH0_REG5_LANE2_TTL_DATA |
> +			    RK3288_LVDS_CH0_REG5_LANE1_TTL_DATA |
> +			    RK3288_LVDS_CH0_REG5_LANE0_TTL_DATA);
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REGD,
> +			    RK3288_LVDS_PLL_PREDIV_REGD(0x0a));
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG20,
> +			    RK3288_LVDS_CH0_REG20_LSB);
> +	} else {
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG0,
> +			    RK3288_LVDS_CH0_REG0_LVDS_EN |
> +			    RK3288_LVDS_CH0_REG0_LANECK_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE4_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE3_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE2_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE1_EN |
> +			    RK3288_LVDS_CH0_REG0_LANE0_EN);
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG1,
> +			    RK3288_LVDS_CH0_REG1_LANECK_BIAS |
> +			    RK3288_LVDS_CH0_REG1_LANE4_BIAS |
> +			    RK3288_LVDS_CH0_REG1_LANE3_BIAS |
> +			    RK3288_LVDS_CH0_REG1_LANE2_BIAS |
> +			    RK3288_LVDS_CH0_REG1_LANE1_BIAS |
> +			    RK3288_LVDS_CH0_REG1_LANE0_BIAS);
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG2,
> +			    RK3288_LVDS_CH0_REG2_RESERVE_ON |
> +			    RK3288_LVDS_CH0_REG2_LANECK_LVDS_MODE |
> +			    RK3288_LVDS_CH0_REG2_LANE4_LVDS_MODE |
> +			    RK3288_LVDS_CH0_REG2_LANE3_LVDS_MODE |
> +			    RK3288_LVDS_CH0_REG2_LANE2_LVDS_MODE |
> +			    RK3288_LVDS_CH0_REG2_LANE1_LVDS_MODE |
> +			    RK3288_LVDS_CH0_REG2_LANE0_LVDS_MODE |
> +			    RK3288_LVDS_PLL_FBDIV_REG2(0x46));
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG3,
> +			    RK3288_LVDS_PLL_FBDIV_REG3(0x46));
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG4, 0x00);
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG5, 0x00);
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REGD,
> +			    RK3288_LVDS_PLL_PREDIV_REGD(0x0a));
> +		lvds_writel(lvds, RK3288_LVDS_CH0_REG20,
> +			    RK3288_LVDS_CH0_REG20_LSB);
> +	}
> +
> +	writel(RK3288_LVDS_CFG_REGC_PLL_ENABLE,
> +	       lvds->regs + RK3288_LVDS_CFG_REGC);
> +	writel(RK3288_LVDS_CFG_REG21_TX_ENABLE,
> +	       lvds->regs + RK3288_LVDS_CFG_REG21);
> +
> +	return 0;
> +}
> +
> +static void rockchip_lvds_poweroff(struct rockchip_lvds *lvds)
> +{
> +	int ret;
> +
> +	writel(RK3288_LVDS_CFG_REG21_TX_DISABLE,
> +	       lvds->regs + RK3288_LVDS_CFG_REG21);
> +	writel(RK3288_LVDS_CFG_REGC_PLL_DISABLE,
> +	       lvds->regs + RK3288_LVDS_CFG_REGC);
> +	ret = regmap_write(lvds->grf,
> +			   lvds->soc_data->grf_soc_con7, 0xffff8000);
> +	if (ret != 0)
> +		dev_err(lvds->dev, "Could not write to GRF: %d\n", ret);
> +
> +	pm_runtime_put(lvds->dev);
> +	if (lvds->pclk)
> +		clk_disable(lvds->pclk);
> +}
> +
> +static enum drm_connector_status
> +rockchip_lvds_connector_detect(struct drm_connector *connector, bool force)
> +{
> +	return connector_status_connected;
> +}
> +
> +static void rockchip_lvds_connector_destroy(struct drm_connector *connector)
> +{
> +	drm_connector_cleanup(connector);
> +}
> +
> +static const struct drm_connector_funcs rockchip_lvds_connector_funcs = {
> +	.dpms = drm_atomic_helper_connector_dpms,
> +	.detect = rockchip_lvds_connector_detect,
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.destroy = rockchip_lvds_connector_destroy,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static int rockchip_lvds_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct rockchip_lvds *lvds = connector_to_lvds(connector);
> +	struct drm_panel *panel = lvds->panel;
> +
> +	return panel->funcs->get_modes(panel);
> +}
> +
> +static struct drm_encoder *
> +rockchip_lvds_connector_best_encoder(struct drm_connector *connector)
> +{
> +	struct rockchip_lvds *lvds = connector_to_lvds(connector);
> +
> +	return &lvds->encoder;
> +}
> +
> +static enum drm_mode_status rockchip_lvds_connector_mode_valid(
> +		struct drm_connector *connector,
> +		struct drm_display_mode *mode)
> +{
> +	return MODE_OK;
> +}
> +
> +static const
> +struct drm_connector_helper_funcs rockchip_lvds_connector_helper_funcs = {
> +	.get_modes = rockchip_lvds_connector_get_modes,
> +	.mode_valid = rockchip_lvds_connector_mode_valid,
> +	.best_encoder = rockchip_lvds_connector_best_encoder,
> +};
> +
> +static void rockchip_lvds_encoder_dpms(struct drm_encoder *encoder, int mode)
> +{
> +	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> +	int ret;
> +
> +	mutex_lock(&lvds->suspend_lock);
> +
> +	switch (mode) {
> +	case DRM_MODE_DPMS_ON:
> +		if (!lvds->suspend)
> +			goto out;
> +
> +		drm_panel_prepare(lvds->panel);
> +		ret = rockchip_lvds_poweron(lvds);
> +		if (ret < 0) {
> +			drm_panel_unprepare(lvds->panel);
> +			goto out;
> +		}
> +		drm_panel_enable(lvds->panel);
> +
> +		lvds->suspend = false;
> +		break;
> +	case DRM_MODE_DPMS_STANDBY:
> +	case DRM_MODE_DPMS_SUSPEND:
> +	case DRM_MODE_DPMS_OFF:
> +		if (lvds->suspend)
> +			goto out;
> +
> +		drm_panel_disable(lvds->panel);
> +		rockchip_lvds_poweroff(lvds);
> +		drm_panel_unprepare(lvds->panel);
> +
> +		lvds->suspend = true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +out:
> +	mutex_unlock(&lvds->suspend_lock);
> +}
> +
> +static bool
> +rockchip_lvds_encoder_mode_fixup(struct drm_encoder *encoder,
> +				const struct drm_display_mode *mode,
> +				struct drm_display_mode *adjusted_mode)
> +{
> +	return true;
> +}
> +
> +static void rockchip_lvds_encoder_mode_set(struct drm_encoder *encoder,
> +					  struct drm_display_mode *mode,
> +					  struct drm_display_mode *adjusted)
> +{
> +	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> +
> +	drm_mode_copy(&lvds->mode, adjusted);
> +}
> +
> +static void rockchip_lvds_grf_config(struct drm_encoder *encoder,
> +				     struct drm_display_mode *mode)
> +{
> +	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> +	u32 h_bp = mode->htotal - mode->hsync_start;
> +	u8 pin_hsync = (mode->flags & DRM_MODE_FLAG_PHSYNC) ? 1 : 0;
> +	u8 pin_dclk = (mode->flags & DRM_MODE_FLAG_PCSYNC) ? 1 : 0;
> +	u32 val;
> +	int ret;
> +
> +	/* iomux to LCD data/sync mode */
> +	if (lvds->output == DISPLAY_OUTPUT_RGB)
> +		if (lvds->pins && !IS_ERR(lvds->pins->default_state))
> +			pinctrl_select_state(lvds->pins->p,
> +					     lvds->pins->default_state);
> +	val = lvds->format;
> +	if (lvds->output == DISPLAY_OUTPUT_DUAL_LVDS)
> +		val |= LVDS_DUAL | LVDS_CH0_EN | LVDS_CH1_EN;
> +	else if (lvds->output == DISPLAY_OUTPUT_LVDS)
> +		val |= LVDS_CH0_EN;
> +	else if (lvds->output == DISPLAY_OUTPUT_RGB)
> +		val |= LVDS_TTL_EN | LVDS_CH0_EN | LVDS_CH1_EN;
> +
> +	if (h_bp & 0x01)
> +		val |= LVDS_START_PHASE_RST_1;
> +
> +	val |= (pin_dclk << 8) | (pin_hsync << 9);
> +	val |= (0xffff << 16);
> +	ret = regmap_write(lvds->grf, lvds->soc_data->grf_soc_con7, val);
> +	if (ret != 0) {
> +		dev_err(lvds->dev, "Could not write to GRF: %d\n", ret);
> +		return;
> +	}
> +}
> +
> +static int rockchip_lvds_set_vop_source(struct rockchip_lvds *lvds,
> +					struct drm_encoder *encoder)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (!lvds->soc_data->has_vop_sel)
> +		return 0;
> +
> +	ret = drm_of_encoder_active_endpoint_id(lvds->dev->of_node, encoder);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret)
> +		val = RK3288_LVDS_SOC_CON6_SEL_VOP_LIT |
> +		      (RK3288_LVDS_SOC_CON6_SEL_VOP_LIT << 16);
> +	else
> +		val = RK3288_LVDS_SOC_CON6_SEL_VOP_LIT << 16;
> +
> +	ret = regmap_write(lvds->grf, lvds->soc_data->grf_soc_con6, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int
> +rockchip_lvds_encoder_atomic_check(struct drm_encoder *encoder,
> +				   struct drm_crtc_state *crtc_state,
> +				   struct drm_connector_state *conn_state)
> +{
> +	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
> +
> +
> +	s->output_mode = ROCKCHIP_OUT_MODE_P888;
> +	s->output_type = DRM_MODE_CONNECTOR_LVDS;
> +
> +
> +	return 0;
> +}
> +
> +static void rockchip_lvds_encoder_enable(struct drm_encoder *encoder)
> +{
> +	struct rockchip_lvds *lvds = encoder_to_lvds(encoder);
> +
> +	rockchip_lvds_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
> +	rockchip_lvds_grf_config(encoder, &lvds->mode);
> +	rockchip_lvds_set_vop_source(lvds, encoder);
> +}
> +
> +static void rockchip_lvds_encoder_disable(struct drm_encoder *encoder)
> +{
> +	rockchip_lvds_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> +}
> +
> +static const
> +struct drm_encoder_helper_funcs rockchip_lvds_encoder_helper_funcs = {
> +	.mode_fixup = rockchip_lvds_encoder_mode_fixup,
> +	.mode_set = rockchip_lvds_encoder_mode_set,
> +	.enable = rockchip_lvds_encoder_enable,
> +	.disable = rockchip_lvds_encoder_disable,
> +	.atomic_check = rockchip_lvds_encoder_atomic_check,
> +};
> +
> +static void rockchip_lvds_encoder_destroy(struct drm_encoder *encoder)
> +{
> +	drm_encoder_cleanup(encoder);
> +}
> +
> +static const struct drm_encoder_funcs rockchip_lvds_encoder_funcs = {
> +	.destroy = rockchip_lvds_encoder_destroy,
> +};
> +
> +static struct rockchip_lvds_soc_data rk3288_lvds_data = {
> +	.chip_type = RK3288_LVDS,
> +	.grf_soc_con6 = 0x025c,
> +	.grf_soc_con7 = 0x0260,
> +	.has_vop_sel = true,
> +};
> +
> +static const struct of_device_id rockchip_lvds_dt_ids[] = {
> +	{
> +		.compatible = "rockchip,rk3288-lvds",
> +		.data = &rk3288_lvds_data
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_lvds_dt_ids);
> +
> +static int rockchip_lvds_bind(struct device *dev, struct device *master,
> +			     void *data)
> +{
> +	struct rockchip_lvds *lvds = dev_get_drvdata(dev);
> +	struct drm_device *drm_dev = data;
> +	struct drm_encoder *encoder;
> +	struct drm_connector *connector;
> +	struct device_node *remote = NULL;
> +	struct device_node  *port, *endpoint;
> +	int ret, i;
> +	const char *name;
> +
> +	lvds->drm_dev = drm_dev;
> +	port = of_graph_get_port_by_id(dev->of_node, 1);
> +	if (!port) {
> +		dev_err(dev, "can't found port point, please init lvds panel port!\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(port, endpoint) {
> +		remote = of_graph_get_remote_port_parent(endpoint);
> +		if (!remote) {
> +			dev_err(dev, "can't found panel node, please init!\n");
> +			ret = -EINVAL;
> +			goto err_put_port;
> +		}
> +		if (!of_device_is_available(remote)) {
> +			of_node_put(remote);
> +			remote = NULL;
> +			continue;
> +		}
> +		break;
> +	}
> +	if (!remote) {
> +		dev_err(dev, "can't found remote node, please init!\n");
> +		ret = -EINVAL;
> +		goto err_put_port;
> +	}
> +
> +	lvds->panel = of_drm_find_panel(remote);
> +	if (!lvds->panel)
> +		lvds->bridge = of_drm_find_bridge(remote);
> +
> +	if (!lvds->panel && !lvds->bridge) {
> +		DRM_ERROR("failed to find panel and bridge node\n");
> +		ret  = -EPROBE_DEFER;
> +		goto err_put_remote;
> +	}
> +
> +	if (of_property_read_string(remote, "rockchip,output", &name))
> +		/* default set it as output rgb */
> +		lvds->output = DISPLAY_OUTPUT_RGB;
> +	else
> +		lvds->output = lvds_name_to_output(name);
> +
> +	if (lvds->output < 0) {
> +		dev_err(dev, "invalid output type [%s]\n", name);
> +		ret = lvds->output;
> +		goto err_put_remote;
> +	}
> +
> +	if (of_property_read_string(remote, "rockchip,data-mapping",
> +				    &name))
> +		/* default set it as format jeida */
> +		lvds->format = LVDS_FORMAT_JEIDA;
> +	else
> +		lvds->format = lvds_name_to_format(name);
> +
> +	if (lvds->format < 0) {
> +		dev_err(dev, "invalid data-mapping format [%s]\n", name);
> +		ret = lvds->format;
> +		goto err_put_remote;
> +	}
> +
> +	if (of_property_read_u32(remote, "rockchip,data-width", &i)) {
> +		lvds->format |= LVDS_24BIT;
> +	} else {
> +		if (i == 24) {
> +			lvds->format |= LVDS_24BIT;
> +		} else if (i == 18) {
> +			lvds->format |= LVDS_18BIT;
> +		} else {
> +			dev_err(dev,
> +				"rockchip-lvds unsupport data-width[%d]\n", i);
> +			ret = -EINVAL;
> +			goto err_put_remote;
> +		}
> +	}
> +
> +	encoder = &lvds->encoder;
> +	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
> +							     dev->of_node);
> +
> +	ret = drm_encoder_init(drm_dev, encoder, &rockchip_lvds_encoder_funcs,
> +			       DRM_MODE_ENCODER_LVDS, NULL);
> +	if (ret < 0) {
> +		DRM_ERROR("failed to initialize encoder with drm\n");
> +		goto err_put_remote;
> +	}
> +
> +	drm_encoder_helper_add(encoder, &rockchip_lvds_encoder_helper_funcs);
> +
> +	if (lvds->panel) {
> +		connector = &lvds->connector;
> +		connector->dpms = DRM_MODE_DPMS_OFF;
> +		ret = drm_connector_init(drm_dev, connector,
> +					 &rockchip_lvds_connector_funcs,
> +					 DRM_MODE_CONNECTOR_LVDS);
> +		if (ret < 0) {
> +			DRM_ERROR("failed to initialize connector with drm\n");
> +			goto err_free_encoder;
> +		}
> +
> +		drm_connector_helper_add(connector,
> +					 &rockchip_lvds_connector_helper_funcs);
> +
> +		ret = drm_mode_connector_attach_encoder(connector, encoder);
> +		if (ret < 0) {
> +			DRM_ERROR("failed to attach connector and encoder\n");
> +			goto err_free_connector;
> +		}
> +
> +		ret = drm_panel_attach(lvds->panel, connector);
> +		if (ret < 0) {
> +			DRM_ERROR("failed to attach connector and encoder\n");
> +			goto err_free_connector;
> +		}
> +	} else {
> +		lvds->bridge->encoder = encoder;
> +		ret = drm_bridge_attach(encoder, lvds->bridge, NULL);
> +		if (ret) {
> +			DRM_ERROR("Failed to attach bridge to drm\n");
> +			goto err_free_encoder;
> +		}
> +		encoder->bridge = lvds->bridge;
> +	}
> +
> +	pm_runtime_enable(dev);
> +	of_node_put(remote);
> +	of_node_put(port);
> +
> +	return 0;
> +
> +err_free_connector:
> +	drm_connector_cleanup(connector);
> +err_free_encoder:
> +	drm_encoder_cleanup(encoder);
> +err_put_remote:
> +	of_node_put(remote);
> +err_put_port:
> +	of_node_put(port);
> +
> +	return ret;
> +}
> +
> +static void rockchip_lvds_unbind(struct device *dev, struct device *master,
> +				void *data)
> +{
> +	struct rockchip_lvds *lvds = dev_get_drvdata(dev);
> +
> +	rockchip_lvds_encoder_dpms(&lvds->encoder, DRM_MODE_DPMS_OFF);
> +
> +	drm_panel_detach(lvds->panel);
> +
> +	drm_connector_cleanup(&lvds->connector);
> +	drm_encoder_cleanup(&lvds->encoder);
> +
> +	pm_runtime_disable(dev);
> +}
> +
> +static const struct component_ops rockchip_lvds_component_ops = {
> +	.bind = rockchip_lvds_bind,
> +	.unbind = rockchip_lvds_unbind,
> +};
> +
> +static int rockchip_lvds_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_lvds *lvds;
> +	const struct of_device_id *match;
> +	struct resource *res;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	lvds = devm_kzalloc(&pdev->dev, sizeof(*lvds), GFP_KERNEL);
> +	if (!lvds)
> +		return -ENOMEM;
> +
> +	lvds->dev = dev;
> +	lvds->suspend = true;
> +	match = of_match_node(rockchip_lvds_dt_ids, dev->of_node);
> +	lvds->soc_data = match->data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	lvds->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(lvds->regs))
> +		return PTR_ERR(lvds->regs);
> +
> +	lvds->pclk = devm_clk_get(&pdev->dev, "pclk_lvds");
> +	if (IS_ERR(lvds->pclk)) {
> +		dev_err(dev, "could not get pclk_lvds\n");
> +		return PTR_ERR(lvds->pclk);
> +	}
> +
> +	lvds->pins = devm_kzalloc(lvds->dev, sizeof(*lvds->pins),
> +				  GFP_KERNEL);
> +	if (!lvds->pins)
> +		return -ENOMEM;
> +
> +	lvds->pins->p = devm_pinctrl_get(lvds->dev);
> +	if (IS_ERR(lvds->pins->p)) {
> +		dev_info(lvds->dev, "no pinctrl handle\n");
> +		devm_kfree(lvds->dev, lvds->pins);
> +		lvds->pins = NULL;
> +	} else {
> +		lvds->pins->default_state =
> +			pinctrl_lookup_state(lvds->pins->p, "lcdc");
> +		if (IS_ERR(lvds->pins->default_state)) {
> +			dev_info(lvds->dev, "no default pinctrl state\n");
> +			devm_kfree(lvds->dev, lvds->pins);
> +			lvds->pins = NULL;
> +		}
> +	}
> +
> +	lvds->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
> +						    "rockchip,grf");
> +	if (IS_ERR(lvds->grf)) {
> +		dev_err(dev, "missing rockchip,grf property\n");
> +		return PTR_ERR(lvds->grf);
> +	}
> +
> +	dev_set_drvdata(dev, lvds);
> +	mutex_init(&lvds->suspend_lock);
> +
> +	if (lvds->pclk) {
> +		ret = clk_prepare(lvds->pclk);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to prepare pclk_lvds\n");
> +			return ret;
> +		}
> +	}
> +	ret = component_add(&pdev->dev, &rockchip_lvds_component_ops);
> +	if (ret < 0) {
> +		if (lvds->pclk)
> +			clk_unprepare(lvds->pclk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rockchip_lvds_remove(struct platform_device *pdev)
> +{
> +	struct rockchip_lvds *lvds = dev_get_drvdata(&pdev->dev);
> +
> +	component_del(&pdev->dev, &rockchip_lvds_component_ops);
> +	if (lvds->pclk)
> +		clk_unprepare(lvds->pclk);
> +
> +	return 0;
> +}
> +
> +struct platform_driver rockchip_lvds_driver = {
> +	.probe = rockchip_lvds_probe,
> +	.remove = rockchip_lvds_remove,
> +	.driver = {
> +		   .name = "rockchip-lvds",
> +		   .of_match_table = of_match_ptr(rockchip_lvds_dt_ids),
> +	},
> +};
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.h b/drivers/gpu/drm/rockchip/rockchip_lvds.h
> new file mode 100644
> index 0000000..49d2422
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.h
> @@ -0,0 +1,112 @@
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Author:
> + *      hjc <hjc@rock-chips.com>
> + *      mark yao <mark.yao@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _ROCKCHIP_LVDS_
> +#define _ROCKCHIP_LVDS_
> +
> +#define RK3288_LVDS_CH0_REG0			0x00
> +#define RK3288_LVDS_CH0_REG0_LVDS_EN		BIT(7)
> +#define RK3288_LVDS_CH0_REG0_TTL_EN		BIT(6)
> +#define RK3288_LVDS_CH0_REG0_LANECK_EN		BIT(5)
> +#define RK3288_LVDS_CH0_REG0_LANE4_EN		BIT(4)
> +#define RK3288_LVDS_CH0_REG0_LANE3_EN		BIT(3)
> +#define RK3288_LVDS_CH0_REG0_LANE2_EN		BIT(2)
> +#define RK3288_LVDS_CH0_REG0_LANE1_EN		BIT(1)
> +#define RK3288_LVDS_CH0_REG0_LANE0_EN		BIT(0)
> +
> +#define RK3288_LVDS_CH0_REG1			0x04
> +#define RK3288_LVDS_CH0_REG1_LANECK_BIAS	BIT(5)
> +#define RK3288_LVDS_CH0_REG1_LANE4_BIAS		BIT(4)
> +#define RK3288_LVDS_CH0_REG1_LANE3_BIAS		BIT(3)
> +#define RK3288_LVDS_CH0_REG1_LANE2_BIAS		BIT(2)
> +#define RK3288_LVDS_CH0_REG1_LANE1_BIAS		BIT(1)
> +#define RK3288_LVDS_CH0_REG1_LANE0_BIAS		BIT(0)
> +
> +#define RK3288_LVDS_CH0_REG2			0x08
> +#define RK3288_LVDS_CH0_REG2_RESERVE_ON		BIT(7)
> +#define RK3288_LVDS_CH0_REG2_LANECK_LVDS_MODE	BIT(6)
> +#define RK3288_LVDS_CH0_REG2_LANE4_LVDS_MODE	BIT(5)
> +#define RK3288_LVDS_CH0_REG2_LANE3_LVDS_MODE	BIT(4)
> +#define RK3288_LVDS_CH0_REG2_LANE2_LVDS_MODE	BIT(3)
> +#define RK3288_LVDS_CH0_REG2_LANE1_LVDS_MODE	BIT(2)
> +#define RK3288_LVDS_CH0_REG2_LANE0_LVDS_MODE	BIT(1)
> +#define RK3288_LVDS_CH0_REG2_PLL_FBDIV8		BIT(0)
> +
> +#define RK3288_LVDS_CH0_REG3			0x0c
> +#define RK3288_LVDS_CH0_REG3_PLL_FBDIV_MASK	0xff
> +
> +#define RK3288_LVDS_CH0_REG4			0x10
> +#define RK3288_LVDS_CH0_REG4_LANECK_TTL_MODE	BIT(5)
> +#define RK3288_LVDS_CH0_REG4_LANE4_TTL_MODE	BIT(4)
> +#define RK3288_LVDS_CH0_REG4_LANE3_TTL_MODE	BIT(3)
> +#define RK3288_LVDS_CH0_REG4_LANE2_TTL_MODE	BIT(2)
> +#define RK3288_LVDS_CH0_REG4_LANE1_TTL_MODE	BIT(1)
> +#define RK3288_LVDS_CH0_REG4_LANE0_TTL_MODE	BIT(0)
> +
> +#define RK3288_LVDS_CH0_REG5			0x14
> +#define RK3288_LVDS_CH0_REG5_LANECK_TTL_DATA	BIT(5)
> +#define RK3288_LVDS_CH0_REG5_LANE4_TTL_DATA	BIT(4)
> +#define RK3288_LVDS_CH0_REG5_LANE3_TTL_DATA	BIT(3)
> +#define RK3288_LVDS_CH0_REG5_LANE2_TTL_DATA	BIT(2)
> +#define RK3288_LVDS_CH0_REG5_LANE1_TTL_DATA	BIT(1)
> +#define RK3288_LVDS_CH0_REG5_LANE0_TTL_DATA	BIT(0)
> +
> +#define RK3288_LVDS_CFG_REGC			0x30
> +#define RK3288_LVDS_CFG_REGC_PLL_ENABLE		0x00
> +#define RK3288_LVDS_CFG_REGC_PLL_DISABLE	0xff
> +
> +#define RK3288_LVDS_CH0_REGD			0x34
> +#define RK3288_LVDS_CH0_REGD_PLL_PREDIV_MASK	0x1f
> +
> +#define RK3288_LVDS_CH0_REG20			0x80
> +#define RK3288_LVDS_CH0_REG20_MSB		0x45
> +#define RK3288_LVDS_CH0_REG20_LSB		0x44
> +
> +#define RK3288_LVDS_CFG_REG21			0x84
> +#define RK3288_LVDS_CFG_REG21_TX_ENABLE		0x92
> +#define RK3288_LVDS_CFG_REG21_TX_DISABLE	0x00
> +#define RK3288_LVDS_CH1_OFFSET                 0x100
> +
> +/* fbdiv value is split over 2 registers, with bit8 in reg2 */
> +#define RK3288_LVDS_PLL_FBDIV_REG2(_fbd) \
> +		(_fbd & BIT(8) ? RK3288_LVDS_CH0_REG2_PLL_FBDIV8 : 0)
> +#define RK3288_LVDS_PLL_FBDIV_REG3(_fbd) \
> +		(_fbd & RK3288_LVDS_CH0_REG3_PLL_FBDIV_MASK)
> +#define RK3288_LVDS_PLL_PREDIV_REGD(_pd) \
> +		(_pd & RK3288_LVDS_CH0_REGD_PLL_PREDIV_MASK)
> +
> +#define RK3288_LVDS_SOC_CON6_SEL_VOP_LIT	BIT(3)
> +
> +#define LVDS_FMT_MASK				(0x07 << 16)
> +#define LVDS_MSB				BIT(3)
> +#define LVDS_DUAL				BIT(4)
> +#define LVDS_FMT_1				BIT(5)
> +#define LVDS_TTL_EN				BIT(6)
> +#define LVDS_START_PHASE_RST_1			BIT(7)
> +#define LVDS_DCLK_INV				BIT(8)
> +#define LVDS_CH0_EN				BIT(11)
> +#define LVDS_CH1_EN				BIT(12)
> +#define LVDS_PWRDN				BIT(15)
> +
> +#define LVDS_24BIT				(0 << 1)
> +#define LVDS_18BIT				(1 << 1)
> +#define LVDS_FORMAT_VESA			(0 << 0)
> +#define LVDS_FORMAT_JEIDA			(1 << 0)
> +
> +enum rockchip_lvds_sub_devtype {
> +	RK3288_LVDS,
> +};
> +#endif /* _ROCKCHIP_LVDS_ */
> 

-- 
Best Regard

???
Sandy Huang
?????????????-?????????
Fuzhou Rockchip Electronics Co.Ltd - Graphics & Display Dept.
Addr: ?????????????89??????A?21??(350003)
          No. 21 Building, A District, No.89,software Boulevard 
Fuzhou,Fujian,PRC
Tel?+86 0591-87884919  8690
E-mail?hjc at rock-chips.com
