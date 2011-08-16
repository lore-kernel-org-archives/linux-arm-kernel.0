From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Aug 2011 14:55:16 +0100
Subject: [PATCH 7/9] ARM: DMA: steal memory for DMA coherent mappings
In-Reply-To: <201108161528.48954.arnd@arndb.de>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<201108121453.05898.arnd@arndb.de>
	<20110814075205.GA4986@n2100.arm.linux.org.uk>
	<201108161528.48954.arnd@arndb.de>
Message-ID: <20110816135516.GC17310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 03:28:48PM +0200, Arnd Bergmann wrote:
> On Sunday 14 August 2011, Russell King - ARM Linux wrote:
> > On Fri, Aug 12, 2011 at 02:53:05PM +0200, Arnd Bergmann wrote:
> > > 
> > > I thought that our discussion ended with the plan to use this only
> > > for ARMv6+ (which has a problem with double mapping) but not on ARMv5
> > > and below (which don't have this problem but might need dmabounce).
> > 
> > I thought we'd decided to have a pool of available CMA memory on ARMv6K
> > to satisfy atomic allocations, which can grow and shrink in size, rather
> > than setting aside a fixed amount of contiguous system memory.
> 
> Hmm, I don't remember the point about dynamically sizing the pool for
> ARMv6K, but that can well be an oversight on my part.  I do remember the
> part about taking that memory pool from the CMA region as you say.

If you're setting aside a pool of pages, then you have to dynamically
size it.  I did mention during our discussion about this.

The problem is that a pool of fixed size is two fold: you need it to be
sufficiently large that it can satisfy all allocations which come along
in atomic context.  Yet, we don't want the pool to be too large because
then it prevents the memory being used for other purposes.

Basically, the total number of pages in the pool can be a fixed size,
but as they are depleted through allocation, they need to be
re-populated from CMA to re-build the reserve for future atomic
allocations.  If the pool becomes larger via frees, then obviously
we need to give pages back.
