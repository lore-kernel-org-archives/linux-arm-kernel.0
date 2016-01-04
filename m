From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Jan 2016 09:24:16 +0100
Subject: [PATCH 4/3] drm: arm-hdlcd: add explictit DRM dependency
In-Reply-To: <5213510.IMdSbsXdoQ@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
 <5213510.IMdSbsXdoQ@wuerfel>
Message-ID: <20160104082416.GB23797@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2016 at 11:04:07PM +0100, Arnd Bergmann wrote:
> CONFIG_DRM_HDLCD is a tristate option that depends on the boolean
> CONFIG_DRM_ARM, which in turn depends on the tristate CONFIG_DRM.
> The effect of this is that a configuration with CONFIG_DRM=m
> and CONFIG_DRM_HDLCD=y can be chosen, but won't link because the
> DRM core symbols are not reachable from builtin code:
> 
> drivers/built-in.o: In function `hdlcd_drm_unbind':
> drivers/gpu/drm/arm/hdlcd_drv.c:445: undefined reference to `drm_fbdev_cma_fini'
> drivers/gpu/drm/arm/hdlcd_drv.c:448: undefined reference to `drm_kms_helper_poll_fini'
> drivers/gpu/drm/arm/hdlcd_drv.c:450: undefined reference to `drm_vblank_cleanup'
> drivers/gpu/drm/arm/hdlcd_drv.c:452: undefined reference to `drm_irq_uninstall'
> drivers/gpu/drm/arm/hdlcd_drv.c:460: undefined reference to `drm_mode_config_cleanup'
> drivers/gpu/drm/arm/hdlcd_drv.c:461: undefined reference to `drm_dev_unregister'
> drivers/gpu/drm/arm/hdlcd_drv.c:462: undefined reference to `drm_dev_unref'
> ...
> 
> This adds another dependency on CONFIG_DRM to enforce that DRM_HDLCD
> cannot be builtin if DRM is not.

Ugh... wouldn't it be much simpler to get rid of DRM_ARM? It seems like
a completely superfluous option to me. I don't think we've ever had the
equivalent of "vendor" Kconfig options in DRM, and I don't see why we'd
need to start now. If ARM was going to add another driver it can simply
have a separate Kconfig entry. There should be no need to select the
vendor option first.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/2937e3ba/attachment.sig>
