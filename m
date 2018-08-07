From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 7 Aug 2018 22:18:01 +0200
Subject: [PATCH] drm/sun4i: Avoid failing to init fbdev without any
 connector
In-Reply-To: <20180807193919.4800-1-contact@paulk.fr>
References: <20180807193919.4800-1-contact@paulk.fr>
Message-ID: <20180807201801.GF3008@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 09:39:19PM +0200, Paul Kocialkowski wrote:
> Initializing and registering fbdev requires at least one DRM connector
> and will fail otherwise. In order to support headless setups (for
> instance for GPU rendering with the GBM backend, where a DRI card node
> is required to provide GEM memory reservation), add a check on the
> number of registered connectors before initializing fbdev.

sun4i is a pure kms driver, why exactly do you need it for gbm backed
rendering? What exactly is rendering here, and why does it insist on a
display card node, even if that display card node is 100% defunct?
-Daniel

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> index 5f29850ef8ac..19a265e4a93a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> @@ -49,6 +49,8 @@ static struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers = {
>  
>  int sun4i_framebuffer_init(struct drm_device *drm)
>  {
> +	int ret;
> +
>  	drm_mode_config_reset(drm);
>  
>  	drm->mode_config.max_width = 8192;
> @@ -57,7 +59,13 @@ int sun4i_framebuffer_init(struct drm_device *drm)
>  	drm->mode_config.funcs = &sun4i_de_mode_config_funcs;
>  	drm->mode_config.helper_private = &sun4i_de_mode_config_helpers;
>  
> -	return drm_fb_cma_fbdev_init(drm, 32, 0);
> +	if (drm->mode_config.num_connector > 0) {
> +		ret = drm_fb_cma_fbdev_init(drm, 32, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  void sun4i_framebuffer_free(struct drm_device *drm)
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
