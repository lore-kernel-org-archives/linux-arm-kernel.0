From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 12 Jul 2017 13:54:37 -0400
Subject: [PATCH v2 3/5] drm/rockchip: vop: move line_flag_num to
 interrupt registers
In-Reply-To: <1499825027-7552-1-git-send-email-mark.yao@rock-chips.com>
References: <1499824991-7391-1-git-send-email-mark.yao@rock-chips.com>
 <1499825027-7552-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170712175437.6do5shj2evqft7nc@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 10:03:46AM +0800, Mark Yao wrote:

Again, please add commit message describing the what and why of this change.

You can also add:

Reviewed-by: Sean Paul <seanpaul@chromium.org>


> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 4 ++--
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index a9180fd..be208ee 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -507,7 +507,7 @@ static void vop_line_flag_irq_enable(struct vop *vop, int line_num)
>  
>  	spin_lock_irqsave(&vop->irq_lock, flags);
>  
> -	VOP_CTRL_SET(vop, line_flag_num[0], line_num);
> +	VOP_INTR_SET(vop, line_flag_num[0], line_num);
>  	VOP_INTR_SET_TYPE(vop, clear, LINE_FLAG_INTR, 1);
>  	VOP_INTR_SET_TYPE(vop, enable, LINE_FLAG_INTR, 1);
>  
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> index e4de890..f64685e 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
> @@ -70,8 +70,6 @@ struct vop_ctrl {
>  	struct vop_reg hpost_st_end;
>  	struct vop_reg vpost_st_end;
>  
> -	struct vop_reg line_flag_num[2];
> -
>  	struct vop_reg global_regdone_en;
>  	struct vop_reg cfg_done;
>  };
> @@ -79,6 +77,8 @@ struct vop_ctrl {
>  struct vop_intr {
>  	const int *intrs;
>  	uint32_t nintrs;
> +
> +	struct vop_reg line_flag_num[2];
>  	struct vop_reg enable;
>  	struct vop_reg clear;
>  	struct vop_reg status;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 7744603..159cedf 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -118,6 +118,7 @@
>  static const struct vop_intr rk3036_intr = {
>  	.intrs = rk3036_vop_intrs,
>  	.nintrs = ARRAY_SIZE(rk3036_vop_intrs),
> +	.line_flag_num[0] = VOP_REG(RK3036_INT_STATUS, 0xfff, 12),
>  	.status = VOP_REG(RK3036_INT_STATUS, 0xf, 0),
>  	.enable = VOP_REG(RK3036_INT_STATUS, 0xf, 4),
>  	.clear = VOP_REG(RK3036_INT_STATUS, 0xf, 8),
> @@ -131,7 +132,6 @@
>  	.hact_st_end = VOP_REG(RK3036_DSP_HACT_ST_END, 0x1fff1fff, 0),
>  	.vtotal_pw = VOP_REG(RK3036_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
>  	.vact_st_end = VOP_REG(RK3036_DSP_VACT_ST_END, 0x1fff1fff, 0),
> -	.line_flag_num[0] = VOP_REG(RK3036_INT_STATUS, 0xfff, 12),
>  	.cfg_done = VOP_REG(RK3036_REG_CFG_DONE, 0x1, 0),
>  };
>  
> @@ -227,7 +227,6 @@
>  	.vact_st_end = VOP_REG(RK3288_DSP_VACT_ST_END, 0x1fff1fff, 0),
>  	.hpost_st_end = VOP_REG(RK3288_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
>  	.vpost_st_end = VOP_REG(RK3288_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
> -	.line_flag_num[0] = VOP_REG(RK3288_INTR_CTRL0, 0x1fff, 12),
>  	.global_regdone_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 11),
>  	.cfg_done = VOP_REG(RK3288_REG_CFG_DONE, 0x1, 0),
>  };
> @@ -259,6 +258,7 @@
>  static const struct vop_intr rk3288_vop_intr = {
>  	.intrs = rk3288_vop_intrs,
>  	.nintrs = ARRAY_SIZE(rk3288_vop_intrs),
> +	.line_flag_num[0] = VOP_REG(RK3288_INTR_CTRL0, 0x1fff, 12),
>  	.status = VOP_REG(RK3288_INTR_CTRL0, 0xf, 0),
>  	.enable = VOP_REG(RK3288_INTR_CTRL0, 0xf, 4),
>  	.clear = VOP_REG(RK3288_INTR_CTRL0, 0xf, 8),
> @@ -295,8 +295,6 @@
>  	.vact_st_end = VOP_REG(RK3399_DSP_VACT_ST_END, 0x1fff1fff, 0),
>  	.hpost_st_end = VOP_REG(RK3399_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
>  	.vpost_st_end = VOP_REG(RK3399_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
> -	.line_flag_num[0] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 0),
> -	.line_flag_num[1] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 16),
>  	.cfg_done = VOP_REG_MASK(RK3399_REG_CFG_DONE, 0x1, 0),
>  };
>  
> @@ -313,6 +311,8 @@
>  static const struct vop_intr rk3399_vop_intr = {
>  	.intrs = rk3399_vop_intrs,
>  	.nintrs = ARRAY_SIZE(rk3399_vop_intrs),
> +	.line_flag_num[0] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 0),
> +	.line_flag_num[1] = VOP_REG(RK3399_LINE_FLAG, 0xffff, 16),
>  	.status = VOP_REG_MASK(RK3399_INTR_STATUS0, 0xffff, 0),
>  	.enable = VOP_REG_MASK(RK3399_INTR_EN0, 0xffff, 0),
>  	.clear = VOP_REG_MASK(RK3399_INTR_CLEAR0, 0xffff, 0),
> -- 
> 1.9.1
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
