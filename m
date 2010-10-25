From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Oct 2010 23:55:36 +0100
Subject: [PATCH] ARM: memblock: set allocation limit for
	MEMBLOCK_ALLOC_ANYWHERE
In-Reply-To: <20101025151513.GB21105@n2100.arm.linux.org.uk>
References: <20101025104800.6961.70715.stgit@e102109-lin.cambridge.arm.com>
	<20101025151513.GB21105@n2100.arm.linux.org.uk>
Message-ID: <1288047336.6035.12.camel@jazztop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, 2010-10-25 at 16:15 +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 25, 2010 at 11:48:00AM +0100, Catalin Marinas wrote:
> > From: Will Deacon <will.deacon@arm.com>
> >
> > Commit e63075a3 removed the explicit MEMBLOCK_REAL_LIMIT #define
> > and introduced the requirement that arch code calls
> > memblock_set_current_limit to ensure that the __va macro can
> > be used on physical addresses returned from memblock_alloc.

[...]

> > diff --git a/arch/arm/include/asm/memblock.h
> b/arch/arm/include/asm/memblock.h
> > index fdbc43b..655b4c4 100644
> > --- a/arch/arm/include/asm/memblock.h
> > +++ b/arch/arm/include/asm/memblock.h
> > @@ -3,9 +3,6 @@
> > 
> >  #ifdef CONFIG_MMU
> >  extern phys_addr_t lowmem_end_addr;
> 
> This doesn't need to be exported anymore.
> 
Thanks for confirming this. I'll remove it from the header file.

> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 72cc529..fd7bb1e 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -753,6 +753,7 @@ static void __init sanity_check_meminfo(void)
> >       int i, j, highmem = 0;
> > 
> >       lowmem_end_addr = __pa(vmalloc_min - 1) + 1;
> > +     memblock_set_current_limit(lowmem_end_addr);
> 
> So this might as well become:
>         memblock_set_current_limit(__pa(vmalloc_min - 1) + 1);

Right. I could also move this call out of sanity_check_meminfo
and into arm_memblock_init now that we don't need lowmem_end_addr
to be initialised. If you're happy with me making that change then
I'll post a revised version to the patch system.

Thanks,

Will
