From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Apr 2018 12:21:41 +0300
Subject: [PATCH v5 1/5] drm/blend: Add a generic alpha property
In-Reply-To: <433cf537279d1cbd3d6e48e06341490e2c94443f.1522829034.git-series.maxime.ripard@bootlin.com>
References: <cover.5437f7a0834f12076bc0a4eba52226f28b2e0dda.1522829034.git-series.maxime.ripard@bootlin.com>
 <433cf537279d1cbd3d6e48e06341490e2c94443f.1522829034.git-series.maxime.ripard@bootlin.com>
Message-ID: <4523362.6qLWbm60l3@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Wednesday, 4 April 2018 11:04:19 EEST Maxime Ripard wrote:
> Some drivers duplicate the logic to create a property to store a per-plane
> alpha.
> 
> This is especially useful if we ever want to support extra protocols for
> Wayland like:
> https://lists.freedesktop.org/archives/wayland-devel/2017-August/034741.html
> 
> Let's create a helper in order to move that to the core.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_atomic.c        |  4 +++-
>  drivers/gpu/drm/drm_atomic_helper.c |  4 +++-
>  drivers/gpu/drm/drm_blend.c         | 37 ++++++++++++++++++++++++++++++-
>  include/drm/drm_blend.h             |  3 ++-
>  include/drm/drm_plane.h             |  6 +++++-
>  5 files changed, 54 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 7d25c42f22db..3d9ae057a6cd 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -783,6 +783,8 @@ static int drm_atomic_plane_set_property(struct
> drm_plane *plane, state->src_w = val;
>  	} else if (property == config->prop_src_h) {
>  		state->src_h = val;
> +	} else if (property == plane->alpha_property) {
> +		state->alpha = val;
>  	} else if (property == plane->rotation_property) {
>  		if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
>  			return -EINVAL;
> @@ -848,6 +850,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>  		*val = state->src_w;
>  	} else if (property == config->prop_src_h) {
>  		*val = state->src_h;
> +	} else if (property == plane->alpha_property) {
> +		*val = state->alpha;
>  	} else if (property == plane->rotation_property) {
>  		*val = state->rotation;
>  	} else if (property == plane->zpos_property) {
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> b/drivers/gpu/drm/drm_atomic_helper.c index ee03c1ed2521..0587a0a2f3aa
> 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3500,6 +3500,10 @@ void drm_atomic_helper_plane_reset(struct drm_plane
> *plane) if (plane->state) {
>  		plane->state->plane = plane;
>  		plane->state->rotation = DRM_MODE_ROTATE_0;
> +
> +		/* Reset the alpha value to fully opaque if it matters */
> +		if (plane->alpha_property)
> +			plane->state->alpha = plane->alpha_property->values[1];
>  	}
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 5a81e1b4c076..3bc8d5e85435 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -88,6 +88,11 @@
>   * On top of this basic transformation additional properties can be exposed
> by * the driver:
>   *
> + * alpha:
> + * 	Alpha is setup with drm_plane_create_alpha_property(). It controls the
> + * 	plane-wide opacity, from transparent (0) to opaque (0xffff). It can be
> + * 	combined with pixel alpha.
> + *
>   * rotation:
>   *	Rotation is set up with drm_plane_create_rotation_property(). It adds a
>   *	rotation and reflection step between the source and destination
> rectangles. @@ -106,6 +111,38 @@
>   */
> 
>  /**
> + * drm_plane_create_alpha_property - create a new alpha property
> + * @plane: drm plane
> + *
> + * This function creates a generic, mutable, alpha property and enables
> support + * for it in the DRM core. It is attached to @plane.
> + *
> + * The alpha property will be allowed to be within the bounds of 0
> + * (transparent) to 0xffff (opaque).
> + *
> + * Returns:
> + * 0 on success, negative error code on failure.
> + */
> +int drm_plane_create_alpha_property(struct drm_plane *plane)
> +{
> +	struct drm_property *prop;
> +
> +	prop = drm_property_create_range(plane->dev, 0, "alpha",
> +					 0, DRM_BLEND_ALPHA_OPAQUE);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&plane->base, prop, DRM_BLEND_ALPHA_OPAQUE);
> +	plane->alpha_property = prop;
> +
> +	if (plane->state)
> +		plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
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
> index 17606026590b..330c561c4c11 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -36,6 +36,9 @@ static inline bool drm_rotation_90_or_270(unsigned int
> rotation) return rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270);
>  }
> 
> +#define DRM_BLEND_ALPHA_OPAQUE		0xffff
> +
> +int drm_plane_create_alpha_property(struct drm_plane *plane);
>  int drm_plane_create_rotation_property(struct drm_plane *plane,
>  				       unsigned int rotation,
>  				       unsigned int supported_rotations);
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index d6da26d66a4b..9563bd25f19b 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -43,6 +43,7 @@ struct drm_modeset_acquire_ctx;
>   *	plane (in 16.16)
>   * @src_w: width of visible portion of plane (in 16.16)
>   * @src_h: height of visible portion of plane (in 16.16)
> + * @alpha: opacity of the plane
>   * @rotation: rotation of the plane
>   * @zpos: priority of the given plane on crtc (optional)
>   *	Note that multiple active planes on the same crtc can have an identical
> @@ -106,6 +107,9 @@ struct drm_plane_state {
>  	uint32_t src_x, src_y;
>  	uint32_t src_h, src_w;
> 
> +	/* Plane opacity */
> +	u16 alpha;
> +
>  	/* Plane rotation */
>  	unsigned int rotation;
> 
> @@ -496,6 +500,7 @@ enum drm_plane_type {
>   * @funcs: helper functions
>   * @properties: property tracking for this plane
>   * @type: type of plane (overlay, primary, cursor)
> + * @alpha_property: alpha property for this plane
>   * @zpos_property: zpos property for this plane
>   * @rotation_property: rotation property for this plane
>   * @helper_private: mid-layer private data
> @@ -571,6 +576,7 @@ struct drm_plane {
>  	 */
>  	struct drm_plane_state *state;
> 
> +	struct drm_property *alpha_property;
>  	struct drm_property *zpos_property;
>  	struct drm_property *rotation_property;

-- 
Regards,

Laurent Pinchart
