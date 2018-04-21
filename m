From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 21 Apr 2018 18:19:21 +0200
Subject: [PATCH v3 4/7] drm/atmel-hlcdc: support bus-width (12/16/18/24)
 in endpoint nodes
In-Reply-To: <20180419162751.25223-5-peda@axentia.se>
References: <20180419162751.25223-1-peda@axentia.se>
 <20180419162751.25223-5-peda@axentia.se>
Message-ID: <20180421181921.75c41917@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Apr 2018 18:27:48 +0200
Peter Rosin <peda@axentia.se> wrote:

> This beats the heuristic that the connector is involved in what format
> should be output for cases where this fails.
> 
> E.g. if there is a bridge that changes format between the encoder and the
> connector, or if some of the RGB pins between the lcd controller and the
> encoder are not routed on the PCB.
> 
> This is critical for the devices that have the "conflicting output
> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
> RGB bits move around depending on the selected output mode. For
> devices that do not have the "conflicting output formats" issue
> (SAMA5D2, SAMA5D4), this is completely irrelevant.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 71 +++++++++++++++++-------
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     |  2 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 40 ++++++++++++-
>  3 files changed, 92 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index d73281095fac..b4e7f5b6f497 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -226,6 +226,56 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>  #define ATMEL_HLCDC_RGB888_OUTPUT	BIT(3)
>  #define ATMEL_HLCDC_OUTPUT_MODE_MASK	GENMASK(3, 0)
>  
> +static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
> +{
> +	struct drm_connector *connector = state->connector;
> +	struct atmel_hlcdc_dc *dc = connector->dev->dev_private;
> +	struct drm_encoder *encoder;
> +	struct drm_display_info *info = &connector->display_info;
> +	unsigned int supported_fmts = 0;
> +	int j;
> +
> +	encoder = state->best_encoder;
> +	if (!encoder)
> +		encoder = connector->encoder;
> +
> +	switch (dc->bus_fmt[encoder->index]) {
> +	case 0:
> +		break;
> +	case MEDIA_BUS_FMT_RGB444_1X12:
> +		return ATMEL_HLCDC_RGB444_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		return ATMEL_HLCDC_RGB565_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +		return ATMEL_HLCDC_RGB666_OUTPUT;
> +	case MEDIA_BUS_FMT_RGB888_1X24:
> +		return ATMEL_HLCDC_RGB888_OUTPUT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (j = 0; j < info->num_bus_formats; j++) {
> +		switch (info->bus_formats[j]) {
> +		case MEDIA_BUS_FMT_RGB444_1X12:
> +			supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB565_1X16:
> +			supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB666_1X18:
> +			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> +			break;
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return supported_fmts;
> +}
> +
>  static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  {
>  	unsigned int output_fmts = ATMEL_HLCDC_OUTPUT_MODE_MASK;
> @@ -238,31 +288,12 @@ static int atmel_hlcdc_crtc_select_output_mode(struct drm_crtc_state *state)
>  	crtc = drm_crtc_to_atmel_hlcdc_crtc(state->crtc);
>  
>  	for_each_new_connector_in_state(state->state, connector, cstate, i) {
> -		struct drm_display_info *info = &connector->display_info;
>  		unsigned int supported_fmts = 0;
> -		int j;
>  
>  		if (!cstate->crtc)
>  			continue;
>  
> -		for (j = 0; j < info->num_bus_formats; j++) {
> -			switch (info->bus_formats[j]) {
> -			case MEDIA_BUS_FMT_RGB444_1X12:
> -				supported_fmts |= ATMEL_HLCDC_RGB444_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB565_1X16:
> -				supported_fmts |= ATMEL_HLCDC_RGB565_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB666_1X18:
> -				supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
> -				break;
> -			case MEDIA_BUS_FMT_RGB888_1X24:
> -				supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
> -				break;
> -			default:
> -				break;
> -			}
> -		}
> +		supported_fmts = atmel_hlcdc_connector_output_mode(cstate);
>  
>  		if (crtc->dc->desc->conflicting_output_formats)
>  			output_fmts &= supported_fmts;
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index ab32d5b268d2..be2d180dd169 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -365,6 +365,7 @@ struct atmel_hlcdc_plane_properties {
>   * @hlcdc: pointer to the atmel_hlcdc structure provided by the MFD device
>   * @fbdev: framebuffer device attached to the Display Controller
>   * @crtc: CRTC provided by the display controller
> + * @bus_fmt: Array of bus format overrides, per connector.
>   * @planes: instantiated planes
>   * @layers: active HLCDC layers
>   * @wq: display controller workqueue
> @@ -376,6 +377,7 @@ struct atmel_hlcdc_dc {
>  	struct dma_pool *dscrpool;
>  	struct atmel_hlcdc *hlcdc;
>  	struct drm_crtc *crtc;
> +	int *bus_fmt;

Looks like this bus_fmt information should be attached to the
atmel_hlcdc_rgb_output object, since the property is placed in the
endpoint representing the DPI encoder output.

You could then parse the format in atmel_hlcdc_attach_endpoint() and
provide a helper to retrieve the hardcoded bus-format attached to an
encoder:

  int atmel_hlcdc_encoder_get_bus_fmt(struct drm_encoder *encoder);

and if it returns zero you can fallback to bus formats
defined in drm_display_info, as you do in this patch.

>  	struct atmel_hlcdc_layer *layers[ATMEL_HLCDC_MAX_LAYERS];
>  	struct workqueue_struct *wq;
>  	struct {
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index 8db51fb131db..8787e2890c93 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -77,10 +77,48 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  
>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
>  {
> +	struct atmel_hlcdc_dc *dc = dev->dev_private;
> +	struct device_node *ep;
> +	int count = of_graph_get_endpoint_count(dev->dev->of_node);
>  	int endpoint, ret = 0;
>  
> -	for (endpoint = 0; !ret; endpoint++)
> +	/*
> +	 * Assume that each endpoint will create a single encoder
> +	 * so that the encoder index can be used as index into
> +	 * this bus_fmt array.
> +	 */
> +	dc->bus_fmt = devm_kzalloc(dev->dev, count * sizeof(*dc->bus_fmt),
> +				   GFP_KERNEL);
> +	if (!dc->bus_fmt)
> +		return -ENOMEM;
> +
> +	for (endpoint = 0; !ret; endpoint++) {
> +		ep = of_graph_get_endpoint_by_regs(dev->dev->of_node, 0,
> +						   endpoint);
> +		if (!ep) {
> +			ret = -ENODEV;
> +			break;
> +		}
> +
> +		dc->bus_fmt[endpoint] = drm_of_media_bus_fmt(ep);
> +
> +		switch (dc->bus_fmt[endpoint]) {
> +		case 0:
> +		case MEDIA_BUS_FMT_RGB444_1X12:
> +		case MEDIA_BUS_FMT_RGB565_1X16:
> +		case MEDIA_BUS_FMT_RGB666_1X18:
> +		case MEDIA_BUS_FMT_RGB888_1X24:
> +			break;
> +		default:
> +			ret = dc->bus_fmt[endpoint];
> +			if (ret > 0)
> +				ret = -EINVAL;
> +		}
> +		if (ret < 0)
> +			break;
> +
>  		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> +	}
>  
>  	/* At least one device was successfully attached.*/
>  	if (ret == -ENODEV && endpoint)
