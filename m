From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 27 Jan 2017 13:43:19 +0100
Subject: [PATCH] Gpu: drm: rockchip - Fix possible NULL derefrence.
In-Reply-To: <1485515510-3129-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170127111200epcas3p34bf747c6c3c0da798ddaf34788d1a324@epcas3p3.samsung.com>
 <1485515510-3129-1-git-send-email-shailendra.v@samsung.com>
Message-ID: <20170127124319.GA13611@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 04:41:50PM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index ca22e5e..dbb99cf 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -1082,15 +1082,22 @@ static enum drm_mode_status rk3288_mipi_dsi_mode_valid(
>  static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
>  			     void *data)
>  {
> -	const struct of_device_id *of_id =
> -			of_match_device(dw_mipi_dsi_dt_ids, dev);
> -	const struct dw_mipi_dsi_plat_data *pdata = of_id->data;
> +	const struct of_device_id *of_id;
> +	const struct dw_mipi_dsi_plat_data *pdata;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct drm_device *drm = data;
>  	struct dw_mipi_dsi *dsi;
>  	struct resource *res;
>  	int ret;
>  
> +	of_id = of_match_device(dw_mipi_dsi_dt_ids, dev);
> +	if (!of_id) {
> +		dev_err(dev, "Error: No device match found\n");
> +		return -ENODEV;
> +	}
> +
> +	pdata = of_id->data;
> +
>  	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
>  	if (!dsi)
>  		return -ENOMEM;

Hello

You could use of_device_get_match_data()

Regards
Corentin Labbe
