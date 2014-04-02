From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Apr 2014 17:51:13 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <ebffe60db89d45ce883b1b9aff121152@BLUPR03MB373.namprd03.prod.outlook.com>
References: <20140324234443.GS7528@n2100.arm.linux.org.uk>
 <20140326001135.GV7528@n2100.arm.linux.org.uk>
 <20140401092638.GA10224@n2100.arm.linux.org.uk>
 <OF15BAA4F9.E675BBEF-ON87257CAD.006812E9-87257CAD.006BE81E@grpleg.it>
 <20140401225149.GC7528@n2100.arm.linux.org.uk>
 <b974be3a995f41029b54cfcc10c732ef@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402085914.GG7528@n2100.arm.linux.org.uk>
 <deb03b2af59a4fe7a46bc66278335826@BLUPR03MB373.namprd03.prod.outlook.com>
 <20140402104644.GI7528@n2100.arm.linux.org.uk>
 <ebffe60db89d45ce883b1b9aff121152@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <20140402165113.GJ7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 11:33:22AM +0000, fugang.duan at freescale.com wrote:
> In kernel 3.0.35, there have no CMA memory allocate mechanism.
> Below Kernel configs are enabled:
> CONFIG_ARM_DMA_MEM_BUFFERABLE
> CONFIG_SMP
> 
> If use dma_alloc_coherent() allocate memory, it must be non-cacheable,
> but bufferable.  The new invented api "dma_alloc_noncacheable()"
> allocate memory is non-cacheable, non-bufferable, the memory type is
> Strongly ordered.

Right, so what you've just said is that it's fine to violate the
requirements of the architecture L1 memory model by setting up a
strongly ordered memory mapping for the same physical addresses as
an existing mapping which is mapped as normal memory.

Sorry, I'm not going to listen to you anymore, you just lost any kind
of authority on this matter.

> >> So wmb() is not necessary.
> >
> >Even on non-cacheable normal memory, the wmb() is required.  Please read up in
> >the ARM architecture reference manual about memory types and their various
> >attributes, followed by the memory ordering chapters.
> >
> >> Yes, it don't impact imx6q since cpu loading is not bottleneck due
> >> rx/tx bandwidth is slow and multi-cores.  But for imx6sx, enet rx can
> >> reach at 940Mbps, tx can reach at 900Mbps, imx6sx is sigle core.
> >
> >What netdev features do you support to achieve that?
> >
> Imx6sx enet accleration feature support crc checksum, interrupt coalescing.
> So we enable the two features.

Checksum and... presumably you're referring to NAPI don't get you to that
kind of speed.  Even on x86, you can't get close to wire speed without
GSO, which you need scatter-gather for, and you don't support that.  So
I don't believe your 900Mbps figure.

Plus, as you're memcpy'ing every packet received, I don't believe you can
reach 940Mbps receive either.

> >> Enet IP don't support TSO feaure, cpu loading is the bottleneck. Wmb()
> >> is very expensive which cause tx performance drop much.
> >
> >wmb() is very expensive because of the L2 cache code using a sledge hammer with
> >it - particularly the spinlock, which has a large overhead if lockdep or
> >spinlock debugging is enabled.
>
> Yes, if add wmb() to xmit(), imx6sx enet performance will drop more
> than 100Mbps.

In any case, I suspect that isn't directly attributable to wmb() itself.
What I've noticed is that even changing an unsigned short to an unsigned
int *can* result in a substantial performance drop.  Although the
unsigned int results in fewer instructions, it's lower performance because
they're placed differently, and the efficiency of the instruction cache
changes, resulting in different throughput.

What this means is that even changing compiler versions can get you
significantly different performance figures.  So I don't attribute very
much creedence to "wmb() causes performance to drop 100Mbps".  It may
very well go back up with some other changes which result in a slightly
different placement of the instructions.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
