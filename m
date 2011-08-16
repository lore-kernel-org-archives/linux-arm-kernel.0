From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Aug 2011 15:28:48 +0200
Subject: [PATCH 7/9] ARM: DMA: steal memory for DMA coherent mappings
In-Reply-To: <20110814075205.GA4986@n2100.arm.linux.org.uk>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<201108121453.05898.arnd@arndb.de>
	<20110814075205.GA4986@n2100.arm.linux.org.uk>
Message-ID: <201108161528.48954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 14 August 2011, Russell King - ARM Linux wrote:
> On Fri, Aug 12, 2011 at 02:53:05PM +0200, Arnd Bergmann wrote:
> > 
> > I thought that our discussion ended with the plan to use this only
> > for ARMv6+ (which has a problem with double mapping) but not on ARMv5
> > and below (which don't have this problem but might need dmabounce).
> 
> I thought we'd decided to have a pool of available CMA memory on ARMv6K
> to satisfy atomic allocations, which can grow and shrink in size, rather
> than setting aside a fixed amount of contiguous system memory.

Hmm, I don't remember the point about dynamically sizing the pool for
ARMv6K, but that can well be an oversight on my part.  I do remember the
part about taking that memory pool from the CMA region as you say.

> ARMv6 and ARMv7+ could use CMA directly, and <= ARMv5 can use the existing
> allocation method.
> 
> Has something changed?

Nothing has changed regarding <=ARMv5. There was a small side discussion
about ARMv6 and ARMv7+ based on the idea that they can either use CMA
directly (doing TLB flushes for every allocation) or they could use the
same method as ARMv6K by setting aside a pool of pages for atomic
allocation. The first approach would consume less memory because it
requires no special pool, the second approach would be simpler because
it unifies the ARMv6K and ARMv6/ARMv7+ cases and also would be slightly
more efficient for atomic allocations because it avoids the expensive
TLB flush.

I didn't have a strong opinion either way, so IIRC Marek said he'd try
out both approaches and then send out the one that looked better, leaning
towards the second for simplicity of having fewer compile-time options.

	Arnd
