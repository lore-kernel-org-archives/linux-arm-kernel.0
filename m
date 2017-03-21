From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 21 Mar 2017 16:30:39 -0400
Subject: [PATCH v3 3/4] drm/rockchip/dsi: enable the grf clk before
 writing grf registers
In-Reply-To: <1489722865-22122-4-git-send-email-zyw@rock-chips.com>
References: <1489722865-22122-1-git-send-email-zyw@rock-chips.com>
 <1489722865-22122-4-git-send-email-zyw@rock-chips.com>
Message-ID: <20170321203039.GK19389@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 11:54:23AM +0800, Chris Zhong wrote:
> For RK3399, the grf clk should be enabled before writing grf registers,
> otherwise the register value can not be changed.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

Minor nit below, with that:

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
> 
> Changes in v3:
> - add a DW_MIPI_NEEDS_GRF_CLK for RK3399
> 
> Changes in v2:
> - check the grf_clk only for RK3399
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 68f48b0..5a18281 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -252,6 +252,7 @@
>  #define THS_ZERO_PROGRAM_EN	BIT(6)
>  
>  #define DW_MIPI_NEEDS_PHY_CFG_CLK	BIT(0)
> +#define DW_MIPI_NEEDS_GRF_CLK		BIT(1)
>  
>  enum {
>  	BANDGAP_97_07,
> @@ -294,6 +295,7 @@ struct dw_mipi_dsi {
>  	struct regmap *grf_regmap;
>  	void __iomem *base;
>  
> +	struct clk *grf_clk;
>  	struct clk *pllref_clk;
>  	struct clk *pclk;
>  	struct clk *phy_cfg_clk;
> @@ -982,6 +984,17 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
>  	dw_mipi_dsi_dphy_interface_config(dsi);
>  	dw_mipi_dsi_clear_err(dsi);
>  
> +	/*
> +	 * For the RK3399, the clk of grf must be enabled before writing grf
> +	 * register. And for RK3288 or other soc, this grf_clk must be NULL,
> +	 * the clk_prepare_enable return true directly.
> +	 */
> +	ret = clk_prepare_enable(dsi->grf_clk);
> +	if (ret) {
> +		dev_err(dsi->dev, "Failed to enable grf_clk\n");

nit: Print ret?

> +		return;
> +	}
> +
>  	if (pdata->grf_dsi0_mode_reg)
>  		regmap_write(dsi->grf_regmap, pdata->grf_dsi0_mode_reg,
>  			     pdata->grf_dsi0_mode);
> @@ -1006,6 +1019,8 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
>  	regmap_write(dsi->grf_regmap, pdata->grf_switch_reg, val);
>  	dev_dbg(dsi->dev, "vop %s output to dsi0\n", (mux) ? "LIT" : "BIG");
>  	dsi->dpms_mode = DRM_MODE_DPMS_ON;
> +
> +	clk_disable_unprepare(dsi->grf_clk);
>  }
>  
>  static int
> @@ -1139,7 +1154,7 @@ static struct dw_mipi_dsi_plat_data rk3399_mipi_dsi_drv_data = {
>  	.grf_switch_reg = RK3399_GRF_SOC_CON19,
>  	.grf_dsi0_mode = RK3399_GRF_DSI_MODE,
>  	.grf_dsi0_mode_reg = RK3399_GRF_SOC_CON22,
> -	.flags = DW_MIPI_NEEDS_PHY_CFG_CLK,
> +	.flags = DW_MIPI_NEEDS_PHY_CFG_CLK | DW_MIPI_NEEDS_GRF_CLK,
>  	.max_data_lanes = 4,
>  };
>  
> @@ -1240,6 +1255,15 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  		}
>  	}
>  
> +	if (pdata->flags & DW_MIPI_NEEDS_GRF_CLK) {
> +		dsi->grf_clk = devm_clk_get(dev, "grf");
> +		if (IS_ERR(dsi->grf_clk)) {
> +			ret = PTR_ERR(dsi->grf_clk);
> +			dev_err(dev, "Unable to get grf_clk: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	ret = clk_prepare_enable(dsi->pllref_clk);
>  	if (ret) {
>  		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
> -- 
> 2.6.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
