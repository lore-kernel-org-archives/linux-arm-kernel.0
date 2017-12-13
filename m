From: thomas@vitsch.nl (Thomas van Kleef)
Date: Wed, 13 Dec 2017 17:23:04 +0100
Subject: [PATCH 6/8] drm/sun4i: sun4i_layer: Wire in the frontend
In-Reply-To: <0cd2570c9cbe20d094cee0e8e9918c3a0f6af2fa.1513178989.git-series.maxime.ripard@free-electrons.com>
References: <1513182183-1118130873.0029cb8ee8@prakkezator.vehosting.nl>
Message-ID: <ae438818-7b5c-c2b0-b390-e86004c36d39@vitsch.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13-12-17 16:33, Maxime Ripard wrote:
> Now that we have a driver, we can make use of it. This is done by
> adding a flag to our custom plane state that will trigger whether we should
> use the frontend on that particular plane or not.
> 
> The rest is just plumbing to set up the backend to not perform the DMA but
> receive its data from the frontend.
> 
> Note that we're still not making any use of the frontend itself, as no one
> is setting the flag yet.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c | 53 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_backend.h |  3 ++-
>  drivers/gpu/drm/sun4i/sun4i_layer.c   | 27 ++++++++++++--
>  drivers/gpu/drm/sun4i/sun4i_layer.h   |  1 +-
>  4 files changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index e83e1fe43823..f1d19767c55d 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -26,6 +26,7 @@
>  
>  #include "sun4i_backend.h"
>  #include "sun4i_drv.h"
> +#include "sun4i_frontend.h"
>  #include "sun4i_layer.h"
>  #include "sunxi_engine.h"
>  
> @@ -203,6 +204,30 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
>  	return 0;
>  }
>  
> +int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
> +					int layer, uint32_t fmt)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = sun4i_backend_drm_format_to_layer(NULL, fmt, &val);
> +	if (ret) {
> +		DRM_DEBUG_DRIVER("Invalid format\n");
> +		return ret;
> +	}
> +
> +	regmap_update_bits(backend->engine.regs,
> +			   SUN4I_BACKEND_ATTCTL_REG0(layer),
> +			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN,
> +			   SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN);
> +
> +	regmap_update_bits(backend->engine.regs,
> +			   SUN4I_BACKEND_ATTCTL_REG1(layer),
> +			   SUN4I_BACKEND_ATTCTL_REG1_LAY_FBFMT, val);
> +
> +	return 0;
> +}
> +
>  int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
>  				      int layer, struct drm_plane *plane)
>  {
> @@ -330,6 +355,34 @@ static int sun4i_backend_of_get_id(struct device_node *node)
>  	return ret;
>  }
>  
> +static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
> +							  struct device_node *node)
> +{
> +	struct device_node *port, *ep, *remote;
> +	struct sun4i_frontend *frontend;
> +
> +	port = of_graph_get_port_by_id(node, 0);
> +	if (!port)
> +		return ERR_PTR(-EINVAL);
> +
> +	for_each_available_child_of_node(port, ep) {
> +		remote = of_graph_get_remote_port_parent(ep);
> +		if (!remote)
> +			continue;
> +
> +		/* does this node match any registered engines? */
> +		list_for_each_entry(frontend, &drv->frontend_list, list) {
> +			if (remote == frontend->node) {
> +				of_node_put(remote);
> +				of_node_put(port);
> +				return frontend;
> +			}
> +		}
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
>  	.commit				= sun4i_backend_commit,
>  	.layers_init			= sun4i_layers_init,
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
> index ba1410fd5410..636a51521e77 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
> @@ -72,6 +72,7 @@
>  #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(x)		((x) << 15)
>  #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL_MASK	GENMASK(11, 10)
>  #define SUN4I_BACKEND_ATTCTL_REG0_LAY_PRISEL(x)			((x) << 10)
> +#define SUN4I_BACKEND_ATTCTL_REG0_LAY_VDOEN		BIT(1)
>  
>  #define SUN4I_BACKEND_ATTCTL_REG1(l)		(0x8a0 + (0x4 * (l)))
>  #define SUN4I_BACKEND_ATTCTL_REG1_LAY_HSCAFCT		GENMASK(15, 14)
> @@ -171,5 +172,7 @@ int sun4i_backend_update_layer_formats(struct sun4i_backend *backend,
>  				       int layer, struct drm_plane *plane);
>  int sun4i_backend_update_layer_buffer(struct sun4i_backend *backend,
>  				      int layer, struct drm_plane *plane);
> +int sun4i_backend_update_layer_frontend(struct sun4i_backend *backend,
> +					int layer, uint32_t in_fmt);
>  
>  #endif /* _SUN4I_BACKEND_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index c3afcf888906..3b58667a06dc 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -15,6 +15,7 @@
>  #include <drm/drmP.h>
>  
>  #include "sun4i_backend.h"
> +#include "sun4i_frontend.h"
>  #include "sun4i_layer.h"
>  #include "sunxi_engine.h"
>  
> @@ -70,21 +71,41 @@ static void sun4i_backend_layer_destroy_state(struct drm_plane *plane,
>  static void sun4i_backend_layer_atomic_disable(struct drm_plane *plane,
>  					       struct drm_plane_state *old_state)
>  {
> +	struct sun4i_layer_state *layer_state = state_to_sun4i_layer_state(old_state);
>  	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
>  	struct sun4i_backend *backend = layer->backend;
> +	struct sun4i_frontend *frontend = backend->frontend;
>  
>  	sun4i_backend_layer_enable(backend, layer->id, false);
> +
> +	if (layer_state->uses_frontend)
> +		sun4i_frontend_exit(frontend);
>  }
>  
>  static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
>  					      struct drm_plane_state *old_state)
>  {
> +	struct sun4i_layer_state *layer_state = state_to_sun4i_layer_state(plane->state);
>  	struct sun4i_layer *layer = plane_to_sun4i_layer(plane);
>  	struct sun4i_backend *backend = layer->backend;
> +	struct sun4i_frontend *frontend = backend->frontend;
> +
> +	if (layer_state->uses_frontend) {
> +		sun4i_frontend_init(frontend);
> +		sun4i_frontend_update_coord(frontend, plane);
> +		sun4i_frontend_update_buffer(frontend, plane);
> +		sun4i_frontend_update_formats(frontend, plane,
> +					      DRM_FORMAT_ARGB8888);
> +		sun4i_backend_update_layer_frontend(backend, layer->id,
> +						    DRM_FORMAT_ARGB8888);
> +		sun4i_backend_update_layer_coord(backend, layer->id, plane);
> +		sun4i_frontend_enable(frontend);
> +	} else {
> +		sun4i_backend_update_layer_coord(backend, layer->id, plane);
> +		sun4i_backend_update_layer_formats(backend, layer->id, plane);
> +		sun4i_backend_update_layer_buffer(backend, layer->id, plane);
> +	}
>  
> -	sun4i_backend_update_layer_coord(backend, layer->id, plane);
> -	sun4i_backend_update_layer_formats(backend, layer->id, plane);
> -	sun4i_backend_update_layer_buffer(backend, layer->id, plane);
>  	sun4i_backend_layer_enable(backend, layer->id, true);
>  }
>  
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
> index d2c19348d1b0..75b4868ba87c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
> @@ -24,6 +24,7 @@ struct sun4i_layer {
>  
>  struct sun4i_layer_state {
>  	struct drm_plane_state	state;
> +	bool			uses_frontend;
>  };
>  
>  static inline struct sun4i_layer *
> 

I wondered if the following is still valid?
In file sun4i_layer.c, func sun4i_layers_init

------------------
         /*
         * The hardware is a bit unusual here.
         *
         * Even though it supports 4 layers, it does the composition
         * in two separate steps.
         *
         * The first one is assigning a layer to one of its two
         * pipes. If more that 1 layer is assigned to the same pipe,
         * and if pixels overlaps, the pipe will take the pixel from
         * the layer with the highest priority.
         *
         * The second step is the actual alpha blending, that takes
         * the two pipes as input, and uses the eventual alpha
         * component to do the transparency between the two.
         *
         * This two steps scenario makes us unable to guarantee a
         * robust alpha blending between the 4 layers in all
         * situations. So we just expose two layers, one per pipe. On
         * SoCs that support it, sprites could fill the need for more
         * layers.
         */
        for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
                const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
                struct sun4i_layer *layer;

                layer = sun4i_layer_init_one(drm, backend, plane);
                if (IS_ERR(layer)) {
                        dev_err(drm->dev, "Couldn't initialize %s plane\n",
                                i ? "overlay" : "primary");
                        return ERR_CAST(layer);
                };

                DRM_DEBUG_DRIVER("Assigning %s plane to pipe %d\n",
                                 i ? "overlay" : "primary", plane->pipe);
                regmap_update_bits(engine->regs, SUN4I_BACKEND_ATTCTL_REG0(i),
                                   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL_MASK,
                                   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(plane->pipe));

                layer->id = i;
                planes[i] = &layer->plane;
        };
-----------------
I have been using the 3rd layer (layer2) as the input for the frontend. This essentially
overlays the other 2 layers. Is it still the case that we can only have 2 layers here?
Or could be present 1 additional layer when it is attached to the frontend?
Perhaps this is not relevant for this patchset.

Regards,

Thomas van Kleef
Vitsch Electronics
http://Vitsch.nl/
http://VitschVPN.nl/
tel: +31-(0)40-7113051
KvK nr: 17174380
BTW nr: NL142748201B01
