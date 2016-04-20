From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 Apr 2016 15:58:25 -0700
Subject: [PATCH] drm/layerscape: reduce excessive stack usage
In-Reply-To: <1456176818-1207477-1-git-send-email-arnd@arndb.de>
References: <1456176818-1207477-1-git-send-email-arnd@arndb.de>
Message-ID: <205ea5e0b82ba83a7679b4a2f9f660e3@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-02-22 13:33, Arnd Bergmann wrote:
> The fsl-dcu driver copies a drm_mode_config object to its
> stack but then only accesses a single member (dpms_property)
> once. The data structure is large enough to trigger a warning
> about the amount of kernel stack being used:
> 
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c: In function
> 'fsl_dcu_drm_connector_create':
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c:182:1: error: the frame size
> of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> This changes the fsl_dcu_drm_connector_create() function to
> only access the drm_mode_config by reference, which is also
> more efficient.

Applied to my tree:
http://git.agner.ch/gitweb/?p=linux-drm-fsl-dcu.git;a=summary

--
Stefan

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 109eee2f2a18 ("drm/layerscape: Add Freescale DCU DRM driver")
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> index 8780deba5e8a..92149152db44 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> @@ -131,7 +131,7 @@ int fsl_dcu_drm_connector_create(struct
> fsl_dcu_drm_device *fsl_dev,
>  				 struct drm_encoder *encoder)
>  {
>  	struct drm_connector *connector = &fsl_dev->connector.base;
> -	struct drm_mode_config mode_config = fsl_dev->drm->mode_config;
> +	struct drm_mode_config *mode_config = &fsl_dev->drm->mode_config;
>  	struct device_node *panel_node;
>  	int ret;
>  
> @@ -153,7 +153,7 @@ int fsl_dcu_drm_connector_create(struct
> fsl_dcu_drm_device *fsl_dev,
>  		goto err_sysfs;
>  
>  	drm_object_property_set_value(&connector->base,
> -				      mode_config.dpms_property,
> +				      mode_config->dpms_property,
>  				      DRM_MODE_DPMS_OFF);
>  
>  	panel_node = of_parse_phandle(fsl_dev->np, "fsl,panel", 0);
