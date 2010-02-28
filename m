From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 28 Feb 2010 23:17:14 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267220980.23523.1820.camel@pasglop>
References: <1266445892.16346.306.camel@pasglop>
	<1266599755.32546.38.camel@e102109-lin.cambridge.arm.com>
	<1266979170.23523.1660.camel@pasglop>
	<1267202674.14703.70.camel@e102109-lin.cambridge.arm.com>
	<1267220980.23523.1820.camel@pasglop>
Message-ID: <1267399034.4485.24.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-02-26 at 21:49 +0000, Benjamin Herrenschmidt wrote:
> > > > On ARM11MPCore we flush the caches in flush_dcache_page() because the
> > > > cache maintenance operations weren't visible to the other CPUs.
> > >
> > > I'm not even sure that's going to be 100% correct. Don't you also need
> > > to flush the remote icaches when you are dealing with instructions (such
> > > as swap) anyways ?
> >
> > I don't think we tried swap but for pages that have been mapped for the
> > first time, the I-cache would be clean.
> >
> > At mm switching, if a thread
> > migrates to a new CPU we invalidate the cache at that point.
> 
> That sounds fragile. What about a multithread app with one thread on
> each core hitting the pages at the same time ? Sounds racy to me...

Interestingly, until commit 826cbdaff29 (< 2 years ago), we didn't have
any I-cache flushing in update_mmu_cache() and it was working fine. I
added it for correctness reasons rather than to fix something. My theory
is that it was working because a page cache page tends to keep the same
physical address, especially if we don't swap pages, and a 16KB PIPT
cache cannot hold enough lines to show any issues (lines are replaced
frequently).

I suspect that's one of the reasons why only invalidating the whole
I-cache when switching the mm to a new CPU seems to suffice. Once we
enable some form of swapping, it may show the problem.

-- 
Catalin
