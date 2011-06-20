From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 21:55:59 +0100
Subject: [PATCH] USB: ehci: use packed,aligned(4) instead of removing
	the packed attribute
In-Reply-To: <201106202226.37381.arnd@arndb.de>
References: <alpine.LFD.2.00.1106201306210.2142@xanadu.home>
	<Pine.LNX.4.44L0.1106201329390.2113-100000@iolanthe.rowland.org>
	<20110620184849.GI26089@n2100.arm.linux.org.uk>
	<201106202226.37381.arnd@arndb.de>
Message-ID: <20110620205559.GM26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 10:26:37PM +0200, Arnd Bergmann wrote:
> * We already need a compiler barrier in the non-_relaxed() versions of
>   the I/O accessors, which will force a reload of the base address
>   in a lot of cases, so the code is already suboptimal. Yes, we don't
>   have the barrier today without CONFIG_ARM_DMA_MEM_BUFFERABLE, but that
>   is a bug, because it lets the compiler move accesses to DMA buffers
>   around readl/writel.

You're now being obtuse there.  You don't need compiler barriers to
guarantee order - that's what volatile does there.

Before you start quoting stuff about volatile, look at the
volatile-considered-harmful.txt document:

  - The above-mentioned accessor functions might use volatile on
    architectures where direct I/O memory access does work.  Essentially,
    each accessor call becomes a little critical section on its own and
    ensures that the access happens as expected by the programmer.

which is what we're doing here.  And because each accessor is its own
little critical section, there's no need for a compiler barrier.

> > If it is the case that these structures do not require packing to get
> > their desired layout, then they don't require packing, and the packed
> > attribute should be dropped.
> 
> Yes. But are you going to audit every other use of __packed in the kernel
> to check if it is used on __iomem pointers?

As I've said, using __packed on __iomem pointers is fraught for many
reasons, and ignoring the other reasons and just concentrating on the
IO accessor problem is bad news in any case.

So yes, __packed needs to be solved _irrespective_ of the IO accessor
issue.
