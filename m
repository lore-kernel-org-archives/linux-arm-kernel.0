From: seanpaul@chromium.org (Sean Paul)
Date: Fri, 23 Feb 2018 09:09:39 -0500
Subject: [PATCH] drm/rockchip: vop: Init vskiplines in scl_vop_cal_scale()
In-Reply-To: <20180223062250.10470-1-jeffy.chen@rock-chips.com>
References: <20180223062250.10470-1-jeffy.chen@rock-chips.com>
Message-ID: <20180223140939.GI223881@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 02:22:50PM +0800, Jeffy Chen wrote:
> Currently we are calling scl_vop_cal_scale() to get vskiplines for yrgb
> and cbcr. So the cbcr's vskiplines might be an unexpected value if the
> second scl_vop_cal_scale() didn't update it.
> 
> Init vskiplines in scl_vop_cal_scale() to avoid that.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 7715853ef90a..9b03c51903ab 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -259,6 +259,9 @@ static uint16_t scl_vop_cal_scale(enum scale_mode mode, uint32_t src,
>  {
>  	uint16_t val = 1 << SCL_FT_DEFAULT_FIXPOINT_SHIFT;
>  
> +	if (vskiplines)
> +		*vskiplines = 0;
> +
>  	if (is_horizontal) {
>  		if (mode == SCALE_UP)
>  			val = GET_SCL_FT_BIC(src, dst);
> @@ -299,7 +302,7 @@ static void scl_vop_cal_scl_fac(struct vop *vop, const struct vop_win_data *win,
>  	uint16_t vsu_mode;
>  	uint16_t lb_mode;
>  	uint32_t val;
> -	int vskiplines = 0;
> +	int vskiplines;
>  
>  	if (dst_w > 3840) {
>  		DRM_DEV_ERROR(vop->dev, "Maximum dst width (3840) exceeded\n");
> -- 
> 2.11.0
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
