From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Nov 2016 11:43:15 +0000
Subject: [RFC 2/6] drm/etnaviv: allow building etnaviv on omap devices
In-Reply-To: <2481825.ONQ5ft592J@diplodocus>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-2-robertcnelson@gmail.com>
 <20161118163342.5t2tbsw54k2gmqe3@rob-hp-laptop>
 <2481825.ONQ5ft592J@diplodocus>
Message-ID: <20161120114314.GD23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 19, 2016 at 03:58:15AM -0800, Joshua Clayton wrote:
> On Friday, November 18, 2016 10:33:42 AM Rob Herring wrote:
> > On Thu, Nov 17, 2016 at 08:44:32PM -0600, Robert Nelson wrote:
> > > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> > > CC: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > CC: Russell King <rmk+kernel@arm.linux.org.uk>
> > > CC: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> > > index 2cde7a5..b776f41 100644
> > > --- a/drivers/gpu/drm/etnaviv/Kconfig
> > > +++ b/drivers/gpu/drm/etnaviv/Kconfig
> > > @@ -2,7 +2,7 @@
> > >  config DRM_ETNAVIV
> > >  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
> > >  	depends on DRM
> > > -	depends on ARCH_MXC || ARCH_DOVE
> > > +	depends on ARCH_MXC || ARCH_DOVE || ARCH_OMAP2PLUS
> > 
> > Why not just drop this line. Then it will get better build testing, too.
> > 
> > >  	select SHMEM
> > >  	select TMPFS
> > >  	select IOMMU_API
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> ...building with ARCH=x86_64
>             ^
> drivers/gpu/drm/etnaviv/etnaviv_gpu.c: In function ?etnaviv_gpu_init?:
> drivers/gpu/drm/etnaviv/etnaviv_gpu.c:633:18: error: ?PHYS_OFFSET? undeclared (first use in this function)
>    if (dma_mask < PHYS_OFFSET + SZ_2G)
>                   ^
> drivers/gpu/drm/etnaviv/etnaviv_gpu.c:633:18: note: each undeclared identifier is reported only once for each function it appears in

... and that's why we don't drop the dependency, although changing it
to "depends on ARM" will open it up to wider build testing on other
ARM platforms, I don't think that gains very much.

The issue is that the command buffers must be located within the first
2GB of GPU virtual address space, and that space can only be translated
(offset).  What the code here is trying to do is to locate the 2GB of
virtual address space such that it overlaps the CMA region if RAM is
bigger than 2GB, or covers all of the RAM if not.

For that, we need to know where physical RAM starts.

I guess we could replace PHYS_OFFSET with virt_to_phys(PAGE_OFFSET)
here instead, which would be more arch-portable - although that would
be assuming there's no (system?) IOMMU between memory and the GPU.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
