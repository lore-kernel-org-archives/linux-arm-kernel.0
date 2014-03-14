From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 13 Mar 2014 18:53:59 -0700
Subject: [PATCH 1/2] arm64: Implement custom mmap functions for dma mapping
In-Reply-To: <20140313174915.GN30339@arm.com>
References: <1394732716-11507-1-git-send-email-lauraa@codeaurora.org>
 <20140313174915.GN30339@arm.com>
Message-ID: <53226137.3070404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/13/2014 10:49 AM, Catalin Marinas wrote:
> On Thu, Mar 13, 2014 at 05:45:15PM +0000, Laura Abbott wrote:
>> +/* vma->vm_page_prot must be set appropriately before calling this function */
>> +static int __dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>> +			     void *cpu_addr, dma_addr_t dma_addr, size_t size)
>> +{
>> +	int ret = -ENXIO;
>> +	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
>> +					PAGE_SHIFT;
>> +	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +	unsigned long pfn = dma_to_phys(dev, dma_addr) >> PAGE_SHIFT;
>> +	unsigned long off = vma->vm_pgoff;
>> +
>> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
>> +		return ret;
>> +
>> +	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
>> +		ret = remap_pfn_range(vma, vma->vm_start,
>> +				      pfn + off,
>> +				      vma->vm_end - vma->vm_start,
>> +				      vma->vm_page_prot);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int arm64_swiotlb_mmap_noncoherent(struct device *dev,
>> +		struct vm_area_struct *vma,
>> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>> +		struct dma_attrs *attrs)
>> +{
>> +	/* Just use whatever page_prot attributes were specified */
>> +	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
>> +}
>> +
>> +static int arm64_swiotlb_mmap_coherent(struct device *dev,
>> +		struct vm_area_struct *vma,
>> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>> +		struct dma_attrs *attrs)
>> +{
>> +	vma->vm_page_prot = pgprot_dmacoherent(vma->vm_page_prot);
>> +	return __dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
>> +}
>
> So I think we got the naming the other way around. The
> noncoherent_dma_ops assume that the DMA is non-coherent and therefore
> must change the pgprot.

I spent way too long convincing myself this was right and I was still 
wrong. I'll fix it up for v2 (I have one more patch I need to put in for 
CMA integration as well)

Thanks,
Laura
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
