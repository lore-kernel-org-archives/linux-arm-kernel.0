From: sam@ravnborg.org (Sam Ravnborg)
Date: Fri, 24 Aug 2018 17:43:29 +0200
Subject: [PATCH v1 1/7] atmel-hlcdc: renamed directory to drm/atmel/
In-Reply-To: <20180824102843.666bc465@bbrezillon>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-1-sam@ravnborg.org>
 <20180824102843.666bc465@bbrezillon>
Message-ID: <20180824154329.GA26678@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris.

On Fri, Aug 24, 2018 at 10:28:43AM +0200, Boris Brezillon wrote:
> On Sun, 12 Aug 2018 20:46:23 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Use vendor name for directory, adding a suitable place
> > for more atmel DRM drivers.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> >  MAINTAINERS                                                 | 2 +-
> >  drivers/gpu/drm/Kconfig                                     | 2 +-
> >  drivers/gpu/drm/Makefile                                    | 2 +-
> >  drivers/gpu/drm/{atmel-hlcdc => atmel}/Kconfig              | 6 ++++++
> >  drivers/gpu/drm/{atmel-hlcdc => atmel}/Makefile             | 0
> >  drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_crtc.c   | 0
> >  drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.c     | 0
> >  drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.h     | 0
> >  drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_output.c | 0
> >  drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c  | 0
> >  10 files changed, 9 insertions(+), 3 deletions(-)
> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/Kconfig (83%)
> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/Makefile (100%)
> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_crtc.c (100%)
> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.c (100%)
> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.h (100%)
> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_output.c (100%)
> >  rename drivers/gpu/drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c (100%)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 96e98e206b0d..09ce76a9a1dc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4681,7 +4681,7 @@ DRM DRIVERS FOR ATMEL HLCDC
> >  M:	Boris Brezillon <boris.brezillon@bootlin.com>
> >  L:	dri-devel at lists.freedesktop.org
> >  S:	Supported
> > -F:	drivers/gpu/drm/atmel-hlcdc/
> > +F:	drivers/gpu/drm/atmel/atmel-hlcdc*
> 
> 			      atmel_hlcdc*
> 
> Also, I think you can keep the whole directory, and add your name plus
> update the entry description after adding code for the LCDC block.

Thanks, will do so in v2.

> 
> >  F:	Documentation/devicetree/bindings/display/atmel/
> >  T:	git git://anongit.freedesktop.org/drm/drm-misc
> >  
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 2a72d2feb76d..4130df0c0dba 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -232,7 +232,7 @@ source "drivers/gpu/drm/cirrus/Kconfig"
> >  
> >  source "drivers/gpu/drm/armada/Kconfig"
> >  
> > -source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
> > +source "drivers/gpu/drm/atmel/Kconfig"
> >  
> >  source "drivers/gpu/drm/rcar-du/Kconfig"
> >  
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index ef9f3dab287f..ce9829967128 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -76,7 +76,7 @@ obj-$(CONFIG_DRM_GMA500) += gma500/
> >  obj-$(CONFIG_DRM_UDL) += udl/
> >  obj-$(CONFIG_DRM_AST) += ast/
> >  obj-$(CONFIG_DRM_ARMADA) += armada/
> > -obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
> > +obj-$(CONFIG_DRM_ATMEL)	+= atmel/
> >  obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
> >  obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
> >  obj-y			+= omapdrm/
> > diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/atmel/Kconfig
> > similarity index 83%
> > rename from drivers/gpu/drm/atmel-hlcdc/Kconfig
> > rename to drivers/gpu/drm/atmel/Kconfig
> > index 32bcc4bad06a..7cd3862f9d18 100644
> > --- a/drivers/gpu/drm/atmel-hlcdc/Kconfig
> > +++ b/drivers/gpu/drm/atmel/Kconfig
> > @@ -1,6 +1,12 @@
> > +config DRM_ATMEL
> > +	bool
> > +	help
> > +	  Enable Atmel DRM support
> > +
> 
> Not sure why you need an extra Kconfig option? And if you really do
> (because you want to share common code), it should be implicitly
> selected by DRM_ATMEL_HLCDC and DRM_ATMEL_LCDC.

The extra config option is to avoid exposing every single option
to the drm makefile, and it is indeed selected by the individual
drivers.
Similar pattern used in arm/Kconfig.
But I see most other places have a prompt that enable the drivers
so I will change this to a prompt in v2.

	Sam
