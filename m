From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 May 2016 17:38:37 +0200
Subject: v7_dma_inv_range performance/high expense
In-Reply-To: <20160527145810.GN19428@n2100.arm.linux.org.uk>
References: <20160527144045.GB20214@lunn.ch>
 <20160527145810.GN19428@n2100.arm.linux.org.uk>
Message-ID: <20160527153837.GE20214@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The original code in arch/arm/mm/cache-v7.S  says:
> > 
> >         mcr     p15, 0, r0, c7, c6, 1           @ invalidate D / U line
> > 
> > I don't get why a cache invalidate instruction should be so expensive.
> > It is just throwing away the contents of the cache line, not flushing
> > it out to DRAM. Should i trust perf? Is a cache invalidate really so
> > expensive? Or am i totally missing something here?
> 
> If we're being asked to do a large region, then flushing the cache one
> line at a time _is_ expensive.

Hi Russell

It is a 2K block, i.e. space for one ethernet frame.

You say flush here. Yet we are not flushing, we are invalidating.

What we logically want to happen is that the DMA engine copies the
packet into DRAM. Once complete we invalidate the cache, and the next
read instruction would cause a cache miss and the ethernet frame is
pulled in.

Looking at these numbers, the invalidate is much more expensive than
the cache miss.

You say one line at a time is expensive. Do you have any idea where
the break even is for invalidating the whole cache? Having said that,
v7_invalidate_l1 seems to be doing it a line at a time as well.

Thanks
	Andrew
