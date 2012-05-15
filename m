From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 May 2012 19:17:37 +0100
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
Message-ID: <20120515181737.GM10057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, May 15, 2012 at 05:36:18PM +0100, Russell King - ARM Linux wrote:
> I repeat: what happens in this situation on A9:
> 
> 	- clean cache
> 	- cache speculatively prefetches data from another core

If this prefetching occurs then either:

	(a) The line is clean (no problem)

	(b) Another core has written some data and we end up (speculatively)
	    loading dirty lines

Case (b) is only a problem if we actually commit to using the data later on.

> 	- clear SCTLR.C
> 	- _this_ core accesses the address associated with that prefetched
> 	  data

Yes. At this point it is cpu-specific whether or not we hit our dirty lines
from above. On A9, we will get the stale data from memory. However, this is
exactly the same situation we would find ourselves in if we tried to access
dirty data held in any cache with our SCTLR.C bit cleared. We're no longer
coherent at this stage, so need to avoid accessing shared data.

> _That_ is a data corruption issue - as soon as SCTLR.C is cleared, the CPUs
> view of data in memory _changes_, and is only restored to what it should
> be when the dirty cache lines are finally flushed out of the cache.  And
> then, hey presto, the data magically changes again.

Well we still can't see dirty data in any of the other L1 caches, so our view
of memory is going to be constantly out of date. The tricky bit is ensuring
that we don't rely on data being written by anybody else (and if we write
data ourself, we need to make sure it's suitably aligned so as not to get
clobbered by evictions from the other caches).

Will
