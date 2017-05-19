From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 May 2017 19:57:53 +0200
Subject: [RFC PATCH 03/11] drm: sun4i: ignore swapped mixer<->tcon
 connection for DE2
In-Reply-To: <20170517164354.16399-4-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-4-icenowy@aosc.io>
Message-ID: <20170519175753.sygqnwopk7tuv35n@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 12:43:46AM +0800, Icenowy Zheng wrote:
> Some SoC's DE2 has two mixers. Defaultly the mixer0 is connected to
> tcon0 and mixer1 is connected to tcon1; however by setting a bit
> the connection can be swapped.
> 
> As we now hardcode the default connection, ignore the bonus endpoint for
> the mixer's output and the TCON's input, as they stands for the swapped
> connection.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c  | 27 ++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 39 +++++++++++++++++++++++++++++---------
>  drivers/gpu/drm/sun4i/sun4i_tcon.h |  2 ++
>  3 files changed, 59 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 1dd1948025d2..29bf1325ded6 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -173,6 +173,13 @@ static bool sun4i_drv_node_is_frontend(struct device_node *node)
>  		of_device_is_compatible(node, "allwinner,sun8i-a33-display-frontend");
>  }
>  
> +static bool sun4i_drv_node_is_swappable_de2_mixer(struct device_node *node)
> +{
> +	/* The V3s has only one mixer-tcon pair, so it's not listed here. */
> +	return of_device_is_compatible(node, "allwinner,sun8i-h3-de2-mixer0") ||
> +		of_device_is_compatible(node, "allwinner,sun8i-h3-de2-mixer1");
> +}
> +
>  static bool sun4i_drv_node_is_tcon(struct device_node *node)
>  {
>  	return of_device_is_compatible(node, "allwinner,sun5i-a13-tcon") ||
> @@ -249,6 +256,26 @@ static int sun4i_drv_add_endpoints(struct device *dev,
>  			}
>  		}
>  
> +		/*
> +		 * The second endpoint of the output of a swappable DE2 mixer
> +		 * is the TCON after connection swapping.
> +		 * Ignore it now, as we now hardcode mixer0->tcon0,
> +		 * mixer1->tcon1 connection.
> +		 */
> +		if (sun4i_drv_node_is_swappable_de2_mixer(node)) {
> +			struct of_endpoint endpoint;
> +
> +			if (of_graph_parse_endpoint(ep, &endpoint)) {
> +				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
> +				continue;
> +			}
> +
> +			if (endpoint.id) {
> +				DRM_DEBUG_DRIVER("Endpoint is an unused connection for DE2 mixer... skipping\n");
> +				continue;
> +			}
> +		}
> +
>  		/* Walk down our tree */
>  		count += sun4i_drv_add_endpoints(dev, match, remote);
>  
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index f44a37a5993d..89a215ff2370 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -425,7 +425,8 @@ static int sun4i_tcon_init_regmap(struct device *dev,
>   * requested via the get_id function of the engine.
>   */
>  static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
> -						   struct device_node *node)
> +						   struct device_node *node,
> +						   bool skip_bonus_ep)
>  {
>  	struct device_node *port, *ep, *remote;
>  	struct sunxi_engine *engine;
> @@ -439,6 +440,20 @@ static struct sunxi_engine *sun4i_tcon_find_engine(struct sun4i_drv *drv,
>  		if (!remote)
>  			continue;
>  
> +		if (skip_bonus_ep) {
> +			struct of_endpoint endpoint;
> +
> +			if (of_graph_parse_endpoint(ep, &endpoint)) {
> +				DRM_DEBUG_DRIVER("Couldn't parse endpoint\n");
> +				continue;
> +			}
> +
> +			if (endpoint.id) {
> +				DRM_DEBUG_DRIVER("Skipping bonus mixer->TCON connection when searching engine\n");
> +				continue;
> +			}
> +		}
> +

You don't list the mixers in the tcon's output, why do you need that
exactly?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170519/eb1f9469/attachment.sig>
