From: stillcompiling@gmail.com (Joshua Clayton)
Date: Sat, 19 Nov 2016 03:58:15 -0800
Subject: [RFC 2/6] drm/etnaviv: allow building etnaviv on omap devices
In-Reply-To: <20161118163342.5t2tbsw54k2gmqe3@rob-hp-laptop>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-2-robertcnelson@gmail.com>
 <20161118163342.5t2tbsw54k2gmqe3@rob-hp-laptop>
Message-ID: <2481825.ONQ5ft592J@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 18, 2016 10:33:42 AM Rob Herring wrote:
> On Thu, Nov 17, 2016 at 08:44:32PM -0600, Robert Nelson wrote:
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > CC: Christian Gmeiner <christian.gmeiner@gmail.com>
> > CC: Russell King <rmk+kernel@arm.linux.org.uk>
> > CC: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> > index 2cde7a5..b776f41 100644
> > --- a/drivers/gpu/drm/etnaviv/Kconfig
> > +++ b/drivers/gpu/drm/etnaviv/Kconfig
> > @@ -2,7 +2,7 @@
> >  config DRM_ETNAVIV
> >  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
> >  	depends on DRM
> > -	depends on ARCH_MXC || ARCH_DOVE
> > +	depends on ARCH_MXC || ARCH_DOVE || ARCH_OMAP2PLUS
> 
> Why not just drop this line. Then it will get better build testing, too.
> 
> >  	select SHMEM
> >  	select TMPFS
> >  	select IOMMU_API
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
...building with ARCH=x86_64
            ^
drivers/gpu/drm/etnaviv/etnaviv_gpu.c: In function ?etnaviv_gpu_init?:
drivers/gpu/drm/etnaviv/etnaviv_gpu.c:633:18: error: ?PHYS_OFFSET? undeclared (first use in this function)
   if (dma_mask < PHYS_OFFSET + SZ_2G)
                  ^
drivers/gpu/drm/etnaviv/etnaviv_gpu.c:633:18: note: each undeclared identifier is reported only once for each function it appears in
make[4]: *** [scripts/Makefile.build:290: drivers/gpu/drm/etnaviv/etnaviv_gpu.o] Error 1
make[3]: *** [scripts/Makefile.build:440: drivers/gpu/drm/etnaviv] Error 2
make[2]: *** [scripts/Makefile.build:440: drivers/gpu/drm] Error 2
make[1]: *** [scripts/Makefile.build:440: drivers/gpu] Error 2
make: *** [Makefile:968: drivers] Error 2


...looks like this snippit is the only (compile time) problem:
 
 622         /*
 623          * Set the GPU linear window to be@the end of the DMA window, where
 624          * the CMA area is likely to reside. This ensures that we are able to
 625          * map the command buffers while having the linear window overlap as
 626          * much RAM as possible, so we can optimize mappings for other buffers.
 627          *
 628          * For 3D cores only do this if MC2.0 is present, as with MC1.0 it leads
 629          * to different views of the memory on the individual engines.
 630          */
 631         if (!(gpu->identity.features & chipFeatures_PIPE_3D) ||
 632             (gpu->identity.minor_features0 & chipMinorFeatures0_MC20)) {
 633                 u32 dma_mask = (u32)dma_get_required_mask(gpu->dev);
 634                 if (dma_mask < PHYS_OFFSET + SZ_2G)
 635                         gpu->memory_base = PHYS_OFFSET;
 636                 else
 637                         gpu->memory_base = dma_mask - SZ_2G + 1;
 638         }

Joshua
