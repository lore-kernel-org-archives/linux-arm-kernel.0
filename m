From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 13:14:41 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <alpine.LFD.2.00.1107062043180.14596@xanadu.home>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230455.GZ8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062043180.14596@xanadu.home>
Message-ID: <20110708121441.GD4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 10:46:03PM -0400, Nicolas Pitre wrote:
> On Thu, 7 Jul 2011, Russell King - ARM Linux wrote:
> 
> > On Tue, Jul 05, 2011 at 10:30:33PM -0400, Nicolas Pitre wrote:
> > > +extern unsigned long arm_dma_zone_size;
> > > +#define MAX_DMA_ADDRESS	(PAGE_OFFSET + arm_dma_zone_size)
> > ...
> > > -#ifndef ARM_DMA_ZONE_SIZE
> > > +#ifndef CONFIG_ZONE_DMA
> > >  #define ISA_DMA_THRESHOLD	(0xffffffffULL)
> > >  #else
> > > -#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + ARM_DMA_ZONE_SIZE - 1)
> > > +#define ISA_DMA_THRESHOLD	({ \
> > > +	extern unsigned long arm_dma_zone_size; \
> > > +	arm_dma_zone_size ? \
> > > +		(PHYS_OFFSET + arm_dma_zone_size - 1) : 0xffffffffULL; })
> > 
> > These two usages do not agree.  With unrestricted DMA, both
> > MAX_DMA_ADDRESS and ISA_DMA_THRESHOLD should be 0xffffffff.  However,
> > you get that with arm_dma_zone_size=0 for ISA_DMA_THRESHOLD, which
> > then gives a MAX_DMA_ADDRESS of PAGE_OFFSET.  So this potentially
> > changes the behaviour of these macros.
> 
> Looking at what other architectures do, we have:
> 
> avr32, parisc, powerpc, sparc -> 0xffffffff
> 
> cris, frv, h8300, m68k, mips -> PAGE_OFFSET
> 
> microblaze, score, xtensa -> 0
> 
> So I wonder if this macro makes any sense when there is no DMA zone.  
> 
> OTOH, since it is almost never used, it is best to make it behave 
> like the original. Fixed tusly in my tree:
> 
> diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
> index 1d34c11..fcf15de 100644
> --- a/arch/arm/include/asm/dma.h
> +++ b/arch/arm/include/asm/dma.h
> @@ -9,8 +9,10 @@
>  #ifndef CONFIG_ZONE_DMA
>  #define MAX_DMA_ADDRESS	0xffffffffUL
>  #else
> -extern unsigned long arm_dma_zone_size;
> -#define MAX_DMA_ADDRESS	(PAGE_OFFSET + arm_dma_zone_size)
> +#define MAX_DMA_ADDRESS	({ \
> +	extern unsigned long arm_dma_zone_size; \
> +	arm_dma_zone_size ? \
> +		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
>  #endif
>  
>  #ifdef CONFIG_ISA_DMA_API
> 
> Yet, excluding sound/oss/dmabuf.c, this is used by only 6 drivers in the 
> whole tree which appear to be old ISA based drivers which would use a a 
> DMA zone already.  The exception is cs89x0.c, however MAX_DMA_ADDRESS is 
> only used in the context of ISA DMA.

Most drivers treat it as a virtual address, and it's used to determine
whether a driver private bounce buffer needs to be used.  Setting it
to PAGE_OFFSET means that the bounce buffer will always be used.  Setting
it to all-ones means that the bounce buffer will never be used and some
code will be optimized away.  Intermediate settings means that we get
run-time checks which aren't required on ARM platforms.

> What is more worrisome is its usage in a few places in the mm code where 
> it is always passed to __pa().  Certainly __pa(0xffffffff) is not going 
> to produce sensible results.

The only real user there is bootmem, which hopefully will be killed
off on ARM soon.  In any case, I wouldn't worry about that at the
moment because it's been that way for a long time and we haven't had
any reports of badness from it.

> One thing is for sure: ISA_DMA_THRESHOLD is not used anywhere in the 
> whole tree except in arch/arm/mm/dma-mapping.c:get_coherent_dma_mask() 
> and arch/arm/include/asm/dma-mapping.h:dma_supported() where its usage 
> is certainly not ISA specific.  Maybe this should be renamed?

It looks like ISA_DMA_THRESHOLD has become unused by most of the kernel,
so yes, renaming it to "dma_zone_limit" would be more descriptive.  We
should probably make dma_supported() be out-of-line anyway (which then
means that dma_zone_limit doesn't have to be exported to drivers) - and
I think the DMA bounce stuff needs cleaning up in dma_set_mask().
