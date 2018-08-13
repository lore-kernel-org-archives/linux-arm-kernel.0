From: jacopo@jmondi.org (jacopo mondi)
Date: Mon, 13 Aug 2018 15:59:49 +0200
Subject: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
In-Reply-To: <20180810130359.9882-4-peda@axentia.se>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
Message-ID: <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
> This enables more flexible devicetrees. You can e.g. have two output
> nodes where one is not enabled, without the ordering affecting things.
> 
> Prior to this patch the active node had to have endpoint id zero.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> index 8db51fb131db..16c1b2f54b42 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>  	.destroy = drm_encoder_cleanup,
>  };
>  
> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
> +				       struct of_endpoint *endpoint)
>  {
>  	struct drm_encoder *encoder;
>  	struct drm_panel *panel;
>  	struct drm_bridge *bridge;
>  	int ret;
>  
> -	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
> +	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
> +					  endpoint->port, endpoint->id,

You are refusing endpoint->port != 0 in the caller, so that could be
0.

Apart from that small nit:
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks
  j

>  					  &panel, &bridge);
>  	if (ret)
>  		return ret;
> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>  
>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
>  {
> -	int endpoint, ret = 0;
> -
> -	for (endpoint = 0; !ret; endpoint++)
> -		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
> +	struct of_endpoint endpoint;
> +	struct device_node *node = NULL;
> +	int count = 0;
> +	int ret = 0;
> +
> +	for_each_endpoint_of_node(dev->dev->of_node, node) {
> +		of_graph_parse_endpoint(node, &endpoint);
> +
> +		if (endpoint.port)
> +			continue;
> +
> +		ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
> +		if (ret == -ENODEV)
> +			continue;
> +		if (ret) {
> +			of_node_put(node);
> +			break;
> +		}
> +		count++;
> +	}
>  
>  	/* At least one device was successfully attached.*/
> -	if (ret == -ENODEV && endpoint)
> +	if (ret == -ENODEV && count)
>  		return 0;
>  
>  	return ret;
> -- 
> 2.11.0
> 
