From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 23 Jan 2017 14:12:58 +0800
Subject: [PATCH v2 25/26] drm/rockchip: dw-mipi-dsi: add reset control
In-Reply-To: <20170121163128.22240-26-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-26-john@metanate.com>
Message-ID: <58859EEA.7080309@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewed-by: Chris Zhong <zyw@rock-chips.com>

On 01/22/2017 12:31 AM, John Keeping wrote:
> In order to fully reset the state of the MIPI controller we must assert
> this reset.
>
> This is slightly more complicated than it could be in order to maintain
> compatibility with device trees that do not specify the reset property.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v2
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 881bb0c62ca5..f780401e8b5e 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -13,6 +13,7 @@
>   #include <linux/module.h>
>   #include <linux/of_device.h>
>   #include <linux/regmap.h>
> +#include <linux/reset.h>
>   #include <linux/mfd/syscon.h>
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_crtc.h>
> @@ -1121,6 +1122,7 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>   			of_match_device(dw_mipi_dsi_dt_ids, dev);
>   	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
>   	struct platform_device *pdev = to_platform_device(dev);
> +	struct reset_control *apb_rst;
>   	struct drm_device *drm = data;
>   	struct dw_mipi_dsi *dsi;
>   	struct resource *res;
> @@ -1159,6 +1161,34 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>   		return ret;
>   	}
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
>   	ret = clk_prepare_enable(dsi->pllref_clk);
>   	if (ret) {
>   		dev_err(dev, "%s: Failed to enable pllref_clk\n", __func__);
