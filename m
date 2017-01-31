From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 31 Jan 2017 14:28:07 -0500
Subject: [PATCH v3 23/24] drm/rockchip: dw-mipi-dsi: add reset control
In-Reply-To: <20170129132444.25251-24-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-24-john@metanate.com>
Message-ID: <20170131192807.GG20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:43PM +0000, John Keeping wrote:
> In order to fully reset the state of the MIPI controller we must assert
> this reset.
> 
> This is slightly more complicated than it could be in order to maintain
> compatibility with device trees that do not specify the reset property.
> 

I always find it a little grating to see a device managed resource given to a
local variable that is used immediately and only once. However, I think this
might just be one of my twitches. So now that I've aired my grievance, 

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
> v3:
> - Add Chris' Reviewed-by
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 58cb8ace2fe8..cf3ca6b0cbdb 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  #include <linux/mfd/syscon.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> @@ -1124,6 +1125,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  			of_match_device(dw_mipi_dsi_dt_ids, dev);
>  	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct reset_control *apb_rst;
>  	struct drm_device *drm = data;
>  	struct dw_mipi_dsi *dsi;
>  	struct resource *res;
> @@ -1162,6 +1164,34 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  		return ret;
>  	}
>  
> +	/*
> +	 * Note that the reset was not defined in the initial device tree, so
> +	 * we have to be prepared for it not being found.
> +	 */
> +	apb_rst = devm_reset_control_get(dev, "apb");
> +	if (IS_ERR(apb_rst)) {
> +		if (PTR_ERR(apb_rst) == -ENODEV) {
> +			apb_rst = NULL;
> +		} else {
> +			dev_err(dev, "Unable to get reset control: %d\n", ret);
> +			return PTR_ERR(apb_rst);
> +		}
> +	}
> +
> +	if (apb_rst) {
> +		ret = clk_prepare_enable(dsi->pclk);
> +		if (ret) {
> +			dev_err(dev, "%s: Failed to enable pclk\n", __func__);
> +			return ret;
> +		}
> +
> +		reset_control_assert(apb_rst);
> +		usleep_range(10, 20);
> +		reset_control_deassert(apb_rst);
> +
> +		clk_disable_unprepare(dsi->pclk);
> +	}
> +
>  	ret = clk_prepare_enable(dsi->pllref_clk);
>  	if (ret) {
>  		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
