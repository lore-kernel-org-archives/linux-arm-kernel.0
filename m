From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 15 May 2012 17:28:51 +0100
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low	power
 modes
In-Reply-To: <20120515101505.GG10453@n2100.arm.linux.org.uk>
References: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
 <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
 <20120514155859.GA13860@n2100.arm.linux.org.uk>
 <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
 <20120514163909.GB13860@n2100.arm.linux.org.uk>
 <20120514171533.GB4830@e102568-lin.cambridge.arm.com>
 <20120515094010.GF10453@n2100.arm.linux.org.uk>
 <20120515100902.GA10463@e102568-lin.cambridge.arm.com>
 <20120515101505.GG10453@n2100.arm.linux.org.uk>
Message-ID: <20120515162851.GC16614@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 11:15:05AM +0100, Russell King - ARM Linux wrote:
> On Tue, May 15, 2012 at 11:09:02AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, May 15, 2012 at 10:40:10AM +0100, Russell King - ARM Linux wrote:
> > > On Mon, May 14, 2012 at 06:15:33PM +0100, Lorenzo Pieralisi wrote:
> > > > On Mon, May 14, 2012 at 05:39:09PM +0100, Russell King - ARM Linux wrote:
> > > > > From what you're saying - and from my understanding of your cache behaviours,
> > > > > even the sequence:
> > > > > - clean cache
> > > > > - disable C bit
> > > > > - clean cache
> > > > > is buggy.
> > > > 
> > > > No, that's correct, works fine on A9 and A15. Second clean is mostly nops.
> > > 
> > > It's racy.  Consider this:
> > > 
> > > 	- clean cache
> > > 	- cache speculatively prefetches a dirty cache line from another CPU
> > > 	- disable C bit
> > 	- clean cache
> 
> Thank you for totally missing the point and destroying the example.
> 
> > > At this point, you lose access to that dirty data.  If that dirty data is
> > > used inbetween disabling the C bit and cleaning the cache for the second
> > > time, you have data corruption issues.
> > 
> > It is not racy. After disabling the C bit the cache clean operations write-back
> > any dirty cache line to the next cache level. And the CPU is still in coherency
> > mode so there is not a problem with that either.
> 
> No.  *THINK* about the exact example I gave you.  Think about what state
> the CPU sees between that "disable C bit" and the final cache clean (which
> you seem to be insisting is an atomic operation.)
> 
> Please, read what I'm saying rather than re-interpreting it, augmenting it
> and then answering something entirely different.
> 
> > > As I have said, given what you've mentioned, it is impossible to safely
> > > disable the cache on a SMP system.  In order to do it safely, you need to
> > > have a way to disable new allocations into the cache _without_ disabling
> > > the ability for the cache to be searched.

First off, my apologies, it was not meant to disrupt the discussion, if
I did sorry about that. Let's try to sum it up:

1) Hitting in the cache when the SCTLR.C is cleared is CPU specific (eg A9
   does not, A15 does)
2) as long as they are taking part in coherency (SMP bit set in ACTLR), all
   Cortex-A cores in a MP configuration with the SCTLR.C bit set can hit in
   the cache of a CPU that runs with the C bit cleared in SCTLR
3) The sequence:
        - clean cache
        - clear SCTLR.C
        - clean cache

is correct and we must mandate it, with the following remarks:

        - The first cache clean is superfluos (but does no harm)
        - The second cache clean must not rely on any data that might
          sit in the cache
        - clearing SCTLR.C and cleaning the cache must be coded in
          assembly in a function carrying out both operations (to avoid
          stack issues ie cacheable push/pop ops and any global data
          reference)

4) Current vexpress hotplug code clears ACTLR.SMP bit before clearing
   SCTLR.C; this is a bug according to this discussion and we must fix
   it (to avoid copy'n'paste of code that does not follow the standard
   for platforms that have PM capabilities beyond standbywfi)

Please let me know if I am missing something and thanks for the discussion.

Lorenzo
