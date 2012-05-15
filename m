From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 11:15:05 +0100
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low
 power modes
In-Reply-To: <20120515100902.GA10463@e102568-lin.cambridge.arm.com>
References: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
 <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
 <20120514155859.GA13860@n2100.arm.linux.org.uk>
 <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
 <20120514163909.GB13860@n2100.arm.linux.org.uk>
 <20120514171533.GB4830@e102568-lin.cambridge.arm.com>
 <20120515094010.GF10453@n2100.arm.linux.org.uk>
 <20120515100902.GA10463@e102568-lin.cambridge.arm.com>
Message-ID: <20120515101505.GG10453@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 11:09:02AM +0100, Lorenzo Pieralisi wrote:
> On Tue, May 15, 2012 at 10:40:10AM +0100, Russell King - ARM Linux wrote:
> > On Mon, May 14, 2012 at 06:15:33PM +0100, Lorenzo Pieralisi wrote:
> > > On Mon, May 14, 2012 at 05:39:09PM +0100, Russell King - ARM Linux wrote:
> > > > From what you're saying - and from my understanding of your cache behaviours,
> > > > even the sequence:
> > > > - clean cache
> > > > - disable C bit
> > > > - clean cache
> > > > is buggy.
> > > 
> > > No, that's correct, works fine on A9 and A15. Second clean is mostly nops.
> > 
> > It's racy.  Consider this:
> > 
> > 	- clean cache
> > 	- cache speculatively prefetches a dirty cache line from another CPU
> > 	- disable C bit
> 	- clean cache

Thank you for totally missing the point and destroying the example.

> > At this point, you lose access to that dirty data.  If that dirty data is
> > used inbetween disabling the C bit and cleaning the cache for the second
> > time, you have data corruption issues.
> 
> It is not racy. After disabling the C bit the cache clean operations write-back
> any dirty cache line to the next cache level. And the CPU is still in coherency
> mode so there is not a problem with that either.

No.  *THINK* about the exact example I gave you.  Think about what state
the CPU sees between that "disable C bit" and the final cache clean (which
you seem to be insisting is an atomic operation.)

Please, read what I'm saying rather than re-interpreting it, augmenting it
and then answering something entirely different.

> > As I have said, given what you've mentioned, it is impossible to safely
> > disable the cache on a SMP system.  In order to do it safely, you need to
> > have a way to disable new allocations into the cache _without_ disabling
> > the ability for the cache to be searched.
> 
> Cache lines can be acted upon with maintenance operations whether the C bit is
> set or clear. For instance caches can be invalidated when the MMU is off
> and the C bit is clear, eg v7 boot.
> 
> Cache cleaning and cache enabling/disabling are two different things, that's
> valid for the PL310 as well.

Yes, of course I realise that.  That's not what I'm talking about at all.
