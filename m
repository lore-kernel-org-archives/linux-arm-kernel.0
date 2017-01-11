From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Jan 2017 14:50:31 +0000
Subject: [PATCH] arm64: avoid increasing DMA masks above what hardware
 supports
In-Reply-To: <09cac197-9e57-5d3e-e742-f29c00051813@cogentembedded.com>
References: <11daacde-5399-039f-80a3-01d7bd13e9e8@arm.com>
 <1484056844-9567-1-git-send-email-nikita.yoush@cogentembedded.com>
 <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <67314806-361d-e0ac-9292-37542160ead5@cogentembedded.com>
 <57459a4a-2c57-e081-8f27-cb83f23b5815@arm.com>
 <09cac197-9e57-5d3e-e742-f29c00051813@cogentembedded.com>
Message-ID: <c5bada32-fbaf-3631-268b-db49dffe3eb9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/17 13:41, Nikita Yushchenko wrote:
>> Yes, I think that ought to work, although the __iommu_setup_dma_ops()
>> call will still want a real size reflecting the default mask
> 
> I see iommu_dma_ops do not define set_dma_mask.
> 
> So what if setup was done for size reflecting one mask and then driver
> changes mask?  Will things still operate correctly?

We've overridden dma_set_mask() at the function level, so it should
always apply regardless. Besides, none of the arm64 ops implement
.set_dma_mask anyway, so we could possibly drop the references to it
altogether.

Conversely, I suppose we could just implement said callback for
swiotlb_dma_ops and iommu_dma_ops with the parent_dma_mask-checking
function and drop the HAVE_ARCH_DMA_SET_MASK override instead. I'm not
sure which approach is preferable - the latter seems arguably cleaner in
isolation, but would also be less consistent with how the coherent mask
has to be handled. Ho hum.

Robin.
