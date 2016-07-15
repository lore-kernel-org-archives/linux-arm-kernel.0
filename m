From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 15 Jul 2016 10:46:38 +0800
Subject: [PATCH] drm/rockchip: allocate correct crtc state structure on
 reset
In-Reply-To: <20160714152915.31235-1-john@metanate.com>
References: <20160714152915.31235-1-john@metanate.com>
Message-ID: <57884E8E.3000504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?07?14? 23:29, John Keeping wrote:
> Because we are using a custom crtc_state structure, we must override the
> reset helper to allocate the correct amount of memory.
>
> Cc: stable at vger.kernel.org
> Fixes: 4e257d9eee23 ("drm/rockchip: get rid of rockchip_drm_crtc_mode_config")
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
Thanks for the fixes, Applied to my drm-fixes


> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 1c4d5b5a70a2..21e1247098be 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1048,6 +1048,17 @@ static void vop_crtc_destroy(struct drm_crtc *crtc)
>   	drm_crtc_cleanup(crtc);
>   }
>   
> +static void vop_crtc_reset(struct drm_crtc *crtc)
> +{
> +	if (crtc->state)
> +		__drm_atomic_helper_crtc_destroy_state(crtc, crtc->state);
> +	kfree(crtc->state);
> +
> +	crtc->state = kzalloc(sizeof(struct rockchip_crtc_state), GFP_KERNEL);
> +	if (crtc->state)
> +		crtc->state->crtc = crtc;
> +}
> +
>   static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
>   {
>   	struct rockchip_crtc_state *rockchip_state;
> @@ -1073,7 +1084,7 @@ static const struct drm_crtc_funcs vop_crtc_funcs = {
>   	.set_config = drm_atomic_helper_set_config,
>   	.page_flip = drm_atomic_helper_page_flip,
>   	.destroy = vop_crtc_destroy,
> -	.reset = drm_atomic_helper_crtc_reset,
> +	.reset = vop_crtc_reset,
>   	.atomic_duplicate_state = vop_crtc_duplicate_state,
>   	.atomic_destroy_state = vop_crtc_destroy_state,
>   };


-- 
?ark Yao
