From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Mar 2016 17:33:17 +0000
Subject: [PATCH] Revert "arm64: Increase the max granular size"
In-Reply-To: <20160321172301.GP23397@arm.com>
References: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
 <DA22064C-45A7-4F79-A433-84054AF182DF@caviumnetworks.com>
 <20160321171403.GE25466@e104818-lin.cambridge.arm.com>
 <20160321172301.GP23397@arm.com>
Message-ID: <20160321173317.GF25466@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:23:01PM +0000, Will Deacon wrote:
> On Mon, Mar 21, 2016 at 05:14:03PM +0000, Catalin Marinas wrote:
> > diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> > index 5082b30bc2c0..4b5d7b27edaf 100644
> > --- a/arch/arm64/include/asm/cache.h
> > +++ b/arch/arm64/include/asm/cache.h
> > @@ -18,17 +18,17 @@
> >  
> >  #include <asm/cachetype.h>
> >  
> > -#define L1_CACHE_SHIFT		7
> > +#define L1_CACHE_SHIFT		6
> >  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
> >  
> >  /*
> >   * Memory returned by kmalloc() may be used for DMA, so we must make
> > - * sure that all such allocations are cache aligned. Otherwise,
> > - * unrelated code may cause parts of the buffer to be read into the
> > - * cache before the transfer is done, causing old data to be seen by
> > - * the CPU.
> > + * sure that all such allocations are aligned to the maximum *known*
> > + * cache line size on ARMv8 systems. Otherwise, unrelated code may cause
> > + * parts of the buffer to be read into the cache before the transfer is
> > + * done, causing old data to be seen by the CPU.
> >   */
> > -#define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
> > +#define ARCH_DMA_MINALIGN	(128)
> 
> Does this actually fix the reported iperf regression? My assumption was
> that ARCH_DMA_MINALIGN is the problem, but I could be wrong.

I can't tell. But since I haven't seen any better explanation in this
thread yet, I hope that at least someone would try this patch and come
back with numbers.

For networking, SKB_DATA_ALIGN() uses SMP_CACHE_BYTES (== L1_CACHE_BYTES).
I think (hope) this alignment is not meant for non-coherent DMA,
otherwise using SMP_CACHE_BYTES wouldn't make sense.

-- 
Catalin
