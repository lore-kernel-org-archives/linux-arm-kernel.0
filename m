From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 9 Jan 2018 13:31:54 +0100
Subject: [PATCH 07/19] drm/atmel-hclcdc: Convert to the new generic
 alpha property
In-Reply-To: <87b4f265eaade03c5afdbd55a46851bbe4d8d2fe.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
 <87b4f265eaade03c5afdbd55a46851bbe4d8d2fe.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20180109133154.321e0f66@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  9 Jan 2018 11:56:26 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Now that we have support for per-plane alpha in the core, let's use it.
> 
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    | 13 +---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 89 ++----------------
>  2 files changed, 14 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 6833ee253cfa..704cac6399eb 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -298,7 +298,6 @@ struct atmel_hlcdc_layer {
>  struct atmel_hlcdc_plane {
>  	struct drm_plane base;
>  	struct atmel_hlcdc_layer layer;
> -	struct atmel_hlcdc_plane_properties *properties;
>  };
>  
>  static inline struct atmel_hlcdc_plane *
> @@ -345,18 +344,6 @@ struct atmel_hlcdc_dc_desc {
>  };
>  
>  /**
> - * Atmel HLCDC Plane properties.
> - *
> - * This structure stores plane property definitions.
> - *
> - * @alpha: alpha blending (or transparency) property
> - * @rotation: rotation property
> - */
> -struct atmel_hlcdc_plane_properties {
> -	struct drm_property *alpha;
> -};
> -
> -/**
>   * Atmel HLCDC Display Controller.
>   *
>   * @desc: HLCDC Display Controller description
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 1a9318810a29..dbc508889e87 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -31,7 +31,6 @@
>   * @src_y: y buffer position
>   * @src_w: buffer width
>   * @src_h: buffer height
> - * @alpha: alpha blending of the plane
>   * @disc_x: x discard position
>   * @disc_y: y discard position
>   * @disc_w: discard width
> @@ -54,8 +53,6 @@ struct atmel_hlcdc_plane_state {
>  	uint32_t src_w;
>  	uint32_t src_h;
>  
> -	u8 alpha;
> -
>  	int disc_x;
>  	int disc_y;
>  	int disc_w;
> @@ -385,7 +382,7 @@ atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
>  			cfg |= ATMEL_HLCDC_LAYER_LAEN;
>  		else
>  			cfg |= ATMEL_HLCDC_LAYER_GAEN |
> -			       ATMEL_HLCDC_LAYER_GA(state->alpha);
> +			       ATMEL_HLCDC_LAYER_GA(state->base.alpha);
>  	}
>  
>  	if (state->disc_h && state->disc_w)
> @@ -553,7 +550,7 @@ atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state)
>  
>  		if (!ovl_s->fb ||
>  		    drm_format_has_alpha(ovl_s->fb->format->format) ||
> -		    ovl_state->alpha != 255)
> +		    ovl_s->alpha != 255)
>  			continue;
>  
>  		/* TODO: implement a smarter hidden area detection */
> @@ -829,51 +826,18 @@ static void atmel_hlcdc_plane_destroy(struct drm_plane *p)
>  	drm_plane_cleanup(p);
>  }
>  
> -static int atmel_hlcdc_plane_atomic_set_property(struct drm_plane *p,
> -						 struct drm_plane_state *s,
> -						 struct drm_property *property,
> -						 uint64_t val)
> -{
> -	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> -	struct atmel_hlcdc_plane_properties *props = plane->properties;
> -	struct atmel_hlcdc_plane_state *state =
> -			drm_plane_state_to_atmel_hlcdc_plane_state(s);
> -
> -	if (property == props->alpha)
> -		state->alpha = val;
> -	else
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static int atmel_hlcdc_plane_atomic_get_property(struct drm_plane *p,
> -					const struct drm_plane_state *s,
> -					struct drm_property *property,
> -					uint64_t *val)
> -{
> -	struct atmel_hlcdc_plane *plane = drm_plane_to_atmel_hlcdc_plane(p);
> -	struct atmel_hlcdc_plane_properties *props = plane->properties;
> -	const struct atmel_hlcdc_plane_state *state =
> -		container_of(s, const struct atmel_hlcdc_plane_state, base);
> -
> -	if (property == props->alpha)
> -		*val = state->alpha;
> -	else
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane,
> -				struct atmel_hlcdc_plane_properties *props)
> +static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
>  {
>  	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
>  
>  	if (desc->type == ATMEL_HLCDC_OVERLAY_LAYER ||
> -	    desc->type == ATMEL_HLCDC_CURSOR_LAYER)
> -		drm_object_attach_property(&plane->base.base,
> -					   props->alpha, 255);
> +	    desc->type == ATMEL_HLCDC_CURSOR_LAYER) {
> +		int ret;
> +
> +		ret = drm_plane_create_alpha_property(&plane->base, 255);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (desc->layout.xstride && desc->layout.pstride) {
>  		int ret;
> @@ -988,8 +952,8 @@ static void atmel_hlcdc_plane_reset(struct drm_plane *p)
>  			return;
>  		}
>  
> -		state->alpha = 255;
>  		p->state = &state->base;
> +		p->state->alpha = 255;
>  		p->state->plane = p;
>  	}
>  }
> @@ -1042,13 +1006,10 @@ static const struct drm_plane_funcs layer_plane_funcs = {
>  	.reset = atmel_hlcdc_plane_reset,
>  	.atomic_duplicate_state = atmel_hlcdc_plane_atomic_duplicate_state,
>  	.atomic_destroy_state = atmel_hlcdc_plane_atomic_destroy_state,
> -	.atomic_set_property = atmel_hlcdc_plane_atomic_set_property,
> -	.atomic_get_property = atmel_hlcdc_plane_atomic_get_property,
>  };
>  
>  static int atmel_hlcdc_plane_create(struct drm_device *dev,
> -				    const struct atmel_hlcdc_layer_desc *desc,
> -				    struct atmel_hlcdc_plane_properties *props)
> +				    const struct atmel_hlcdc_layer_desc *desc)
>  {
>  	struct atmel_hlcdc_dc *dc = dev->dev_private;
>  	struct atmel_hlcdc_plane *plane;
> @@ -1060,7 +1021,6 @@ static int atmel_hlcdc_plane_create(struct drm_device *dev,
>  		return -ENOMEM;
>  
>  	atmel_hlcdc_layer_init(&plane->layer, desc, dc->hlcdc->regmap);
> -	plane->properties = props;
>  
>  	if (desc->type == ATMEL_HLCDC_BASE_LAYER)
>  		type = DRM_PLANE_TYPE_PRIMARY;
> @@ -1081,7 +1041,7 @@ static int atmel_hlcdc_plane_create(struct drm_device *dev,
>  			     &atmel_hlcdc_layer_plane_helper_funcs);
>  
>  	/* Set default property values*/
> -	ret = atmel_hlcdc_plane_init_properties(plane, props);
> +	ret = atmel_hlcdc_plane_init_properties(plane);
>  	if (ret)
>  		return ret;
>  
> @@ -1090,34 +1050,13 @@ static int atmel_hlcdc_plane_create(struct drm_device *dev,
>  	return 0;
>  }
>  
> -static struct atmel_hlcdc_plane_properties *
> -atmel_hlcdc_plane_create_properties(struct drm_device *dev)
> -{
> -	struct atmel_hlcdc_plane_properties *props;
> -
> -	props = devm_kzalloc(dev->dev, sizeof(*props), GFP_KERNEL);
> -	if (!props)
> -		return ERR_PTR(-ENOMEM);
> -
> -	props->alpha = drm_property_create_range(dev, 0, "alpha", 0, 255);
> -	if (!props->alpha)
> -		return ERR_PTR(-ENOMEM);
> -
> -	return props;
> -}
> -
>  int atmel_hlcdc_create_planes(struct drm_device *dev)
>  {
>  	struct atmel_hlcdc_dc *dc = dev->dev_private;
> -	struct atmel_hlcdc_plane_properties *props;
>  	const struct atmel_hlcdc_layer_desc *descs = dc->desc->layers;
>  	int nlayers = dc->desc->nlayers;
>  	int i, ret;
>  
> -	props = atmel_hlcdc_plane_create_properties(dev);
> -	if (IS_ERR(props))
> -		return PTR_ERR(props);
> -
>  	dc->dscrpool = dmam_pool_create("atmel-hlcdc-dscr", dev->dev,
>  				sizeof(struct atmel_hlcdc_dma_channel_dscr),
>  				sizeof(u64), 0);
> @@ -1130,7 +1069,7 @@ int atmel_hlcdc_create_planes(struct drm_device *dev)
>  		    descs[i].type != ATMEL_HLCDC_CURSOR_LAYER)
>  			continue;
>  
> -		ret = atmel_hlcdc_plane_create(dev, &descs[i], props);
> +		ret = atmel_hlcdc_plane_create(dev, &descs[i]);
>  		if (ret)
>  			return ret;
>  	}
