From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 23 Jan 2017 15:12:05 +0800
Subject: [PATCH v2 22/26] drm/rockchip: vop: test for P{H,V}SYNC
In-Reply-To: <20170121163128.22240-23-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-23-john@metanate.com>
Message-ID: <5885ACC5.5090108@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?01?22? 00:31, John Keeping wrote:
> When connected to the MIPI DSI output, we need to use N{H,V}SYNC for the
> internal connection but these flags are meaningless for DSI panels.
> Switch the test so that we do not set the P{H,V}SYNC bits unless the
> mode requires it.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v2
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index c7eba305c488..67aefc6d4e9a 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -933,8 +933,8 @@ static void vop_crtc_enable(struct drm_crtc *crtc)
>   	}
>   
>   	pin_pol = 0x8;
> -	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC) ? 0 : 1;
> -	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC) ? 0 : (1 << 1);
> +	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PHSYNC) ? 1 : 0;
> +	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PVSYNC) ? (1 << 1) : 0;

I'm confuse that why SYNC flags have N and P on drm, they are same meaning.

If no one configure display mode's flags, I don't know which one is 
correct, N or P? it's a problem.
Does anyone can answer it?

For this patch, it may effect non-sync flags mode on other connector's 
behavior,
but seems mostly display mode has sync flags except mipi dsi connector, 
I think feed mipi's requirement would be better.

So it's no problem  on my side.

Reviewed-by: Mark Yao <mark.yao@rock-chips.com>

>   	VOP_CTRL_SET(vop, pin_pol, pin_pol);
>   
>   	switch (s->output_type) {


-- 
?ark Yao
