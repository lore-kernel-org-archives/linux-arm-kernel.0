From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 18:24:33 +0100
Subject: [PATCH 2/2] ARM: use ARM_DMA_ZONE_SIZE to adjust the zone sizes
In-Reply-To: <1305134498.10103.123.camel@e102109-lin.cambridge.arm.com>
References: <20110511162450.GF5315@n2100.arm.linux.org.uk>
	<E1QKCEB-0007Ns-AN@rmk-PC.arm.linux.org.uk>
	<1305134498.10103.123.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20110511172433.GH5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2011 at 06:21:38PM +0100, Catalin Marinas wrote:
> On Wed, 2011-05-11 at 17:25 +0100, Russell King - ARM Linux wrote:
> > Rather than each platform providing its own function to adjust the
> > zone sizes, use the new ARM_DMA_ZONE_SIZE definition to perform this
> > adjustment.  This ensures that the actual DMA zone size and the
> > ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS definitions are consistent with
> > each other, and moves this complexity out of the platform code.
> ...
> > diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
> > index 973428d..1759fa6 100644
> > --- a/arch/arm/mach-realview/include/mach/memory.h
> > +++ b/arch/arm/mach-realview/include/mach/memory.h
> > @@ -29,11 +29,7 @@
> >  #define PLAT_PHYS_OFFSET               UL(0x00000000)
> >  #endif
> > 
> > -#if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
> > -extern void realview_adjust_zones(unsigned long *size, unsigned long *hole);
> > -#define arch_adjust_zones(size, hole) \
> > -       realview_adjust_zones(size, hole)
> > -
> > +#ifdef CONFIG_ZONE_DMA
> >  #define ARM_DMA_ZONE_SIZE      SZ_256M
> >  #endif
> 
> We only use ZONE_DMA for PBX and realview_adjust_zones() does this
> check. We end up with limiting the DMA zone to 256MB on all RealView
> platforms if we compile a single kernel image that includes PBX. Not a
> big problem though:

You've already implicitly limited it by the ISA_DMA_THRESHOLD/
MAX_DMA_ADDRESS definition - what's left is an inconsistent relative
size of those definitions and the actual DMA zone.  That inconsistency
can cause the DMA allocator to fail unexpectedly as it assumes that
GFP_DMA will return a page which will satisfy ISA_DMA_THRESHOLD.

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.
