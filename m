From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 22 Nov 2018 10:07:47 +0100
Subject: [PATCH] drm/sun4i: wait on implicit fence before display
In-Reply-To: <20181122014417.23285-1-yuq825@gmail.com>
References: <20181122014417.23285-1-yuq825@gmail.com>
Message-ID: <20181122090747.GB4266@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 09:44:17AM +0800, Qiang Yu wrote:
> Render like lima will attach a fence to the framebuffer
> dma_buf, display like sun4i should wait it finish before
> show the framebuffer. Otherwise tearing will be observed.
> 
> Signed-off-by: Qiang Yu <yuq825@gmail.com>

Thanks for submitting this fix, applied to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/sun4i/sun4i_layer.c    | 2 ++
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 2 ++
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
> index 750ad24de1d7..d68e663df9a0 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
> @@ -12,6 +12,7 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drmP.h>
>  
>  #include "sun4i_backend.h"
> @@ -114,6 +115,7 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
>  }
>  
>  static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
> +	.prepare_fb	= drm_gem_fb_prepare_fb,
>  	.atomic_disable	= sun4i_backend_layer_atomic_disable,
>  	.atomic_update	= sun4i_backend_layer_atomic_update,
>  };
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> index 28c15c6ef1ef..7bc2ca2bd0c3 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -19,6 +19,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drmP.h>
>  
> @@ -287,6 +288,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
> +	.prepare_fb	= drm_gem_fb_prepare_fb,
>  	.atomic_check	= sun8i_ui_layer_atomic_check,
>  	.atomic_disable	= sun8i_ui_layer_atomic_disable,
>  	.atomic_update	= sun8i_ui_layer_atomic_update,
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> index f4fe97813f94..815895795afd 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -13,6 +13,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drmP.h>
>  
> @@ -315,6 +316,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
>  }
>  
>  static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
> +	.prepare_fb	= drm_gem_fb_prepare_fb,
>  	.atomic_check	= sun8i_vi_layer_atomic_check,
>  	.atomic_disable	= sun8i_vi_layer_atomic_disable,
>  	.atomic_update	= sun8i_vi_layer_atomic_update,
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
