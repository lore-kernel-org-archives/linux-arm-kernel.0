From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 15 Mar 2016 12:33:03 +0000
Subject: [RFC 3/3] iommu: dma-iommu: use common implementation also on ARM
 architecture
In-Reply-To: <2724572.qtPjgumFDJ@wuerfel>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
 <1455870164-25337-4-git-send-email-m.szyprowski@samsung.com>
 <2724572.qtPjgumFDJ@wuerfel>
Message-ID: <56E800FF.6050705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek, Arnd,

On 19/02/16 10:30, Arnd Bergmann wrote:
> On Friday 19 February 2016 09:22:44 Marek Szyprowski wrote:
>> This patch replaces ARM-specific IOMMU-based DMA-mapping implementation
>> with generic IOMMU DMA-mapping code shared with ARM64 architecture. The
>> side-effect of this change is a switch from bitmap-based IO address space
>> management to tree-based code. There should be no functional changes
>> for drivers, which rely on initialization from generic arch_setup_dna_ops()
>> interface. Code, which used old arm_iommu_* functions must be updated to
>> new interface.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> I like the overall idea. However, this interface from the iommu
> subsystem into architecture specific code:
>
>> +/*
>> + * The DMA API is built upon the notion of "buffer ownership".  A buffer
>> + * is either exclusively owned by the CPU (and therefore may be accessed
>> + * by it) or exclusively owned by the DMA device.  These helper functions
>> + * represent the transitions between these two ownership states.
>> + *
>> + * Note, however, that on later ARMs, this notion does not work due to
>> + * speculative prefetches.  We model our approach on the assumption that
>> + * the CPU does do speculative prefetches, which means we clean caches
>> + * before transfers and delay cache invalidation until transfer completion.
>> + *
>> + */
>> +extern void __dma_page_cpu_to_dev(struct page *, unsigned long, size_t,
>> +				  enum dma_data_direction);
>> +extern void __dma_page_dev_to_cpu(struct page *, unsigned long, size_t,
>> +				  enum dma_data_direction);
>> +
>> +static inline void arch_flush_page(struct device *dev, const void *virt,
>> +			    phys_addr_t phys)
>> +{
>> +	dmac_flush_range(virt, virt + PAGE_SIZE);
>> +	outer_flush_range(phys, phys + PAGE_SIZE);
>> +}
>> +
>> +static inline void arch_dma_map_area(phys_addr_t phys, size_t size,
>> +				     enum dma_data_direction dir)
>> +{
>> +	unsigned int offset = phys & ~PAGE_MASK;
>> +	__dma_page_cpu_to_dev(phys_to_page(phys & PAGE_MASK), offset, size, dir);
>> +}
>> +
>> +static inline void arch_dma_unmap_area(phys_addr_t phys, size_t size,
>> +				       enum dma_data_direction dir)
>> +{
>> +	unsigned int offset = phys & ~PAGE_MASK;
>> +	__dma_page_dev_to_cpu(phys_to_page(phys & PAGE_MASK), offset, size, dir);
>> +}
>> +
>> +static inline pgprot_t arch_get_dma_pgprot(struct dma_attrs *attrs,
>> +					pgprot_t prot, bool coherent)
>> +{
>> +	if (coherent)
>> +		return prot;
>> +
>> +	prot = dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs) ?
>> +			    pgprot_writecombine(prot) :
>> +			    pgprot_dmacoherent(prot);
>> +	return prot;
>> +}
>> +
>> +extern void *arch_alloc_from_atomic_pool(size_t size, struct page **ret_page,
>> +					 gfp_t flags);
>> +extern bool arch_in_atomic_pool(void *start, size_t size);
>> +extern int arch_free_from_atomic_pool(void *start, size_t size);
>> +
>> +
>
> doesn't feel completely right yet. In particular the arch_flush_page()
> interface is probably still too specific to ARM/ARM64 and won't work
> that way on other architectures.
>
> I think it would be better to do this either more generic, or less generic:
>
> a) leave the iommu_dma_map_ops definition in the architecture specific
>     code, but make it call helper functions in the drivers/iommu to do all
>     of the really generic parts.

This was certainly the original intent of the arm64 code. The division 
of responsibility there is a conscious decision - IOMMU-API-wrangling 
goes in the common code, cache maintenance and actual dma_map_ops stay 
hidden in architecture-private code, safe from abuse. It's very much 
modelled on SWIOTLB.

Given all the work Russell did last year getting rid of direct uses of 
the dmac_* cache maintenance functions by ARM drivers, I don't think 
bringing all of that back is a good way to go - Personally I'd much 
rather see several dozen lines of very similar looking (other than 
highmem and outer cache stuff) arch-private code if it maintains a 
robust and clearly-defined abstraction (and avoids yet another level of 
indirection). It does also seem a little odd to factor out only half the 
file on the grounds of architectural similarity, when that argument 
applies equally to the other (non-IOMMU) half too. I think the recent 
tree-wide conversion to generic dma_map_ops was in part motivated by the 
thought of common implementations, so I'm sure that's something we can 
revisit in due course.

Robin.

>
> b) clarify that this is only applicable to arch/arm and arch/arm64, and
>     unify things further between these two, as they have very similar
>     requirements in the CPU architecture.
>
> 	Arnd
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
