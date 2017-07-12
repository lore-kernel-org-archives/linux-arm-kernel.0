From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 12 Jul 2017 14:33:58 -0400
Subject: [PATCH v2 4/5] drm/rockchip: vop: add a series of vop support
In-Reply-To: <1499825034-7604-1-git-send-email-mark.yao@rock-chips.com>
References: <1499824991-7391-1-git-send-email-mark.yao@rock-chips.com>
 <1499825034-7604-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170712183358.7n4vspuygiuu6era@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 12, 2017 at 10:03:54AM +0800, Mark Yao wrote:
> Vop Full framework now has following vops:
> IP version    chipname
>   3.1           rk3288
>   3.2           rk3368
>   3.4           rk3366
>   3.5           rk3399 big
>   3.6           rk3399 lit

Below you say little vop is major == 2, but you have major == 3 here.

>   3.7           rk3228
>   3.8           rk3328
> 
> The above IP version is from H/W define, some of vop support get
> the IP version from VERSION_INFO register, some are not.
> hardcode the IP version for each vop to identify them.
> 
> major version: used for IP structure, Vop full framework is 3,
>                vop little framework is 2.
> minor version: on same structure, newer design vop will bigger
>                then old one.
> 
> Changes in v2:
> - rename rk322x to rk3228(Heiko St?bner)
> - correct some vop registers define
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 202 +++++--
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.h | 905 ++++++++++++++++++++++------
>  2 files changed, 863 insertions(+), 244 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 159cedf..b33483c 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -211,6 +211,7 @@
>  	.standby = VOP_REG(RK3288_SYS_CTRL, 0x1, 22),
>  	.gate_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 23),
>  	.mmu_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 20),
> +	.dp_en = VOP_REG_VER(RK3399_SYS_CTRL, 0x1, 11, 3, 5, -1),
>  	.rgb_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 12),
>  	.hdmi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 13),
>  	.edp_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 14),
> @@ -220,14 +221,19 @@
>  	.data_blank = VOP_REG(RK3288_DSP_CTRL0, 0x1, 19),
>  	.dsp_blank = VOP_REG(RK3288_DSP_CTRL0, 0x3, 18),
>  	.out_mode = VOP_REG(RK3288_DSP_CTRL0, 0xf, 0),
> -	.pin_pol = VOP_REG(RK3288_DSP_CTRL0, 0xf, 4),
> +	.pin_pol = VOP_REG_VER(RK3288_DSP_CTRL0, 0xf, 4, 3, 0, 1),
> +	.dp_pin_pol = VOP_REG_VER(RK3399_DSP_CTRL1, 0xf, 16, 3, 5, -1),
> +	.rgb_pin_pol = VOP_REG_VER(RK3368_DSP_CTRL1, 0xf, 16, 3, 2, -1),
> +	.hdmi_pin_pol = VOP_REG_VER(RK3368_DSP_CTRL1, 0xf, 20, 3, 2, -1),
> +	.edp_pin_pol = VOP_REG_VER(RK3368_DSP_CTRL1, 0xf, 24, 3, 2, -1),
> +	.mipi_pin_pol = VOP_REG_VER(RK3368_DSP_CTRL1, 0xf, 28, 3, 2, -1),
>  	.htotal_pw = VOP_REG(RK3288_DSP_HTOTAL_HS_END, 0x1fff1fff, 0),
>  	.hact_st_end = VOP_REG(RK3288_DSP_HACT_ST_END, 0x1fff1fff, 0),
>  	.vtotal_pw = VOP_REG(RK3288_DSP_VTOTAL_VS_END, 0x1fff1fff, 0),
>  	.vact_st_end = VOP_REG(RK3288_DSP_VACT_ST_END, 0x1fff1fff, 0),
>  	.hpost_st_end = VOP_REG(RK3288_POST_DSP_HACT_INFO, 0x1fff1fff, 0),
>  	.vpost_st_end = VOP_REG(RK3288_POST_DSP_VACT_INFO, 0x1fff1fff, 0),
> -	.global_regdone_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 11),
> +	.global_regdone_en = VOP_REG_VER(RK3288_SYS_CTRL, 0x1, 11, 3, 2, -1),
>  	.cfg_done = VOP_REG(RK3288_REG_CFG_DONE, 0x1, 0),

I'm not really convinced VOP_REG_VER is a good idea. In the case of dp_en and
pin_pol, the register is already used for different offsets, so presumably
you're writing into don't care offsets?

In the other cases, it just looks like a few new registers added for 3368 and
3399. In this scenario, I don't think it's that bad to just have separate
structs for each version that has distinct features. There's going to be more
duplication, but then it's super easy to understand which platform has which
registers.

The whole versioning system is a little strange. For example, is each version
guaranteed to have the registered defined for the previous version (ie: 3.6
contains all registers defined for 3.5)?

Sean


<snip>

> -- 
> 1.9.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
