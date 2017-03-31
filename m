From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Mar 2017 14:13:22 +0100
Subject: [PATCH 2/3] drm/arm: hdlcd: fix plane base address calculation
In-Reply-To: <E1cttDe-000679-UD@rmk-PC.armlinux.org.uk>
References: <20170331094937.GO7909@n2100.armlinux.org.uk>
 <E1cttDe-000679-UD@rmk-PC.armlinux.org.uk>
Message-ID: <20170331131322.GJ13355@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 10:51:46AM +0100, Russell King wrote:
> The plane base address needs to be calculated using the source
> coordinates to position the source correctly - it's possible to have
> a larger source buffer than the CRTC size, and have several CRTCs
> reading from different parts of the buffer.
> 
> In such a case, the pitch may be larger, and we will use the source
> position to select an area of the buffer to scan out.
> 
> In order for this to work correctly, we need to also fix the atomic
> check to do a fuller validation of the new state.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This patch does not apply for me. You seem to be missing patch 59477fa90bfec
("drm/arm: Add local 'fb' variables) from your tree.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/hdlcd_crtc.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
> index ba68fa2b5701..cf70184fd028 100644
> --- a/drivers/gpu/drm/arm/hdlcd_crtc.c
> +++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
> @@ -240,21 +240,19 @@ static void hdlcd_plane_atomic_update(struct drm_plane *plane,
>  {
>  	struct hdlcd_drm_private *hdlcd;
>  	struct drm_gem_cma_object *gem;
> -	u32 src_w, src_h, dest_w, dest_h;
> +	u32 src_x, src_y, dest_h;
>  	dma_addr_t scanout_start;
>  
>  	if (!plane->state->fb)
>  		return;
>  
> -	src_w = plane->state->src_w >> 16;
> -	src_h = plane->state->src_h >> 16;
> -	dest_w = plane->state->crtc_w;
> -	dest_h = plane->state->crtc_h;
>  	gem = drm_fb_cma_get_gem_obj(plane->state->fb, 0);
> +	src_x = plane->state->src_x >> 16;
> +	src_y = plane->state->src_y >> 16;
> +	dest_h = plane->state->crtc_h;
>  	scanout_start = gem->paddr + plane->state->fb->offsets[0] +
> -		plane->state->crtc_y * plane->state->fb->pitches[0] +
> -		plane->state->crtc_x *
> -		drm_format_plane_cpp(plane->state->fb->pixel_format, 0);
> +		src_y * plane->state->fb->pitches[0] +
> +		src_x * drm_format_plane_cpp(plane->state->fb->pixel_format, 0);
>  
>  	hdlcd = plane->dev->dev_private;
>  	hdlcd_write(hdlcd, HDLCD_REG_FB_LINE_LENGTH, plane->state->fb->pitches[0]);
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
