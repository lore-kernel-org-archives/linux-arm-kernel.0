From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 08 Oct 2013 16:45:59 +0200
Subject: [PATCH] SHMOBILE: DRM: Fix backlight_device register and
 unregister undefined errors.
In-Reply-To: <1381228757-23144-1-git-send-email-csmanjuvijay@gmail.com>
References: <1381228757-23144-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <13157207.BOibbx65gp@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Majunath,

Thank you for the patch.

On Tuesday 08 October 2013 16:09:17 Majunath Goudar wrote:
> This patch adds a BACKLIGHT_CLASS_DEVICE dependency to configure the
> DRM_SHMOBILE. Without this patch, build system can lead to build failure.
> This was observed during randconfig testing, in which DRM_SHMOBILE was
> enabled w/o BACKLIGHT_CLASS_DEVICE being enabled. Following was the error:
> 
>  Building modules, stage 2.
>   MODPOST 516 modules
> ERROR: "backlight_device_register" [drivers/gpu/drm/shmobile/shmob-drm.ko]
> undefined! ERROR: "backlight_device_unregister"
> [drivers/gpu/drm/shmobile/shmob-drm.ko] undefined! make[1]: *** [__modpost]
> Error 1
> make: *** [modules] Error 2
> 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/gpu/drm/shmobile/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/Kconfig
> b/drivers/gpu/drm/shmobile/Kconfig index ca498d1..eaf822e 100644
> --- a/drivers/gpu/drm/shmobile/Kconfig
> +++ b/drivers/gpu/drm/shmobile/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_SHMOBILE
>  	tristate "DRM Support for SH Mobile"
> -	depends on DRM && (ARM || SUPERH)
> +	depends on DRM && (ARM || SUPERH) && BACKLIGHT_CLASS_DEVICE

What about

select BACKLIGHT_CLASS_DEVICE

instead ? That's what the i915, radeon, gma500, tilcdc and nouveau drivers do.

>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
>  	select DRM_GEM_CMA_HELPER

-- 
Regards,

Laurent Pinchart
