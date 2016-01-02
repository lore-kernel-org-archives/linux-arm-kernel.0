From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2016 10:53:54 +0000
Subject: [Question about DMA] Consistent memory?
In-Reply-To: <CAK7LNAS3wXfJ_syOEMoi1aEt5_maNur05figQ472_9usGQagHQ@mail.gmail.com>
References: <CAK7LNASd1amcHinXzYy=8mtYbnHUY1G_v=fthpachAVSyjqPZA@mail.gmail.com>
 <20151231102548.3ed389fb@lxorguk.ukuu.org.uk>
 <CAK7LNAS3wXfJ_syOEMoi1aEt5_maNur05figQ472_9usGQagHQ@mail.gmail.com>
Message-ID: <20160102105354.GS8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 31, 2015 at 11:57:55PM +0900, Masahiro Yamada wrote:
> [1] DMA-coherent buffers
> 
> Allocate buffers with dma_alloc_coherent()
> and just have access to the buffers without cache synchronization.
> 
> There is no need to call dma_sync_single_for_*().

dma_sync_single_for_*() is part of the streaming API and should never
be used with DMA-coherent buffers.

> [2] Streaming DMA
> 
> Allocate buffers with kmalloc() or friends,
> and then map them for DMA with dma_map_single().
> 
> The buffers are cached, so they are non-consitent
> unless there exists hardware assist such as
> Cache Coherency Interconnect.
> 
> The drivers must invoke cache operations
> by calling dma_sync_single_for_*().

I have a problem with that last statement.  There is no "must".  One
way to look at the DMA API is that you're using the various calls to
transfer ownership (and access right) of the buffer between the CPU
and the DMA device.

So, dma_map_single() transfers ownership from the CPU to the DMA
device, as does dma_sync_single_for_device().  dma_unmap_single()
and dma_sync_single_for_cpu() transfers ownership from the DMA
device to the CPU.

If you intend to allocate a buffer, and then perform DMA on it, you
just need to allocate, use dma_map_single(), and then kick the DMA.
Once DMA has completed, use dma_unmap_single() before touching the
buffer.

If you intend to inspect the contents of the buffer during DMA, then
use dma_sync_single_for_cpu() before reading the buffer.  This
ensures that when you read from the buffer, you see up-to-date data.
You strictly don't need to use dma_sync_single_for_device() prior
to resuming DMA.

However, you must use dma_unmap_single() before you free the memory.

> I think, if the buffer size is small, [1] is more efficient
> because it need not invoke cache operations.
> 
> If the buffer is large, [2] seems better because
> the cost of uncached memory access gets more expensive
> than that of cache operations.

It doesn't always follow.  Coherent memory is only available in page
sized chunks, so aren't really "small buffers".

Generally, coherent memory is used for things like DMA descriptor ring
buffers, where we need simultaneous access by both the DMA device and
CPU (the DMA device updates descriptors as it processes them, the CPU
can inspect and queue new descriptors as the DMA device processes them.)
Network devices do this a lot.

The DMA API streaming interfaces tend to be used with buffers which are
allocated "out of control" of the driver - if we take the network device
example, the network packet buffers will be mapped and unmapped using
the streaming API.

With a different example, video capture, there's different trade offs.
A video capture buffer may be very large (8MB for a 1080p frame.)
Flushing the cache over 8MB of data is very inefficient, and it's
probably more performant to use DMA coherent memory instead, even
more so if you don't actually intend for the CPU to access it - eg,
you're passing the frame to another hardware block for further
processing.

> I grepped under drivers/mmc/host, and
> I found many drivers call dma_alloc_coherent(),
> but there are also some drivers that use dma_map_single().

Yes - you're probably seeing the pattern I mentioned above - DMA
descriptors on coherent memory, the data buffers being passed in
to the driver from elsewhere, and mapped using the streaming API.

Hope this is helpful.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
