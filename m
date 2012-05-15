From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 15 May 2012 18:05:35 +0100
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
In-Reply-To: <20120515163618.GH13860@n2100.arm.linux.org.uk>
References: <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
 <20120514155859.GA13860@n2100.arm.linux.org.uk>
 <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
 <20120514163909.GB13860@n2100.arm.linux.org.uk>
 <20120514171533.GB4830@e102568-lin.cambridge.arm.com>
 <20120515094010.GF10453@n2100.arm.linux.org.uk>
 <20120515100902.GA10463@e102568-lin.cambridge.arm.com>
 <20120515101505.GG10453@n2100.arm.linux.org.uk>
 <20120515162851.GC16614@e102568-lin.cambridge.arm.com>
 <20120515163618.GH13860@n2100.arm.linux.org.uk>
Message-ID: <20120515170534.GA17319@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 05:36:18PM +0100, Russell King - ARM Linux wrote:
> On Tue, May 15, 2012 at 05:28:51PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, May 15, 2012 at 11:15:05AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, May 15, 2012 at 11:09:02AM +0100, Lorenzo Pieralisi wrote:
> > > > On Tue, May 15, 2012 at 10:40:10AM +0100, Russell King - ARM Linux wrote:
> > > > > On Mon, May 14, 2012 at 06:15:33PM +0100, Lorenzo Pieralisi wrote:
> > > > > > On Mon, May 14, 2012 at 05:39:09PM +0100, Russell King - ARM Linux wrote:
> > > > > > > From what you're saying - and from my understanding of your cache behaviours,
> > > > > > > even the sequence:
> > > > > > > - clean cache
> > > > > > > - disable C bit
> > > > > > > - clean cache
> > > > > > > is buggy.
> > > > > > 
> > > > > > No, that's correct, works fine on A9 and A15. Second clean is mostly nops.
> > > > > 
> > > > > It's racy.  Consider this:
> > > > > 
> > > > > 	- clean cache
> > > > > 	- cache speculatively prefetches a dirty cache line from another CPU
> > > > > 	- disable C bit
> > > > 	- clean cache
> > > 
> > > Thank you for totally missing the point and destroying the example.
> > > 
> > > > > At this point, you lose access to that dirty data.  If that dirty data is
> > > > > used inbetween disabling the C bit and cleaning the cache for the second
> > > > > time, you have data corruption issues.
> > > > 
> > > > It is not racy. After disabling the C bit the cache clean operations write-back
> > > > any dirty cache line to the next cache level. And the CPU is still in coherency
> > > > mode so there is not a problem with that either.
> > > 
> > > No.  *THINK* about the exact example I gave you.  Think about what state
> > > the CPU sees between that "disable C bit" and the final cache clean (which
> > > you seem to be insisting is an atomic operation.)
> > > 
> > > Please, read what I'm saying rather than re-interpreting it, augmenting it
> > > and then answering something entirely different.
> > > 
> > > > > As I have said, given what you've mentioned, it is impossible to safely
> > > > > disable the cache on a SMP system.  In order to do it safely, you need to
> > > > > have a way to disable new allocations into the cache _without_ disabling
> > > > > the ability for the cache to be searched.
> > 
> > First off, my apologies, it was not meant to disrupt the discussion, if
> > I did sorry about that. Let's try to sum it up:
> > 
> > 1) Hitting in the cache when the SCTLR.C is cleared is CPU specific (eg A9
> >    does not, A15 does)
> > 2) as long as they are taking part in coherency (SMP bit set in ACTLR), all
> >    Cortex-A cores in a MP configuration with the SCTLR.C bit set can hit in
> >    the cache of a CPU that runs with the C bit cleared in SCTLR
> > 3) The sequence:
> >         - clean cache
> >         - clear SCTLR.C
> >         - clean cache
> > 
> > is correct
> 
> I continue to disagree with that assertion.
> 
> I repeat: what happens in this situation on A9:
> 
> 	- clean cache
> 	- cache speculatively prefetches data from another core
> 	- clear SCTLR.C
> 	- _this_ core accesses the address associated with that prefetched
> 	  data
> 
> _That_ is a data corruption issue - as soon as SCTLR.C is cleared, the CPUs
> view of data in memory _changes_, and is only restored to what it should
> be when the dirty cache lines are finally flushed out of the cache.  And
> then, hey presto, the data magically changes again.

What you are saying is correct, no doubts about that; I think though that
in this controlled code execution code path for power down, explicit data
access after clearing the C bit but before cleaning the cache must and
can be prevented.

What we should do as I described, is executing the sequence:

clear SCTRL.C
clean cache
exit coherency

in an uninterruptible way (it is always executed with IRQs disabled) and
with no explicit access to any data whatsoever.
If we code that in assembly (and lots of us already did that for v7, eg OMAP4)
in a controlled code path, I think we can call it safe, that's my opinion FWIW.

Thanks,
Lorenzo
