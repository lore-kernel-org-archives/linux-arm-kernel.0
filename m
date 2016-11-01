From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 1 Nov 2016 12:56:22 +0000
Subject: [PATCH] staging: vc04_services: setup DMA and coherent mask
In-Reply-To: <1477943593.30971.3.camel@crowfest.net>
References: <20161028171159.23973-1-mzoran@crowfest.net>
 <87twbsqsb4.fsf@eliezer.anholt.net> <1477939258.30971.1.camel@crowfest.net>
 <1477943593.30971.3.camel@crowfest.net>
Message-ID: <f98b3421-af7b-b351-99b5-300971047219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On 31/10/16 19:53, Michael Zoran wrote:
> On Mon, 2016-10-31 at 11:40 -0700, Michael Zoran wrote:
>> On Mon, 2016-10-31 at 11:36 -0700, Eric Anholt wrote:
>>> Michael Zoran <mzoran@crowfest.net> writes:
>>>
>>>> Setting the DMA mask is optional on 32 bit but
>>>> is mandatory on 64 bit.  Set the DMA mask and coherent
>>>> to force all DMA to be in the 32 bit address space.
>>>>
>>>> This is considered a "good practice" and most drivers
>>>> already do this.
>>>>
>>>> Signed-off-by: Michael Zoran <mzoran@crowfest.net>
>>>> ---

[...]

>>>> +	/*
>>>> +	 * Setting the DMA mask is necessary in the 64 bit
>>>> environment.
>>>> +	 * It isn't necessary in a 32 bit environment but is
>>>> considered
>>>> +	 * a good practice.
>>>> +	 */
>>>> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>>
>>> I think a better comment here would be simply:
>>>
>>> /* VCHI messages between the CPU and firmware use 32-bit bus
>>> addresses. */
>>>
>>> explaining why the value is chosen (once you know that the 32 bit
>>> restriction exists, reporting it is obviously needed).  I'm
>>> curious,
>>> though: what failed when you didn't set it?
>>>
>>
>> The comment is easy to change.
>>
>> I don't have the log available ATM, but if I remember the DMA API's
>> bugcheck the first time that are used.  
>>
>> I think this was a policy decision or something because the
>> information
>> should be available in the dma-ranges.
>>
>> If it's important, I can setup a test again without the change and e-
>> mail the logs.
>>
>> If you look at the DWC2 driver you will see that it also sets this
>> mask.
> 
> OK, I'm begging to understand this.  It appears the architecture
> specific paths are very different.
> 
> In arm the mask and coherent is set to DMA_BIT_MASK(32) in mm/dma-
> mapping.c the first time the dma APIs are used.  On arm64, it appears
> this variable is uninitialized and will contain random crude.
> 
> Like I said, I don't know if this is a policy decision or if it just
> slipped through the cracks.

[...]

> arch/arm64/mm/dma-mapping.c(Note no call to get_coherent_dma_mask)
> 
> static void *__dma_alloc(struct device *dev, size_t size,
> 			 dma_addr_t *dma_handle, gfp_t flags,
> 			 unsigned long attrs)
> {
> 	struct page *page;
> 	void *ptr, *coherent_ptr;
> 	bool coherent = is_device_dma_coherent(dev);
> 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL, false);
> 
> 	size = PAGE_ALIGN(size);
> 
> 	if (!coherent && !gfpflags_allow_blocking(flags)) {
> 		struct page *page = NULL;
> 		void *addr = __alloc_from_pool(size, &page, flags);
> 
> 		if (addr)
> 			*dma_handle = phys_to_dma(dev,
> page_to_phys(page));
> 
> 		return addr;
> 	}
> 
> 	ptr = __dma_alloc_coherent(dev, size, dma_handle, flags,
> attrs);

In the general case, the device's coherent DMA mask is checked inside
that helper function, and then again further on in the SWIOTLB code if
necessary. For the atomic pool case beforehand, the pool is already
allocated below 4GB, and on arm64 we don't really expect devices to have
DMA masks *smaller* than 32 bits.

Devices created from DT get 32-bit DMA masks by default, although the
dma-ranges property may override that - see of_dma_configure() - so if
you somehow have a device with an uninitialised mask then I can only
assume there's some platform driver shenanigans going on. Adding the
dma_set_mask() call to the driver is no bad thing, but the rationale in
the commit message is bogus.

Robin.
