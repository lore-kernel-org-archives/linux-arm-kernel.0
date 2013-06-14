From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Fri, 14 Jun 2013 09:54:17 -0700
Subject: [PATCH] arm: fix pmd flushing in map_init_section
In-Reply-To: <20130614164831.GA3387@e106331-lin.cambridge.arm.com>
References: <1371226942-3189-1-git-send-email-mark.rutland@arm.com>
 <20130614163409.GO3245@lvm>
 <20130614164831.GA3387@e106331-lin.cambridge.arm.com>
Message-ID: <20130614165417.GP3245@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:48:31PM +0100, Mark Rutland wrote:
> On Fri, Jun 14, 2013 at 05:34:09PM +0100, Christoffer Dall wrote:
> > On Fri, Jun 14, 2013 at 05:22:22PM +0100, Mark Rutland wrote:
> > > In e651eab0af: "ARM: 7677/1: LPAE: Fix mapping in alloc_init_section for
> > > unaligned addresses", the pmd flushing was broken when split out to
> > > map_init_section. At the end of the final iteration of the while loop,
> > > pmd will point at the pmd_t immediately after the pmds we updated, and
> > > thus flush_pmd_entry(pmd) won't flush the newly modified pmds. This has
> > > been observed to prevent an 11MPCore system from booting.
> > > 
> > > This patch fixes this by remembering the address of the first pmd we
> > > update and using this as the argument to flush_pmd_entry.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: R Sricharan <r.sricharan@ti.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Christoffer Dall <cdall@cs.columbia.edu>
> > > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Cc: stable at vger.kernel.org
> > > ---
> > >  arch/arm/mm/mmu.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > > index e0d8565..22bc0ff 100644
> > > --- a/arch/arm/mm/mmu.c
> > > +++ b/arch/arm/mm/mmu.c
> > > @@ -620,6 +620,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
> > >  			unsigned long end, phys_addr_t phys,
> > >  			const struct mem_type *type)
> > >  {
> > > +	pmd_t *p = pmd;
> > >  #ifndef CONFIG_ARM_LPAE
> > >  	/*
> > >  	 * In classic MMU format, puds and pmds are folded in to
> > > @@ -638,7 +639,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
> > >  		phys += SECTION_SIZE;
> > >  	} while (pmd++, addr += SECTION_SIZE, addr != end);
> > >  
> > > -	flush_pmd_entry(pmd);
> > > +	flush_pmd_entry(p);
> > >  }
> > >  
> > >  static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
> > > -- 
> > 
> > Refresh my memory here again, why are we not flushing every pmd entry we
> > update?  Is it because we assume the cache lines cover the maximum span
> > between addr and end?
> 
> Yup, we assume a minimum cache line size of 8 bytes. I'm not so keen on this,
> but I suspect others might not be happy with moving the flush into the loop.
> 

A comment on the call to flush_pmd_entry could solve it.

> > 
> > Theoretically, shouldn't you also increment p in the non-LPAE case?
> 
> Yes, I should. v2 shortly...
> 
> Thanks,
> Mark.
