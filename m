From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 22:26:37 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <20110620184849.GI26089@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1106201306210.2142@xanadu.home>
	<Pine.LNX.4.44L0.1106201329390.2113-100000@iolanthe.rowland.org>
	<20110620184849.GI26089@n2100.arm.linux.org.uk>
Message-ID: <201106202226.37381.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011 20:48:49 Russell King - ARM Linux wrote:
> On Mon, Jun 20, 2011 at 01:35:35PM -0400, Alan Stern wrote:
> > According to Arnd, any remaining possible issues will be addressed by
> > changing the implementation of readl/writel on ARM.  It doesn't look as
> > though the ehci files need anything else done.
> 
> I'm not about to change their implementation because they've proven
> themselves over the last 10 years to be perfectly fine, and changing
> them has a habbit of causing GCC to play less optimally than it should
> do.

Well, we do know that gcc now makes different tradeoffs, and that it's
entirely within the C99 specification when it's generating byte accesses
from __raw_readl(). The case where the pointer is __packed is just the
obvious case where it would do that, and I fully agree that the __packed
in that case is a bug, but I'm much in favor of writing code so that
we instruct the compiler to create correct code rather than giving it
the choice between correct and incorrect.

> I've seen drivers where GCC reloads the base address from the driver
> private data structure each time a register access is performed, rather
> than caching the base address in a register.  I've seen it issuing
> separate add instructions and using a zero pre-index load/store.  The
> existing way is the only way I've found to get GCC to come anywhere
> close to producing "optimal" code for the IO accessors.

Two points here:

* What's the olders compiler that we really need to be able to build
  efficient kernels? Would you consider it if we can show that gcc-4.2
  and higher produce code that is as good as the existing macros?
  How about making the code gcc version dependent?

* We already need a compiler barrier in the non-_relaxed() versions of
  the I/O accessors, which will force a reload of the base address
  in a lot of cases, so the code is already suboptimal. Yes, we don't
  have the barrier today without CONFIG_ARM_DMA_MEM_BUFFERABLE, but that
  is a bug, because it lets the compiler move accesses to DMA buffers
  around readl/writel.

> If it is the case that these structures do not require packing to get
> their desired layout, then they don't require packing, and the packed
> attribute should be dropped.

Yes. But are you going to audit every other use of __packed in the kernel
to check if it is used on __iomem pointers?

	Arnd
