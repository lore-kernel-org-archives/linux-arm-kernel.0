From: dkos@cadence.com (Damian Kos)
Date: Mon, 24 Sep 2018 11:40:03 +0000
Subject: [PATCH v4 5/5] drm: bridge: add support for Cadence MHDP DPI/DP
 bridge
In-Reply-To: <1903708.pJTgKoWLiI@phil>
References: <1537455288-20223-1-git-send-email-dkos@cadence.com>
 <1537455288-20223-6-git-send-email-dkos@cadence.com>
 <1903708.pJTgKoWLiI@phil>
Message-ID: <CO2PR07MB2551EC0A7DEB61C54A4D6A5FCD170@CO2PR07MB2551.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

> Hi Damian,
> 
> Am Donnerstag, 20. September 2018, 16:54:40 CEST schrieb Damian Kos:
> > From: Quentin Schulz <quentin.schulz@free-electrons.com>
> > 
> > This adds basic support for Cadence MHDP DPI to DP bridge.
> > 
> > Basically, it takes a DPI stream as input and output it encoded in DP 
> > format. It's missing proper HPD, HDCP and currently supports only SST 
> > mode.
> > 
> > Changes made in the low level driver (cdn-dp-reg.*):
> > - moved it to from drivers/gpu/drm/rockchip to
> >   drivers/gpu/drm/bridge/cdns-mhdp-common.*
> > - functions for sending/receiving commands are now public
> > - added functions for reading registers and link training
> >   adjustment
> > 
> > Changes made in RK's driver (cdn-dp-core.*):
> > - Moved audio_info and audio_pdev fields from cdn_dp_device to
> >   cdns_mhdp_device structure.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > Signed-off-by: Damian Kos <dkos@cadence.com>
> 
> [...]
> 
> > diff --git a/drivers/gpu/drm/rockchip/Kconfig 
> > b/drivers/gpu/drm/rockchip/Kconfig
> > index 0ccc76217ee4..129b0529f3e1 100644
> > --- a/drivers/gpu/drm/rockchip/Kconfig
> > +++ b/drivers/gpu/drm/rockchip/Kconfig
> > @@ -27,7 +27,9 @@ config ROCKCHIP_ANALOGIX_DP
> >  
> >  config ROCKCHIP_CDN_DP
> >          bool "Rockchip cdn DP"
> > -	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
> > +	depends on DRM_ROCKCHIP=m
> 
> Sorry, I wasn't fast enough in my reply to you mail to catch that before your v4, but I don't think this is necessary.
> Instead I do guess, the select below should do the right thing by making EXTCON=y if DRM_ROCKCHIP=y.
> 
> Somewhat clumsily verified by making EXTCON=m in my defconfig and seeing get changed to y upon build, which I guess comes from a different "select" in the config.
> 

I've changed it to:

config ROCKCHIP_CDN_DP
        bool "Rockchip cdn DP"
        depends on DRM_ROCKCHIP
        select EXTCON if DRM_ROCKCHIP=y
        select DRM_CDNS_MHDP
        help...

and it seems that there are no issues. At least for me.

Please let me know if that's OK.

> 
> > +	select EXTCON
> > +	select DRM_CDNS_MHDP
> >          help
> >  	  This selects support for Rockchip SoC specific extensions
> >  	  for the cdn DP driver. If you want to enable Dp on diff --git 
> > a/drivers/gpu/drm/rockchip/Makefile 
> > b/drivers/gpu/drm/rockchip/Makefile
> > index a314e2109e76..16ba61ffca39 100644
> > --- a/drivers/gpu/drm/rockchip/Makefile
> > +++ b/drivers/gpu/drm/rockchip/Makefile
> > @@ -3,13 +3,15 @@
> >  # Makefile for the drm device driver.  This driver provides support 
> > for the  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> >  
> > +ccflags-y += -I$(src)/../bridge
> 
> hmm, instead of adding an include path, the shared header should probably just live in /include/drm/bridge/... in the kernel source?
> 

I'll move the common header to include/drm/bridge/ in v5.

> 
> Heiko

--
Damian
