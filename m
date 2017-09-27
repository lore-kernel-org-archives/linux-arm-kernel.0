From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 27 Sep 2017 16:27:09 -0400
Subject: [PATCH] drm/rockchip: Fix memory leak in rockchip_drm_sys_resume()
In-Reply-To: <20170927122642.18628-1-jeffy.chen@rock-chips.com>
References: <20170927122642.18628-1-jeffy.chen@rock-chips.com>
Message-ID: <20170927202709.ugbjyi3ktfjssiyp@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 08:26:42PM +0800, Jeffy Chen wrote:
> Free the drm_atomic_state allocated by drm_atomic_helper_suspend().
> 
> Fixes: 5a5873830972 ("drm/rockchip: Use atomic PM helpers")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 76d63de5921d..80235b672deb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> @@ -299,6 +300,7 @@ static int rockchip_drm_sys_resume(struct device *dev)
>  
>  	priv = drm->dev_private;
>  	drm_atomic_helper_resume(drm, priv->state);
> +	drm_atomic_state_put(priv->state);

Won't this be freed for you eventually in commit_tail()?

Sean

>  	rockchip_drm_fb_resume(drm);
>  	drm_kms_helper_poll_enable(drm);
>  
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
