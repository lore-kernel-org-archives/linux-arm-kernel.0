From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Feb 2010 10:45:01 +0000
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <20100210212156.GB30854@n2100.arm.linux.org.uk>
References: <20100210212156.GB30854@n2100.arm.linux.org.uk>
Message-ID: <1265885102.3389.34.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-10 at 21:21 +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 10, 2010 at 12:37:28PM -0800, adharmap at codeaurora.org wrote:
> > From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> >
> > Please refer to the post here
> > http://lkml.org/lkml/2010/1/4/347
> >
> > These changes are to introduce barrierless dma_map_area and dma_unmap_area and
> > use them to map the buffers in the scatterlist. For the last buffer, call
> > the normal dma_map_area(aka with barriers) effectively executing the barrier
> > at the end of the operation.
> 
> What if we make dma_map_area and dma_unmap_area both be barrier-less,
> and instead have a separate dma_barrier method - eg, something like the
> attached?

I was just writing the reply when I noticed yours :). Yes, that's a
better approach.

> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> index e290885..5928e78 100644
> --- a/arch/arm/include/asm/cacheflush.h
> +++ b/arch/arm/include/asm/cacheflush.h
> @@ -200,6 +200,7 @@ struct cpu_cache_fns {
> 
>         void (*dma_map_area)(const void *, size_t, int);
>         void (*dma_unmap_area)(const void *, size_t, int);
> +       void (*dma_barrier)(void);

Alternatively we could use the dsb() macro. I don't think we need more
than this and we would not (well, not easily) compile ARMv5 and ARMv6 in
the same kernel.

Anyway, an additional branch and return would probably be negligible
compared to the cache flushing operation.

> @@ -345,6 +347,7 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
>         BUG_ON(!valid_dma_direction(dir));
> 
>         __dma_single_cpu_to_dev(cpu_addr, size, dir);
> +       __dma_barrier(dir);
> 
>         return virt_to_dma(dev, cpu_addr);
>  }

The ___dma_single_cpu_to_dev() covers both inner and outer caches but I
haven't seen it touched by this patch (nor the other you posted). When
you clean the L1 cache, you need to make sure that there is a barrier
(DSB) so that it completes before cleaning the L2, otherwise you clean
the L2 but data keeps coming from L1.

For the *_sg functions, you either use barrier between L1 and L2 for
each page or you do the for_each_sg() loop twice, once for L1 and
another for L2.

-- 
Catalin
