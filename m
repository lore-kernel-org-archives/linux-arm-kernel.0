From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Tue, 10 Jan 2017 15:47:25 +0300
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <20170110115132.GD21598@arm.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110115132.GD21598@arm.com>
Message-ID: <07253eaa-5729-0f15-42b6-e8403f1f0412@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> The point here is that an IOMMU doesn't solve your issue, and the
> IOMMU-backed DMA ops need the same treatment. In light of that, it really
> feels to me like the DMA masks should be restricted in of_dma_configure
> so that the parent mask is taken into account there, rather than hook
> into each set of DMA ops to intercept set_dma_mask. We'd still need to
> do something to stop dma_set_mask widening the mask if it was restricted
> by of_dma_configure, but I think Robin (cc'd) was playing with that.

What issue "IOMMU doesn't solve"?

Issue I'm trying to address is - inconsistency within swiotlb
dma_map_ops, where (1) any wide mask is silently accepted, but (2) then
mask is used to decide if bounce buffers are needed or not. This
inconsistency causes NVMe+R-Car cobmo not working (and breaking memory
instead).

I just can't think out what similar issue iommu can have.
Do you mean that in iommu case, mask also must not be set to whatever
wider than initial value? Why? What is the use of mask in iommu case? Is
there any real case when iommu can't address all memory existing in the
system?

NVMe maintainer has just stated that they expect
set_dma_mask(DMA_BIT_MASK(64)) to always succeed, and are going to error
out driver probe if that call fails.  They claim that architecture must
always be able to dma_map() whatever memory existing in the system - via
iommu or swiotlb or whatever. Their direction is to remove bounce
buffers from block and other layers.

With this direction, semantics of dma mask becomes even more
questionable. I'd say dma_mask is candidate for removal (or to move to
swiotlb's or iommu's local area)

Nikita
