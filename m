From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Apr 2014 10:43:09 +0200
Subject: dma_alloc_coherent and cache?
In-Reply-To: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
References: <45E047AA-4C3B-4645-A590-5B75A1729ADA@nowonline.co.uk>
Message-ID: <4356499.vN3lxjGqPZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 09:43:38 Lee Essen wrote:
> 
> 
> At a high level I have it working, however I get regular (reproducible) 
> hangs and I suspect it's to do with the writes to the descriptiors 
> (from dma_alloc_coherent) being buffered or cached and not making it
> to the device when dma is triggered.

dma_alloc_coherent() is a wrapper around a device-specific allocator,
based on the dma_map_ops implementation. The default allocator
from arm_dma_ops gives you uncached, buffered memory. It is expected
that the driver uses a barrier (which is implied by readl/writel
but not __raw_readl/__raw_writel or readl_relaxed/writel_relaxed)
to ensure the write buffers are flushed.

If the machine sets arm_coherent_dma_ops rather than arm_dma_ops,
the memory will be cacheable, as it's assumed that the hardware
is set up for cache-coherent DMAs.
 
> My theory is based on the fact that the hang always seems to happen
> at the point of enabling dma for transmit, and occasionally I get a
> packet out which is corrupt ... and if I add lots of debug printk's
> or delay loops then it happens less frequently.
> 
> The original GPL code has some functions in to invalidate/clear the
> L2 cache, but no other driver seems to do this, so it doesn't feel
> like it's a good solution.

Correct, drivers should never do cache management by hand, they
should rely on dma_alloc_coherent, dma_map_* and dma_unmap_* to
do the right thing.

> It's a feroceon cpu, and I've tried disabling the L2 controller and
> also the d-cache - neither of which made any difference.
> 
> So I'm now completely out of ideas and way out of my depth  
> 
> Any suggestions would be greatly appreciated.

Can you post a link to the source code?

	Arnd
