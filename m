From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 22 Jun 2016 10:03:28 +0200
Subject: [PATCH 3/3] drm/sun4i: Remove open-coded
 drm_connector_register_all()
In-Reply-To: <1466501283-19976-4-git-send-email-chris@chris-wilson.co.uk>
References: <1466501283-19976-1-git-send-email-chris@chris-wilson.co.uk>
 <1466501283-19976-4-git-send-email-chris@chris-wilson.co.uk>
Message-ID: <20160622080328.GK23520@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 10:28:03AM +0100, Chris Wilson wrote:
> drm_dev_register() will now register all known connectors, so we no
> longer have to do so manually.
> 
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org

Merged all 3 to drm-misc, thanks.
-Daniel

> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 68e9d85085fb..59cd8b27ee02 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -24,34 +24,6 @@
>  #include "sun4i_layer.h"
>  #include "sun4i_tcon.h"
>  
> -static int sun4i_drv_connector_plug_all(struct drm_device *drm)
> -{
> -	struct drm_connector *connector, *failed;
> -	int ret;
> -
> -	mutex_lock(&drm->mode_config.mutex);
> -	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
> -		ret = drm_connector_register(connector);
> -		if (ret) {
> -			failed = connector;
> -			goto err;
> -		}
> -	}
> -	mutex_unlock(&drm->mode_config.mutex);
> -	return 0;
> -
> -err:
> -	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
> -		if (failed == connector)
> -			break;
> -
> -		drm_connector_unregister(connector);
> -	}
> -	mutex_unlock(&drm->mode_config.mutex);
> -
> -	return ret;
> -}
> -
>  static int sun4i_drv_enable_vblank(struct drm_device *drm, unsigned int pipe)
>  {
>  	struct sun4i_drv *drv = drm->dev_private;
> @@ -187,14 +159,8 @@ static int sun4i_drv_bind(struct device *dev)
>  	if (ret)
>  		goto free_drm;
>  
> -	ret = sun4i_drv_connector_plug_all(drm);
> -	if (ret)
> -		goto unregister_drm;
> -
>  	return 0;
>  
> -unregister_drm:
> -	drm_dev_unregister(drm);
>  free_drm:
>  	drm_dev_unref(drm);
>  	return ret;
> -- 
> 2.8.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
