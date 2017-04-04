From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 4 Apr 2017 15:28:37 -0400
Subject: [PATCH v3 04/11] drm/sun4i: abstract the layer type
In-Reply-To: <20170329194613.55548-5-icenowy@aosc.io>
References: <20170329194613.55548-1-icenowy@aosc.io>
 <20170329194613.55548-5-icenowy@aosc.io>
Message-ID: <20170404192837.pvlhwyeut45vg2wg@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 03:46:06AM +0800, Icenowy Zheng wrote:
> As we are going to add support for the Allwinner DE2 Mixer in sun4i-drm
> driver, we will finally have two types of layer.
> 
> Abstract the layer type to void * and a ops struct, which contains the
> only function used by crtc -- get the drm_plane struct of the layer.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Refactored patch in v3.
> 
>  drivers/gpu/drm/sun4i/sun4i_crtc.c  | 19 +++++++++++--------
>  drivers/gpu/drm/sun4i/sun4i_crtc.h  |  3 ++-
>  drivers/gpu/drm/sun4i/sun4i_layer.c | 19 ++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_layer.h |  2 +-
>  drivers/gpu/drm/sun4i/sunxi_layer.h | 17 +++++++++++++++++
>  5 files changed, 49 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sunxi_layer.h
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> index 3c876c3a356a..33854ee7f636 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -29,6 +29,7 @@
>  #include "sun4i_crtc.h"
>  #include "sun4i_drv.h"
>  #include "sun4i_layer.h"
> +#include "sunxi_layer.h"
>  #include "sun4i_tcon.h"
>  
>  static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
> @@ -149,7 +150,7 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>  	scrtc->tcon = tcon;
>  
>  	/* Create our layers */
> -	scrtc->layers = sun4i_layers_init(drm, scrtc->backend);
> +	scrtc->layers = (void **)sun4i_layers_init(drm, scrtc);
>  	if (IS_ERR(scrtc->layers)) {
>  		dev_err(drm->dev, "Couldn't create the planes\n");
>  		return NULL;
> @@ -157,14 +158,15 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>  
>  	/* find primary and cursor planes for drm_crtc_init_with_planes */
>  	for (i = 0; scrtc->layers[i]; i++) {
> -		struct sun4i_layer *layer = scrtc->layers[i];
> +		void *layer = scrtc->layers[i];
> +		struct drm_plane *plane = scrtc->layer_ops->get_plane(layer);
>  
> -		switch (layer->plane.type) {
> +		switch (plane->type) {
>  		case DRM_PLANE_TYPE_PRIMARY:
> -			primary = &layer->plane;
> +			primary = plane;
>  			break;
>  		case DRM_PLANE_TYPE_CURSOR:
> -			cursor = &layer->plane;
> +			cursor = plane;
>  			break;
>  		default:
>  			break;
> @@ -190,10 +192,11 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>  	/* Set possible_crtcs to this crtc for overlay planes */
>  	for (i = 0; scrtc->layers[i]; i++) {
>  		uint32_t possible_crtcs = BIT(drm_crtc_index(&scrtc->crtc));
> -		struct sun4i_layer *layer = scrtc->layers[i];
> +		void *layer = scrtc->layers[i];
> +		struct drm_plane *plane = scrtc->layer_ops->get_plane(layer);
>  
> -		if (layer->plane.type == DRM_PLANE_TYPE_OVERLAY)
> -			layer->plane.possible_crtcs = possible_crtcs;
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
> +			plane->possible_crtcs = possible_crtcs;
>  	}
>  
>  	return scrtc;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.h b/drivers/gpu/drm/sun4i/sun4i_crtc.h
> index 230cb8f0d601..a4036ee44cf8 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.h
> @@ -19,7 +19,8 @@ struct sun4i_crtc {
>  
>  	struct sun4i_backend		*backend;
>  	struct sun4i_tcon		*tcon;
> -	struct sun4i_layer		**layers;
> +	void				**layers;
> +	const struct sunxi_layer_ops	*layer_ops;

I think you should probably take a different approach to abstract the layer
type. How about creating

struct sunxi_layer {
        struct drm_plane plane;
}

base and then subclassing that for sun4i and sun8i? By doing this you can avoid
the nasty casting and you can also get rid of the get_plane() hook and
layer_ops.

Sean



>  };
>  
>  static inline struct sun4i_crtc *drm_crtc_to_sun4i_crtc(struct drm_crtc *crtc)
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index f26bde5b9117..bc4a70d6968b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -16,7 +16,9 @@
>  #include <drm/drmP.h>
>  
>  #include "sun4i_backend.h"
> +#include "sun4i_crtc.h"
>  #include "sun4i_layer.h"
> +#include "sunxi_layer.h"
>  
>  struct sun4i_plane_desc {
>  	       enum drm_plane_type     type;
> @@ -100,6 +102,17 @@ static const struct sun4i_plane_desc sun4i_backend_planes[] = {
>  	},
>  };
>  
> +static struct drm_plane *sun4i_layer_get_plane(void *layer)
> +{
> +	struct sun4i_layer *sun4i_layer = layer;
> +
> +	return &sun4i_layer->plane;
> +}
> +
> +static const struct sunxi_layer_ops layer_ops = {
> +	.get_plane = sun4i_layer_get_plane,
> +};
> +
>  static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
>  						struct sun4i_backend *backend,
>  						const struct sun4i_plane_desc *plane)
> @@ -129,9 +142,10 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
>  }
>  
>  struct sun4i_layer **sun4i_layers_init(struct drm_device *drm,
> -				       struct sun4i_backend *backend)
> +				       struct sun4i_crtc *crtc)
>  {
>  	struct sun4i_layer **layers;
> +	struct sun4i_backend *backend = crtc->backend;
>  	int i;
>  
>  	layers = devm_kcalloc(drm->dev, ARRAY_SIZE(sun4i_backend_planes) + 1,
> @@ -181,5 +195,8 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm,
>  		layers[i] = layer;
>  	};
>  
> +	/* Assign layer ops to the CRTC */
> +	crtc->layer_ops = &layer_ops;
> +
>  	return layers;
>  }
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.h b/drivers/gpu/drm/sun4i/sun4i_layer.h
> index 4be1f0919df2..425eea7b9e3b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.h
> @@ -27,6 +27,6 @@ plane_to_sun4i_layer(struct drm_plane *plane)
>  }
>  
>  struct sun4i_layer **sun4i_layers_init(struct drm_device *drm,
> -				       struct sun4i_backend *backend);
> +				       struct sun4i_crtc *crtc);
>  
>  #endif /* _SUN4I_LAYER_H_ */
> diff --git a/drivers/gpu/drm/sun4i/sunxi_layer.h b/drivers/gpu/drm/sun4i/sunxi_layer.h
> new file mode 100644
> index 000000000000..d8838ec39299
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sunxi_layer.h
> @@ -0,0 +1,17 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef _SUNXI_LAYER_H_
> +#define _SUNXI_LAYER_H_
> +
> +struct sunxi_layer_ops {
> +	struct drm_plane *(*get_plane)(void *layer);
> +};
> +
> +#endif /* _SUNXI_LAYER_H_ */
> -- 
> 2.12.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
