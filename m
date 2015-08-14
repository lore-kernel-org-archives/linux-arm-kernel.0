From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 14 Aug 2015 17:06:09 +0200
Subject: [PATCH] ARM: dma-mapping: Don't use outer_flush_range when the
 L2C is coherent
In-Reply-To: <20150814143000.GF16368@e104818-lin.cambridge.arm.com>
References: <1439474365-12058-1-git-send-email-gregory.clement@free-electrons.com>
 <20150813151603.GB4602@e104818-lin.cambridge.arm.com>
 <55CDE3F6.7050401@free-electrons.com>
 <20150814143000.GF16368@e104818-lin.cambridge.arm.com>
Message-ID: <55CE03E1.5020001@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 14/08/2015 16:30, Catalin Marinas wrote:
>>>> -static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
>>>> -	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
>>>> +static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
>>>> +	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs,
>>>> +	    bool is_coherent)
>>>>  {
>>>>  	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
>>>>  	struct page **pages;
>>>> @@ -1381,7 +1395,7 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
>>>>  	 */
>>>>  	gfp &= ~(__GFP_COMP);
>>>>  
>>>> -	pages = __iommu_alloc_buffer(dev, size, gfp, attrs);
>>>> +	pages = __iommu_alloc_buffer(dev, size, gfp, attrs, is_coherent);
>>>>  	if (!pages)
>>>>  		return NULL;
>>>>  
>>>
>>> I can see you are trying to fix the iommu_alloc code to cope with
>>> coherent devices. I think it's currently broken and if you want to fix
>>
>> Could you explain what is broken exactly?
>> The way I tried to deal with coherency or something more low level?
> 
> The problem is that __iommu_alloc_atomic() allocates from a
> non-cacheable pool, which is fine when the device is not cache coherent
> but won't work as expected in the is_coherent case (the CPU and device
> must access the memory using the same cacheability attributes).

Thanks for the explanation.

> 
>>> In arm_iommu_alloc_attrs(), there is an __iommu_alloc_atomic() call
>>> which goes to the non-cacheable pool, it should use
>>> __alloc_simple_buffer() instead if is_coherent.
>>
>> __iommu_alloc_atomic is called when GFP_WAIT is not set meaning that
>> we can't sleep, but _alloc_simple_buffer can sleep. I follow the calls
>> inside this function and at a point we found a call to the might_sleep_if
>> macro:
>> http://lxr.free-electrons.com/source/mm/page_alloc.c#L2859
> 
> This might sleep thing is:
> 
> 	might_sleep_if(gfp_mask & __GFP_WAIT);
> 
> So it only sleeps if the __GFP_WAIT is set, but we would only call
> __alloc_simple_buffer() in the !__GFP_WAIT case, so there is no
> sleeping.

Yes my bad I inverted the logic at a point!

> 
> The reason to call __alloc_simple_buffer() (in the atomic alloc case) is
> to get cacheable memory, unlike __alloc_from_pool() which only returns
> memory from the non-cacheable pool.
> 
>> The _alloc_simple_buffer function ended by calling gen_pool_alloc
>> which won't sleep so from my point of view it is still the right
>> function to call. Did I miss something?
> 
> It's not just about sleep vs atomic but about cacheable vs non-cacheable
> as well.
> 
> As a quick fix, below is what I meant. It needs extra snippets from your
> patch to add arm_iommu_alloc_attrs_(coherent|noncoherent) and it's not
> tested, but just to give you an idea:

I am fine to make it a proper patch following my 1st patch. However I don't have
a platform with IOMMU so the test would have to be done by people ahving such
platforms.

Gregory
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 9f509b264346..e20a31d45ff3 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1335,13 +1335,16 @@ static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
>  	return NULL;
>  }
>  
> -static void *__iommu_alloc_atomic(struct device *dev, size_t size,
> -				  dma_addr_t *handle)
> +static void *__iommu_alloc_simple(struct device *dev, size_t size, gfp_t gfp,
> +				  dma_addr_t *handle, bool is_coherent)
>  {
>  	struct page *page;
>  	void *addr;
>  
> -	addr = __alloc_from_pool(size, &page);
> +	if (is_coherent)
> +		addr = __alloc_simple_buffer(dev, size, gfp, &page);
> +	else
> +		addr = __alloc_from_pool(size, &page);
>  	if (!addr)
>  		return NULL;
>  
> @@ -1356,15 +1359,18 @@ err_mapping:
>  	return NULL;
>  }
>  
> -static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
> -				dma_addr_t handle, size_t size)
> +static void __iommu_free_simple(struct device *dev, void *cpu_addr,
> +				dma_addr_t handle, size_t size, bool is_coherent)
>  {
>  	__iommu_remove_mapping(dev, handle, size);
> -	__free_from_pool(cpu_addr, size);
> +	if (is_coherent)
> +		__dma_free_buffer(virt_to_page(cpu_addr), size);
> +	else
> +		__free_from_pool(cpu_addr, size);
>  }
>  
> -static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
> -	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> +static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
> +	    dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs, bool is_coherent)
>  {
>  	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
>  	struct page **pages;
> @@ -1373,8 +1379,8 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
>  	*handle = DMA_ERROR_CODE;
>  	size = PAGE_ALIGN(size);
>  
> -	if (!(gfp & __GFP_WAIT))
> -		return __iommu_alloc_atomic(dev, size, handle);
> +	if (is_coherent || !(gfp & __GFP_WAIT))
> +		return __iommu_alloc_simple(dev, size, gfp, handle, is_coherent);
>  
>  	/*
>  	 * Following is a work-around (a.k.a. hack) to prevent pages
> @@ -1440,14 +1446,14 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   * free a page as defined by the above mapping.
>   * Must not be called with IRQs disabled.
>   */
> -void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> -			  dma_addr_t handle, struct dma_attrs *attrs)
> +void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> +			  dma_addr_t handle, struct dma_attrs *attrs, bool is_coherent)
>  {
>  	struct page **pages;
>  	size = PAGE_ALIGN(size);
>  
> -	if (__in_atomic_pool(cpu_addr, size)) {
> -		__iommu_free_atomic(dev, cpu_addr, handle, size);
> +	if (is_coherent || __in_atomic_pool(cpu_addr, size)) {
> +		__iommu_free_simple(dev, cpu_addr, handle, size, is_coherent);
>  		return;
>  	}
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
