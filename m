From: Jan.JABLONSKY@thalesgroup.com (JABLONSKY Jan)
Date: Thu, 22 Nov 2018 12:25:18 +0000
Subject: arm: dma-mapping: CPU may not see up-to-date data after DMA
 transaction
In-Reply-To: <20181122092928.GF30658@n2100.armlinux.org.uk>
References: <1542872133.26115.4.camel@atviedlbe741.rss.d3s.at.thales>
 <20181122092928.GF30658@n2100.armlinux.org.uk>
Message-ID: <1542889465.26115.54.camel@atviedlbe741.rss.d3s.at.thales>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After DMA transaction is complete, content of the DMA buffer is stored in the main memory.

outer_inv_range invalidates cache lines only in L2 level.
outer_cache is dedicated to L2 cache, but CPU must also clean L1 dcache to avoid possible L1 hit


Functions __sync_cache_range_r/w handle L1 and also L2 cache maintenance

That means outer_cache_* functions (within __dma_page_cpu_to_dev and __dma_page_dev_to_cpu) they can be replaced with functions below:

outer_inv_range -> __sync_cache_range_r
outer_clean_range -> __sync_cache_range_w

- __sync_cache_range_r -> - When DMA writes and CPU read
                          - to achieve reading direct from main memory (L1 miss, L2 miss)
                          - Ensure preceding writes to *p by other CPUs are visible to
                            subsequent reads by this CPU 
and

- __sync_cache_range_w -> - When CPU writes and DMA read
                          - Ensure preceding writes to *p by this CPU are visible to
                            subsequent reads by other CPUs


Similar problem is also described in the link below:
https://community.arm.com/processors/f/discussions/6555/need-to-invalidate-l1-cache-after-dma-on-cortex-a9



Test case:
The problem appears during calculation of md5sum of eMMC (16GB) in the loop.
After some time (e.g. 1-2 hours), md5sum may be different

For example:
5c2b3c7a6d69a2f6c4c1ddfdd3bf1ed5  /dev/mmcblk0     time 746 [s]
5c2b3c7a6d69a2f6c4c1ddfdd3bf1ed5  /dev/mmcblk0     time 738 [s]
c5f2bb8e9d83744d4087450d6274208e  /dev/mmcblk0     time 691 [s]
...


I hope, now is more clear for you



On Do, 2018-11-22 at 09:29 +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 22, 2018 at 07:36:26AM +0000, JABLONSKY Jan wrote:
> > Proper cleaning and invalidating has to be performed also for inner cache,
> > otherwise CPU may work with data from inner cache
> 
> The functions are _already_ performing cache maintanence on the inner
> cache, this patch makes no sense.
> 
> > Problem appears on The Altera SoC FPGA (Cortex-A9), during
> > higher CPU and system memory load followed reading by CPU from memory after
> > DMA transaction.
> > That means CPU may not see most up-to-date and correct copy of DMA buffer.
> > 
> > Replace with functions __sync_cache_range_r/w, which handle mentioned
> > situation.
> > Protect against preemption to make sure, that the code is
> > running on the current CPU
> 
> This is too vague to say much more.
> 
> > 
> > Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
> > ---
> >  arch/arm/mm/dma-mapping.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 661fe48ab78d..f40dc8b250d8 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -997,11 +997,18 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
> >  	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
> >  
> >  	paddr = page_to_phys(page) + off;
> > +
> > +	/*
> > +	 * Protect against preemption
> > +	 * Ensure that the code is running on the current CPU
> > +	 */
> > +	preempt_disable();
> >  	if (dir == DMA_FROM_DEVICE) {
> > -		outer_inv_range(paddr, paddr + size);
> > +		__sync_cache_range_r(phys_to_virt(paddr), size);
> >  	} else {
> > -		outer_clean_range(paddr, paddr + size);
> > +		__sync_cache_range_w(phys_to_virt(paddr), size);
> >  	}
> > +	preempt_enable();
> >  	/* FIXME: non-speculating: flush on bidirectional mappings? */
> >  }
> >  
> > @@ -1013,7 +1020,13 @@ static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
> >  	/* FIXME: non-speculating: not required */
> >  	/* in any case, don't bother invalidating if DMA to device */
> >  	if (dir != DMA_TO_DEVICE) {
> > -		outer_inv_range(paddr, paddr + size);
> > +		/*
> > +		 * Protect against preemption
> > +		 * Ensure that the code is running on the current CPU
> > +		 */
> > +		preempt_disable();
> > +		__sync_cache_range_r(phys_to_virt(paddr), size);
> > +		preempt_enable();
> >  
> >  		dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
> >  	}
> 
