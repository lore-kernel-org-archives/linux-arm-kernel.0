From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 22 Apr 2014 11:00:19 -0600
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <535681A4.1080402@monstr.eu>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com>
 <535681A4.1080402@monstr.eu>
Message-ID: <20140422170019.GA23955@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > index 8756e4b..551e971 100644
> > +++ b/arch/arm/include/asm/memory.h
> > @@ -350,7 +350,7 @@ static inline __deprecated void *bus_to_virt(unsigned long x)
> >  #define virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory) \
> >  					&& pfn_valid(__pa(kaddr) >> PAGE_SHIFT) )
> >  
> > -#endif
> > +#endif /* __ASSEMBLY__ */

> This is unrelated change.

Right, as I said it needs some cleanup :) This is left overs from
rebasing to 3.14 - the original had to carry some small changes to
memory.h as well, but now that we have PLAT_PHYS_OFFSET that isn't
necessary.
 
> > @@ -43,7 +50,7 @@
> >  #endif
> >  
> >  OUTPUT_ARCH(arm)
> > -ENTRY(stext)
> > +ENTRY(phys_start)
> >  
> >  #ifndef __ARMEB__
> >  jiffies = jiffies_64;
> > @@ -86,11 +93,13 @@ SECTIONS
> >  #else
> >  	. = PAGE_OFFSET + TEXT_OFFSET;
> >  #endif
> > -	.head.text : {
> > +	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
> >  		_text = .;
> > +		phys_start = . - LOAD_OFFSET;
> >  		HEAD_TEXT
> >  	}
> 
> I am not quite about these changes above but Russell can comment it.

This is adjusting the entry point address in the ELF.

I have copied what other arch's are doing and used the physical
address as the entry address (see x86, ia64).

Jason
