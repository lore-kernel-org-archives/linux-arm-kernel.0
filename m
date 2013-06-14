From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Jun 2013 18:28:58 +0100
Subject: [PATCH] arm: fix pmd flushing in map_init_section
In-Reply-To: <20130614163409.GO3245@lvm>
References: <1371226942-3189-1-git-send-email-mark.rutland@arm.com>
 <20130614163409.GO3245@lvm>
Message-ID: <20130614172858.GS29271@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:34:09PM +0100, Christoffer Dall wrote:
> On Fri, Jun 14, 2013 at 05:22:22PM +0100, Mark Rutland wrote:
> > In e651eab0af: "ARM: 7677/1: LPAE: Fix mapping in alloc_init_section for
> > unaligned addresses", the pmd flushing was broken when split out to
> > map_init_section. At the end of the final iteration of the while loop,
> > pmd will point at the pmd_t immediately after the pmds we updated, and
> > thus flush_pmd_entry(pmd) won't flush the newly modified pmds. This has
> > been observed to prevent an 11MPCore system from booting.
> > 
> > This patch fixes this by remembering the address of the first pmd we
> > update and using this as the argument to flush_pmd_entry.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: R Sricharan <r.sricharan@ti.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Christoffer Dall <cdall@cs.columbia.edu>
> > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > Cc: stable at vger.kernel.org
> > ---
> >  arch/arm/mm/mmu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index e0d8565..22bc0ff 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -620,6 +620,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
> >  			unsigned long end, phys_addr_t phys,
> >  			const struct mem_type *type)
> >  {
> > +	pmd_t *p = pmd;
> >  #ifndef CONFIG_ARM_LPAE
> >  	/*
> >  	 * In classic MMU format, puds and pmds are folded in to
> > @@ -638,7 +639,7 @@ static void __init map_init_section(pmd_t *pmd, unsigned long addr,
> >  		phys += SECTION_SIZE;
> >  	} while (pmd++, addr += SECTION_SIZE, addr != end);
> >  
> > -	flush_pmd_entry(pmd);
> > +	flush_pmd_entry(p);
> >  }
> >  
> >  static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
> > -- 
> 
> Refresh my memory here again, why are we not flushing every pmd entry we
> update?  Is it because we assume the cache lines cover the maximum span
> between addr and end?
> 
> Theoretically, shouldn't you also increment p in the non-LPAE case?

It wouldn't make any difference. With classic MMU we assume that we
write 2 pmds at the same time (to form a pgd covering 2MB) but the above
increment is a workaround to only allow 1MB section mappings. Either
way, it's harmless.

-- 
Catalin
