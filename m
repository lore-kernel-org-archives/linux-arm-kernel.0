From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 May 2010 19:48:52 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the
	ARMv6 DMA cache ops
In-Reply-To: <1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100512184852.GC22371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 02:55:39PM +0100, Catalin Marinas wrote:
> Drivers shouldn't call dma_inv_range if they have valid date in that
> buffer (that's why I removed the dma_inv_range call from
> dma_unmap_area).

That (removal of dma_inv_range) is the wrong approach - if drivers are
expecting data in the cache to be preserved over a dma_unmap_area() call,
they are buggy and need fixing.

However...

> > 2) CPU 0 is doing inv, the str write garbage which get to the DRAM
> > because of eviction and break the assumption that inv shouldn't change
> > the DRAM...
> 
> This may be the case but is there such situation?

This is why there's a problem - if we (rightfully) have dma_unmap_area()
call dma_inv_range, and dma_inv_range() corrupts the SDRAM, that's where
the bug is - dma_unmap_area() must not change the contents of SDRAM.

Aren't there CPUs which speculatively prefetch _and_ which don't have
broadcast cache ops?  If yes, then we can't use the "read/write to
gain ownership" approach - and since we can't use IPIs either, I think
we're sadly boxed in by hardware restrictions to the point of not being
able to run with DMA on these CPUs.
