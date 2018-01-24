From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 24 Jan 2018 13:14:56 +0000
Subject: [PATCH 3/5] drm: add ARM64 flush implementations
In-Reply-To: <20180124123644.GU17719@n2100.armlinux.org.uk>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
 <20180124025606.3020-3-gurchetansingh@chromium.org>
 <2cf40ed8-cb7c-3f17-a8e4-2cbf2fb980e6@arm.com>
 <20180124123644.GU17719@n2100.armlinux.org.uk>
Message-ID: <e1bb338d-78a7-870e-20a1-756e9a36f1ed@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/18 12:36, Russell King - ARM Linux wrote:
> On Wed, Jan 24, 2018 at 12:00:59PM +0000, Robin Murphy wrote:
>> On 24/01/18 02:56, Gurchetan Singh wrote:
>>> This patch uses the __dma_map_area function to flush the cache
>>> on ARM64.
>>>
>>> v2: Don't use DMA API, call functions directly (Daniel)
>>>
>>> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>>> ---
>>>   drivers/gpu/drm/drm_cache.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
>>> index 5124582451c6..250cdfbb711f 100644
>>> --- a/drivers/gpu/drm/drm_cache.c
>>> +++ b/drivers/gpu/drm/drm_cache.c
>>> @@ -159,6 +159,12 @@ drm_flush_pages(struct page *pages[], unsigned long num_pages)
>>>   	for (i = 0; i < num_pages; i++)
>>>   		drm_cache_maint_page(pages[i], 0, PAGE_SIZE, DMA_TO_DEVICE,
>>>   				     dmac_map_area);
>>> +#elif defined(CONFIG_ARM64)
>>> +	unsigned long i;
>>> +
>>> +	for (i = 0; i < num_pages; i++)
>>> +		__dma_map_area(phys_to_virt(page_to_phys(pages[i])), PAGE_SIZE,
>>> +			       DMA_TO_DEVICE);
>>
>> Note that this is not exactly equivalent to clflush - if it's at all
>> possible for a non-coherent GPU to write back to these pages and someone
>> somewhere expects to be able to read the updated data from a CPU, that's
>> going to be subtly broken.
>>
>> This also breaks building DRM as a module. And I doubt that either of the
>> two easy solutions to that are going to fly with the respective
>> maintainers...
>>
>> Given all the bodging around which seems to happen in DRM/ION/etc., it would
>> be really nice to pin down what exactly the shortcomings of the DMA API are
>> for these use-cases, and extend it to address them properly.
> 
> Aren't the cache flushing instructions available from userspace on
> ARM64?  (I've certainly used them in my spectre/meltdown PoC).  If
> userspace wants to flush before reading a GPU buffer that has been
> writtent to, why can't it use the already available cache maintenance
> instructions?  It's likely to be quicker, and it can target just the
> area of the buffer it wants to read.

Indeed, whilst the main reason we enable EL0 cache maintenance access is 
for JITs cleaning to PoU, it inherently makes PoC operations available 
as well. The semantics of drm_clflush_*() weren't immediately obvious, 
but if it is purely a sync point around userspace reading/writing GPU 
buffers directly, then what you suggest does sound ideal (and 
__dma_map_area is definitely wrong for the read case as above).

> 
> 32-bit ARM is a different matter, and I'll reply separately.
> 

Thanks,
Robin.
