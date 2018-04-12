From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 Apr 2018 08:26:00 +0200
Subject: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
In-Reply-To: <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <32b82296-bba5-b5f1-266b-45c1ed66da94@arm.com>
Message-ID: <20180412062600.GB30499@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 01:03:59PM +0100, Robin Murphy wrote:
> On 10/04/18 21:59, Sinan Kaya wrote:
>> Code is expecing to observe the same number of buffers returned from
>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>> doesn't hold true universally especially for systems with IOMMU.
>
> So why not fix said code? It's clearly not a real hardware limitation, and 
> the map_sg() APIs have potentially returned fewer than nents since forever, 
> so there's really no excuse.

Yes, relying on dma_map_sg returning the same number of entries as passed
it is completely bogus.

>> IOMMU driver tries to combine buffers into a single DMA address as much
>> as it can. The right thing is to tell the DMA layer how much combining
>> IOMMU can do.
>
> Disagree; this is a dodgy hack, since you'll now end up passing 
> scatterlists into dma_map_sg() which already violate max_seg_size to begin 
> with, and I think a conscientious DMA API implementation would be at rights 
> to fail the mapping for that reason (I know arm64 happens not to, but that 
> was a deliberate design decision to make my life easier at the time).

Agreed.
