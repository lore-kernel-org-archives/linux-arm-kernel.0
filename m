From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Jul 2011 23:31:25 -0400 (EDT)
Subject: [PATCH 05/10] ARM: mach-ixp4xx: move from ARM_DMA_ZONE_SIZE to
	mdesc->dma_zone_size
In-Reply-To: <20110706231259.GC8286@n2100.arm.linux.org.uk>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<1309919442-20451-5-git-send-email-nicolas.pitre@linaro.org>
	<20110706231259.GC8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107062300080.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Russell King - ARM Linux wrote:

> On Tue, Jul 05, 2011 at 10:30:37PM -0400, Nicolas Pitre wrote:
> > +#if defined(config_PCI) && !defined(CONFIG_IXP4XX_INDIRECT_PCI)
> 
> This won't fly.  CONFIG has to be upper case.  Multiple instances of
> that in this patch.

Okay... Obviously the fact that one's unidimensional 40x1 display made 
of mechanically raised pixels might have some of those pixels stuck in 
their set position is enough to confuse lower and upper case braille 
characters (yes I should have it fixed).

Fixed the code in the mean time, and compile tested it.  turns out that 
an unrelated file doesn't compile:

arch/arm/mach-ixp4xx/common.c: In function 'ixp4xx_clocksource_init':
arch/arm/mach-ixp4xx/common.c:428:2: error: lvalue required as unary '&' operand

> > diff --git a/arch/arm/mach-ixp4xx/include/mach/memory.h b/arch/arm/mach-ixp4xx/include/mach/memory.h
> > index 34e7940..4caf176 100644
> > --- a/arch/arm/mach-ixp4xx/include/mach/memory.h
> > +++ b/arch/arm/mach-ixp4xx/include/mach/memory.h
> > @@ -14,8 +14,4 @@
> >   */
> >  #define PLAT_PHYS_OFFSET	UL(0x00000000)
> >  
> > -#ifdef CONFIG_PCI
> > -#define ARM_DMA_ZONE_SIZE	SZ_64M
> > -#endif
> 
> And the addition of dependence on CONFIG_IXP4XX_INDIRECT_PCI needs someone
> from the IXP4xx folk to ACK as that's a functional change.

The motivation for this change can be found in the Kconfig help text for 
IXP4XX_INDIRECT_PCI which looked pretty clear.  But this would be best 
if done in a separate patch so I've reverted this patch to the single 
CONFIG_PCI dependency.


Nicolas
