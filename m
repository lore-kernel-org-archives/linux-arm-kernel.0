From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 16 Nov 2017 14:00:32 +0800
Subject: [PATCH 2/2] drm/rockchip: vop: add rk3126 vop support
In-Reply-To: <1510658857-90299-1-git-send-email-hjc@rock-chips.com>
References: <1510658851-90160-1-git-send-email-hjc@rock-chips.com>
 <1510658857-90299-1-git-send-email-hjc@rock-chips.com>
Message-ID: <d0a8186a-e919-d2de-3ee8-b3cb8d9247d2@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?11?14? 19:27, Sandy Huang wrote:
> RK3126 vop register layout is similar with rk3036, so some feature
> can reuse with rk3036.
>
> RK3126 support two overlay plane and one hwc plane, max output
> resolution is 1080p. it support IOMMU, and its IOMMU same as
> rk3288's
>
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>

Looks good.
Reviewed-by:? Mark Yao <mark.yao@rock-chips.com>

> ---
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 30 +++++++++++++++++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.h |  6 ++++++
>   2 files changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 4a39049..2e4eea3 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -149,6 +149,34 @@ static const struct vop_data rk3036_vop = {
>   	.win_size = ARRAY_SIZE(rk3036_vop_win_data),
>   };
>   
> +static const struct vop_win_phy rk3126_win1_data = {
> +	.data_formats = formats_win_lite,
> +	.nformats = ARRAY_SIZE(formats_win_lite),
> +	.enable = VOP_REG(RK3036_SYS_CTRL, 0x1, 1),
> +	.format = VOP_REG(RK3036_SYS_CTRL, 0x7, 6),
> +	.rb_swap = VOP_REG(RK3036_SYS_CTRL, 0x1, 19),
> +	.dsp_info = VOP_REG(RK3126_WIN1_DSP_INFO, 0x0fff0fff, 0),
> +	.dsp_st = VOP_REG(RK3126_WIN1_DSP_ST, 0x1fff1fff, 0),
> +	.yrgb_mst = VOP_REG(RK3126_WIN1_MST, 0xffffffff, 0),
> +	.yrgb_vir = VOP_REG(RK3036_WIN1_VIR, 0xffff, 0),
> +};
> +
> +static const struct vop_win_data rk3126_vop_win_data[] = {
> +	{ .base = 0x00, .phy = &rk3036_win0_data,
> +	  .type = DRM_PLANE_TYPE_PRIMARY },
> +	{ .base = 0x00, .phy = &rk3126_win1_data,
> +	  .type = DRM_PLANE_TYPE_CURSOR },
> +};
> +
> +static const struct vop_data rk3126_vop = {
> +	.intr = &rk3036_intr,
> +	.common = &rk3036_common,
> +	.modeset = &rk3036_modeset,
> +	.output = &rk3036_output,
> +	.win = rk3126_vop_win_data,
> +	.win_size = ARRAY_SIZE(rk3126_vop_win_data),
> +};
> +
>   static const struct vop_scl_extension rk3288_win_full_scl_ext = {
>   	.cbcr_vsd_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 31),
>   	.cbcr_vsu_mode = VOP_REG(RK3288_WIN0_CTRL1, 0x1, 30),
> @@ -510,6 +538,8 @@ static const struct vop_data rk3328_vop = {
>   static const struct of_device_id vop_driver_dt_match[] = {
>   	{ .compatible = "rockchip,rk3036-vop",
>   	  .data = &rk3036_vop },
> +	{ .compatible = "rockchip,rk3126-vop",
> +	  .data = &rk3126_vop },
>   	{ .compatible = "rockchip,rk3288-vop",
>   	  .data = &rk3288_vop },
>   	{ .compatible = "rockchip,rk3368-vop",
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
> index 4a4799f..f81b510 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.h
> @@ -878,4 +878,10 @@
>   #define RK3036_HWC_LUT_ADDR		0x800
>   /* rk3036 register definition end */
>   
> +/* rk3126 register definition */
> +#define RK3126_WIN1_MST			0x4c
> +#define RK3126_WIN1_DSP_INFO		0x50
> +#define RK3126_WIN1_DSP_ST		0x54
> +/* rk3126 register definition end */
> +
>   #endif /* _ROCKCHIP_VOP_REG_H */
