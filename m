From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 29 Aug 2016 10:51:45 +0800
Subject: [PATCH] drm/rockchip: vop: make vop register setting take effect
In-Reply-To: <1472269178-16593-1-git-send-email-zyw@rock-chips.com>
References: <1472269178-16593-1-git-send-email-zyw@rock-chips.com>
Message-ID: <57C3A341.9030302@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?08?27? 11:39, Chris Zhong wrote:
> The setting of vop registers need a reg_done writing to take effect.
> In vop_enable the vop return to work by by restoring registers, but the
> registers do not take effect immediately, it should a vop_cfg_done
> after it. The same thing is needed by windows_disabled in
> vop_crtc_disable.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++++
>   1 file changed, 4 insertions(+)
Thanks for your fix.

applied to my drm-fixes.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index efbc41a..a0bfcff 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -464,6 +464,8 @@ static int vop_enable(struct drm_crtc *crtc)
>   	}
>   
>   	memcpy(vop->regs, vop->regsbak, vop->len);
> +	vop_cfg_done(vop);
> +
>   	/*
>   	 * At here, vop clock & iommu is enable, R/W vop regs would be safe.
>   	 */
> @@ -513,6 +515,8 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
>   		spin_unlock(&vop->reg_lock);
>   	}
>   
> +	vop_cfg_done(vop);
> +
>   	drm_crtc_vblank_off(crtc);
>   
>   	/*

-- 
?ark Yao
