From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Apr 2018 16:32:13 +0100
Subject: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
In-Reply-To: <1a1d0069-c8d3-cc0d-cf1c-8e90e4a2b0d7@codeaurora.org>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
 <1a1d0069-c8d3-cc0d-cf1c-8e90e4a2b0d7@codeaurora.org>
Message-ID: <2d812da5-1c0d-0e53-83f2-ba1781a12fe9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/18 15:33, Sinan Kaya wrote:
> On 4/11/2018 8:03 AM, Robin Murphy wrote:
>> On 10/04/18 21:59, Sinan Kaya wrote:
>>> Code is expecing to observe the same number of buffers returned
>>> from dma_map_sg() function compared to
>>> sg_alloc_table_from_pages(). This doesn't hold true universally
>>> especially for systems with IOMMU.
>> 
>> So why not fix said code? It's clearly not a real hardware
>> limitation, and the map_sg() APIs have potentially returned fewer
>> than nents since forever, so there's really no excuse.
> 
> Sure, I'll take a better fix if there is one.
> 
>> 
>>> IOMMU driver tries to combine buffers into a single DMA address
>>> as much as it can. The right thing is to tell the DMA layer how
>>> much combining IOMMU can do.
>> 
>> Disagree; this is a dodgy hack, since you'll now end up passing
>> scatterlists into dma_map_sg() which already violate max_seg_size
>> to begin with, and I think a conscientious DMA API implementation
>> would be at rights to fail the mapping for that reason (I know
>> arm64 happens not to, but that was a deliberate design decision to
>> make my life easier at the time).
>> 
>> As a short-term fix, at least do something like what i915 does and
>> constrain the table allocation to the desired segment size as well,
>> so things remain self-consistent. But still never claim that faking
>> a hardware constraint as a workaround for a driver shortcoming is
>> "the right thing to do" ;)
> 
> You are asking for something like this from here, right?
> 
> https://elixir.bootlin.com/linux/v4.16.1/source/drivers/gpu/drm/i915/i915_gem_dmabuf.c#L58

I just looked for callers of __sg_alloc_table_from_pages() with a limit 
other than SCATTERLIST_MAX_SEGMENT, and found 
__i915_gem_userptr_alloc_pages(), which at first glance appears to be 
doing something vaguely similar to amdgpu_ttm_tt_pin_userptr().

Robin.
