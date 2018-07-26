From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 26 Jul 2018 23:20:52 +0300
Subject: [PATCH v2 01/10] drm/atomic: Add __drm_atomic_helper_plane_reset
In-Reply-To: <20180726161756.1794-2-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
 <20180726161756.1794-2-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <2271754.L0ZicdVV5V@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandru,

Thank you for the patch.

On Thursday, 26 July 2018 19:17:47 EEST Alexandru Gheorghe wrote:
> There are a lot of drivers that subclass drm_plane_state, all of them
> duplicate the code that links toghether the plane with plane_state.

s/toghether/together/

> On top of that, drivers that enable core properties also have to
> duplicate the code for initializing the properties to their default
> values, which in all cases are the same as the defaults from core.
> 
> Change since v1:
> - Make it consistent with the other helpers and require that both
>   plane and state not be NULL, suggested by Boris Brezillon and
>   Philipp Zabel.
> 
> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 31 ++++++++++++++++++++---------
>  include/drm/drm_atomic_helper.h     |  2 ++
>  2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c
> b/drivers/gpu/drm/drm_atomic_helper.c index 866a2cc72ef6..7f5aafc5b1a0
> 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3552,6 +3552,26 @@ void drm_atomic_helper_crtc_destroy_state(struct
> drm_crtc *crtc, }
>  EXPORT_SYMBOL(drm_atomic_helper_crtc_destroy_state);
> 
> +/**
> + * __drm_atomic_helper_plane_reset - resets planes state to default values
> + * @plane: plane object, must not be NULL
> + * @state: atomic plane state, must not be NULL
> + *
> + * Initializes plane state to default. This is useful for drivers that
> subclass
> + * the plane state.
> + */
> +void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
> +				     struct drm_plane_state *state)
> +{
> +	state->plane = plane;
> +	state->rotation = DRM_MODE_ROTATE_0;

Nitpicking, I'd keep the blank line here to make the code a bit easier to read

> +	/* Reset the alpha value to fully opaque if it matters */
> +	if (plane->alpha_property)
> +		state->alpha = plane->alpha_property->values[1];

And here too.

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	plane->state = state;
> +}
> +EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
> +
>  /**
>   * drm_atomic_helper_plane_reset - default &drm_plane_funcs.reset hook for
> planes * @plane: drm plane
> @@ -3566,15 +3586,8 @@ void drm_atomic_helper_plane_reset(struct drm_plane
> *plane)
> 
>  	kfree(plane->state);
>  	plane->state = kzalloc(sizeof(*plane->state), GFP_KERNEL);
> -
> -	if (plane->state) {
> -		plane->state->plane = plane;
> -		plane->state->rotation = DRM_MODE_ROTATE_0;
> -
> -		/* Reset the alpha value to fully opaque if it matters */
> -		if (plane->alpha_property)
> -			plane->state->alpha = plane->alpha_property->values[1];
> -	}
> +	if (plane->state)
> +		__drm_atomic_helper_plane_reset(plane, plane->state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
> 
> diff --git a/include/drm/drm_atomic_helper.h
> b/include/drm/drm_atomic_helper.h index 99e2a5297c69..f4c7ed876c97 100644
> --- a/include/drm/drm_atomic_helper.h
> +++ b/include/drm/drm_atomic_helper.h
> @@ -156,6 +156,8 @@ void __drm_atomic_helper_crtc_destroy_state(struct
> drm_crtc_state *state); void drm_atomic_helper_crtc_destroy_state(struct
> drm_crtc *crtc,
>  					  struct drm_crtc_state *state);
> 
> +void __drm_atomic_helper_plane_reset(struct drm_plane *plane,
> +				     struct drm_plane_state *state);
>  void drm_atomic_helper_plane_reset(struct drm_plane *plane);
>  void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>  					       struct drm_plane_state *state);

-- 
Regards,

Laurent Pinchart
