From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 25 Jul 2017 23:47:09 +0200
Subject: [PATCH v5 2/7] drm/rockchip: vop: move write_relaxed flags to vop
 register
In-Reply-To: <1500518608-30538-1-git-send-email-mark.yao@rock-chips.com>
References: <1500518564-30371-1-git-send-email-mark.yao@rock-chips.com>
 <1500518608-30538-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2048476.V4PpOSpEqb@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Donnerstag, 20. Juli 2017, 10:43:27 CEST schrieb Mark Yao:
> Since the drm atomic framework, only a small part of the vop
> register needs sync write, Currently seems only following registers
> need sync write:
>    cfg_done, standby and interrupt related register.
> 
> All ctrl registers are using the sync write method that is
> inefficient, hardcode the write_relaxed flags to vop registers,
> then can only do synchronize write for those actual needed register.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 14 +++-------
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 42 ++++++++++++++++-------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 81164d6..784a2b7 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -42,18 +42,12 @@
>  #include "rockchip_drm_psr.h"
>  #include "rockchip_drm_vop.h"
>  
> -#define __REG_SET_RELAXED(x, off, mask, shift, v, write_mask) \
> -		vop_mask_write(x, off, mask, shift, v, write_mask, true)
> -
> -#define __REG_SET_NORMAL(x, off, mask, shift, v, write_mask) \
> -		vop_mask_write(x, off, mask, shift, v, write_mask, false)
> -
>  #define REG_SET(x, base, reg, v, mode) \
> -		__REG_SET_##mode(x, base + reg.offset, \
> -				 reg.mask, reg.shift, v, reg.write_mask)
> +		vop_mask_write(x, base + reg.offset, reg.mask, reg.shift, \
> +			       v, reg.write_mask, reg.relaxed)
>  #define REG_SET_MASK(x, base, reg, mask, v, mode) \
> -		__REG_SET_##mode(x, base + reg.offset, \
> -				 mask, reg.shift, v, reg.write_mask)
> +		vop_mask_write(x, base + reg.offset, \
> +			       mask, reg.shift, v, reg.write_mask, reg.relaxed)

you only introduce the relaxed element of struct vop_reg in patch4.
So using it here produces a compile error

../drivers/gpu/drm/rockchip/rockchip_drm_vop.c: In function ?vop_cfg_done?:
../drivers/gpu/drm/rockchip/rockchip_drm_vop.c:47:33: error: ?const struct vop_reg? has no member named ?relaxed?
           v, reg.write_mask, reg.relaxed)
                                 ^
../drivers/gpu/drm/rockchip/rockchip_drm_vop.c:59:3: note: in expansion of macro ?REG_SET?
   REG_SET(x, 0, (x)->data->ctrl->name, v, NORMAL)
   ^~~~~~~
../drivers/gpu/drm/rockchip/rockchip_drm_vop.c:201:2: note: in expansion of macro ?VOP_CTRL_SET?
  VOP_CTRL_SET(vop, cfg_done, 1);
  ^~~~~~~~~~~~

when only patches 1+2 are applied. So the relaxed field addition should
definitly move into this patch to not break bisectability.


Heiko
