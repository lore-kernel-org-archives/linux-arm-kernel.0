From: edgar.iglesias@gmail.com (Edgar E. Iglesias)
Date: Tue, 24 Mar 2015 14:37:49 +1000
Subject: RPmsg, DMA and ARM64
Message-ID: <20150324043749.GJ23658@toto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying to run rpmsg and remoteproc on the ZynqMP but hitting an mm error.
I'm not sure who is breaking the rules, rpmsg or the dma allocators?

When rpmsg sets up the virtqueues, it allocates memory with
dma_alloc_coherent() and initializes a scatterlist with sg_init_one().
drivers/rpmsg/virtio_rpmsg_bus.c:rpmsg_probe().
sg_init_one() requires that the memory it gets is virt_addr_valid().

The problem I'm seeing is that on arm64, the dma alloc functions can
return vmalloced (via dma_common_contiguous_remap) memory. This
then causes havoc when the scatterlist code tries to go virt_to_page
and back to get hold of a physical adress (sg_phys()).

I couldn't find a definitive answer in the docs, is the arm64 DMA code
doing the right here when returning vmalloced memory?

Cheers,
Edgar
