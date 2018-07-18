From: ville.syrjala@linux.intel.com (Ville =?iso-8859-1?Q?Syrj=E4l=E4?=)
Date: Wed, 18 Jul 2018 13:17:41 +0300
Subject: [Intel-gfx] [PATCH 4/5] drm/omapdrm: Substitute format_is_yuv()
 with format->is_yuv
In-Reply-To: <1531847626-22248-4-git-send-email-ayan.halder@arm.com>
References: <1531847626-22248-1-git-send-email-ayan.halder@arm.com>
 <1531847626-22248-4-git-send-email-ayan.halder@arm.com>
Message-ID: <20180718101741.GU5565@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 06:13:45PM +0100, Ayan Kumar Halder wrote:
> drm_format_info table has a field 'is_yuv' to denote if the format
> is yuv or not. The driver is expected to use this instead of
> having a function for the same purpose.
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index 84f274c..8d2d7a4 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -1140,18 +1140,6 @@ static void dispc_ovl_set_color_mode(struct dispc_device *dispc,
>  	REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
>  }
>  
> -static bool format_is_yuv(u32 fourcc)
> -{
> -	switch (fourcc) {
> -	case DRM_FORMAT_YUYV:
> -	case DRM_FORMAT_UYVY:
> -	case DRM_FORMAT_NV12:
> -		return true;
> -	default:
> -		return false;
> -	}
> -}
> -
>  static void dispc_ovl_configure_burst_type(struct dispc_device *dispc,
>  					   enum omap_plane_id plane,
>  					   enum omap_dss_rotation_type rotation)
> @@ -1910,11 +1898,14 @@ static void dispc_ovl_set_scaling_uv(struct dispc_device *dispc,
>  	int scale_x = out_width != orig_width;
>  	int scale_y = out_height != orig_height;
>  	bool chroma_upscale = plane != OMAP_DSS_WB;
> +	const struct drm_format_info *info;
> +
> +	info = drm_format_info(fourcc);

Not sure Tomi wants drm usage (apart from the fourccs) inside the
dss code.

>  
>  	if (!dispc_has_feature(dispc, FEAT_HANDLE_UV_SEPARATE))
>  		return;
>  
> -	if (!format_is_yuv(fourcc)) {
> +	if (!info->is_yuv) {
>  		/* reset chroma resampling for RGB formats  */
>  		if (plane != OMAP_DSS_WB)
>  			REG_FLD_MOD(dispc, DISPC_OVL_ATTRIBUTES2(plane),
> @@ -2632,6 +2623,9 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  	bool ilace = !!(vm->flags & DISPLAY_FLAGS_INTERLACED);
>  	unsigned long pclk = dispc_plane_pclk_rate(dispc, plane);
>  	unsigned long lclk = dispc_plane_lclk_rate(dispc, plane);
> +	const struct drm_format_info *info;
> +
> +	info = drm_format_info(fourcc);
>  
>  	/* when setting up WB, dispc_plane_pclk_rate() returns 0 */
>  	if (plane == OMAP_DSS_WB)
> @@ -2640,7 +2634,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  	if (paddr == 0 && rotation_type != OMAP_DSS_ROT_TILER)
>  		return -EINVAL;
>  
> -	if (format_is_yuv(fourcc) && (in_width & 1)) {
> +	if (info->is_yuv && (in_width & 1)) {
>  		DSSERR("input width %d is not even for YUV format\n", in_width);
>  		return -EINVAL;
>  	}
> @@ -2680,7 +2674,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  		DSSDBG("predecimation %d x %x, new input size %d x %d\n",
>  			x_predecim, y_predecim, in_width, in_height);
>  
> -	if (format_is_yuv(fourcc) && (in_width & 1)) {
> +	if (info->is_yuv && (in_width & 1)) {
>  		DSSDBG("predecimated input width is not even for YUV format\n");
>  		DSSDBG("adjusting input width %d -> %d\n",
>  			in_width, in_width & ~1);
> @@ -2688,7 +2682,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  		in_width &= ~1;
>  	}
>  
> -	if (format_is_yuv(fourcc))
> +	if (info->is_yuv)
>  		cconv = 1;
>  
>  	if (ilace && !fieldmode) {
> -- 
> 2.7.4
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Ville Syrj?l?
Intel
