From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 May 2016 17:37:15 +0100
Subject: v7_dma_inv_range performance/high expense
In-Reply-To: <20160527153837.GE20214@lunn.ch>
References: <20160527144045.GB20214@lunn.ch>
 <20160527145810.GN19428@n2100.arm.linux.org.uk>
 <20160527153837.GE20214@lunn.ch>
Message-ID: <20160527163715.GP19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 05:38:37PM +0200, Andrew Lunn wrote:
> You say flush here. Yet we are not flushing, we are invalidating.

Yes, I meant invalidating, sorry.

> What we logically want to happen is that the DMA engine copies the
> packet into DRAM. Once complete we invalidate the cache, and the next
> read instruction would cause a cache miss and the ethernet frame is
> pulled in.

Yes, so you read the data which was DMAd, rather than any data that may
be in the cache from previous accesses _or_ speculative prefetches.

> Looking at these numbers, the invalidate is much more expensive than
> the cache miss.
> 
> You say one line at a time is expensive. Do you have any idea where
> the break even is for invalidating the whole cache? Having said that,
> v7_invalidate_l1 seems to be doing it a line at a time as well.

Yes, v7_invalidate_l1 also does it one line at a time, but by set/way
instead, and set/way doesn't tell you whether the cache line overlaps
the memory region you're invalidating, so you would end up discarding
dirty data from other memory regions.

The alternative is to flush all cache lines in the cache, 

Even so, for either to be cheaper, you need to be touching less lines
than the present method.  For 2K worth of data, it's unlikely to be
cheaper.

I guess something which may be worth trying is to unroll the loop a
little, and see what effect it has on the perf numbers... if things
like the branch predictor are working correctly, I'd have expected
little difference (except to spread the cost over more of the function.)
It may be worth just proving that point.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
