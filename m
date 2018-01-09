From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 9 Jan 2018 13:34:58 +0100
Subject: [PATCH 05/19] drm/vc4: Use the alpha format helper
In-Reply-To: <78890e262e8394b2319f15c11de3282a2a2a2efd.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
 <78890e262e8394b2319f15c11de3282a2a2a2efd.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20180109123458.GV26573@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 11:56:24AM +0100, Maxime Ripard wrote:
> Now that the core has a drm format helper to tell if a format embeds an
> alpha component in it, let's use it.
> 
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

On patches 1-5:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/vc4/vc4_plane.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 423a23ed8fc2..2c0e25128dcd 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -85,40 +85,39 @@ static const struct hvs_format {
>  	u32 drm; /* DRM_FORMAT_* */
>  	u32 hvs; /* HVS_FORMAT_* */
>  	u32 pixel_order;
> -	bool has_alpha;
>  	bool flip_cbcr;
>  } hvs_formats[] = {
>  	{
>  		.drm = DRM_FORMAT_XRGB8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
> -		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = false,
> +		.pixel_order = HVS_PIXEL_ORDER_ABGR,
>  	},
>  	{
>  		.drm = DRM_FORMAT_ARGB8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
> -		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = true,
> +		.pixel_order = HVS_PIXEL_ORDER_ABGR,
>  	},
>  	{
>  		.drm = DRM_FORMAT_ABGR8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
> -		.pixel_order = HVS_PIXEL_ORDER_ARGB, .has_alpha = true,
> +		.pixel_order = HVS_PIXEL_ORDER_ARGB,
>  	},
>  	{
>  		.drm = DRM_FORMAT_XBGR8888, .hvs = HVS_PIXEL_FORMAT_RGBA8888,
> -		.pixel_order = HVS_PIXEL_ORDER_ARGB, .has_alpha = false,
> +		.pixel_order = HVS_PIXEL_ORDER_ARGB,
>  	},
>  	{
>  		.drm = DRM_FORMAT_RGB565, .hvs = HVS_PIXEL_FORMAT_RGB565,
> -		.pixel_order = HVS_PIXEL_ORDER_XRGB, .has_alpha = false,
> +		.pixel_order = HVS_PIXEL_ORDER_XRGB,
>  	},
>  	{
>  		.drm = DRM_FORMAT_BGR565, .hvs = HVS_PIXEL_FORMAT_RGB565,
> -		.pixel_order = HVS_PIXEL_ORDER_XBGR, .has_alpha = false,
> +		.pixel_order = HVS_PIXEL_ORDER_XBGR,
>  	},
>  	{
>  		.drm = DRM_FORMAT_ARGB1555, .hvs = HVS_PIXEL_FORMAT_RGBA5551,
> -		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = true,
> +		.pixel_order = HVS_PIXEL_ORDER_ABGR,
>  	},
>  	{
>  		.drm = DRM_FORMAT_XRGB1555, .hvs = HVS_PIXEL_FORMAT_RGBA5551,
> -		.pixel_order = HVS_PIXEL_ORDER_ABGR, .has_alpha = false,
> +		.pixel_order = HVS_PIXEL_ORDER_ABGR,
>  	},
>  	{
>  		.drm = DRM_FORMAT_YUV422,
> @@ -601,7 +600,7 @@ static int vc4_plane_mode_set(struct drm_plane *plane,
>  	/* Position Word 2: Source Image Size, Alpha Mode */
>  	vc4_state->pos2_offset = vc4_state->dlist_count;
>  	vc4_dlist_write(vc4_state,
> -			VC4_SET_FIELD(format->has_alpha ?
> +			VC4_SET_FIELD(drm_format_has_alpha(format->drm) ?
>  				      SCALER_POS2_ALPHA_MODE_PIPELINE :
>  				      SCALER_POS2_ALPHA_MODE_FIXED,
>  				      SCALER_POS2_ALPHA_MODE) |
> -- 
> git-series 0.9.1
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
