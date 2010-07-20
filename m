From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Jul 2010 13:09:35 +0200
Subject: =?iso-8859-1?q?=5BRFC=5D=A0arm=3A_versatile=3A_enable_PCI_I/O?= space
In-Reply-To: <20100720095940.GA32702@n2100.arm.linux.org.uk>
References: <201007201123.38709.arnd@arndb.de>
	<20100720095940.GA32702@n2100.arm.linux.org.uk>
Message-ID: <201007201309.36898.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 July 2010, Russell King - ARM Linux wrote:
> On Tue, Jul 20, 2010 at 11:23:38AM +0200, Arnd Bergmann wrote:
> > -/* macro to get at IO space when running virtually */
> > +/* macro to get at MMIO space when running virtually */
> >  #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
> >  
> > -#define __io_address(n)		__io(IO_ADDRESS(n))
> > +#define __io_address(n)		__typesafe_io(IO_ADDRESS(n))
> 
> Hmm, that's not a scenario that I forsaw __typesafe_io() being used -
> I'd prefer it to be restricted to only aliasing __io() to if it's
> appropriate.  Either add an IOMEM() definition or open-code the cast
> here.

Yes, that's what I thought, but I didn't want to change too much.
Thanks for the confirmation. The same pattern is also present in
other platforms, I'll follow up with a patch to fix them all.

> > diff --git a/arch/arm/mach-versatile/include/mach/io.h b/arch/arm/mach-versatile/include/mach/io.h
> > index f067c14..a276171 100644
> > --- a/arch/arm/mach-versatile/include/mach/io.h
> > +++ b/arch/arm/mach-versatile/include/mach/io.h
> > @@ -20,9 +20,12 @@
> >  #ifndef __ASM_ARM_ARCH_IO_H
> >  #define __ASM_ARM_ARCH_IO_H
> >  
> > -#define IO_SPACE_LIMIT 0xffffffff
> > +#include <mach/hardware.h>
> > +#include <mach/platform.h>
> >  
> > -#define __io(a)		__typesafe_io(a)
> > +#define IO_SPACE_LIMIT (VERSATILE_PCI_MEM_BASE0_SIZE - 1)
> > +
> > +#define __io(a)		(a + VERSATILE_PCI_VIRT_MEM_BASE0)
> 
> Not quite.  Have a look at arch/arm/mach-footbridge/include/mach/io.h to
> see how __io is defined there.

The result is basically the same. My idea was to only define
VERSATILE_PCI_VIRT_MEM_BASE0 in one place and use it in both the place
where it get mapped and in the place where it gets used.

If I use the same definition as footbridge (which looks sensible,
#define __io(a)     ((void __iomem *)(PCIO_BASE + (a))) ),
should I do 

a)
mach-versatile/include/mach/io.h:
#define PCIO_BASE                ((unsigned long)VERSATILE_PCI_VIRT_MEM_BASE0)
mach-versatile/include/mach/hardware.h:
#define VERSATILE_PCI_VIRT_MEM_BASE0 ((void __iomem *)0xeb000000ul)

or b)
mach-versatile/include/mach/io.h:
#define PCIO_BASE                0xeb000000ul
mach-versatile/include/mach/hardware.h:
#define VERSATILE_PCI_VIRT_MEM_BASE0 ((void __iomem *)PCIO_BASE)


Thanks for the review!

	Arnd
