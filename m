From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2009 11:07:51 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1253526263.1541.32.camel@pc1117.cambridge.arm.com>
References: <1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
Message-ID: <20090921100751.GF27357@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 10:44:23AM +0100, Catalin Marinas wrote:
> I would still call this I-D cache coherency issue since the two caches
> have a different view of the RAM but I agree that the D-cache is the one
> holding the data (with a slight chance for the I-cache not to be in sync
> with main RAM, though we could treat it separately).
> 
> We can sort out the D-cache issue with your approach for cleaning it in
> the copy_user_highpage() function, but, as I said, we affect the
> standard CoW mechanism for data pages quite a lot.

Let me restate my approach more clearly:

1. Remember that a VMA has been executable.
2. Only do the additional handing if the VMA has been executable.

> Since the latest dynamic linker was fixed already to avoid writing to a
> text page, we would penalise (with either solution) user-space in the
> future even if it doesn't need this.

Great - that means a previously executable region won't be COWed anymore,
and so my patch will have no measurable impact.

> > The instruction cache issue is an entirely separate problem.
> 
> We would need to fix this somehow as well. We currently handle the
> I-cache in update_mmu_cache() when a page is first mapped if it has
> VM_EXEC set.

The reason I'm pushing you hard to separate the two issues is that the
two should be treated separately.  I think we need to consider ensuring
that freed pages do not have any I-cache lines associated with them,
rather than waiting for them to be allocated and then dealing with the
I-cache problem.

We need to measure what the impact of that would be.

> But mprotect() or change_protection() don't seem to call this.

That's because update_mmu_cache() is a TLB interface, not a cache
interface.  You'd have to call update_mmu_cache() for every individual
page.  See cachetlb.txt.

> Should we mandate a cacheflush syscall in user space when calling
> mprotect(RX)? I don't think people are expecting this.

It is not clear what effect mprotect() with harvard caches should have
on I+D coherency - certainly there's no behavioural requirements in
this regard specified by POSIX.

Given that if you have a RWX region you have to deal with the coherency
issue in userspace already, I don't see mprotect() being any different
in this regard.
