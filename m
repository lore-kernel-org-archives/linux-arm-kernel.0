From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Jul 2011 22:46:03 -0400 (EDT)
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <20110706230455.GZ8286@n2100.arm.linux.org.uk>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230455.GZ8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107062043180.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Russell King - ARM Linux wrote:

> On Tue, Jul 05, 2011 at 10:30:33PM -0400, Nicolas Pitre wrote:
> > +extern unsigned long arm_dma_zone_size;
> > +#define MAX_DMA_ADDRESS	(PAGE_OFFSET + arm_dma_zone_size)
> ...
> > -#ifndef ARM_DMA_ZONE_SIZE
> > +#ifndef CONFIG_ZONE_DMA
> >  #define ISA_DMA_THRESHOLD	(0xffffffffULL)
> >  #else
> > -#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1)
> > +#define ISA_DMA_THRESHOLD	({ \
> > +	extern unsigned long arm_dma_zone_size; \
> > +	arm_dma_zone_size ? \
> > +		(PHYS_OFFSET + arm_dma_zone_size - 1) : 0xffffffffULL; })
> 
> These two usages do not agree.  With unrestricted DMA, both
> MAX_DMA_ADDRESS and ISA_DMA_THRESHOLD should be 0xffffffff.  However,
> you get that with arm_dma_zone_size=0 for ISA_DMA_THRESHOLD, which
> then gives a MAX_DMA_ADDRESS of PAGE_OFFSET.  So this potentially
> changes the behaviour of these macros.

Looking at what other architectures do, we have:

avr32, parisc, powerpc, sparc -> 0xffffffff

cris, frv, h8300, m68k, mips -> PAGE_OFFSET

microblaze, score, xtensa -> 0

So I wonder if this macro makes any sense when there is no DMA zone.  

OTOH, since it is almost never used, it is best to make it behave 
like the original. Fixed tusly in my tree:

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index 1d34c11..fcf15de 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -9,8 +9,10 @@
 #ifndef CONFIG_ZONE_DMA
 #define MAX_DMA_ADDRESS	0xffffffffUL
 #else
-extern unsigned long arm_dma_zone_size;
-#define MAX_DMA_ADDRESS	(PAGE_OFFSET + arm_dma_zone_size)
+#define MAX_DMA_ADDRESS	({ \
+	extern unsigned long arm_dma_zone_size; \
+	arm_dma_zone_size ? \
+		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
 #endif
 
 #ifdef CONFIG_ISA_DMA_API

Yet, excluding sound/oss/dmabuf.c, this is used by only 6 drivers in the 
whole tree which appear to be old ISA based drivers which would use a a 
DMA zone already.  The exception is cs89x0.c, however MAX_DMA_ADDRESS is 
only used in the context of ISA DMA.

What is more worrisome is its usage in a few places in the mm code where 
it is always passed to __pa().  Certainly __pa(0xffffffff) is not going 
to produce sensible results.

One thing is for sure: ISA_DMA_THRESHOLD is not used anywhere in the 
whole tree except in arch/arm/mm/dma-mapping.c:get_coherent_dma_mask() 
and arch/arm/include/asm/dma-mapping.h:dma_supported() where its usage 
is certainly not ISA specific.  Maybe this should be renamed?


Nicolas
