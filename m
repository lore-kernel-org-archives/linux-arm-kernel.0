From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Mar 2015 15:36:34 +0000
Subject: RPmsg, DMA and ARM64
In-Reply-To: <20150324043749.GJ23658@toto>
References: <20150324043749.GJ23658@toto>
Message-ID: <20150325153634.GF26903@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 02:37:49PM +1000, Edgar E. Iglesias wrote:
> I'm trying to run rpmsg and remoteproc on the ZynqMP but hitting an mm error.
> I'm not sure who is breaking the rules, rpmsg or the dma allocators?
> 
> When rpmsg sets up the virtqueues, it allocates memory with
> dma_alloc_coherent() and initializes a scatterlist with sg_init_one().
> drivers/rpmsg/virtio_rpmsg_bus.c:rpmsg_probe().
> sg_init_one() requires that the memory it gets is virt_addr_valid().
> 
> The problem I'm seeing is that on arm64, the dma alloc functions can
> return vmalloced (via dma_common_contiguous_remap) memory. This
> then causes havoc when the scatterlist code tries to go virt_to_page
> and back to get hold of a physical adress (sg_phys()).

dma_alloc_coherent may return vmap'ed memory when it needs to create a
non-cacheable alias.

Is the sg code supposed to be used with coherent DMA allocations? I
thought it's normally used with the streaming DMA, i.e. standard page
allocation rather than dma_alloc_coherent().

I'm also not sure why virtio_rpmsg_bus.c needs non-cacheable memory, I
thought normal cacheable memory would be enough for virtio.

-- 
Catalin
