From: ck.hu@mediatek.com (CK Hu)
Date: Mon, 26 Nov 2018 13:30:00 +0800
Subject: [PATCH] drm/mediatek: Only try to attach bridge if there is one
In-Reply-To: <20181126040737.138682-1-drinkcat@chromium.org>
References: <20181126040737.138682-1-drinkcat@chromium.org>
Message-ID: <1543210200.1796.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Nicolas:

On Mon, 2018-11-26 at 12:07 +0800, Nicolas Boichat wrote:
> Even if dsi->bridge is NULL, we still try to call drm_bridge_attach,
> and print out an error message, before creating the connector.
> 
> When no bridge is provided, let's skip these 2 steps and directly
> create the connector.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 66df1b17795921..27b507eb4a997d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -818,10 +818,13 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
>  	dsi->encoder.possible_crtcs = 1;
>  
>  	/* If there's a bridge, attach to it and let it create the connector */
> -	ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
> -	if (ret) {
> -		DRM_ERROR("Failed to attach bridge to drm\n");
> -
> +	if (dsi->bridge) {
> +		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
> +		if (ret) {
> +			DRM_ERROR("Failed to attach bridge to drm\n");
> +			goto err_encoder_cleanup;
> +		}
> +	} else {
>  		/* Otherwise create our own connector and attach to a panel */
>  		ret = mtk_dsi_create_connector(drm, dsi);
>  		if (ret)
