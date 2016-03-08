From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 8 Mar 2016 16:08:19 +0100
Subject: [PATCH 5/8] drm: atmel-hlcdc: support extended timing ranges on
 sama5d4 and sama5d2
In-Reply-To: <1452075569-8545-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1452075569-8545-1-git-send-email-boris.brezillon@free-electrons.com>
 <1452075569-8545-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <56DEEAE3.2010909@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/01/2016 11:19, Boris Brezillon a ?crit :
> The display timings on old SoCs older than the sama5d4 are quite limited
> and prevent the use of many displays. Add support for extended timing
> ranges on sama5d2 and sama5d4.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Absolutely:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.


> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 24 ++++++++++++++++++------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h |  6 ++++++
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index d760475..66f97e1 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -50,6 +50,9 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_at91sam9n12 = {
>  	.min_height = 0,
>  	.max_width = 1280,
>  	.max_height = 860,
> +	.max_spw = 0x3f,
> +	.max_vpw = 0x3f,
> +	.max_hpw = 0xff,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_at91sam9n12_layers),
>  	.layers = atmel_hlcdc_at91sam9n12_layers,
>  };
> @@ -134,6 +137,9 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_at91sam9x5 = {
>  	.min_height = 0,
>  	.max_width = 800,
>  	.max_height = 600,
> +	.max_spw = 0x3f,
> +	.max_vpw = 0x3f,
> +	.max_hpw = 0xff,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_at91sam9x5_layers),
>  	.layers = atmel_hlcdc_at91sam9x5_layers,
>  };
> @@ -237,6 +243,9 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d3 = {
>  	.min_height = 0,
>  	.max_width = 2048,
>  	.max_height = 2048,
> +	.max_spw = 0x3f,
> +	.max_vpw = 0x3f,
> +	.max_hpw = 0x1ff,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_sama5d3_layers),
>  	.layers = atmel_hlcdc_sama5d3_layers,
>  };
> @@ -320,6 +329,9 @@ static const struct atmel_hlcdc_dc_desc atmel_hlcdc_dc_sama5d4 = {
>  	.min_height = 0,
>  	.max_width = 2048,
>  	.max_height = 2048,
> +	.max_spw = 0xff,
> +	.max_vpw = 0xff,
> +	.max_hpw = 0x3ff,
>  	.nlayers = ARRAY_SIZE(atmel_hlcdc_sama5d4_layers),
>  	.layers = atmel_hlcdc_sama5d4_layers,
>  };
> @@ -358,19 +370,19 @@ int atmel_hlcdc_dc_mode_valid(struct atmel_hlcdc_dc *dc,
>  	int hback_porch = mode->htotal - mode->hsync_end;
>  	int hsync_len = mode->hsync_end - mode->hsync_start;
>  
> -	if (hsync_len > 0x40 || hsync_len < 1)
> +	if (hsync_len > dc->desc->max_spw + 1 || hsync_len < 1)
>  		return MODE_HSYNC;
>  
> -	if (vsync_len > 0x40 || vsync_len < 1)
> +	if (vsync_len > dc->desc->max_spw + 1 || vsync_len < 1)
>  		return MODE_VSYNC;
>  
> -	if (hfront_porch > 0x200 || hfront_porch < 1 ||
> -	    hback_porch > 0x200 || hback_porch < 1 ||
> +	if (hfront_porch > dc->desc->max_hpw + 1 || hfront_porch < 1 ||
> +	    hback_porch > dc->desc->max_hpw + 1 || hback_porch < 1 ||
>  	    mode->hdisplay < 1)
>  		return MODE_H_ILLEGAL;
>  
> -	if (vfront_porch > 0x40 || vfront_porch < 1 ||
> -	    vback_porch > 0x40 || vback_porch < 0 ||
> +	if (vfront_porch > dc->desc->max_vpw + 1 || vfront_porch < 1 ||
> +	    vback_porch > dc->desc->max_vpw || vback_porch < 0 ||
>  	    mode->vdisplay < 1)
>  		return MODE_V_ILLEGAL;
>  
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 6a762c9..864791e 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -50,6 +50,9 @@
>   * @min_height: minimum height supported by the Display Controller
>   * @max_width: maximum width supported by the Display Controller
>   * @max_height: maximum height supported by the Display Controller
> + * @max_spw: maximum vertical/horizontal pulse width
> + * @max_vpw: maximum vertical back/front porch width
> + * @max_hpw: maximum horizontal back/front porch width
>   * @layers: a layer description table describing available layers
>   * @nlayers: layer description table size
>   */
> @@ -58,6 +61,9 @@ struct atmel_hlcdc_dc_desc {
>  	int min_height;
>  	int max_width;
>  	int max_height;
> +	int max_spw;
> +	int max_vpw;
> +	int max_hpw;
>  	const struct atmel_hlcdc_layer_desc *layers;
>  	int nlayers;
>  };
> 


-- 
Nicolas Ferre
