From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Sep 2011 10:09:31 +0100
Subject: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
In-Reply-To: <201109051635.59927.arnd@arndb.de>
References: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
	<20110822130942.23830.4767.stgit@e102602-lin.cambridge.arm.com>
	<201109051635.59927.arnd@arndb.de>
Message-ID: <20110908090931.GD14953@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

Please can you answer Arnd's concerns.  He's right that these points
have been brought up before, they've also been discussed on the list
a number of times with regards to other platforms too.

Note that Arnd sent a follow-up email to the one below correcting a
small mistake in his comments.

Thanks.

On Mon, Sep 05, 2011 at 04:35:59PM +0200, Arnd Bergmann wrote:
> On Monday 22 August 2011, Colin Tuckley wrote:
> > This patch adds the memory map PCI support to the include
> > files for the Realview Northbridge based boards.
> > 
> > Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Hi Colin,
> 
> I think we've discussed this before. I think it's good to
> have PCI support enabled in realview, but please do the
> PIO window properly.
> 
> > diff --git a/arch/arm/mach-realview/include/mach/hardware.h b/arch/arm/mach-realview/include/mach/hardware.h
> > index 8a638d1..dcc64f2 100644
> > --- a/arch/arm/mach-realview/include/mach/hardware.h
> > +++ b/arch/arm/mach-realview/include/mach/hardware.h
> > +/*
> > + * PCI space physical addresses and sizes
> > + */
> > +#define REALVIEW_PB_PCI_BASE		0x90040000	/* PCI-X Unit base */
> > +#define REALVIEW_PB_PCI_BASE_SIZE	0x00010000	/* 4 Kb + 60Kb reserved */
> > +#define REALVIEW_PB_PCI_IO_BASE		0x90050000	/* IO Region on AHB */
> > +#define REALVIEW_PB_PCI_IO_SIZE		0x00010000	/* 64 Kb */
> > +#define REALVIEW_PB_PCI_IO_LIMIT       (REALVIEW_PB_PCI_IO_BASE + REALVIEW_PB_PCI_IO_SIZE - 1)
> > +#define REALVIEW_PB_PCI_MEM_BASE	0xA0000000	/* MEM Region on AHB */
> > +#define REALVIEW_PB_PCI_MEM_SIZE	0x20000000	/* 512 MB */
> > +
> > +#define REALVIEW_ISSP_REG_BASE		0x100E3000
> 
> As you write here, the I/O window size is 64KB, which is totally normal
> for PCI buses.
> 
> > +#ifdef CONFIG_PCI
> > +#if !defined(__ASSEMBLY__)
> > +static inline unsigned int pcibios_min_io(void)
> > +{
> > +	if (machine_is_realview_pb11mp() || machine_is_realview_pba8() ||
> > +	    machine_is_realview_pbx())
> > +		return REALVIEW_PB_PCI_IO_BASE;
> > +	else
> > +		return 0;
> > +}
> 
> pcibios_min_io should be 0x1000 as a constant, in order to get the
> ISA addresses out of the way, but there is no need to make it
> board dependent.
> 
> > +static inline unsigned int pcibios_min_mem(void)
> > +{
> > +	if (machine_is_realview_pb11mp() || machine_is_realview_pba8() ||
> > +	    machine_is_realview_pbx())
> > +		return REALVIEW_PB_PCI_MEM_BASE;
> > +	else
> > +		return 0;
> > +}
> > +#endif
> 
> Just hardcode this to REALVIEW_PB_PCI_MEM_BASE
> 
> > diff --git a/arch/arm/mach-realview/include/mach/io.h b/arch/arm/mach-realview/include/mach/io.h
> > index f05bcdf..aa97d18 100644
> > --- a/arch/arm/mach-realview/include/mach/io.h
> > +++ b/arch/arm/mach-realview/include/mach/io.h
> > @@ -20,9 +20,25 @@
> >  #ifndef __ASM_ARM_ARCH_IO_H
> >  #define __ASM_ARM_ARCH_IO_H
> >  
> > +#include <asm/mach-types.h>
> > +#include <mach/hardware.h>
> > +
> >  #define IO_SPACE_LIMIT 0xffffffff
> 
> The IO_SPACE_LIMIT should match the REALVIEW_PB_PCI_IO_BASE above.
> 
> > -#define __io(a)		__typesafe_io(a)
> > +static inline void __iomem *__io(unsigned long addr)
> > +{
> > +#ifdef CONFIG_PCI
> > +	/* check for PCI I/O space */
> > +	if (addr >= REALVIEW_PB_PCI_IO_BASE && addr <= REALVIEW_PB_PCI_IO_LIMIT)
> > +		return (void __iomem *)((addr - REALVIEW_PB_PCI_IO_BASE) + REALVIEW_PCI_IO_VBASE);
> > +	else
> > +		return (void __iomem *)addr;
> > +#else
> > +	return (void __iomem *)addr;
> > +#endif
> > +}
> 
> And there is no need to do these tricks when you only have a single
> PCI bus. Just define the PIO window to be based on zero and 64K
> in size, and hardcode that, to end up with
> 
> #define __io(a)  (REALVIEW_PCI_IO_VBASE + (a & IO_SPACE_LIMIT))
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
