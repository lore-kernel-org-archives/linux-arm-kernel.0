From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 7 Jul 2011 11:07:15 +0100
Subject: [PATCH v3 01/40] Subject: ARM: mm: proc-macros Add generic
	proc/cache/tlb struct definition macros
In-Reply-To: <20110707082251.GH8286@n2100.arm.linux.org.uk>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-2-git-send-email-dave.martin@linaro.org>
	<20110707082251.GH8286@n2100.arm.linux.org.uk>
Message-ID: <20110707100715.GB2486@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 09:22:51AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 23, 2011 at 06:50:09PM +0100, Dave Martin wrote:
> > +.macro define_cache_functions name:req, default:req, \
> > +		flush_kern_dcache_area, dma_map_area, dma_flush_range
> > +	.align 2
> > + 	.type	\name\()_cache_fns, #object
> > +ENTRY(\name\()_cache_fns)
> > +	.long	\default\()_flush_icache_all
> > +	.long	\default\()_flush_kern_cache_all
> > +	.long	\default\()_flush_user_cache_all
> > +	.long	\default\()_flush_user_cache_range
> > +	.long	\default\()_coherent_kern_range
> > +	.long	\default\()_coherent_user_range
> > +	.ifb \flush_kern_dcache_area
> > +		.long	\default\()_flush_kern_dcache_area
> > +	.else
> > +		.long	\flush_kern_dcache_area
> > +	.endif
> > +	.ifb \dma_map_area
> > +		.long	\default\()_dma_map_area
> > +	.else
> > +		.long	\dma_map_area
> > +	.endif
> > +	.long	\default\()_dma_unmap_area
> > +	.ifb \dma_flush_range
> > +		.long	\default\()_dma_flush_range
> > +	.else
> > +		.long	\dma_flush_range
> > +	.endif
> > +	.size	\name\()_cache_fns, . - \name\()_cache_fns
> > +.endm
> 
> This looks wrong.  The flush_kern_dcache_area and DMA stuff can't be
> any different:
> 
> #define __cpuc_flush_icache_all         __glue(_CACHE,_flush_icache_all)
> #define __cpuc_flush_kern_all           __glue(_CACHE,_flush_kern_cache_all)
> #define __cpuc_flush_user_all           __glue(_CACHE,_flush_user_cache_all)
> #define __cpuc_flush_user_range         __glue(_CACHE,_flush_user_cache_range)
> #define __cpuc_coherent_kern_range      __glue(_CACHE,_coherent_kern_range)
> #define __cpuc_coherent_user_range      __glue(_CACHE,_coherent_user_range)
> #define __cpuc_flush_dcache_area        __glue(_CACHE,_flush_kern_dcache_area)
> 
> #define dmac_map_area                   __glue(_CACHE,_dma_map_area)
> #define dmac_unmap_area                 __glue(_CACHE,_dma_unmap_area)
> #define dmac_flush_range                __glue(_CACHE,_dma_flush_range)
> 
> If they don't conform to the "<cachename>_<functionname>" pattern then
> single-cache model kernels will not compile.

I added this override capability purely because some proc-*.S define multiple
sets of cache functions which are mostly common but have some differences.
This facility is actually just used by feroceon and xscale, so you're probably
right -- it may be better to fix those than encourage deviation elsewhere.

If this makes any CPU broken, it must by definition be broken already since
I was very careful to ensure there was no change to symbols or generated
code as a result of these patches.

IIUC, these processors may already not work for a single cache model kernel.
In asm/glue-cache.h, this seems to be acknowledged for feroceon (which defines
MULTI_CACHE unconditionally if CONFIG_CPU_FEROCEON is defined).

For xscale, there is no unconditional MULTI_CACHE, so it looks as though if
a single cache model kernel is built, xscale_dma_map_area may get used
unconditionally instead of xscale_dma_a0_map_area even for the buggy A0/A1
processor revisions.  That won't result in a compile failure, just some
incorrect cache maintenance at runtime -- if so, it looks like a bug.

> As these macros are supposed to be about correctness, they should be
> enforcing that too, and not allowing certain functions to be overriden
> by different names.

I guess I agree with that -- making it too easy to override individual
functions may encourage people to do the wrong thing.  So yes, taking away
that generic override capability the forcing people to define appropriate
aliases in the proc-*.S files sounds like a better approach.

However, we also have the problem that any kenel containing multiple sets
of cache fns needs to have MULTI_CACHE defined; otherwise, a faulty
kernel may be built silently.  I think this only applies to xscale right now,
if I've understood correctly.

The easiest solution to that particular problem would be to define MULTI_CACHE
for xscale unconditionally, as is done for feroceon.

Do you think we need a generic check for such situations?

Cheers
---Dave
