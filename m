From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 10:40:10 +0100
Subject: L1 & L2 cache flush sequence on CortexA5 MPcore w.r.t low power
 modes
In-Reply-To: <20120514171533.GB4830@e102568-lin.cambridge.arm.com>
References: <CAF0TxboSEZuHO6mo-F=os9cvNCyAfVjs3j=SSLjgC7DV6Q_jow@mail.gmail.com>
 <20120514155022.GA3792@e102568-lin.cambridge.arm.com>
 <20120514155859.GA13860@n2100.arm.linux.org.uk>
 <20120514162150.GA4654@e102568-lin.cambridge.arm.com>
 <20120514163909.GB13860@n2100.arm.linux.org.uk>
 <20120514171533.GB4830@e102568-lin.cambridge.arm.com>
Message-ID: <20120515094010.GF10453@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 06:15:33PM +0100, Lorenzo Pieralisi wrote:
> On Mon, May 14, 2012 at 05:39:09PM +0100, Russell King - ARM Linux wrote:
> > From what you're saying - and from my understanding of your cache behaviours,
> > even the sequence:
> > - clean cache
> > - disable C bit
> > - clean cache
> > is buggy.
> 
> No, that's correct, works fine on A9 and A15. Second clean is mostly nops.

It's racy.  Consider this:

	- clean cache
	- cache speculatively prefetches a dirty cache line from another CPU
	- disable C bit

At this point, you lose access to that dirty data.  If that dirty data is
used inbetween disabling the C bit and cleaning the cache for the second
time, you have data corruption issues.

Another point which needs to be checked is whether dirty cache lines in
a CPUs cache which has had the C bit disabled still take part in the
coherency protocol with other CPUs.  If the answer is no, then that's a
_major_ problem for the hot unplug code paths.  That effectively means
that we have a window where a CPU going down actively _corrupts_ the
data visible to other CPUs.

As I have said, given what you've mentioned, it is impossible to safely
disable the cache on a SMP system.  In order to do it safely, you need to
have a way to disable new allocations into the cache _without_ disabling
the ability for the cache to be searched.

And if we could do that, then the sequence becomes a simple and race free:

	- disable new allocations
	- clean cache
	- disable cache
