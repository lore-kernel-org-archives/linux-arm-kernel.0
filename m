From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 15:26:07 +0000
Subject: RPmsg, DMA and ARM64
In-Reply-To: <20150324043749.GJ23658@toto>
References: <20150324043749.GJ23658@toto>
Message-ID: <20150326152607.GM8656@n2100.arm.linux.org.uk>
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

dma_alloc_coherent() is permitted to remap the memory which it returns;
it's allowed not to be part of the linear mapping.  The underlying
memory could even be sourced from highmem and mapped in on demand.

This means that using virt_to_page() et.al. on the return value from
dma_alloc_coherent() is not permitted.

The only way to pass such memory using scatterlists is by doing:

	sg_init_table(sg, 1);
	sg_dma_address(sg) = addr;
	sg_dma_length(sg) = length;

Such a scatterlist must _never_ have the dma_(map|unmap|sync)_sg*()
functions called on it - the only operations which would be permissible
is to walk the scatterlist, and access it using the standard DMA
accessors sg_dma_address() and sg_dma_length().

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
