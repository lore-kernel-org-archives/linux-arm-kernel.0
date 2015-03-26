From: edgar.iglesias@gmail.com (Edgar E. Iglesias)
Date: Thu, 26 Mar 2015 11:30:32 +1000
Subject: RPmsg, DMA and ARM64
In-Reply-To: <20150325153634.GF26903@localhost>
References: <20150324043749.GJ23658@toto>
 <20150325153634.GF26903@localhost>
Message-ID: <20150326013032.GA15765@toto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 03:36:34PM +0000, Catalin Marinas wrote:
> On Tue, Mar 24, 2015 at 02:37:49PM +1000, Edgar E. Iglesias wrote:
> > I'm trying to run rpmsg and remoteproc on the ZynqMP but hitting an mm error.
> > I'm not sure who is breaking the rules, rpmsg or the dma allocators?
> > 
> > When rpmsg sets up the virtqueues, it allocates memory with
> > dma_alloc_coherent() and initializes a scatterlist with sg_init_one().
> > drivers/rpmsg/virtio_rpmsg_bus.c:rpmsg_probe().
> > sg_init_one() requires that the memory it gets is virt_addr_valid().
> > 
> > The problem I'm seeing is that on arm64, the dma alloc functions can
> > return vmalloced (via dma_common_contiguous_remap) memory. This
> > then causes havoc when the scatterlist code tries to go virt_to_page
> > and back to get hold of a physical adress (sg_phys()).
> 
> dma_alloc_coherent may return vmap'ed memory when it needs to create a
> non-cacheable alias.

Right, if returning vmapped memory is OK for dma allocs, then I can assume
that the rpmsg code is doing something bad.

> Is the sg code supposed to be used with coherent DMA allocations? I
> thought it's normally used with the streaming DMA, i.e. standard page
> allocation rather than dma_alloc_coherent().

Yes, I think that is the normal use-case but for virtio, the scatterlist
describes a ring of buffers that are not temporary/streaming. I can see
why rpmsg wants to use dma_alloc_coherent()...

My impression is though, that it may be wrong to pass the result of
dma_alloc_coherent directly to sg_init_one. Maybe we need another mechanism
to create an sg and virtio rings from a virtual address and a dma_addr_t,
avoiding the sg_phys page-based address translation.

Does this make any sense?

> I'm also not sure why virtio_rpmsg_bus.c needs non-cacheable memory, I
> thought normal cacheable memory would be enough for virtio.

Virtio is normally used within a coherent system for communication between
hypervisor and guests. But it can also, in the remoteproc use-case be
used between a CPU and a remote CPU/device. In the latter case, my
understanding is that coherent memory mappings across the local domain
are important (either via HW coherency or by using slow non-cached mappings).

Cheers,
Edgar
