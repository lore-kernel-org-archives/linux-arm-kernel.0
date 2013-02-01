From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 1 Feb 2013 14:34:06 +0000
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <20130201141914.GO23505@n2100.arm.linux.org.uk>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
 <510BA728.4060300@ti.com>
 <20130201121137.GC23869@e102568-lin.cambridge.arm.com>
 <20130201125417.GL23505@n2100.arm.linux.org.uk>
 <20130201141052.GA25172@e102568-lin.cambridge.arm.com>
 <20130201141914.GO23505@n2100.arm.linux.org.uk>
Message-ID: <20130201143406.GB25172@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 02:19:14PM +0000, Russell King - ARM Linux wrote:
> On Fri, Feb 01, 2013 at 02:10:52PM +0000, Lorenzo Pieralisi wrote:
> > On Fri, Feb 01, 2013 at 12:54:17PM +0000, Russell King - ARM Linux wrote:
> > > On Fri, Feb 01, 2013 at 12:11:38PM +0000, Lorenzo Pieralisi wrote:
> > > > Well, on latest processors (A15, A7) caches are invalidated on reset unless
> > > > the chip is programmed to skip that on reset (ie L2 retained).
> > > > 
> > > > But it makes sense, for sure it should not be called v7_invalidate_l1,
> > > > but invalidate_louis, and instead of forcing level 0 we should be
> > > > reading LoUIS and invalidate up to that level as we do in the clean and
> > > > invalidate function.
> > > 
> > > No.  Think about it.  c7, c6, 2 _invalidates_ the cache.  That means any
> > > data contained within the cache is discarded.  Data is not written back.
> > > 
> > > If you do this down to the LoUIS, that includes all cache levels in the
> > > inner sharable domain.  The inner sharable domain includes the other CPUs
> > > in the system which may already be running (certainly the boot CPU will
> > > be running).
> > 
> > On all v7 ARM systems I know of LoUIS correspond to L1 and using LoUIS is a
> > plaster that works for current systems (where by LoUIS I mean all cache
> > levels down to but not inclusive of, LoUIS).
> 
> All that I'm saying is that suggesting that v7_invalidate_l1 should go
> down to LoUIS is wrong, in much the same way as _invalidating_ only the
> first level of cache.
> 
> However, invalidating the first level of cache only is safer than
> invalidating down to LoUIS.
> 
> The only path which needs this is the secondary CPU bringup path; that's
> the only path we have where some platforms give us a CPU which has only
> just come out of reset, and so the caches for that CPU may be in an
> unknown state.  And it only happens to a small subset of platforms.
> 
> Currently, that small subset of platforms only need the first level of
> cache invalidating.  (Most platforms don't need this; most platforms
> this would be a waste of time - and people seem to care about hotplug
> times.)
> 
> So, that's what we should do.  And v7_invalidate_l1 is a perfectly
> reasonable name for a function to do that for the V7 architecture.
> 
> As has been pointed out, there's several duplications of that.  That's
> fine, let's move them into the v7 cache code.  But... let's not change
> how they work and go through a pointless design exercise for
> invalidating more levels of cache when we know that no platform needs
> it.
> 
> If/when we do end up with a platform which requires it, we can deal
> with it then.  But let's not lead people down the route of thinking
> that LoUIS is suitable here when it isn't.

Your point is fair Russell, and I agree with that in the context you
provided. Last thing I want to mention is that duplicating code that
loops through sets/ways is not that great, but I also understand that
refactoring the code to share the loop in v7_flush_dcache_all might
do more harm than good and introduce bugs, so let's merge the
invalidate_l1 function as it stands.

Thank you,
Lorenzo
