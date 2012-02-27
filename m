From: robherring2@gmail.com (Rob Herring)
Date: Mon, 27 Feb 2012 16:31:24 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <201202140804.49026.arnd@arndb.de>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <201202140203.15360.arnd@arndb.de> <4F39CCE0.200@gmail.com>
 <201202140804.49026.arnd@arndb.de>
Message-ID: <4F4C043C.3030407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2012 02:04 AM, Arnd Bergmann wrote:
> On Tuesday 14 February 2012, Rob Herring wrote:
>> Arnd,
>>
>> On 02/13/2012 08:03 PM, Arnd Bergmann wrote:
>>> On Monday 13 February 2012, Russell King - ARM Linux wrote:
>>>> On Mon, Feb 13, 2012 at 03:43:26PM -0600, Rob Herring wrote:
>>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>>
>>>>> Add a kconfig option NEED_MACH_IO_H to conditionally include mach/io.h.
>>>>>
>>>>> Basing this on CONFIG_PCI and CONFIG_ISA doesn't quite work. Most ISA
>>>>> platforms don't need mach/io.h, but ebsa110 does.
>>>>
>>>> This is architecturally wrong.  If you have ISA, and your __io() macro
>>>> is essentially a 1:1 translation, you're asking for ISA drivers to
>>>> scribble on whatever is at virtual address 0-64K.  Too bad if that
>>>> happens to be where your CPU vectors are stored, you'll lose control
>>>> of the CPU in that case.
>>>
>>> Right. I still think it should be conditional on PCI || ISA || PCMCIA,
>>> not introducing a new kconfig symbol, and the next step should be to
>>> unify the __io() implementations for the platforms that need them.
>>
>> As we discussed at Connect, that was my original intent. However, there
>> are a couple of issues as NEED_MACH_IO_H is not exactly equivalent to
>> PCI || ISA || PCMCIA.
>>
>> There are a few platforms which still need io.h for custom accessor
>> functions: rpc, ixp4xx, s3c2410, and ebsa110.
> 
> I've tried to interpret what is there, please correct me if this is wrong:
> 
> RPC and ebsa110 have ISA, or some twisted version of that. I believe
> RPC doesn't select CONFIG_ISA because it has no actual ISA slots but
> it still uses legacy ISA I/O and we might just select it anyway.
> 
> s3c24xx seems to have ISA in a similar way on the "bast" machine,
> while the setup code for that got copied into some platforms that
> don't really require it.
> 
> ixp4xx has PCI, but does not always use direct MMIO to access the
> memory or I/O spaces.
> 
> I guess the only way we can ever make these ones use a common header
> file (in case we care) by letting them go through an indirect
> struct io_ops { u8 (*inb)(int); void (*outb)(u8, int); ... };,
> but we might not care enough.
> 
>> Also, a few platforms that
>> only select ISA don't do any translation in __io(). These are sa1100,
>> clps711x, and pxa. My understanding is that is wrong.
> 
> sa1100 has pcmcia slots that use their own method (setting io_offset)
> of redirecting the i/o space into the right location. As Russell
> mentioned, this is broken if you load an ISA device driver that
> uses hardcoded port numbers, or as I might add when you use /dev/port.
> 
> pxa seems to do the same as sa1100 for PCMCIA and PCI, but I can't figure
> out what they do for ISA. I suspect they only enable that in order to
> get ISA device drivers for PCMCIA based add-on cards.
> 
> clps711x for all I can tell is broken as you say.
> 
> I think omap1 and at91 fit into the same category as sa1100 and pxa
> regarding pcmcia. All four can in theory be converted to use a
> common virtual mapping as we want to have for PCI.
> 
>> If we use CONFIG_PCI, then we have to move over all PCI enabled
>> platforms at once. With a separate kconfig option, then we can move
>> platforms one by one. Some are legacy and we may not want to move. This
>> also helped with omap, but Tony has now fixed it.
> 
> We could also generalize the implementation from tegra, which seems
> reasonable as a start:
> 
> 
> #define IO_SPACE_LIMIT 0xffff
> 
> #if defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> #include <mach/io.h>
> #elif defined(CONFIG_PCI)
> extern void __iomem *pci_io_base;
> 
> static inline void __iomem *__io(unsigned long addr)
> {
>         return pci_io_base + (addr & IO_SPACE_LIMIT);
> }
> #else
> static inline void __iomem *__io(unsigned long addr)
> {
>         return NULL;
> }
> #endif
> #define __io(a) __io(a)
> 
> Out of the platforms supporting PCI right now, we currently have these three classes:
> 
> 1. portable, but using different virtual addresses:
> arch/arm/mach-integrator/include/mach/io.h:#define __io(a)                      ((void __iomem *)(PCI_IO_VADDR + (a)))
> arch/arm/mach-ixp23xx/include/mach/io.h:#define __io(p)         ((void __iomem*)((p) + IXP23XX_PCI_IO_VIRT))
> arch/arm/mach-ixp2000/include/mach/io.h:#define __io(p)                 ((void __iomem *)((p)+IXP2000_PCI_IO_VIRT_BASE))
> arch/arm/mach-shark/include/mach/io.h:#define __io(a)                 ((void __iomem *)(0xe0000000 + (a)))
> arch/arm/mach-footbridge/include/mach/io.h:#define __io(a)                      ((void __iomem *)(PCIO_BASE + (a)))
> arch/arm/mach-tegra/include/mach/io.h:static inline void __iomem *__io(unsigned long addr)
> arch/arm/mach-kirkwood/include/mach/io.h:static inline void __iomem *__io(unsigned long addr)
> arch/arm/mach-dove/include/mach/io.h:#define __io(a)    ((void __iomem *)(((a) - DOVE_PCIE0_IO_BUS_BASE) + \
> 
> 2. Does not map the I/O space, or does not use it -- I cannot see how
>    any of these use PIO based PCI devices at all, probably broken already:
> arch/arm/mach-cns3xxx/include/mach/io.h:#define __io(a)                 __typesafe_io(a)
> arch/arm/mach-ixp4xx/include/mach/io.h:#define  __io(v)         __typesafe_io(v)
> arch/arm/mach-ks8695/include/mach/io.h:#define __io(a)          __typesafe_io(a)
> arch/arm/mach-orion5x/include/mach/io.h:#define __io(a)                 __typesafe_io(a)
> arch/arm/mach-sa1100/include/mach/io.h:#define __io(a)          __typesafe_io(a)
> arch/arm/mach-pxa/include/mach/io.h:#define __io(a)             __typesafe_io(a)
> arch/arm/mach-versatile/include/mach/io.h:#define __io(a)               __typesafe_io(a)
> 
> 3. scary multi-way translation, needs someone to really understand (Nico?, Lennert?)
> arch/arm/mach-iop32x/include/mach/io.h:#define __io(p)          ((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
> arch/arm/mach-iop33x/include/mach/io.h:#define __io(p)          ((void __iomem *)IOP3XX_PCI_IO_PHYS_TO_VIRT(p))
> arch/arm/mach-iop13xx/include/mach/io.h:#define __io(a) __iop13xx_io(a)
> arch/arm/mach-mv78xx0/include/mach/io.h:static inline void __iomem *__io(unsigned long addr)

It seems iop3xx and mv78xx0 are just setting the PCI bus address to the
local bus address. The OIOWTVR register controls local bus to PCI
address translation. It is set to 0x90000000 which is effectively no
translation. But don't we really want 0x9000xxxx local bus translated to
0x0000xxxx PCI bus? Then the io resource region is setup for 0x9000xxxx
as well. If both the PCI bus address and i/o resources are moved to 0x0
that should make these category 1.

Also, you've left off ixp4xx from this list. It has PCI and needs io.h,
so fixing all the PCI platforms above will not make using CONFIG_PCI,
ISA or PCMCIA to include mach/io.h or not work. However, if indirect io
is all that io.h is needed for then perhaps a config option called
NEEDS_INDIRECT_IO would be a better name.

Rob
