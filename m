From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 16:00:01 +0100
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <54773A8B.5000200@free.fr>
References: <5476FFA2.8010403@free.fr> <7958894.CNnhBWEkgT@wuerfel>
 <54773A8B.5000200@free.fr>
Message-ID: <2978273.VePW8UymqL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 15:51:55 Mason wrote:
> Arnd,
> 
> First of all, thanks (a lot) for your highly informative replies!
> 
> On 27/11/2014 14:12, Arnd Bergmann wrote:
> 
> > On Thursday 27 November 2014 14:01:41 Mason wrote:
> >
> >> #define gbus_read_reg32(r)      __raw_readl((volatile void __iomem *)IO_ADDRESS(r))
> >> #define gbus_write_reg32(r, v)  __raw_writel(v, (volatile void __iomem *)IO_ADDRESS(r))
> >
> > Right, that's how things used to be done a while ago.
> 
> So, IIUC, old code used to call __raw_readl directly, but modern
> code is supposed to call either readl or readl_relaxed?
> 
> (BTW, the original code is 4-5 years old, while my target is 3.14.x)

I meant the IO_ADDRESS stuff. Modern code uses ioremap() instead
since the IO_ADDRESS was platform specific, and drivers can no longer
use platform headers on CONFIG_ARCH_MULTIPLATFORM, which is used
for all new code now.

The __raw_readl() was probably considered bad back then already, but
a lot of people did it as we were lacking readl_relaxed().

Would you consider submitting the code upstream?

> >>> use of_iomap or devm_ioremap_resource to get to the pointer for
> >>> a device, don't just hardcode virtual addresses.
> >>
> >> About that. If nothing had been done, 0xf0010024 would be an
> >> invalid virtual address, and reading from that address would
> >> generate a TLB miss, right? So something must have configured
> >> the TLB to accept and translate this address correctly.
> >>
> >> I'm looking for an iomap or ioremap call, right?
> >
> > The IO_ADDRESS() macro on this platform is probably defined to
> > match a address range that is set up from a map_io callback in
> > the platform.
> 
> #define __IO_START 0xf0000000
> #define __IO_SIZE  SZ_8M
> #define __IO_END   (__IO_START + __IO_SIZE)
> #define IO_ADDRESS(x) (__IO_START +(x))
> 
> static struct map_desc hw_io_desc[] __initdata = {
> 	{
> 		.virtual	= SCU_VIRT_BASE_ADDR,
> 		.pfn		=__phys_to_pfn(SCU_BASE_ADDR),
> 		.length		= SZ_2M,
> 		.type 		= MT_DEVICE,
> 	},
> 	{
> 		.virtual	= IO_ADDRESS(0),
> 		.pfn		=__phys_to_pfn(0),
> 		.length		= SZ_8M,
> 		.type 		= MT_DEVICE,
> 	},
> };
> 
>    ...
>    iotable_init(hw_io_desc, ARRAY_SIZE(tangox_87xx_io_desc));
> 
> I'll take a much closer look at iotable_init, but I suppose it is
> this function that sets up the TLB? As far as I can see, it is not
> optimal to map 8 MB, because that will take up 8 entries in the TLB,
> whereas 16 MB would take only one (in theory).

Right, it should just map 16 MB.

> > On new platforms, you can't do that because the mach/*.h header
> > files are inaccessible to drivers, so you have to use ioremap.
> 
> What do you mean by new platforms?
> 
> Indeed, the IO_* macros given above are defined in
> arch/arm/mach-tangox/include/mach/io.h

Modern platforms no longer have an include directory and use the
standard definitions. How many other header files do you have in there?

Actually, we also try to get rid of the need for most other files
in mach-* as well, though commonly you need a little bit of code for
bringing up secondary CPU cores. Everything else should be a device
driver.

> But my 3.14 driver does see the header.

That means you don't use CONFIG_ARCH_MULTIPLATFORM. You should ;-)

> >> I'm asking because I have an idea in mind: on the bus, the first
> >> 16 MB contains only memory-mapped registers, so I've been thinking
> >> I can map this region at init, and keep it for the lifetime of the
> >> system. It would use only one entry in the TLB, since the CPU
> >> supports 16 MB super-sections (or whatever they are called).
> >>
> >> I could even lock that entry in the TLB so that these accesses
> >> are guaranteed to never TLB miss, right?
> >
> > The map_io callback will set up a mapping like that, and when
> > a driver calls ioremap on the same physical address, you will
> > get the correct pointer using that TLB, you just don't communicate
> > the address through a pointer any more.
> 
> IIUC, you're saying the current method using iotable_init is not
> appropriate, and I should use the map_io callback?

map_io and iotable_init is the same thing, the former calls the latter.
What I'm saying is that relying on hardcoded virtual addresses is
not appropriate, you can use the iotable_init call to set up a
hugetlb mapping for performance optimization, but it should really
work without that.

	Arnd
