From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Nov 2010 21:02:40 +0100
Subject: [PATCH] ARM: Gemini: Add support for PCI BUS
In-Reply-To: <4CF3F687.6040801@gmail.com>
References: <1290860675-15453-1-git-send-email-ulli.kroll@googlemail.com>
	<201011291745.22566.arnd@arndb.de> <4CF3F687.6040801@gmail.com>
Message-ID: <201011292102.41155.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 November 2010 19:52:55 Paulius Zaleckas wrote:
> On 11/29/2010 06:45 PM, Arnd Bergmann wrote:
> > There are many differences between readl and __raw_readl, including
> >
> > * __raw_readl does not have barriers and does not serialize with
> >    spinlocks, so it breaks on out-of-order CPUs.
> > * __raw_readl does not have a specific endianess, while readl is
> >    fixed little-endian, just as the hardware is in this case.
> >    The endian-conversion is a NOP on little-endian ARM, but required
> >    if you actually run on a big-endian ARM (you don't).
> > * __raw_readl may not be atomic, gcc is free to split the access
> >    into byte wise reads (it normally does not, unless you mark
> >    the pointer __attribute__((packed))).
> >
> > In essence, it is almost never a good idea to use __raw_readl, and
> > the double underscores should tell you so.
> 
> You are wrong:
> 
> Since CONFIG_ARM_DMA_MEM_BUFFERABLE is NOT defined for FA526 core,
> no barriers are in use when using readl. It just translates into
> le32_to_cpu(__raw_readl(x)). Now this CPU has physical pin for endianess
> configuration and if you will chose big-endian you will fail to read
> internal registers, because they ALSO change endianess and le32_to_cpu()
> will screw it. However it is different when accessing registers through
> PCI bus, then you need to use readl().

Ok, I only checked that the platform does not support big-endian Linux
kernel, not if the HW designers screwed up their registers, sorry about
that.

The other points are of course still valid: If the code ever gets
used on an out of order CPU, it is broken. More importantly, if someone
looks at the code as an example for writing another PCI support code,
it may end up getting copied to some place where it ends up causing
trouble.

The typical way to deal with mixed-endian hardware reliably is to have
a header file containing code like

#ifdef CONFIG_GEMINI_BIG_ENDIAN_IO
#define gemini_readl(x) __swab32(readl(x))
#define ...
#else
#define gemini_readl(x) readl(x))
#endif

This also takes care of the (not as unlikely as you'd hope) case that
the next person reusing the PCI hardware wires its endianess different
from the CPU endianess.

	Arnd
