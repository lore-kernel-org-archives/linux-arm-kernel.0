From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 May 2010 19:59:03 +0100
Subject: [PATCH 2/8] ARM: Implement read/write for ownership in the
	ARMv6 DMA cache ops
In-Reply-To: <20100512184852.GC22371@n2100.arm.linux.org.uk>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164426.26355.19161.stgit@e102109-lin.cambridge.arm.com>
	<309002C0DA137042828828FC53D7A93492FA312B64@IL-MB01.marvell.com>
	<1273672539.23818.96.camel@e102109-lin.cambridge.arm.com>
	<20100512184852.GC22371@n2100.arm.linux.org.uk>
Message-ID: <20100512185903.GD22371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 12, 2010 at 07:48:52PM +0100, Russell King - ARM Linux wrote:
> Aren't there CPUs which speculatively prefetch _and_ which don't have
> broadcast cache ops?  If yes, then we can't use the "read/write to
> gain ownership" approach - and since we can't use IPIs either, I think
> we're sadly boxed in by hardware restrictions to the point of not being
> able to run with DMA on these CPUs.

I just had a second thought that what I wrote above was tosh, but then
had a third thought which reconfirmed it as a valid point...

Consider if the CPU speculatively prefetches the line you're going to
read before the DMA has completed, and it prefetches the pre-DMA data.

Your read loads the pre-DMA data, and the write writes it back to the
cache line.  An interrupt happens, and the cache line gets evicted some
time later before the invalidate line operation - overwriting the DMA
data, thereby corrupting it.

So, a CPU which speculatively prefetches _and_ doesn't broadcast cache
operations _is_ a big problem.  I hope we don't have any.
