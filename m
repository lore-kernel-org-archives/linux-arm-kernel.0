From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 23 Jul 2018 10:36:34 -0400
Subject: [RFC RESEND PATCH] drm/rockchip: update cursors asynchronously
 through atomic.
In-Reply-To: <20180627211447.20927-1-enric.balletbo@collabora.com>
References: <20180627211447.20927-1-enric.balletbo@collabora.com>
Message-ID: <20180723143634.GJ20359@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 11:14:47PM +0200, Enric Balletbo i Serra wrote:
> Add support to async updates of cursors by using the new atomic
> interface for that.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

LGTM. Given rockchip hasn't weighed in on the patch, and that you've tested it
on real hardware, let's land it.

Reviewed-by: Sean Paul <seanpaul@chromium.org>


> ---
> I am sending this as RFC because I still don't have a deep knowledge of
> the hw and I am not sure if the vop_plane_update function can be reused
> in both cases, atomic_updates and atomic_async_updates. I think that
> someone with more knowledge should take a look. The patch was tested on
> a Samsung Chromebook Plus in two ways.
> 
> 1. Running all igt kms_cursor_legacy and kms_atomic at plane_cursor_legacy
> tests and see that there is no regression after the patch.
> 
> 2. Running weston using the atomic API.
> 
> Best regards,
>   Enric
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 80 ++++++++++++++++-----
>  1 file changed, 64 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 53d4afe15278..1eb6bda924af 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -688,8 +688,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
>  	spin_unlock(&vop->reg_lock);
>  }
>  
> -static void vop_plane_atomic_update(struct drm_plane *plane,
> -		struct drm_plane_state *old_state)
> +static void vop_plane_update(struct drm_plane *plane)
>  {
>  	struct drm_plane_state *state = plane->state;
>  	struct drm_crtc *crtc = state->crtc;
> @@ -710,20 +709,6 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>  	bool rb_swap;
>  	int format;
>  
> -	/*
> -	 * can't update plane when vop is disabled.
> -	 */
> -	if (WARN_ON(!crtc))
> -		return;
> -
> -	if (WARN_ON(!vop->is_enabled))
> -		return;
> -
> -	if (!state->visible) {
> -		vop_plane_atomic_disable(plane, old_state);
> -		return;
> -	}
> -
>  	obj = rockchip_fb_get_gem_obj(fb, 0);
>  	rk_obj = to_rockchip_obj(obj);
>  
> @@ -794,10 +779,73 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>  	spin_unlock(&vop->reg_lock);
>  }
>  
> +static void vop_plane_atomic_update(struct drm_plane *plane,
> +				    struct drm_plane_state *old_state)
> +{
> +	struct drm_plane_state *state = plane->state;
> +	struct vop *vop = to_vop(state->crtc);
> +
> +	/*
> +	 * can't update plane when vop is disabled.
> +	 */
> +	if (WARN_ON(!state->crtc))
> +		return;
> +
> +	if (WARN_ON(!vop->is_enabled))
> +		return;
> +
> +	if (!state->visible) {
> +		vop_plane_atomic_disable(plane, old_state);
> +		return;
> +	}
> +
> +	vop_plane_update(plane);
> +}
> +
> +static int vop_plane_atomic_async_check(struct drm_plane *plane,
> +					struct drm_plane_state *state)
> +{
> +	struct drm_crtc_state *crtc_state;
> +
> +	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> +							state->crtc);
> +	if (WARN_ON(!crtc_state))
> +		return -EINVAL;
> +
> +	if (!crtc_state->active)
> +		return -EINVAL;
> +
> +	if (plane->state->crtc != state->crtc ||
> +	    plane->state->src_w != state->src_w ||
> +	    plane->state->src_h != state->src_h ||
> +	    plane->state->crtc_w != state->crtc_w ||
> +	    plane->state->crtc_h != state->crtc_h ||
> +	    !plane->state->fb ||
> +	    plane->state->fb != state->fb)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void vop_plane_atomic_async_update(struct drm_plane *plane,
> +					  struct drm_plane_state *new_state)
> +{
> +	plane->state->src_x = new_state->src_x;
> +	plane->state->src_y = new_state->src_y;
> +	plane->state->crtc_x = new_state->crtc_x;
> +	plane->state->crtc_y = new_state->crtc_y;
> +	plane->state->fb = new_state->fb;
> +	*plane->state = *new_state;
> +
> +	vop_plane_update(plane);
> +}
> +
>  static const struct drm_plane_helper_funcs plane_helper_funcs = {
>  	.atomic_check = vop_plane_atomic_check,
>  	.atomic_update = vop_plane_atomic_update,
>  	.atomic_disable = vop_plane_atomic_disable,
> +	.atomic_async_check = vop_plane_atomic_async_check,
> +	.atomic_async_update = vop_plane_atomic_async_update,
>  };
>  
>  static const struct drm_plane_funcs vop_plane_funcs = {
> -- 
> 2.18.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
