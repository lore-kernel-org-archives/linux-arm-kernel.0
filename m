From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Apr 2015 18:36:56 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
Message-ID: <20150408173656.GF5977@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Apr 08, 2015 at 10:45:30AM +0100, Russell King wrote:
> Re-implement the physical address space switching to be architecturally
> complaint.  This involves flushing the caches, disabling the MMU, and
> only then updating the page tables.  Once that is complete, the system
> can be brought back up again.
> 
> Since we disable the MMU, we need to do the update in assembly code.
> Luckily, the entries which need updating are fairly trivial, and are
> all setup by the early assembly code.  We can merely adjust each entry
> by the delta required.
> 
> Not only does htis fix the code to be architecturally compliant, but it
> fixes a couple of bugs too:

Nit: s/htis/this/

[...]

> -       /*
> -        * Ensure that the above updates are flushed out of the cache.
> -        * This is not strictly correct; on a system where the caches
> -        * are coherent with each other, but the MMU page table walks
> -        * may not be coherent, flush_cache_all() may be a no-op, and
> -        * this will fail.
> +        * We changing not only the virtual to physical mapping, but
> +        * also the physical addresses used to access memory.  We need
> +        * to flush all levels of cache in the system with caching
> +        * disabled to ensure that all data is written back.  We do this
> +        * with caching and write buffering disabled to ensure that
> +        * nothing is speculatively prefetched.
>          */
> +       cr = get_cr();
> +       set_cr(cr & ~(CR_I | CR_C | CR_W));

SCTLR[3] (CR_W) is RAO/SBOP in VMSAv7. I don't think we should clear it
here for ARMv7.

To the best of my knowledge, the page table walkers aren't affected by
SCTLR.C, and use the attributes in TTBR{0,1} or TTBCR when translation
is active (i.e. when SCTLR.M is set). So at this point they can make
cacheable accesses to the page tables (and allocate into the caches) in
the background...

>         flush_cache_all();

...meaning this flush may not leave the caches empty, at least for
memory regions containing page tables. Stale lines could mask updates
made in lpae_pgtables_remap_asm.

I think that the cache flush needs to be performed after both
SCTLR.{C,M} are cleared in lpae_pgtables_remap_asm, just before the page
table updates. So long as the relevant pieces of kernel text are
initially clean to the PoC, we shouldn't need to flush anything
beforehand.


> 
>         /*
> -        * Re-write the TTBR values to point them at the high physical
> -        * alias of the page tables.  We expect __va() will work on
> -        * cpu_get_pgd(), which returns the value of TTBR0.
> +        * Fixup the page tables - this must be in the idmap region as
> +        * we need to disable the MMU to do this safely, and hence it
> +        * needs to be assembly.  It's fairly simple, as we're using the
> +        * temporary tables setup by the initial assembly code.
>          */
> -       cpu_switch_mm(pgd0, &init_mm);
> -       cpu_set_ttbr(1, __pa(pgd0) + TTBR1_OFFSET);
> +       lpae_pgtables_remap(offset, pa_pgd, boot_data);
> 
> -       /* Finally flush any stale TLB values. */
> -       local_flush_bp_all();
> -       local_flush_tlb_all();
> +       /* Re-enable the caches */
> +       set_cr(cr);

That being the case there's no reason to restore M and C separately on
the return path either.

[...]

> +ENTRY(lpae_pgtables_remap_asm)
> +       stmfd   sp!, {r4-r8, lr}
> +
> +       mrc     p15, 0, r8, c1, c0, 0           @ read control reg
> +       bic     ip, r8, #CR_M                   @ disable caches and MMU
> +       mcr     p15, 0, ip, c1, c0, 0
> +       dsb
> +       isb

Shouldn't the DSB be between the STMFD and the MCR (given the SP doesn't
point to an idmap/physical address)?

I don't see why we need a DSB after the write to the SCTLR.

[...]

> +       dsb
> +       isb
> +
> +       mcr     p15, 0, r8, c1, c0, 0           @ re-enable MMU
> +       dsb
> +       isb

Similarly, isn't the last DSB redundant?

Thanks,
Mark.
