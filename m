From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Jan 2017 19:41:14 +0000
Subject: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
In-Reply-To: <20170127154217.GA4113@fireball>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org>
 <588B5229.60509@arm.com> <20170127154217.GA4113@fireball>
Message-ID: <20170127194114.GA31865@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2017 at 12:42:20AM +0900, AKASHI Takahiro wrote:
> On Fri, Jan 27, 2017 at 01:59:05PM +0000, James Morse wrote:
> > On 24/01/17 08:49, AKASHI Takahiro wrote:
> > > +	/*
> > > +	 * While crash dump kernel memory is contained in a single memblock
> > > +	 * for now, it should appear in an isolated mapping so that we can
> > > +	 * independently unmap the region later.
> > > +	 */
> > > +	if (crashk_res.end && crashk_res.start >= start &&
> > > +	    crashk_res.end <= end) {
> > > +		if (crashk_res.start != start)
> > > +			__create_pgd_mapping(pgd, start, __phys_to_virt(start),
> > > +					     crashk_res.start - start,
> > > +					     PAGE_KERNEL,
> > > +					     early_pgtable_alloc,
> > > +					     debug_pagealloc_enabled());
> > > +
> > > +		/* before kexec_load(), the region can be read-writable. */
> > > +		__create_pgd_mapping(pgd, crashk_res.start,
> > > +				     __phys_to_virt(crashk_res.start),
> > > +				     crashk_res.end - crashk_res.start + 1,
> > > +				     PAGE_KERNEL, early_pgtable_alloc,
> > > +				     debug_pagealloc_enabled());
> > > +
> > > +		if (crashk_res.end != end)
> > > +			__create_pgd_mapping(pgd, crashk_res.end + 1,
> > > +					     __phys_to_virt(crashk_res.end + 1),
> > > +					     end - crashk_res.end - 1,
> > > +					     PAGE_KERNEL,
> > > +					     early_pgtable_alloc,
> > > +					     debug_pagealloc_enabled());
> > 
> > > +		return;
> > 
> > Doesn't this mean we skip all the 'does this overlap with the kernel text' tests
> > that happen further down in this file?
> 
> You're right. We should still ckeck the overlap against
> [start..crashk_res.start] and [crashk_res.end+1..end].
> 
> (Using memblock_isolate_range() could simplify the code.)

My key concern here was that we handle both of these in the same way, so
using memblock_isolate_range() for both generally sounds fine to me.

One concern I had with using memblock_isolate_range() is that it does
not guarantee that the region remains isolated. So if there was a
subsequent memblock_add() call, memblock_merge_regions() might end up
merging the region with an adjacent region.

If we isolate the regions at the start of map_mem(), and have a comment
explaining that we must avoid subsequent memblock merging, then I think
this would be ok.

Thanks,
Mark.
