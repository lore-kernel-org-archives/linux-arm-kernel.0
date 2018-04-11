From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 11 Apr 2018 10:33:14 -0400
Subject: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
In-Reply-To: <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
Message-ID: <1a1d0069-c8d3-cc0d-cf1c-8e90e4a2b0d7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/11/2018 8:03 AM, Robin Murphy wrote:
> On 10/04/18 21:59, Sinan Kaya wrote:
>> Code is expecing to observe the same number of buffers returned from
>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>> doesn't hold true universally especially for systems with IOMMU.
> 
> So why not fix said code? It's clearly not a real hardware limitation, and the map_sg() APIs have potentially returned fewer than nents since forever, so there's really no excuse.

Sure, I'll take a better fix if there is one.

> 
>> IOMMU driver tries to combine buffers into a single DMA address as much
>> as it can. The right thing is to tell the DMA layer how much combining
>> IOMMU can do.
> 
> Disagree; this is a dodgy hack, since you'll now end up passing scatterlists into dma_map_sg() which already violate max_seg_size to begin with, and I think a conscientious DMA API implementation would be at rights to fail the mapping for that reason (I know arm64 happens not to, but that was a deliberate design decision to make my life easier at the time).
> 
> As a short-term fix, at least do something like what i915 does and constrain the table allocation to the desired segment size as well, so things remain self-consistent. But still never claim that faking a hardware constraint as a workaround for a driver shortcoming is "the right thing to do" ;)

You are asking for something like this from here, right?

https://elixir.bootlin.com/linux/v4.16.1/source/drivers/gpu/drm/i915/i915_gem_dmabuf.c#L58


	ret = sg_alloc_table(st, obj->mm.pages->nents, GFP_KERNEL);
	if (ret)
		goto err_free;

	src = obj->mm.pages->sgl;
	dst = st->sgl;
	for (i = 0; i < obj->mm.pages->nents; i++) {
		sg_set_page(dst, sg_page(src), src->length, 0);
		dst = sg_next(dst);
		src = sg_next(src);
	}

This seems to allocate the scatter gather list and fill it in manually before passing it
to dma_map_sg(). I'll give it a try. 

Just double checking.

> 
> Robin.
> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
