From: daniel@ffwll.ch (Daniel Vetter)
Date: Fri, 6 Feb 2015 22:11:47 +0100
Subject: [PATCH] drm: atmel-hlcdc: add discard area support
In-Reply-To: <1423236662-6782-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1423236662-6782-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150206211147.GF14009@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 04:31:02PM +0100, Boris Brezillon wrote:
> The HLCDC IP provides a way to discard a specific area on the primary
> plane (in case at least one of the overlay is activated and alpha
> blending is disabled).
> Doing this will reduce the amount of data to transfer from the main
> memory to the Display Controller, and thus alleviate the load on the
> memory bus (since this link is quite limited on such hardware,
> this kind of optimization is really important).
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Hi Daniel,
> 
> Can you tell me if that's what you had in mind for the discard area feature
> we talked about yersterday.
> 
> This patch depends on the Atmel HLCDC Atomic mode-setting conversion
> work [1].
> 
> Best Regards,
> 
> Boris
> 
> [1]https://lkml.org/lkml/2015/2/4/658
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |   2 +-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |   2 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 108 ++++++++++++++++++++++++
>  3 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index de6973d..4fd1683 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -201,7 +201,7 @@ static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
>  	if (atmel_hlcdc_dc_mode_valid(crtc->dc, &s->adjusted_mode) != MODE_OK)
>  		return -EINVAL;
>  
> -	return 0;
> +	return atmel_hlcdc_plane_prepare_disc_area(s);
>  }
>  
>  static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c)
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> index 015c3f1..1ea9c2c 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> @@ -148,6 +148,8 @@ int atmel_hlcdc_dc_mode_valid(struct atmel_hlcdc_dc *dc,
>  struct atmel_hlcdc_planes *
>  atmel_hlcdc_create_planes(struct drm_device *dev);
>  
> +int atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state);
> +
>  void atmel_hlcdc_crtc_irq(struct drm_crtc *c);
>  
>  void atmel_hlcdc_crtc_cancel_page_flip(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 6c6fcae..dbf97d9 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -51,6 +51,13 @@ struct atmel_hlcdc_plane_state {
>  
>  	u8 alpha;
>  
> +	bool disc_updated;
> +
> +	int disc_x;
> +	int disc_y;
> +	int disc_w;
> +	int disc_h;
> +
>  	/* These fields are private and should not be touched */
>  	int bpp[ATMEL_HLCDC_MAX_PLANES];
>  	unsigned int offsets[ATMEL_HLCDC_MAX_PLANES];
> @@ -428,6 +435,104 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
>  	}
>  }
>  
> +int
> +atmel_hlcdc_plane_prepare_disc_area(struct drm_crtc_state *c_state)
> +{
> +	int disc_x = 0, disc_y = 0, disc_w = 0, disc_h = 0;
> +	const struct atmel_hlcdc_layer_cfg_layout *layout;
> +	struct atmel_hlcdc_plane_state *primary_state;
> +	struct drm_plane_state *primary_s;
> +	struct atmel_hlcdc_plane *primary;
> +	struct drm_plane *ovl;
> +
> +	primary = drm_plane_to_atmel_hlcdc_plane(c_state->crtc->primary);
> +	layout = &primary->layer.desc->layout;
> +	if (!layout->disc_pos || !layout->disc_size)
> +		return 0;
> +
> +	primary_s = drm_atomic_get_plane_state(c_state->state,
> +					       &primary->base);
> +	if (IS_ERR(primary_s))
> +		return PTR_ERR(primary_s);
> +
> +	primary_state = drm_plane_state_to_atmel_hlcdc_plane_state(primary_s);
> +
> +	drm_atomic_crtc_state_for_each_plane(ovl, c_state) {
> +		struct atmel_hlcdc_plane_state *ovl_state;
> +		struct drm_plane_state *ovl_s;
> +
> +		if (ovl == c_state->crtc->primary)
> +			continue;
> +
> +		ovl_s = drm_atomic_get_plane_state(c_state->state, ovl);
> +		if (IS_ERR(ovl_s))
> +			return PTR_ERR(ovl_s);
> +
> +		ovl_state = drm_plane_state_to_atmel_hlcdc_plane_state(ovl_s);

Note that right now the atomic helpers do not no-op out null plane state
updates. The assumption is that such plane states aren't requested.
Usually it's not harmful to add more planes by default (just a bit of
busy-work really), but if you have more than 1 crtc then suddenly every
pageflip will be converted into an update spanning more than 1 crtc, and
you most definitely don't want that. This is because we always must the
state for the crtc each plane is connected to. This is also the reason why
my speudo-code started from the planes and not the crtc, so that
unecessary plane states can be avoided.

If that's a problem I can try to look into some way to remove a plane
state from an atomic update.

Assuming this isn't an issue for your hw the overall logic here looks
sound, so

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
> +		if (!ovl_s->fb ||
> +		    atmel_hlcdc_format_embeds_alpha(ovl_s->fb->pixel_format) ||
> +		    ovl_state->alpha != 255)
> +			continue;
> +
> +		/* TODO: implement a smarter hidden area detection */
> +		if (ovl_state->crtc_h * ovl_state->crtc_w < disc_h * disc_w)
> +			continue;
> +
> +		disc_x = ovl_state->crtc_x;
> +		disc_y = ovl_state->crtc_y;
> +		disc_h = ovl_state->crtc_h;
> +		disc_w = ovl_state->crtc_w;
> +	}
> +
> +	if (disc_x == primary_state->disc_x &&
> +	    disc_y == primary_state->disc_y &&
> +	    disc_w == primary_state->disc_w &&
> +	    disc_h == primary_state->disc_h)
> +		return 0;
> +
> +
> +	primary_state->disc_x = disc_x;
> +	primary_state->disc_y = disc_y;
> +	primary_state->disc_w = disc_w;
> +	primary_state->disc_h = disc_h;
> +	primary_state->disc_updated = true;
> +
> +	return 0;
> +}
> +
> +static void
> +atmel_hlcdc_plane_update_disc_area(struct atmel_hlcdc_plane *plane,
> +				   struct atmel_hlcdc_plane_state *state)
> +{
> +	const struct atmel_hlcdc_layer_cfg_layout *layout =
> +						&plane->layer.desc->layout;
> +	int disc_surface = 0;
> +
> +	if (!state->disc_updated)
> +		return;
> +
> +	disc_surface = state->disc_h * state->disc_w;
> +
> +	atmel_hlcdc_layer_update_cfg(&plane->layer, layout->general_config,
> +				ATMEL_HLCDC_LAYER_DISCEN,
> +				disc_surface ? ATMEL_HLCDC_LAYER_DISCEN : 0);
> +
> +	if (!disc_surface)
> +		return;
> +
> +	atmel_hlcdc_layer_update_cfg(&plane->layer,
> +				     layout->disc_pos,
> +				     0xffffffff,
> +				     state->disc_x | (state->disc_y << 16));
> +
> +	atmel_hlcdc_layer_update_cfg(&plane->layer,
> +				     layout->disc_size,
> +				     0xffffffff,
> +				     (state->disc_w - 1) |
> +				     ((state->disc_h - 1) << 16));
> +}
> +
>  static int atmel_hlcdc_plane_atomic_check(struct drm_plane *p,
>  					  struct drm_plane_state *s)
>  {
> @@ -628,6 +733,7 @@ static void atmel_hlcdc_plane_atomic_update(struct drm_plane *p,
>  	atmel_hlcdc_plane_update_general_settings(plane, state);
>  	atmel_hlcdc_plane_update_format(plane, state);
>  	atmel_hlcdc_plane_update_buffers(plane, state);
> +	atmel_hlcdc_plane_update_disc_area(plane, state);
>  
>  	atmel_hlcdc_layer_update_commit(&plane->layer);
>  }
> @@ -773,6 +879,8 @@ atmel_hlcdc_plane_atomic_duplicate_state(struct drm_plane *p)
>  	if (!copy)
>  		return NULL;
>  
> +	copy->disc_updated = false;
> +
>  	if (copy->base.fb)
>  		drm_framebuffer_reference(copy->base.fb);
>  
> -- 
> 1.9.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
