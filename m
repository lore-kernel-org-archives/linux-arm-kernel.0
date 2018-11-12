From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 12 Nov 2018 16:36:41 +0100
Subject: [PATCH 2/2] drm/atomic: Create and use
 __drm_atomic_helper_crtc_reset() everywhere
In-Reply-To: <20181112150114.18395-2-maarten.lankhorst@linux.intel.com>
References: <20181112150114.18395-1-maarten.lankhorst@linux.intel.com>
 <20181112150114.18395-2-maarten.lankhorst@linux.intel.com>
Message-ID: <2475529.N6HtQ5V54z@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 12. November 2018, 16:01:14 CET schrieb Maarten Lankhorst:
> We already have __drm_atomic_helper_connector_reset() and
> __drm_atomic_helper_plane_reset(), extend this to crtc as well.
> 
> Most drivers already have a gpu reset hook, correct it.
> Nouveau already implemented its own __drm_atomic_helper_crtc_reset(),
> convert it to the common one.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>


> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index fb70fb486fbf..d2d5aa676084 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1071,13 +1071,14 @@ static void vop_crtc_destroy(struct drm_crtc *crtc)
>  
>  static void vop_crtc_reset(struct drm_crtc *crtc)
>  {
> +	struct rockchip_crtc_state *crtc_state =
> +		kzalloc(sizeof(*crtc_state), GFP_KERNEL);
> +
>  	if (crtc->state)
>  		__drm_atomic_helper_crtc_destroy_state(crtc->state);
>  	kfree(crtc->state);
>  
> -	crtc->state = kzalloc(sizeof(struct rockchip_crtc_state), GFP_KERNEL);
> -	if (crtc->state)
> -		crtc->state->crtc = crtc;
> +	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
>  }
>  
>  static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
