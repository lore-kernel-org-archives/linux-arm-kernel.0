From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 26 Oct 2016 07:56:48 +0200
Subject: [PATCH v5 3/9] drm/hisilicon/hibmc: Add support for frame buffer
In-Reply-To: <1477449426-69018-4-git-send-email-zourongrong@gmail.com>
References: <1477449426-69018-1-git-send-email-zourongrong@gmail.com>
 <1477449426-69018-4-git-send-email-zourongrong@gmail.com>
Message-ID: <20161026055648.bipks7wthiu4gmlf@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 10:37:00AM +0800, Rongrong Zou wrote:
> Add support for fbdev and kms fb management.
> 
> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>

Small drive-by comment below.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index db8d80e..d41138a 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -20,9 +20,23 @@
>  #define HIBMC_DRM_DRV_H
>  
>  #include <drm/drmP.h>
> +#include <drm/drm_fb_helper.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/drm_gem.h>
>  
> +struct hibmc_framebuffer {
> +	struct drm_framebuffer fb;
> +	struct drm_gem_object *obj;
> +	bool is_fbdev_fb;
> +};
> +
> +struct hibmc_fbdev {
> +	struct drm_fb_helper helper;
> +	struct hibmc_framebuffer fb;

I wouldn't embed the single framebuffer here, but instead have a pointer
and just refcount it. This here is a pattern that predates framebuffer
refcounting, and it leads to plenty of surprises.

Maybe we should update the documentation of
drm_framebuffer_unregister_private() to mention that it is deprecated? The
overview doc in drm_framebuffer.c already explains that, but I guess
that's not obvious enough.

Can you pls do that patch? And pls make sure it all looks pretty when
building the docs with

$ make htmldocs

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
