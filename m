From: seanpaul@chromium.org (Sean Paul)
Date: Wed, 5 Apr 2017 12:28:40 -0400
Subject: [PATCH v3 8/9] drm/rockchip: gem: Don't alloc/free gem buf when
 dev_private is invalid
In-Reply-To: <1491380967-28570-9-git-send-email-jeffy.chen@rock-chips.com>
References: <1491380967-28570-1-git-send-email-jeffy.chen@rock-chips.com>
 <1491380967-28570-9-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170405162839.k6q4b3tpt6t2s3zm@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 04:29:26PM +0800, Jeffy Chen wrote:
> After unbinding drm, the userspace may still has a chance to access
> gem buf.
> 
> Add a sanity check for a NULL dev_private to prevent that from
> happening.

I still don't understand how this is happening. You're saying that these hooks
can be called after rockchip_drm_unbind() has finished? 

Sean

> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> Address Daniel Vetter <daniel@ffwll.ch>'s comments.
> Update commit message.
> 
> Changes in v2: None
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index df9e570..205a3dc 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -184,6 +184,9 @@ static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
>  	struct drm_device *drm = obj->dev;
>  	struct rockchip_drm_private *private = drm->dev_private;
>  
> +	if (!private)
> +		return -ENODEV;
> +
>  	if (private->domain)
>  		return rockchip_gem_alloc_iommu(rk_obj, alloc_kmap);
>  	else
> @@ -208,6 +211,11 @@ static void rockchip_gem_free_dma(struct rockchip_gem_object *rk_obj)
>  
>  static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
>  {
> +	struct drm_device *drm = rk_obj->base.dev;
> +
> +	if (!drm->dev_private)
> +		return;
> +
>  	if (rk_obj->pages)
>  		rockchip_gem_free_iommu(rk_obj);
>  	else
> -- 
> 2.1.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
