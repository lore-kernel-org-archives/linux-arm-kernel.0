From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 09 Jan 2018 14:34:47 +0200
Subject: [PATCH 06/19] drm/blend: Add a generic alpha property
In-Reply-To: <5c765fc730d75cb362dc37bcdb3b3aeacc7bdb30.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
 <5c765fc730d75cb362dc37bcdb3b3aeacc7bdb30.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <2691997.qmgyvrLtFu@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Tuesday, 9 January 2018 12:56:25 EET Maxime Ripard wrote:
> Some drivers duplicate the logic to create a property to store a per-plane
> alpha.
> 
> Let's create a helper in order to move that to the core.
> 
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/gpu/kms-properties.csv |  2 +-
>  drivers/gpu/drm/drm_atomic.c         |  4 ++++-
>  drivers/gpu/drm/drm_atomic_helper.c  |  1 +-
>  drivers/gpu/drm/drm_blend.c          | 32 +++++++++++++++++++++++++++++-
>  include/drm/drm_blend.h              |  1 +-
>  include/drm/drm_plane.h              |  6 +++++-
>  6 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/kms-properties.csv
> b/Documentation/gpu/kms-properties.csv index 927b65e14219..a3c3969c1992
> 100644
> --- a/Documentation/gpu/kms-properties.csv
> +++ b/Documentation/gpu/kms-properties.csv
> @@ -99,5 +99,5 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0, Max=1",Connector,TBD
> ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
>  ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
>  ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
> -rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
> +,,"""alpha""",RANGE,"Min=0, Max=255",Plane,Opacity of the plane from
> transparent (0) to opaque (255) ,,"""colorkey""",RANGE,"Min=0,
> Max=0x01ffffff",Plane,TBD

I think more documentation is needed. You should explain how the property 
operates and which formats it is applicable to. For instance you need to 
clarify what happens for format that contain an alpha component.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index c2da5585e201..ade18cf62c89 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -749,6 +749,8 @@ static int drm_atomic_plane_set_property(struct
> drm_plane *plane, state->src_w = val;
>  	} else if (property == config->prop_src_h) {
>  		state->src_h = val;
> +	} else if (property == plane->alpha_property) {
> +		state->alpha = val;
>  	} else if (property == plane->rotation_property) {
>  		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
>  			return -EINVAL;
> @@ -810,6 +812,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>  		*val = state->src_w;
>  	} else if (property == config->prop_src_h) {
>  		*val = state->src_h;
> +	} else if (property == plane->alpha_property) {
> +		*val = state->alpha;
>  	} else if (property == plane->rotation_property) {
>  		*val = state->rotation;
>  	} else if (property == plane->zpos_property) {
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> b/drivers/gpu/drm/drm_atomic_helper.c index 71d712f1b56a..018993df4c18
> 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3372,6 +3372,7 @@ void drm_atomic_helper_plane_reset(struct drm_plane
> *plane)
> 
>  	if (plane->state) {
>  		plane->state->plane = plane;
> +		plane->state->alpha = 255;

If you keep the ability to select an initial value other than fully opaque 
(see my comment below about that) you should reset to that value instead of 
hardcoding 255.

>  		plane->state->rotation = DRM_MODE_ROTATE_0;
>  	}
>  }
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 2e5e089dd912..8eea2a8af458 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -104,6 +104,38 @@
>   */
> 
>  /**
> + * drm_plane_create_alpha_property - create a new alpha property
> + * @plane: drm plane
> + * @alpha: initial value of alpha, from 0 (transparent) to 255 (opaque)

Do you have a use case for initializing the alpha value to something else than 
fully opaque ?

> + * This function initializes a generic, mutable, alpha property and
> + * enables support for it in the DRM core.
> + *
> + * Drivers can then attach this property to their plane to enable
> + * support for configurable plane alpha.

The function attaches the property to the plane, is the documentation outdated 
?

> + * Returns:
> + * 0 on success, negative error code on failure.
> + */
> +int drm_plane_create_alpha_property(struct drm_plane *plane, u8 alpha)
> +{
> +	struct drm_property *prop;
> +
> +	prop = drm_property_create_range(plane->dev, 0, "alpha", 0, 255);

Do you think the 0-255 range will fit all use cases ?

> +	if (!prop)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&plane->base, prop, alpha);
> +	plane->alpha_property = prop;
> +
> +	if (plane->state)
> +		plane->state->alpha = alpha;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_create_alpha_property);
> +
> +/**
>   * drm_plane_create_rotation_property - create a new rotation property
>   * @plane: drm plane
>   * @rotation: initial value of the rotation property
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index 17606026590b..5979a8fce453 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -36,6 +36,7 @@ static inline bool drm_rotation_90_or_270(unsigned int
> rotation) return rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270);
>  }
> 
> +int drm_plane_create_alpha_property(struct drm_plane *plane, u8 alpha);
>  int drm_plane_create_rotation_property(struct drm_plane *plane,
>  				       unsigned int rotation,
>  				       unsigned int supported_rotations);
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 571615079230..a5e26064b132 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -42,6 +42,7 @@ struct drm_modeset_acquire_ctx;
>   *	plane (in 16.16)
>   * @src_w: width of visible portion of plane (in 16.16)
>   * @src_h: height of visible portion of plane (in 16.16)
> + * @alpha: opacity of the plane
>   * @rotation: rotation of the plane
>   * @zpos: priority of the given plane on crtc (optional)
>   *	Note that multiple active planes on the same crtc can have an identical
> @@ -105,6 +106,9 @@ struct drm_plane_state {
>  	uint32_t src_x, src_y;
>  	uint32_t src_h, src_w;
> 
> +	/* Plane opacity */
> +	u8 alpha;
> +
>  	/* Plane rotation */
>  	unsigned int rotation;
> 
> @@ -481,6 +485,7 @@ enum drm_plane_type {
>   * @funcs: helper functions
>   * @properties: property tracking for this plane
>   * @type: type of plane (overlay, primary, cursor)
> + * @alpha_property: alpha property for this plane
>   * @zpos_property: zpos property for this plane
>   * @rotation_property: rotation property for this plane
>   * @helper_private: mid-layer private data
> @@ -546,6 +551,7 @@ struct drm_plane {
>  	 */
>  	struct drm_plane_state *state;
> 
> +	struct drm_property *alpha_property;
>  	struct drm_property *zpos_property;
>  	struct drm_property *rotation_property;
>  };

-- 
Regards,

Laurent Pinchart
