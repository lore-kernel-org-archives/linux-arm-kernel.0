From: briannorris@chromium.org (Brian Norris)
Date: Thu, 2 Mar 2017 13:59:26 -0800
Subject: [PATCH v4 23/23] drm/rockchip: dw-mipi-dsi: add reset control
In-Reply-To: <20170224125506.21533-24-john@metanate.com>
References: <20170224125506.21533-1-john@metanate.com>
 <20170224125506.21533-24-john@metanate.com>
Message-ID: <20170302215925.GA49518@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh, one more thing:

On Fri, Feb 24, 2017 at 12:55:06PM +0000, John Keeping wrote:

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 0c4bae711e84..30da75667334 100644
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
> @@ -1144,6 +1145,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  			of_match_device(dw_mipi_dsi_dt_ids, dev);
>  	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct reset_control *apb_rst;
>  	struct drm_device *drm = data;
>  	struct dw_mipi_dsi *dsi;
>  	struct resource *res;
> @@ -1182,6 +1184,35 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  		return ret;
>  	}
>  
> +	/*
> +	 * Note that the reset was not defined in the initial device tree, so
> +	 * we have to be prepared for it not being found.
> +	 */
> +	apb_rst = devm_reset_control_get(dev, "apb");
> +	if (IS_ERR(apb_rst)) {
> +		ret = PTR_ERR(apb_rst);
> +		if (ret == -ENOENT) {
> +			apb_rst = NULL;
> +		} else {
> +			dev_err(dev, "Unable to get reset control: %d\n", ret);

Might want to check for -EPROBE_DEFER before printing an error?

Brian

> +			return ret;
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
