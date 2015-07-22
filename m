From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Jul 2015 23:50:58 +0200
Subject: [PATCH v3 6/6] drm/rockchip: vop: support plane scale
In-Reply-To: <1437467332-14006-1-git-send-email-mark.yao@rock-chips.com>
References: <1437466807-13689-1-git-send-email-mark.yao@rock-chips.com>
 <1437467332-14006-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2669731.iJNoek9ed4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juli 2015, 16:28:52 schrieb Mark Yao:
> Win_full support 1/8 to 8 scale down/up engine, support
> all format scale.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v3:
> Adviced by Tomasz Figa
> - remove unused code and unnecessary scale path.
> - use static inline funcion instead "#define", let gcc check the cast
> - move same call into helper, make code clean.
> 
> Changes in v2:
> - Fix scale dest info.
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  196
> ++++++++++++++++++++++++++- drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  
> 87 ++++++++++++
>  2 files changed, 281 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c index 4dfad065..8257e98
> 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -49,6 +49,8 @@
> 
>  #define VOP_WIN_SET(x, win, name, v) \
>  		REG_SET(x, win->base, win->phy->name, v, RELAXED)
> +#define VOP_SCL_SET(x, win, name, v) \
> +		REG_SET(x, win->base, win->phy->scl->name, v, RELAXED)
>  #define VOP_CTRL_SET(x, name, v) \
>  		REG_SET(x, 0, (x)->data->ctrl->name, v, NORMAL)
> 
> @@ -163,7 +165,37 @@ struct vop_ctrl {
>  	struct vop_reg vpost_st_end;
>  };
> 
> +struct vop_scl_regs {
> +	struct vop_reg cbcr_vsd_mode;
> +	struct vop_reg cbcr_vsu_mode;
> +	struct vop_reg cbcr_hsd_mode;
> +	struct vop_reg cbcr_ver_scl_mode;
> +	struct vop_reg cbcr_hor_scl_mode;
> +	struct vop_reg yrgb_vsd_mode;
> +	struct vop_reg yrgb_vsu_mode;
> +	struct vop_reg yrgb_hsd_mode;
> +	struct vop_reg yrgb_ver_scl_mode;
> +	struct vop_reg yrgb_hor_scl_mode;
> +	struct vop_reg line_load_mode;
> +	struct vop_reg cbcr_axi_gather_num;
> +	struct vop_reg yrgb_axi_gather_num;
> +	struct vop_reg vsd_cbcr_gt2;
> +	struct vop_reg vsd_cbcr_gt4;
> +	struct vop_reg vsd_yrgb_gt2;
> +	struct vop_reg vsd_yrgb_gt4;
> +	struct vop_reg bic_coe_sel;
> +	struct vop_reg cbcr_axi_gather_en;
> +	struct vop_reg yrgb_axi_gather_en;
> +
> +	struct vop_reg lb_mode;
> +	struct vop_reg scale_yrgb_x;
> +	struct vop_reg scale_yrgb_y;
> +	struct vop_reg scale_cbcr_x;
> +	struct vop_reg scale_cbcr_y;
> +};
> +
>  struct vop_win_phy {
> +	const struct vop_scl_regs *scl;
>  	const uint32_t *data_formats;
>  	uint32_t nformats;
> 
> @@ -212,7 +244,36 @@ static const uint32_t formats_234[] = {
>  	DRM_FORMAT_RGB565,
>  };

does not apply to what's in mainline, as this patch seems to ignore
	85a359f25388 ("drm/rockchip: Add BGR formats to VOP")
from Tomasz


Heiko
