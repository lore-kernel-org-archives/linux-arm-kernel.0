From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Nov 2013 08:35:43 -0500 (EST)
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131126095430.GA16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311252254200.9667@knanqh.ubzr>
 <20131126095430.GA16735@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.10.1311260834520.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:

> On Mon, Nov 25, 2013 at 10:56:25PM -0500, Nicolas Pitre wrote:
> > What about simply doing the following instead, which I'm sure used to 
> > work properly at some point:
> > 
> > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > index 9ecccc8650..2b8b8d3236 100644
> > --- a/arch/arm/include/asm/memory.h
> > +++ b/arch/arm/include/asm/memory.h
> > @@ -239,6 +239,14 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> >  
> >  #else
> >  
> > +#ifndef PHYS_OFFSET
> > +#ifdef PLAT_PHYS_OFFSET
> > +#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> > +#else
> > +#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> > +#endif
> > +#endif
> > +
> >  static inline phys_addr_t __virt_to_phys(unsigned long x)
> >  {
> >  	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
> > @@ -253,14 +261,6 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> >  #endif
> >  #endif /* __ASSEMBLY__ */
> >  
> > -#ifndef PHYS_OFFSET
> > -#ifdef PLAT_PHYS_OFFSET
> > -#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> > -#else
> > -#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> > -#endif
> > -#endif
> 
> And that makes PHYS_OFFSET undefined to assembly code - and we have
> references to it from said code.

Why does the kernel compile properly for me with this change then?


Nicolas
