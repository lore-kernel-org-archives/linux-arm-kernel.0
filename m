From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jul 2010 13:39:48 +0200
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <1278714714.30012.14.camel@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<201007092130.17504.arnd@arndb.de>
	<1278714714.30012.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201007121339.48719.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 July 2010, Catalin Marinas wrote:
> > Right. IMHO the PCI IO variants should get the same barriers that
> > Catalin is introducing in the PCI MEM variants. The ordering requirements
> > for IO accesses are stricter than those for MEM, the main difference
> > being that MEM writes are posted while IO writes are synchronizing.
> 
> Linux docs don't clearly define the ordering requirements. There are
> various e-mail threads but not a finalised document. In principle,
> trying to be as close to x86 as possible, in which case we probably need
> barriers here as well.

Right, emulating x86 behaviour for any PCI access with inl/readl/ioread32
and their counterparts seems to be the only practical answer.
It would be nice to have an architecture independent way of doing non-PCI
register access, and more importantly relaxed accesses to those.

Note that no other architecture currently defines write*_relaxed(), only
read*_relaxed(). Maybe we should add them everywhere, not just on ARM.

> > Thinking about it from this angle, I'm not even sure that x86 compatibility
> > requires arm to add wmb() after writel(). IIRC, PCI memory space writes are
> > required to be ordered with regard to each other, but not necessarily
> > with regard to other CPU instructions or DMA transfers, unlike memory
> > space reads and IO space read/write accesses.
> 
> We don't need a wmb() after writel(), my patch only adds wmb() before
> writel(). We need previous DMA buffer writes to be visible before
> writel(), otherwise we get corrupted DMA transfers.

Ah, that's right: writel and outl both need the barrier before the access,
but writel will never need a barrier after the access.
The x86 variant of outl also has the implicit ordering after the access,
but I'm not sure if we need to emulate that. I can't currently think
of a case where it's strictly required because any later access to the same
PCI function will be ordered anyway.

	Arnd
