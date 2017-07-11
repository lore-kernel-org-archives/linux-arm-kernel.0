From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 11 Jul 2017 15:50:19 +0100
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
Message-ID: <5235ccf4-9dc2-a4aa-280b-18a0ab5a42bf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/17 14:40, Moese, Michael wrote:
> Hello ARM folks, I turn to you in hope you have any hints or
> directions on the problem I describe below.
> 
> I am currently investigating strange behavior of our i.MX 6 (Quad)
> board with an FPGA connected to to PCI Express. This FPGA contains,
> among others, an Ethernet (10/100 Mbps) IP core. The Ethernet relies
> completely on DMA transfers. There is one buffer descriptor table
> containing pointers to 64 RX and TX buffers. Buffers are allocated
> using dma_alloc_coherent() and mapped using dma_map_single(). Prior

I don't much like the sound of that "and" there - coherent DMA
allocations are, as the name implies, already coherent for CPU and DMA
accesses, and require no maintenance; the streaming DMA API
(dma_{map,unmap,sync}_*) on the other hand is *only* for use on
kmalloced memory.

I'm far more of a DMA guy than a networking guy, so I don't know much
about the details of ethernet drivers, but typically, long-lived things
like descriptor rings would usually use coherent allocations, whilst
streaming DMA is used for the transient mapping/unmapping of individual
skbs.

> to access, dma_sync_single_for_cpu() is called on the memory regions,
> afterwards dma_sync_single_for_device().
> 
> If a new frame is received, the driver reads the RX buffer and passes
> the frame using skb_put(). When the issue was reported for an old
> (say 3.18.19) kernel, the buffer descriptor was read correctly
> (including a correct length), but the buffer contained all zeroes.
> When I map the physical address in userspace and dump the contents, I
> can see the correct buffer descriptor contents and inside the buffers
> valid Ethernet frames. So the DMA transfer itself is working
> obviously. To avoid chasing after already-fixed bugs, I switched to a
> 4.12.0 kernel and observed almost the same behavior, but this time
> there was no length read as well. On 3.18.19 I was able to read the
> buffers when I allocate them using kmalloc() instead of
> dma_alloc_coherent(), on 4.12 this did not have any impact.
> 
> I was suspecting the caches to be the root of my issue, but I was not
> able to resolve the issue with calls to flush_cache_all(), which I
> suppose should have invalidated the entire cache.

i.MX6Q has a PL310 L2 outer cache, which brings with it a whole load of
extra fun, but the primary effect is that it'll be extremely hard to
bodge things if the DMA API usage is incorrect in the first place.
AFAICS flush_cache_all() on a v7 CPU performs set/way operations on the
CPU caches, which means a) on that system it will only affect L1, and b)
it shouldn't really be used from an SMP context with the MMU on anyway.

The PL310 does have more than its fair share of wackiness, but unless
you also see DMA going wrong for the on-chip peripherals, the problem is
almost certainly down to the driver itself rather than the cache
configuration.

Robin.

> Unfortunately, our driver is legacy out-of-tree code and I started
> working on this driver to get it ready for submission. If it is of
> any help, I could send the code of the driver as well as our board's
> device tree.
> 
> I would highly appreciate any hint or direction that may help my
> troubleshooting.
> 
> Best Regards, Michael
> 
> 
> 
> _______________________________________________ linux-arm-kernel
> mailing list linux-arm-kernel at lists.infradead.org 
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
