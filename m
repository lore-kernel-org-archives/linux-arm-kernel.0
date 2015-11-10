From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 10 Nov 2015 15:57:34 +0100
Subject: [PATCH] drm/rockchip: vop: fix window origin calculation
In-Reply-To: <1447149550-18595-1-git-send-email-mark.yao@rock-chips.com>
References: <1447149550-18595-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <2130118.giXtpUm1Fo@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. November 2015, 17:59:10 schrieb Mark Yao:
> From: Dominik Behr <dbehr@chromium.org>
> 
> VOP_WINx_DSP_ST does not require subtracting 1 from the values written to
> it. It actually causes the screen to be shifted by one pixel.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>

One thing I noticed, the original patch [0] had a Signed-off from
Dominik already and you should keep that as he is the author, and then
add your Signed-off below that, as you are the submitter,

So it would look like:

Signed-off-by: Dominik Behr <dbehr@chromium.org>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>


That may not need a repost, but should probably be corrected when applying
the patch.

Heiko

[0] https://chromium-review.googlesource.com/#/c/233251/


> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 48719df..4730ae4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -959,8 +959,8 @@ static int vop_update_plane_event(struct drm_plane *plane,
>  	val = (dest.y2 - dest.y1 - 1) << 16;
>  	val |= (dest.x2 - dest.x1 - 1) & 0xffff;
>  	VOP_WIN_SET(vop, win, dsp_info, val);
> -	val = (dsp_sty - 1) << 16;
> -	val |= (dsp_stx - 1) & 0xffff;
> +	val = dsp_sty << 16;
> +	val |= dsp_stx & 0xffff;
>  	VOP_WIN_SET(vop, win, dsp_st, val);
>  	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
>  
> 
