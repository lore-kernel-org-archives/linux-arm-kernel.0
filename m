From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 Jan 2016 23:04:07 +0100
Subject: [PATCH 4/3] drm: arm-hdlcd: add explictit DRM dependency
In-Reply-To: <4194408.X82ccDjh5X@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
Message-ID: <5213510.IMdSbsXdoQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_DRM_HDLCD is a tristate option that depends on the boolean
CONFIG_DRM_ARM, which in turn depends on the tristate CONFIG_DRM.
The effect of this is that a configuration with CONFIG_DRM=m
and CONFIG_DRM_HDLCD=y can be chosen, but won't link because the
DRM core symbols are not reachable from builtin code:

drivers/built-in.o: In function `hdlcd_drm_unbind':
drivers/gpu/drm/arm/hdlcd_drv.c:445: undefined reference to `drm_fbdev_cma_fini'
drivers/gpu/drm/arm/hdlcd_drv.c:448: undefined reference to `drm_kms_helper_poll_fini'
drivers/gpu/drm/arm/hdlcd_drv.c:450: undefined reference to `drm_vblank_cleanup'
drivers/gpu/drm/arm/hdlcd_drv.c:452: undefined reference to `drm_irq_uninstall'
drivers/gpu/drm/arm/hdlcd_drv.c:460: undefined reference to `drm_mode_config_cleanup'
drivers/gpu/drm/arm/hdlcd_drv.c:461: undefined reference to `drm_dev_unregister'
drivers/gpu/drm/arm/hdlcd_drv.c:462: undefined reference to `drm_dev_unref'
...

This adds another dependency on CONFIG_DRM to enforce that DRM_HDLCD
cannot be builtin if DRM is not.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Ok, I found yet another one after a few hundred extra randconfig builds
on today's next. Let me know if you'd rather have the three Kconfig
changes combined into a single patch, it's starting to get ridiculous.

diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index 81ea7802ca50..487fb1f0c979 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -7,7 +7,7 @@ config DRM_ARM
 
 config DRM_HDLCD
 	tristate "ARM HDLCD"
-	depends on DRM_ARM
+	depends on DRM_ARM && DRM
 	depends on COMMON_CLK
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
