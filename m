From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Jan 2018 14:56:01 +0000
Subject: [PATCH 11/33] dma-mapping: move swiotlb arch helpers to a new
 header
In-Reply-To: <20180110080027.13879-12-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-12-hch@lst.de>
Message-ID: <3721b4ba-0685-255e-06b9-6e60678a1a92@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/18 08:00, Christoph Hellwig wrote:
> phys_to_dma, dma_to_phys and dma_capable are helpers published by
> architecture code for use of swiotlb and xen-swiotlb only.  Drivers are
> not supposed to use these directly, but use the DMA API instead.
> 
> Move these to a new asm/dma-direct.h helper, included by a
> linux/dma-direct.h wrapper that provides the default linear mapping
> unless the architecture wants to override it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[...]
>   drivers/crypto/marvell/cesa.c                      |  1 +
>   drivers/mtd/nand/qcom_nandc.c                      |  1 +

I took a look at these, and it seems their phys_to_dma() usage is doing 
the thing which we subsequently formalised as dma_map_resource(). I've 
had a crack at a quick patch to update the CESA driver; qcom_nandc looks 
slightly more complex in that the changes probably need to span the BAM 
dmaengine driver as well.

In the process, though, I stumbled across gen_pool_dma_alloc() - yuck, 
something needs doing there, for sure...

Robin.
