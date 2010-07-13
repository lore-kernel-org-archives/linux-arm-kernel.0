From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 10:02:23 +0100
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100713174519D.fujita.tomonori@lab.ntt.co.jp>
References: <20100713092012.7c1fe53e@lxorguk.ukuu.org.uk>
	<20100713173028M.fujita.tomonori@lab.ntt.co.jp>
	<20100713094244.7eb84f1b@lxorguk.ukuu.org.uk>
	<20100713174519D.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100713090223.GB20590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 05:45:39PM +0900, FUJITA Tomonori wrote:
> Drivers can tell the USB layer that these are vmapped buffers? Adding
> something to struct urb? I might be totally wrong since I don't know
> anything about the USB layer.

With non-DMA coherent aliasing caches, you need to know where the page
is mapped into the virtual address space, so you can deal with aliases.

You'd need to tell the USB layer about the other mappings of the page
which you'd like to be coherent (such as the vmalloc area - and there's
also the possible userspace mapping to think about too, but that's
a separate issue.)

I wonder if we should have had:

	vmalloc_prepare_dma(void *, size_t, enum dma_direction)
	vmalloc_finish_dma(void *, size_t, enum dma_direction)

rather than flush_kernel_vmap_range and invalidate_kernel_vmap_range,
which'd make their use entirely obvious.

However, this brings up a question - how does the driver (eg, v4l, xfs)
which is preparing the buffer for another driver (eg, usb host, block
dev) know that DMA will be performed on the buffer rather than PIO?

That's a very relevant question, because for speculatively prefetching
CPUs, we need to invalidate caches after a DMA-from-device operation -
but if PIO-from-device happened, this would destroy data read from the
device.

That problem goes away if we decide that PIO drivers must have the same
apparant semantics as DMA drivers - in that data must end up beyond the
point of DMA coherency (eg, physical page) - but that's been proven to
be very hard to achieve, especially with block device drivers.
