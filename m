From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 19 Jun 2015 10:50:54 +0800
Subject: [PATCH 1/6] drm/rockchip: import dma_buf to gem
In-Reply-To: <20150618105715.GJ7557@n2100.arm.linux.org.uk>
References: <1434613770-6608-1-git-send-email-mark.yao@rock-chips.com>
 <1434613770-6608-2-git-send-email-mark.yao@rock-chips.com>
 <20150618105715.GJ7557@n2100.arm.linux.org.uk>
Message-ID: <5583838E.7080001@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Russell
On 2015?06?18? 18:57, Russell King - ARM Linux wrote:
> This is wrong.
>
> First, if you can only cope with a single scatterlist entry, you need to
> enforce that.  You can do that in your gem_prime_import_sg_table() method
> by checking sgt->nents.
I'm confuse that how to get coherent iova address from nocoherent 
scatterlist with iommu.
I saw the arm_iommu_map_sg, it says that:
         The scatter gather list elements are merged together (if 
possible) and
          tagged with the appropriate dma address and length.

I guess the map_sg maybe merge scatterlist into coherent iova address, 
but I don't know how to
check the "if possible", and the sgt->nents not be 1 when already map to 
coherent iova address.

checking sgt-nents = 1 can sure that iova is coherent, but when coherent 
iova address from
nocoherent scatterlist, I think sgt->nents maybe greater than 1, is 
there a method can deal it?

All above is my guess, maybe wrong, I only tested it with CMA buffer import.

> Secondly, you're mapping an already mapped scatterlist - scatterlists
> are mapped by the exporter inside dma_buf_map_attachment() for your
> device.

Right, found the dma_map_sg on dma_buf_map_attachment().

>
> Thirdly, I hate drm_gem_prime_import() being used on ARM... it forces
> drivers to do something very buggy: the DMA buffer is mapped for DMA
> when the buffer is imported.  If the buffer is a write-combine or cached
> buffer, writes to the buffer after the import will not become visible to
> the display hardware until sometime later (when they're evicted from the
> caches and/or pushed out of the bus structure.)  The DMA mapping should
> be performed as close to the start of DMA as possible.  However, this is
> a long-standing issue I have with dma_buf itself and is not something you
> should be too concerned with in your patch.  Just bear it in mind if you
> start to see corruption of imported buffers - the answer is not more
> dma_map_sg() calls, but to get dma_buf fixed.
Yeah, Got it.

-- 
?ark Yao
