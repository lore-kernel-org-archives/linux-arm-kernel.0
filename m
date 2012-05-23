From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 May 2012 00:02:54 +0100
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <201205232302.26191.rui.p.m.sousa@gmail.com>
References: <201205232302.26191.rui.p.m.sousa@gmail.com>
Message-ID: <20120523230254.GD6908@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2012 at 11:02:25PM +0200, Rui Sousa wrote:
> I read this old thread but never saw any comments on the performance
> regression for the DMA_FROM_DEVICE case. Looking at a "recent" 3.2.x kernel
> I see there is still a double invalidate of the DMA range, once on dma map,
> once on dma unmap.

That's because you can't realistically avoid it.  You need both to ensure
data correctness.

The first one kills off any dirty cache lines which _may_ be written back
over the top of your DMA'd data.

The second one kills off any speculative prefetched cache lines which may
have been read before your DMA'd data was written to RAM.

> If it's true, and in general if speculative fetches can be disabled for 
> some/all armv7 CPU's, I think it would be a good idea to introduce a compile
> time flag and make the dual invalidate optional. Comments?

It would be a good idea to get some performance comparisons between the
two approaches.  At the moment you've given one side which is insufficient
information to base any judgement what so ever on this.

What you may find is that turning off the speculative prefetch hurts you
in other ways, but we don't know that until you measure it.
