From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 14:12:48 +0100
Subject: Code generation involving __raw_readl and __raw_writel
In-Reply-To: <547720B5.7020904@free.fr>
References: <5476FFA2.8010403@free.fr> <7562945.VT72mKYTjh@wuerfel>
 <547720B5.7020904@free.fr>
Message-ID: <7958894.CNnhBWEkgT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 14:01:41 Mason wrote:
> On 27/11/2014 12:23, Arnd Bergmann wrote:
> 
> > On Thursday 27 November 2014 11:40:34 Mason wrote:
> >
> >> Hello everyone,
> >>
> >> Consider the following code (preprocessor output):
> >>
> >> static int tangox_target(struct cpufreq_policy *policy, unsigned int index)
> >> {
> >>    while (__raw_readl((volatile void *)(0xf0000000 +(0x10024))) >> 31);
> >>    __raw_writel(0, (volatile void *)(0xf0000000 +(0x10024)));
> >>    return 0;
> >> }
> >
> > First of all:
> 
> Disclaimer: I've only recently started writing driver code, so I am
> very grateful for every tip/suggestion I receive. Please note that
> what I provided was *preprocessor output* (to help in diagnosing the
> "C to ASM" translation). The actual code was:
> 
>    while (gbus_read_reg32(SYS_cpuclk_div_ctrl) >> 31);
>    gbus_write_reg32(SYS_cpuclk_div_ctrl, 0);
> 
> these being macro wrappers:
> 
> #define gbus_read_reg32(r)      __raw_readl((volatile void __iomem *)IO_ADDRESS(r))
> #define gbus_write_reg32(r, v)  __raw_writel(v, (volatile void __iomem *)IO_ADDRESS(r))

Right, that's how things used to be done a while ago.

> > - don't use __raw_readl in driver code, use readl or readl_relaxed.
> 
> Can you expand a bit on the differences between these variants?
> __raw_readl, readl, readl_relaxed

__raw_* is for accessing RAM behind a memory-mapped I/O bus,
and will not do any endian-swaps or guarantee atomic access.

readl is the standard way to access an MMIO register

readl_relaxed is like readl, but it does not guarantee synchronization
with device access to DMA buffers, and can be a little faster than
readl.

> Is this an appropriate reference?
> https://www.kernel.org/doc/htmldocs/deviceiobook/index.html
> ( https://lwn.net/Articles/66938/ )
> 
> NB: if it matters, I am accessing memory-mapped registers, across
> a non-standard (I mean not PCI, ISA, etc) memory bus.
> 
> arch/arm/include/asm/io.h defines
> #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) __raw_readl(c)); __r; })
> #define readl(c)         ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> #define ioread32(p)	 ({ unsigned int __v = le32_to_cpu((__force __le32)__raw_readl(p)); __iormb(); __v; })
> static inline u32 __raw_readl(const volatile void __iomem *addr)
> {
> 	u32 val;
> 	asm volatile("ldr %1, %0"
> 		     : "+Qo" (*(volatile u32 __force *)addr),
> 		       "=r" (val));
> 	return val;
> }
> 
> As far as I can tell, readl and ioread32 are equivalent, right?

On arm32 yes. On other architectures, ioread32 may be a little slower
but also take __iomem tokens that were returned from ioport_map()
or pci_iomap() instead of ioremap(). On arm32 those are all pointers
that can be passed into readl.

> > - When you do a busy-loop, add a cpu_relax().
> 
> LDD3 mentions cpu_relax in the context of long delays.
> My busy wait loop has a maximum latency of 60 ?s, and the cpufreq core
> is given this information, so that, typically, execution falls through
> the loop at the first iteration.
> 
> Should I still use cpu_relax? Doesn't that risk adding latency to the
> calling thread?
> 
> On my platform, cpu_relax is defined to a barrier:
> __asm__ __volatile__("": : :"memory")

I would always use it in a busy-loop.

> > - use proper types: 'void __iomem *', not 'volatile void *'.
> 
> The actual code does use the __iomem attribute.
> 
> > - use of_iomap or devm_ioremap_resource to get to the pointer for
> >    a device, don't just hardcode virtual addresses.
> 
> About that. If nothing had been done, 0xf0010024 would be an
> invalid virtual address, and reading from that address would
> generate a TLB miss, right? So something must have configured
> the TLB to accept and translate this address correctly.
> 
> I'm looking for an iomap or ioremap call, right?

The IO_ADDRESS() macro on this platform is probably defined to
match a address range that is set up from a map_io callback in
the platform.

On new platforms, you can't do that because the mach/*.h header
files are inaccessible to drivers, so you have to use ioremap.

> I'm asking because I have an idea in mind: on the bus, the first
> 16 MB contains only memory-mapped registers, so I've been thinking
> I can map this region at init, and keep it for the lifetime of the
> system. It would use only one entry in the TLB, since the CPU
> supports 16 MB super-sections (or whatever they are called).
> 
> I could even lock that entry in the TLB so that these accesses
> are guaranteed to never TLB miss, right?

The map_io callback will set up a mapping like that, and when
a driver calls ioremap on the same physical address, you will
get the correct pointer using that TLB, you just don't communicate
the address through a pointer any more.

> I'm also wondering: why did we choose to map physical address
> PA at virtual address VA = PA + 0xf000000? What happens if I
> map PA at VA = PA? Is it a problem if I "shadow" the 0 page?
> (I imagine it is.)

The address has to be between VMALLOC_START and VMALLOC_END.
0xf0000000 is a typical address for such mappings.

	Arnd
