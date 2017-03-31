From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Mar 2017 11:18:50 +0100
Subject: [PATCH 1/3] drm/arm: hdlcd: properly validate plane state
In-Reply-To: <E1cttDZ-000671-Q1@rmk-PC.armlinux.org.uk>
References: <20170331094937.GO7909@n2100.armlinux.org.uk>
 <E1cttDZ-000671-Q1@rmk-PC.armlinux.org.uk>
Message-ID: <20170331101850.GD13355@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

You were Cc-ed in a patch from March 8th that did all this:

https://lists.freedesktop.org/archives/dri-devel/2017-March/135172.html

I have not received any response from you, so I have already pushed the
patch in my public repo:

git://linux-arm.org/linux-ld.git for-upstream/hdlcd

It has been included into linux-next for at least a couple of weeks now.

Best regards,
Liviu

On Fri, Mar 31, 2017 at 10:51:41AM +0100, Russell King wrote:
> The hdlcd crtc is unable to place planes in arbitary positions and sizes
> within the active area.  Use drm_plane_helper_check_state() to validate
> the requested state.
> 
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index 7d4e5aa77195..ba68fa2b5701 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -205,13 +206,30 @@ static const struct drm_crtc_helper_funcs hdlcd_crtc_helper_funcs = {
>  static int hdlcd_plane_atomic_check(struct drm_plane *plane,
>  				    struct drm_plane_state *state)
>  {
> -	u32 src_w, src_h;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc *crtc;
> +	struct drm_rect clip = { 0 };
> +	int ret;
> +
> +	crtc = state->crtc;
> +	if (!crtc)
> +		return 0;
>  
> -	src_w = state->src_w >> 16;
> -	src_h = state->src_h >> 16;
> +	crtc_state = drm_atomic_get_existing_crtc_state(state->state, crtc);
> +	if (!crtc_state->enable)
> +		return -EINVAL;
> +
> +	clip.x2 = crtc_state->adjusted_mode.hdisplay;
> +	clip.y2 = crtc_state->adjusted_mode.vdisplay;
> +
> +	ret = drm_plane_helper_check_state(state, &clip,
> +					   DRM_PLANE_HELPER_NO_SCALING,
> +					   DRM_PLANE_HELPER_NO_SCALING,
> +					   false, true);
> +	if (ret)
> +		return ret;
>  
> -	/* we can't do any scaling of the plane source */
> -	if ((src_w != state->crtc_w) || (src_h != state->crtc_h))
> +	if (!state->visible)
>  		return -EINVAL;
>  
>  	return 0;
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
