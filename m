From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 19:08:14 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110706160551.GH32020@e102109-lin.cambridge.arm.com>
References: <20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
	<20110704104329.GD19117@e102109-lin.cambridge.arm.com>
	<20110704111338.GD8286@n2100.arm.linux.org.uk>
	<20110704155835.GA30189@e102109-lin.cambridge.arm.com>
	<20110704195819.GG8286@n2100.arm.linux.org.uk>
	<20110704232019.GK8286@n2100.arm.linux.org.uk>
	<20110706160551.GH32020@e102109-lin.cambridge.arm.com>
Message-ID: <20110706180814.GL8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 05:05:51PM +0100, Catalin Marinas wrote:
> On Tue, Jul 05, 2011 at 12:20:19AM +0100, Russell King - ARM Linux wrote:
> > Please can you also check whether BTC invalidation is required when a
> > page is removed from the page tables for the purpose of swapping it
> > out (so the PTE entry becomes zero).
> 
> Not required.
> 
> > Also, is BTC invalidation required if the very same page that was
> > there before is later restored without any modification to the
> > instruction content of that page.  (I'm thinking page is aged to old,
> > and so unmapped, then a prefetch abort which reinstates the same page
> > that was there previously.)
> 
> Not required.
> 
> > Finally, is BTC invalidation required if a different physical page
> > containing the same instruction content as before is placed at that
> > location?
> 
> Required (see the comment below).
> 
> > Lastly, please check whether population and removal of page table
> > entries for NX pages require BTC invalidation.  I expect not.
>  
> Not required.
> 
> Basically the rules for BTC are similar to those for the I-cache, but it
> can be either ASID-tagged VIVT or VIPT, independent of the type of the
> I-cache. I think current implementations of the BTC are ASID-tagged VIVT
> but the architecture doesn't mandate this.
> 
> So the mapping of a data page doesn't require BTC invalidation, even if
> the page is not marked as XN.
> 
> Having a branch between BTC and ISB is OK as long as we don't change the
> mapping of the branch.
> 
> Mapping a page in a previously unmapped location doesn't generally
> require BTC invalidation if we guarantee that there are no BTC entries
> for that location (IOW, we got a new ASID or unmapping the page
> previously had a BTC invalidation).

Okay, so I can say with confidence then that how things stand in my tree,
which limits BTC invalidation to:

1. For kernel mappings, flush_icache_range() which must be called prior
   to code placed in them being executed.

2. For user mappings, __sync_icache_dcache's icache flush, which is
   called before a non-zero user PTE is inserted.

together covers all the necessary points.

The area which needs more to focus some further work is
__sync_icache_dcache(), which is fairly over-zealous about all the
flushing.  In a boot of the Versatile Express platform, it inserts
193k PTEs.  Of that, 192k are for userspace.  For userspace:

87k are for new executable pages, 87 are for executable pages with
their attributes (eg, young-ness/read-only ness) changed.

54k are for new non-executable pages, 51k are for non-executable pages
with attributes changed.

__sync_icache_dcache() handles these userspace PTEs as follows:

0 satisfy the !pte_present_user() test.

105k are ignored due to the VIPT non-aliasing cache and the PTE being
non-executable.

0 have invalid PFNs.

964 result in a Dcache flush.  This number does not increment through
repeated monitoring of the stats via 'cat'.

87k result in an Icache invalidate with BTC invalidation.

Around 130 (of 193k) calls into this code can be saved by checking
whether the PFN has changed and the state of the young bit (no point
doing any flushing if the page is marked old as it won't be accessible
to the user in that state.)

130 may not sound like many, but that's just from a boot.  Over time,
pages will be aged, which will push that number up.  We really ought not
flush the I-cache and BTC just because we marked the page old, and then
again when it is marked young.

That's also something which won't really show up in benchmarks, as it
depends on pushing virtual memory out of the system which is not
something which benchmarks are particularly good at measuring.  It's
effect depends on overall system behaviour depends on the system setup
and memory pressure.
