From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Nov 2018 19:31:40 +0000
Subject: [PATCH v2] arm64/mm: unmap the linear alias of module allocations
In-Reply-To: <CAKv+Gu-G+qced2Cyx9UHx2DPxVC+ignft6azYLcmUzAtPCW8XA@mail.gmail.com>
References: <20180711170426.11133-1-ard.biesheuvel@linaro.org>
 <20181101151702.GF15788@arm.com>
 <CAKv+Gu-G+qced2Cyx9UHx2DPxVC+ignft6azYLcmUzAtPCW8XA@mail.gmail.com>
Message-ID: <20181105193139.GA25195@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 01:29:34PM +0100, Ard Biesheuvel wrote:
> On 1 November 2018 at 16:17, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Jul 11, 2018 at 07:04:26PM +0200, Ard Biesheuvel wrote:
> >> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> >> index 97d0ef12e2ff..f16f0073642b 100644
> >> --- a/arch/arm64/include/asm/module.h
> >> +++ b/arch/arm64/include/asm/module.h
> >> @@ -91,4 +91,10 @@ static inline bool plt_entries_equal(const struct plt_entry *a,
> >>              a->mov2 == b->mov2;
> >>  }
> >>
> >> +#ifdef CONFIG_STRICT_KERNEL_RWX
> >> +void remap_linear_module_alias(void *module_region, bool ro);
> >> +#else
> >> +static inline void remap_linear_module_alias(void *module_region, bool ro) {}
> >> +#endif
> >> +
> >>  #endif /* __ASM_MODULE_H */
> >> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> >> index f0f27aeefb73..2b61ca0285eb 100644
> >> --- a/arch/arm64/kernel/module.c
> >> +++ b/arch/arm64/kernel/module.c
> >> @@ -26,10 +26,51 @@
> >>  #include <linux/mm.h>
> >>  #include <linux/moduleloader.h>
> >>  #include <linux/vmalloc.h>
> >> +#include <linux/workqueue.h>
> >>  #include <asm/alternative.h>
> >>  #include <asm/insn.h>
> >>  #include <asm/sections.h>
> >>
> >> +#ifdef CONFIG_STRICT_KERNEL_RWX
> >> +
> >> +static struct workqueue_struct *module_free_wq;
> >> +
> >> +static int init_workqueue(void)
> >> +{
> >> +     module_free_wq = alloc_ordered_workqueue("module_free_wq", 0);
> >> +     WARN_ON(!module_free_wq);
> >> +
> >> +     return 0;
> >> +}
> >> +pure_initcall(init_workqueue);
> >> +
> >> +static void module_free_wq_worker(struct work_struct *work)
> >> +{
> >> +     remap_linear_module_alias(work, false);
> >> +     vfree(work);
> >> +}
> >> +
> >> +void module_memfree(void *module_region)
> >> +{
> >> +     struct work_struct *work;
> >> +
> >> +     if (!module_region)
> >> +             return;
> >> +
> >> +     /*
> >> +      * At this point, module_region is a pointer to an allocation of at
> >> +      * least PAGE_SIZE bytes that is mapped read-write. So instead of
> >> +      * allocating memory for a data structure containing a work_struct
> >> +      * instance and a copy of the value of module_region, just reuse the
> >> +      * allocation directly.
> >> +      */
> >> +     work = module_region;
> >> +     INIT_WORK(work, module_free_wq_worker);
> >> +     queue_work(module_free_wq, work);
> >> +}
> >
> > Whilst I can see that this works, it's a bit grotty because we're
> > duplicating much of the hoop-jumping that vfree() also has to go through.
> > Given that we allocate the module memory in the arch code, could we grab
> > the pages at alloc time and stash them in the mod_arch_specific field?
> >
> 
> Yeah that should work

Great!

> >> +#endif
> >> +
> >>  void *module_alloc(unsigned long size)
> >>  {
> >>       gfp_t gfp_mask = GFP_KERNEL;
> >> @@ -65,6 +106,7 @@ void *module_alloc(unsigned long size)
> >>               return NULL;
> >>       }
> >>
> >> +     remap_linear_module_alias(p, true);
> >>       return p;
> >>  }
> >>
> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> >> index 493ff75670ff..5492b691aafd 100644
> >> --- a/arch/arm64/mm/mmu.c
> >> +++ b/arch/arm64/mm/mmu.c
> >> @@ -432,7 +432,7 @@ static void __init map_mem(pgd_t *pgdp)
> >>       struct memblock_region *reg;
> >>       int flags = 0;
> >>
> >> -     if (debug_pagealloc_enabled())
> >> +     if (rodata_enabled || debug_pagealloc_enabled())
> >>               flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> > I suppose this is the most contentious part of the patch. Perhaps a
> > better solution would be to tweak CONFIG_STRICT_MODULE_RWX so that it's
> > structured more like CONFIG_STACKPROTECTOR. That way, your patch here
> > could be the "strong" version, which comes with more of a performance
> > cost.
> >
> 
> I'd like to understand whether this performance hit is theoretical or
> not. It is obviously less efficient to map the linear region at page
> granularity, but which workloads will actually notice the difference?
> 
> Also, I think this should be a runtime setting, perhaps rodata=full?
> With a CONFIG_ option to set the default.

Yes, that's a better idea. We could even default to "full" if we don't have
any performance data (if people start shouting then we'll know it's an
issue!).

Do you plan to spin a v2?

Will
