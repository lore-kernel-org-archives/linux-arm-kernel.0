From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Jan 2011 15:36:40 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
Message-ID: <20110101153640.GD25924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 03:45:39PM -0800, Dan Williams wrote:
> Support for the DMA_COMPL flags are necessary if the DMA_MEMCPY
> capability is advertised, yes this driver got this wrong.  I'll update
> the documentation to make this requirement clear, and audit the other
> drivers.  With slave-only drivers the only usage model is one where
> the client driver owns dma-mapping.  In the non-slave (opportunistic
> memcpy offload) case the client is unaware of the engine so the driver
> owns unmapping.  The minimal fix is to disable memcpy offload.

Another point - the example code in async-tx-api.txt section 3.7 is
a very bad example.  It doesn't show how the result of one operation
is passed to the next operation, as the source and destination for
each operation is passed in separately.  It actually won't even
compile because of this declaration:

        addr_conv_t addr_conv[xor_src_cnt];
        addr_conv_t addr_conv[NDISKS];

Neither of these are used in the example.

On the subject of chained operations, I really don't see how this can
hope to work with the DMA API.  Using the example provided there:

	async_xor(dst, src, ...)
	async_memcpy
	async_xor(dst, src, ...)
	async_tx_issue_pending_all

Let's assume that the operations start running when we call
async_tx_issue_pending_all(), and the two XOR operations reuse the same
buffers.

The first async_xor() dma_map_page()'s the source and destination buffers.
At this point, the ownership of these buffers passes to the DMA device.

When we get to the second async_xor(), as we haven't started to run any
of these operations, the source and destination buffers are still mapped.
However, we ignore that and call dma_map_page() on them again - this is
illegal because the CPU does not own these buffers.

Moreover, when the first XOR operation completes, it will unmap the
buffers (which returns ownership of the buffer to the CPU), but
continues with the second XOR operation on a now unmapped buffer.

If there is an IOMMU between the DMA engine peripheral and memory, then
this is going to be really vile.  As it is, I don't think this is going
to be reliable on ARM as we're destroying the ownership rules for DMA
buffers which we rely heavily upon to prevent effects from speculative
prefetching.

Last point I've noticed reading through this example and the associated
code is that the async_xor() maps the destination buffer using
DMA_BIDIRECTIONAL.  The corresponding unmap (in the DMA engine driver)
_must_ also be done with DMA_BIDIRECTIONAL (I don't see any drivers
respecting this.)

Sorry for the number of emails on DMA engine stuff recently...
