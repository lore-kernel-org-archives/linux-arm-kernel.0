From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 19 Nov 2013 18:20:23 +0000
Subject: [PATCH] arm: mm: refactor v7 cache cleaning ops to use way/index
 sequence
In-Reply-To: <20131119171606.GB32337@arm.com>
References: <1384874993-4577-1-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.10.1311191155080.9667@knanqh.ubzr>
 <20131119171606.GB32337@arm.com>
Message-ID: <20131119182023.GC27679@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 05:16:06PM +0000, Catalin Marinas wrote:
> On Tue, Nov 19, 2013 at 04:58:58PM +0000, Nicolas Pitre wrote:
> > On Tue, 19 Nov 2013, Lorenzo Pieralisi wrote:
> > 
> > > Set-associative caches on all v7 implementations map the index bits
> > > to physical addresses LSBs and tag bits to MSBs. On most systems with
> > > sane DRAM controller configurations, this means that the current v7
> > > cache flush routine using set/way operations triggers a DRAM memory
> > > controller precharge/activate for every cache line writeback since the
> > > cache routine cleans lines by first fixing the index and then looping
> > > through ways.
> > > 
> > > Given the random content of cache tags, swapping the order between
> > > indexes and ways loops do not prevent DRAM pages precharge and
> > > activate cycles but at least, on average, improves the chances that
> > > either multiple lines hit the same page or multiple lines belong to
> > > different DRAM banks, improving throughput significantly.
> > > 
> > > This patch swaps the inner loops in the v7 cache flushing routine to
> > > carry out the clean operations first on all sets belonging to a given
> > > way (looping through sets) and then decrementing the way.
> > > 
> > > Benchmarks showed that by swapping the ordering in which sets and ways
> > > are decremented in the v7 cache flushing routine, that uses set/way
> > > operations, time required to flush caches is reduced significantly,
> > > owing to improved writebacks throughput to the DRAM controller.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > 
> > Could you include some benchmark results so we have an idea of the 
> > expected improvement scale?
> 
> Lorenzo should have some numbers.

Thanks for the acks.

Throughput improvements strictly depend on what's in the cache at
runtime, since the throughput to DRAM depends on the tag addresses of the
writebacks. I have seen throughput 2x on TC2 when L2 is likely to contain
sequential tags (same DRAM row and at row switch bank interleaving - when
I say likely it is because I can measure the number of writebacks using PMU
counters to verify L2 dirtyness, but I have no crystal ball, I can't
check the tag RAM content, I can only craft code that tries to set it
to specific values).

Current kernel code triggers the worst case: every cache line WB implies a
precharge/activate set of commands to the DRAM, since the bits mapping
sets are PA[15:6] on eg A15 L2, looping through ways with fixed index implies
opening a page on common DRAM controller configurations.

On TC2 timing I saw L2 clean/invalidate time going up to 1.8ms with the
current kernel code.

With this patch applied the timing depends on the L2 content, but it
cannot get worse than the current scenario, it can just improve and
that's what happens. With a syntetic idle benchmark (that memsets and
sleeps) worst case goes down to 1.2 ms, and average follows the same
pattern.

I can improve the commit log with HW details, if anyone can give it a go
on systems with embedded L2 that would be grand, actually I am really
keen on getting this code to -next asap for testing reasons.

Thank you,
Lorenzo
