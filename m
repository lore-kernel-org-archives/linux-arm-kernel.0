From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Nov 2013 13:41:08 -0500 (EST)
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131126173659.GE16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311252254200.9667@knanqh.ubzr>
 <20131126095430.GA16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311260834520.9667@knanqh.ubzr>
 <20131126134155.GB16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311261205300.9667@knanqh.ubzr>
 <20131126173659.GE16735@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.10.1311261323280.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:

> On Tue, Nov 26, 2013 at 12:26:49PM -0500, Nicolas Pitre wrote:
> > On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:
> > 
> > > On Tue, Nov 26, 2013 at 08:35:43AM -0500, Nicolas Pitre wrote:
> > > > On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:
> > > > 
> > > > > On Mon, Nov 25, 2013 at 10:56:25PM -0500, Nicolas Pitre wrote:
> > > > > > What about simply doing the following instead, which I'm sure used to 
> > > > > > work properly at some point:
> > > > > > 
> > > > > > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > > > > > index 9ecccc8650..2b8b8d3236 100644
> > > > > > --- a/arch/arm/include/asm/memory.h
> > > > > > +++ b/arch/arm/include/asm/memory.h
> > > > > > @@ -239,6 +239,14 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> > > > > >  
> > > > > >  #else
> > > > > >  
> > > > > > +#ifndef PHYS_OFFSET
> > > > > > +#ifdef PLAT_PHYS_OFFSET
> > > > > > +#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> > > > > > +#else
> > > > > > +#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> > > > > > +#endif
> > > > > > +#endif
> > > > > > +
> > > > > >  static inline phys_addr_t __virt_to_phys(unsigned long x)
> > > > > >  {
> > > > > >  	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
> > > > > > @@ -253,14 +261,6 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> > > > > >  #endif
> > > > > >  #endif /* __ASSEMBLY__ */
> > > > > >  
> > > > > > -#ifndef PHYS_OFFSET
> > > > > > -#ifdef PLAT_PHYS_OFFSET
> > > > > > -#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> > > > > > -#else
> > > > > > -#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> > > > > > -#endif
> > > > > > -#endif
> > > > > 
> > > > > And that makes PHYS_OFFSET undefined to assembly code - and we have
> > > > > references to it from said code.
> > > > 
> > > > Why does the kernel compile properly for me with this change then?
> > > 
> > > Nicolas,
> > > 
> > > Try using grep rather than just typing emails for the hell of it.
> > > Try looking at the patch I sent to fix this issue.  Either of those
> > > will give you the appropriate clue necessary to answer your question.
> > 
> > Your patch does s/PHYS_OFFSET/PLAT_PHYS_OFFSET/ in assembly code and 
> > defines PLAT_PHYS_OFFSET with CONFIG_PHYS_OFFSET when needed.
> > 
> > Mine leaves PHYS_OFFSET as is in assembly code and defines PHYS_OFFSET 
> > with PLAT_PHYS_OFFSET or CONFIG_PHYS_OFFSET as appropriate, as it *used* 
> > to work before commit ca5a45c06c.
> 
> If manual inspection fails you, try building a nommu or XIP kernel.

All right.  I did a build test of course.  What failed me is the 
difficulty nowdays to have the desired config symbols enabled (or 
left disabled for that matter) without other rules overriding manual 
choices.

I think your patch is therefore the best solution.  However, I'd suggest 
you include this as well to enforce configuration validity:

#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
#undef PLAT_PHYS_OFFSET
#endif

The idea as I explained in my previous email is to prevent wrong usage.


Nicolas
