From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Nov 2013 12:26:49 -0500 (EST)
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131126134155.GB16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311252254200.9667@knanqh.ubzr>
 <20131126095430.GA16735@n2100.arm.linux.org.uk>
 <alpine.LFD.2.10.1311260834520.9667@knanqh.ubzr>
 <20131126134155.GB16735@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.10.1311261205300.9667@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:

> On Tue, Nov 26, 2013 at 08:35:43AM -0500, Nicolas Pitre wrote:
> > On Tue, 26 Nov 2013, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Nov 25, 2013 at 10:56:25PM -0500, Nicolas Pitre wrote:
> > > > What about simply doing the following instead, which I'm sure used to 
> > > > work properly at some point:
> > > > 
> > > > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > > > index 9ecccc8650..2b8b8d3236 100644
> > > > --- a/arch/arm/include/asm/memory.h
> > > > +++ b/arch/arm/include/asm/memory.h
> > > > @@ -239,6 +239,14 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> > > >  
> > > >  #else
> > > >  
> > > > +#ifndef PHYS_OFFSET
> > > > +#ifdef PLAT_PHYS_OFFSET
> > > > +#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> > > > +#else
> > > > +#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> > > > +#endif
> > > > +#endif
> > > > +
> > > >  static inline phys_addr_t __virt_to_phys(unsigned long x)
> > > >  {
> > > >  	return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
> > > > @@ -253,14 +261,6 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> > > >  #endif
> > > >  #endif /* __ASSEMBLY__ */
> > > >  
> > > > -#ifndef PHYS_OFFSET
> > > > -#ifdef PLAT_PHYS_OFFSET
> > > > -#define PHYS_OFFSET	PLAT_PHYS_OFFSET
> > > > -#else
> > > > -#define PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
> > > > -#endif
> > > > -#endif
> > > 
> > > And that makes PHYS_OFFSET undefined to assembly code - and we have
> > > references to it from said code.
> > 
> > Why does the kernel compile properly for me with this change then?
> 
> Nicolas,
> 
> Try using grep rather than just typing emails for the hell of it.
> Try looking at the patch I sent to fix this issue.  Either of those
> will give you the appropriate clue necessary to answer your question.

Your patch does s/PHYS_OFFSET/PLAT_PHYS_OFFSET/ in assembly code and 
defines PLAT_PHYS_OFFSET with CONFIG_PHYS_OFFSET when needed.

Mine leaves PHYS_OFFSET as is in assembly code and defines PHYS_OFFSET 
with PLAT_PHYS_OFFSET or CONFIG_PHYS_OFFSET as appropriate, as it *used* 
to work before commit ca5a45c06c.

The reason this commit broke things is because it moved __virt_to_phys() 
and __phys_to_virt() from macros to static inline.  The macro version 
didn't need PHYS_OFFSET to be defined beforehand, which is not the case 
for static inline definitions.  Hence my fix which is to simply move 
(one of) the definition of PHYS_OFFSET above its use by the mentioned 
static inline code.

I also think it is a good thing _not_ to use PLAT_PHYS_OFFSET in 
assembly code.  This was in fact done on purpose.  The simple fact that 
PHYS_OFFSET, with some configuration, expands to something unappropriate 
for assembly code is a perfect mechanism to identify that something is 
wrong with that configuration.  The reason is that no assembly code 
should be using PHYS_OFFSET when CONFIG_PATCH_PHYS_VIRT is defined.  If 
it does then this is wrong.

By moving that assembly code to PLAT_PHYS_OFFSET you are basically 
removing that sanity check mechanism since it might be possible for a 
platform to still define PLAT_PHYS_OFFSET in its mach/memory.h even if 
CONFIG_PATCH_PHYS_VIRT is defined.

So, unless you identify a problem with the patch I sent, I still stand 
by my suggested fix.


Nicolas
