From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Nov 2013 01:57:35 +0100
Subject: [PATCH 07/19] v4l: sh_vou: Enable the driver on all ARM platforms
In-Reply-To: <20131030102623.1d498c16@samsung.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131030102623.1d498c16@samsung.com>
Message-ID: <2618401.AsTUKxu6fa@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Wednesday 30 October 2013 10:26:23 Mauro Carvalho Chehab wrote:
> Em Tue, 29 Oct 2013 00:46:55 +0100 Laurent Pinchart escreveu:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> > 
> > Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
> > Cc: linux-media at vger.kernel.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> I'm understanding that the plan is to commit it via an ARM tree, right?

Actually the plan is to get this upstream through you tree :-) However, I'm 
trying a different approach to the problem, so I'll post a new version of the 
patch set in the near future.

> If so:
> 	Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
> 
> PS.: With regards to the discussions about this patch series, I'm ok on
> having this enabled for all archs or just for the archs that are known have
> this IP block, of course provided that not includes to march are there.
> 
> The rationale is that, in the specific case of V4L, the platform drivers are
> already on a separate Kconfig menu, with makes no sense to be enabled on any
> non SoC configuration.

We will likely split dependencies on two lines in Kconfig, one for the build-
time dependencies and one for the runtime dependencies. A driver that compiles 
on ARM only and supports hardware that is present on ARCH_SHMOBILE SoCs only 
would thus have

	depends on ARM
	depends on ARCH_SHMOBILE || COMPILE_TEST

Build-time dependencies on other software components (I2C for instance) would 
be listed on the first line. The code below would become

	depends on VIDEO_DEV && I2C
	depends on ARCH_SHMOBILE || COMPILE_TEST

> > ---
> > 
> >  drivers/media/platform/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/platform/Kconfig
> > b/drivers/media/platform/Kconfig index c7caf94..a726f86 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -36,7 +36,7 @@ source "drivers/media/platform/blackfin/Kconfig"
> >  config VIDEO_SH_VOU
> >  	tristate "SuperH VOU video output driver"
> >  	depends on MEDIA_CAMERA_SUPPORT
> > -	depends on VIDEO_DEV && ARCH_SHMOBILE && I2C
> > +	depends on VIDEO_DEV && ARM && I2C
> >  	select VIDEOBUF_DMA_CONTIG
> >  	help
> >  	  Support for the Video Output Unit (VOU) on SuperH SoCs.
-- 
Regards,

Laurent Pinchart
