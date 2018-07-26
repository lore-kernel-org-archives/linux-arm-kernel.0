From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 26 Jul 2018 23:17:57 +0300
Subject: [PATCH v2 07/10] drm: rcar-du: Use
 __drm_atomic_helper_plane_reset instead of copying the logic
In-Reply-To: <20180726161756.1794-8-alexandru-cosmin.gheorghe@arm.com>
References: <20180726161756.1794-1-alexandru-cosmin.gheorghe@arm.com>
 <20180726161756.1794-8-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <5705422.OO4MiyceDJ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandru,

Thank you for the patch.

On Thursday, 26 July 2018 19:17:53 EEST Alexandru Gheorghe wrote:
> A new helper function(__drm_atomic_helper_plane_reset) has been added
> for linking a plane with its state and resetting the core
> properties(alpha, rotation, etc.) to their default values.
> Use that instead of duplicating the logic.
> 
> __drm_atomic_helper_plane_reset initializes the alpha property to its
> max value, which is defined by the drm core as DRM_BLEND_ALPHA_OPAQUE,
> so nothing changes regarding the alpha value.
> 
> Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 4 +---
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c   | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> b/drivers/gpu/drm/rcar-du/rcar_du_plane.c index c20f7ed48c8d..19a9d5f6db1c
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> @@ -689,15 +689,13 @@ static void rcar_du_plane_reset(struct drm_plane
> *plane)
> 	state = kzalloc(sizeof(*state), GFP_KERNEL);
>  	if (state == NULL)
>  		return;

As I'd like you to fix the two small issues below, could you also add a blank 
line here ?

> +	__drm_atomic_helper_plane_reset(plane, &state->state);
> 
>  	state->hwindex = -1;
>  	state->source = RCAR_DU_PLANE_MEMORY;
>  	state->colorkey = RCAR_DU_COLORKEY_NONE;
>  	state->state.zpos = plane->type == DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
> 

This blank line should be removed.

> -	plane->state = &state->state;
> -	plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
> -	plane->state->plane = plane;
>  }
> 
>  static int rcar_du_plane_atomic_set_property(struct drm_plane *plane,
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c index 72eebeda518e..0a0aa490f805
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
> @@ -346,11 +346,9 @@ static void rcar_du_vsp_plane_reset(struct drm_plane
> *plane)
> 	if (state == NULL)
>  		return;
> 
> -	state->state.alpha = DRM_BLEND_ALPHA_OPAQUE;
> +	__drm_atomic_helper_plane_reset(plane, &state->state);
>  	state->state.zpos = plane->type == DRM_PLANE_TYPE_PRIMARY ? 0 : 1;
> 

And this one too.

> -	plane->state = &state->state;
> -	plane->state->plane = plane;
>  }
> 
>  static const struct drm_plane_funcs rcar_du_vsp_plane_funcs = {

Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
