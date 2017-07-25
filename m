From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 25 Jul 2017 23:54:19 +0200
Subject: [PATCH v5 3/7] drm/rockchip: vop: move line_flag_num to interrupt
 registers
In-Reply-To: <1500518613-30590-1-git-send-email-mark.yao@rock-chips.com>
References: <1500518564-30371-1-git-send-email-mark.yao@rock-chips.com>
 <1500518613-30590-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1816316.NCRF09CkBJ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Donnerstag, 20. Juli 2017, 10:43:32 CEST schrieb Mark Yao:
> In the hardware design process, the design of line flags
> register is associated with the interrupt register,
> placing the line flags in the interrupt definition is
> more reasonable, and it would make multi-vop define easilier.
> 
> Changes in v3:
> - Explain more in details, introduce why we need this patch
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 4 ++--
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 784a2b7..4f6c7bc 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -982,7 +982,7 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
>  	VOP_CTRL_SET(vop, vact_st_end, val);
>  	VOP_CTRL_SET(vop, vpost_st_end, val);
>  
> -	VOP_CTRL_SET(vop, line_flag_num[0], vact_end);
> +	VOP_INTR_SET(vop, line_flag_num[0], vact_end);

With patches applied up to this one I end up with

  CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_vop.o
../drivers/gpu/drm/rockchip/rockchip_drm_vop.c: In function ?vop_crtc_enable?:
../drivers/gpu/drm/rockchip/rockchip_drm_vop.c:985:46: error: macro "VOP_INTR_SET" requires 4 arguments, but only 3 given
  VOP_INTR_SET(vop, line_flag_num[0], vact_end);
                                              ^
../drivers/gpu/drm/rockchip/rockchip_drm_vop.c:985:2: error: ?VOP_INTR_SET? undeclared (first use in this function)
  VOP_INTR_SET(vop, line_flag_num[0], vact_end);
  ^~~~~~~~~~~~
../drivers/gpu/drm/rockchip/rockchip_drm_vop.c:985:2: note: each undeclared identifier is reported only once for each function it appears in

In patch4 you replace this again, with 
-	VOP_INTR_SET(vop, line_flag_num[0], vact_end);
+	VOP_REG_SET(vop, intr, line_flag_num[0], vact_end);

but this intermediate breakage should not happen, to keep bisectability.


Heiko
