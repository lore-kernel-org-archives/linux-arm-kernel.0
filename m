From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Sep 2010 16:39:44 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <4C961906.4040303@compulab.co.il>
References: <cover.1284655723.git.mike@compulab.co.il>
	<201009161912.12330.arnd@arndb.de>
	<4C961906.4040303@compulab.co.il>
Message-ID: <201009191639.44488.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 September 2010 16:07:02 Mike Rapoport wrote:
> > diff --git a/arch/arm/mach-tegra/include/mach/io.h b/arch/arm/mach-tegra/include/mach/io.h
> > index 35edfc3..d54e384 100644
> > --- a/arch/arm/mach-tegra/include/mach/io.h
> > +++ b/arch/arm/mach-tegra/include/mach/io.h
> > @@ -21,7 +21,8 @@
> >  #ifndef __MACH_TEGRA_IO_H
> >  #define __MACH_TEGRA_IO_H
> >  
> > -#define IO_SPACE_LIMIT 0xffffffff
> > +/* Two 1MB windows */
> > +#define IO_SPACE_LIMIT (SZ_1M + SZ_1M - 1)
> 
> This would limit ioport_resource to 2M, and request_resource(&ioport_resource, 
> &res) will fail because ioport_resource does not take into account that IO can 
> start somewhere else than at 0.

Normally, the ioport_resource is limited to 65536 bytes in practice,
because that's the most that many PCI cards decode.

The only reason to let the I/O window start at something other than 0 is
to leave space for legacy ISA devices, so typically the available range
is between 0x1000 and 0xffff.

I don't see that as a limitation here.

> >  /* On TEGRA, many peripherals are very closely packed in
> >   * two 256MB io windows (that actually only use about 64KB
> > @@ -69,7 +70,7 @@ void tegra_iounmap(volatile void __iomem *addr);
> >  
> >  static inline void __iomem *__io(unsigned long addr)
> >  {
> > -     return (void __iomem *)addr;
> > +     return addr + tegra_pcie.regs + SZ_4M;
> 
> I wish things were that simple :)
> As far as I understand, the IO space should be mapped prior to use and __io 
> should return the virtual address.

That's right. You already map all the PCI registers including the I/O port
mapping at initialization time, but you must not attempt to access these
during boot before that time.

You should probably mask the size as above, which I forgot:

static inline void __iomem *__io(unsigned long addr)
{
     return (addr & IO_SPACE_LIMIT) + (tegra_pcie.regs + SZ_4M);
}

Hopefully it's clearer that way, and certainly safer in case someone
passes the physical address of the I/O window into __io rather than
the offset.

	Arnd
