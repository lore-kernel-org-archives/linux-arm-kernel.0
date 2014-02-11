From: steve.capper@linaro.org (Steve Capper)
Date: Tue, 11 Feb 2014 16:08:17 +0000
Subject: [RFC PATCH V2 3/4] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <20140211154229.GF3748@arm.com>
References: <1391703531-12845-1-git-send-email-steve.capper@linaro.org>
 <1391703531-12845-4-git-send-email-steve.capper@linaro.org>
 <20140211154229.GF3748@arm.com>
Message-ID: <20140211160816.GA16371@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 03:42:29PM +0000, Catalin Marinas wrote:
> Hi Steve,
> 
> On Thu, Feb 06, 2014 at 04:18:50PM +0000, Steve Capper wrote:
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 6d4dd22..129bd6a 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -28,6 +28,7 @@ config ARM64
> >  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
> >  	select HAVE_MEMBLOCK
> >  	select HAVE_PERF_EVENTS
> > +	select HAVE_RCU_TABLE_FREE
> >  	select IRQ_DOMAIN
> >  	select MODULES_USE_ELF_RELA
> >  	select NO_BOOTMEM
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index 717031a..8999823 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -27,12 +27,33 @@
> >  
> >  #define MMU_GATHER_BUNDLE	8
> >  
> > +static inline void __tlb_remove_table(void *_table)
> > +{
> > +	free_page_and_swap_cache((struct page *)_table);
> > +}
> 
> I think you can reduce your patch to just the above (and a linux/swap.h
> include) after the arm64 conversion to generic mmu_gather below.
> 
> I cc'ed Peter Z for a sanity check, some of the code is close to
> https://lkml.org/lkml/2011/3/7/302, only that it's under arch/arm64.
> 
> And, of course, it needs a lot more testing.

Okay, cheers Catalin, I'll give that a go.

Cheers,
-- 
Steve
