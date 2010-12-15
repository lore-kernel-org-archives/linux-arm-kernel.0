From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 23:26:38 +0100
Subject: [PATCH v6 01/15] ARM: mxs: Add core definitions
In-Reply-To: <20101215172754.GI9937@n2100.arm.linux.org.uk>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<201012151817.33671.arnd@arndb.de>
	<20101215172754.GI9937@n2100.arm.linux.org.uk>
Message-ID: <201012152326.39191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Russell King - ARM Linux wrote:
> > * be synchronized with spinlocks
> 
> Err.  Even readl/writel are not synchronized with spinlocks.  See
> Documentation/memory-barriers.txt:

readl is synchronized, writel by itself is never synchronized with
spinlocks if it is posted.

> | Under certain circumstances (especially involving NUMA), I/O accesses within
> | two spinlocked sections on two different CPUs may be seen as interleaved by the
> | PCI bridge, because the PCI bridge does not necessarily participate in the
> | cache-coherence protocol, and is therefore incapable of issuing the required
> | read memory barriers.
> |
> | For example:
> |
> |       CPU 1                           CPU 2
> |       =============================== ===============================
> |       spin_lock(Q)
> |       writel(0, ADDR)
> |       writel(1, DATA);
> |       spin_unlock(Q);
> |                                       spin_lock(Q);
> |                                       writel(4, ADDR);
> |                                       writel(5, DATA);
> |                                       spin_unlock(Q);
> |
> | may be seen by the PCI bridge as follows:
> |
> |       STORE *ADDR = 0, STORE *ADDR = 4, STORE *DATA = 1, STORE *DATA = 5
> |
> | which would probably cause the hardware to malfunction.

I was simplifying. To be more specific, __raw_readl/__raw_writel
makes no explicit guarantees regarding ordering with spinlocks.
I could argue that it also makes no guarantees about ordering between
writes, although for all practical purposes they are ordered
as long as you have sane buses underneath.

The ordering of readl/writel is defined to be at least as strict
as what x86 gets you on PCI. This means fully ordered for readl
and writel. In theory, writel is only ordered wrt spinlocks in
combination with mmiowb() as you mentioned, but hardly anyone uses
that correctly, so all sane architectures define mmiowb as a NOP
anyway, except when it's an extremely expensive operation and there
are only a handful of drivers that are actually being used and
they can be audited. I'm not crazy enough to ask anyone to
understand and use mmiowb() correctly ;-)

Russell, from previous discussions I had the impression that you did
not actually want __raw_readl/writel to be used for random platform
drivers, although you might not bother to complain about it either.
When I first complained about readl() being used for non-PCI drivers,
I got the reply that it's actually the right thing to do on ARM, so
I started telling people about that in reviews. My current mental
matrix of the various I/O so far accessors is:

readl: 		anywhere, except PCI I/O space, little-endian
inl: 		PCI I/O space, little-endian
readl_relaxed:	SoC components only, little-endian
ioread32:	anywhere, little-endian
ioread32be:	anywhere, big-endian
pointer dereference: definitely nowhere, native-endian
__raw_readl:	almost nowhere, native-endian

You apparently disagree on the last one, which is fine. Just tell
me what you want and I can make sure I'll look out for any
misuse of the rules in future reviews but don't complain about
correct uses.

	Arnd
