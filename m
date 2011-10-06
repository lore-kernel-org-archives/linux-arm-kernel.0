From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Thu, 6 Oct 2011 15:00:50 +0100
Subject: [PATCH 1/3 v3] ARM Realview PCIX map include file changes
In-Reply-To: <201109051635.59927.arnd@arndb.de>
References: <20110822130507.23830.26191.stgit@e102602-lin.cambridge.arm.com>
	<20110822130942.23830.4767.stgit@e102602-lin.cambridge.arm.com>
	<201109051635.59927.arnd@arndb.de>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA47375AC1794@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Subject: Re: [PATCH 1/3 v3] ARM Realview PCIX map include file changes

Sorry it's taken a while to get back to you on this.

> I think we've discussed this before. I think it's good to
> have PCI support enabled in realview, but please do the
> PIO window properly.

I think Catalin wrote that bit originally.

> > diff --git a/arch/arm/mach-realview/include/mach/hardware.h
> b/arch/arm/mach-realview/include/mach/hardware.h

> As you write here, the I/O window size is 64KB, which is totally normal
> for PCI buses.
>
> > +#ifdef CONFIG_PCI
> > +#if !defined(__ASSEMBLY__)
> > +static inline unsigned int pcibios_min_io(void)
> > +{
> > +   if (machine_is_realview_pb11mp() || machine_is_realview_pba8() ||
> > +       machine_is_realview_pbx())
> > +           return REALVIEW_PB_PCI_IO_BASE;
> > +   else
> > +           return 0;
> > +}
>
> pcibios_min_io should be 0x1000 as a constant, in order to get the
> ISA addresses out of the way, but there is no need to make it
> board dependent.

REALVIEW_PB_PCI_IO_BASE is currently 0x90050000, which works, so why would I change pcibios_min_io to 0x1000 ?

>
> > +static inline unsigned int pcibios_min_mem(void)
> > +{
> > +   if (machine_is_realview_pb11mp() || machine_is_realview_pba8() ||
> > +       machine_is_realview_pbx())
> > +           return REALVIEW_PB_PCI_MEM_BASE;
> > +   else
> > +           return 0;
> > +}
> > +#endif
>
> Just hardcode this to REALVIEW_PB_PCI_MEM_BASE

OK.

> >  #define IO_SPACE_LIMIT 0xffffffff
>
> The IO_SPACE_LIMIT should match the REALVIEW_PB_PCI_IO_SIZE above.

Agreed.

> > -#define __io(a)            __typesafe_io(a)
> > +static inline void __iomem *__io(unsigned long addr)
> > +{
> > +#ifdef CONFIG_PCI
> > +   /* check for PCI I/O space */
> > +   if (addr >= REALVIEW_PB_PCI_IO_BASE && addr <=
> REALVIEW_PB_PCI_IO_LIMIT)
> > +           return (void __iomem *)((addr - REALVIEW_PB_PCI_IO_BASE) +
> REALVIEW_PCI_IO_VBASE);
> > +   else
> > +           return (void __iomem *)addr;
> > +#else
> > +   return (void __iomem *)addr;
> > +#endif
> > +}
>
> And there is no need to do these tricks when you only have a single
> PCI bus. Just define the PIO window to be based on zero and 64K
> in size, and hardcode that, to end up with
>
> #define __io(a)  (REALVIEW_PCI_IO_VBASE + (a & IO_SPACE_LIMIT))

I tried this, the kernel fails to boot! Can you explain how you think your version works please?

Colin


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
