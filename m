From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Tue, 9 Jan 2018 16:55:50 +0100
Subject: [PATCH 05/67] dma-mapping: replace PCI_DMA_BUS_IS_PHYS with a
 flag in struct dma_map_ops
In-Reply-To: <20171229081911.2802-6-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-6-hch@lst.de>
Message-ID: <20180109155550.GP32368@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 09:18:09AM +0100, Christoph Hellwig wrote:
> The current PCI_DMA_BUS_IS_PHYS decided if a dma implementation is bound
> by the dma mask in the device because it directly maps to a physical
> address range (modulo an offset in the device), or if it is virtualized
> by an iommu and can map any address (that includes virtual iommus like
> swiotlb).  The problem with this scheme is that it is per-architecture and
> not per dma_ops instance, and we are growing more and more setups that
> have multiple different dma operations in use on a single system, for
> which this scheme can't provide a correct answer.  Depending on the
> architecture that means we either get a false positive or false negative
> at the moment.
> 
> This patch instead extents the is_phys flag in struct dma_map_ops that
> is currently only used by a few architectures to be used tree wide.
> 
> Note that this means that we now need a struct device parent in the
> Scsi_Host or netdevice.  Every modern driver has these, but there might
> still be a few outdated legacy drivers out there, which now won't make
> an intelligent decision.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/arch-v32/drivers/pci/dma.c  |  1 +
>  arch/cris/include/asm/pci.h           |  6 ------

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
