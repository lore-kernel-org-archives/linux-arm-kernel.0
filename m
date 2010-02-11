From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Feb 2010 10:53:05 +0000
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <1265885102.3389.34.camel@pc1117.cambridge.arm.com>
References: <20100210212156.GB30854@n2100.arm.linux.org.uk>
	<1265885102.3389.34.camel@pc1117.cambridge.arm.com>
Message-ID: <1265885585.3389.38.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-02-11 at 10:45 +0000, Catalin Marinas wrote:
> On Wed, 2010-02-10 at 21:21 +0000, Russell King - ARM Linux wrote:
> > @@ -345,6 +347,7 @@ static inline dma_addr_t dma_map_single(struct device *dev, void *cpu_addr,
> >         BUG_ON(!valid_dma_direction(dir));
> >
> >         __dma_single_cpu_to_dev(cpu_addr, size, dir);
> > +       __dma_barrier(dir);
> >
> >         return virt_to_dma(dev, cpu_addr);
> >  }
> 
> The ___dma_single_cpu_to_dev() covers both inner and outer caches but I
> haven't seen it touched by this patch (nor the other you posted). When
> you clean the L1 cache, you need to make sure that there is a barrier
> (DSB) so that it completes before cleaning the L2, otherwise you clean
> the L2 but data keeps coming from L1.

Actually after L2 maintenance we don't even need the __dma_barrier(), we
need an outer_cache.sync() function.

I can do the outer cache optimisations together with a few others for
PL310 (which does not require the cache_wait() call for line
operations).

-- 
Catalin
