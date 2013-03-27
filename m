From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Mar 2013 13:54:18 +0000
Subject: [PATCH 1/4] ARM: tlb: don't perform inner-shareable invalidation
 for local TLB ops
In-Reply-To: <20130327134028.GC1863@MacBook-Pro.local>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-2-git-send-email-will.deacon@arm.com>
 <20130327103429.GB801@MacBook-Pro.local>
 <20130327120737.GB17185@mudshark.cambridge.arm.com>
 <20130327123054.GF1603@MacBook-Pro.local>
 <20130327125639.GD18429@mudshark.cambridge.arm.com>
 <20130327134028.GC1863@MacBook-Pro.local>
Message-ID: <20130327135418.GF18429@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 01:40:29PM +0000, Catalin Marinas wrote:
> On Wed, Mar 27, 2013 at 12:56:39PM +0000, Will Deacon wrote:
> > Damn, yes, I missed those. Perhaps we should add set_top_pte_atomic, which
> > just does the local flush, and then promote the current flush to be IS?
> 
> Where would we use the set_top_pte_atomic() on ARMv7?

I was thinking of kmap_atomic{_pfn}, to avoid adding further overhead to
highmem.

> > > It's not whether they are used explicitly but whether a speculative TLB
> > > load can bring them in on a different CPU. I don't immediately see a
> > > problem with non-aliasing caches but needs some more thinking.
> > 
> > But why do we care about the speculation? If the core doing the speculating
> > is always going to write a new pte before dereferencing anything mapped
> > there, then it will invalidate its own TLB then.
> 
> It's about speculation on another CPU.
> 
> Let's say CPU0 does several kmap_atomic() calls which in turn call
> set_top_pte(). The same page tables are visible to CPU1 which
> speculatively loads some top pte (not the latest). At this point we have
> a VA pointing to different PAs on CPU0 and CPU1. CPU1 would not access
> this VA, so not a problem here, but whether this matters for
> inner-shareable cache maintenance (dma_cache_maint_page), I can't tell
> yet (internal thread with the architecture guys).

Ok... given that the (speculated) lines won't be dirty, I'm don't see why
this matters for cache maintenance, but I'll wait to see what the
architecture guys some back with.

Will
