From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 May 2010 22:21:15 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <20100512185903.GD22371@n2100.arm.linux.org.uk>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
	<20100512185903.GD22371@n2100.arm.linux.org.uk>
Message-ID: <1273699275.16677.10.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 19:59 +0100, Russell King - ARM Linux wrote:
> On Wed, May 12, 2010 at 07:48:52PM +0100, Russell King - ARM Linux wrote:
> > Aren't there CPUs which speculatively prefetch _and_ which don't have
> > broadcast cache ops?  If yes, then we can't use the "read/write to
> > gain ownership" approach - and since we can't use IPIs either, I think
> > we're sadly boxed in by hardware restrictions to the point of not being
> > able to run with DMA on these CPUs.
> 
> I just had a second thought that what I wrote above was tosh, but then
> had a third thought which reconfirmed it as a valid point...
> 
> Consider if the CPU speculatively prefetches the line you're going to
> read before the DMA has completed, and it prefetches the pre-DMA data.

I won't consider this scenario :). For such cores there isn't an easy
workaround to the DMA cache operations. Even with IPI via FIQ, you may
still have the risk of cache lines migrating around CPUs and missing the
cache flushing.

AFAICT, ARM11MPCore doesn't do this.
> 
Since my implementation of v6_dma_inv_range is destructive, I removed it
from dma_unmap_area() with the precondition that the CPU doesn't do
speculative accesses. With my patch, the dma_unmap_area() doesn't change
the content of the SDRAM.

I don't entirely understand why corruption happens with the e1000 driver
(looking at the e1000.c code it uses consistent memory).

-- 
Catalin
