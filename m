From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 2 Feb 2017 19:31:30 +0900
Subject: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170201180008.GG4756@leverpostej>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
Message-ID: <20170202103129.GE13549@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
> > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> > are meant to be called around kexec_load() in order to protect
> > the memory allocated for crash dump kernel once after it's loaded.
> > 
> > The protection is implemented here by unmapping the region rather than
> > making it read-only.
> > To make the things work correctly, we also have to
> > - put the region in an isolated, page-level mapping initially, and
> > - move copying kexec's control_code_page to machine_kexec_prepare()
> > 
> > Note that page-level mapping is also required to allow for shrinking
> > the size of memory, through /sys/kernel/kexec_crash_size, by any number
> > of multiple pages.
> 
> Looking at kexec_crash_size_store(), I don't see where memory returned
> to the OS is mapped. AFAICT, if the region is protected when the user
> shrinks the region, the memory will not be mapped, yet handed over to
> the kernel for general allocation.

The region is protected only when the crash dump kernel is loaded,
and after that, we are no longer able to shrink the region.

> Surely we need an arch-specific callback to handle that? e.g.
> 
> arch_crash_release_region(unsigned long base, unsigned long size)
> {
> 	/*
> 	 * Ensure the region is part of the linear map before we return
> 	 * it to the OS. We won't unmap this again, so we can use block
> 	 * mappings.
> 	 */
> 	create_pgd_mapping(&init_mm, start, __phys_to_virt(start),
> 			   size, PAGE_KERNEL, false);
> }
> 
> ... which we'd call from crash_shrink_memory() before we freed the
> reserved pages.

All the memory is mapped by my map_crashkernel() at boot time.

> [...]
> 
> > +void arch_kexec_unprotect_crashkres(void)
> > +{
> > +	/*
> > +	 * We don't have to make page-level mappings here because
> > +	 * the crash dump kernel memory is not allowed to be shrunk
> > +	 * once the kernel is loaded.
> > +	 */
> > +	create_pgd_mapping(&init_mm, crashk_res.start,
> > +			__phys_to_virt(crashk_res.start),
> > +			resource_size(&crashk_res), PAGE_KERNEL,
> > +			debug_pagealloc_enabled());
> > +
> > +	flush_tlb_all();
> > +}
> 
> We can lose the flush_tlb_all() here; TLBs aren't allowed to cache an
> invalid entry, so there's nothing to remove from the TLBs.

Ah, yes!

> [...]
> 
> > @@ -538,6 +540,24 @@ static void __init map_mem(pgd_t *pgd)
> >  		if (memblock_is_nomap(reg))
> >  			continue;
> >  
> > +#ifdef CONFIG_KEXEC_CORE
> > +		/*
> > +		 * While crash dump kernel memory is contained in a single
> > +		 * memblock for now, it should appear in an isolated mapping
> > +		 * so that we can independently unmap the region later.
> > +		 */
> > +		if (crashk_res.end &&
> > +		    (start <= crashk_res.start) &&
> > +		    ((crashk_res.end + 1) < end)) {
> > +			if (crashk_res.start != start)
> > +				__map_memblock(pgd, start, crashk_res.start);
> > +
> > +			if ((crashk_res.end + 1) < end)
> > +				__map_memblock(pgd, crashk_res.end + 1, end);
> > +
> > +			continue;
> > +		}
> > +#endif
> 
> This wasn't quite what I had in mind. I had expected that here we would
> isolate the ranges we wanted to avoid mapping (with a comment as to why
> we couldn't move the memblock_isolate_range() calls earlier). In
> map_memblock(), we'd skip those ranges entirely.
> 
> I believe the above isn't correct if we have a single memblock.memory
> region covering both the crashkernel and kernel regions. In that case,
> we'd erroneously map the portion which overlaps the kernel.
> 
> It seems there are a number of subtle problems here. :/

I didn't see any problems, but I will go back with memblock_isolate_range()
here in map_mem().

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.
