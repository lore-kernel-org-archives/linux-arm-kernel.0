From: dongas86@gmail.com (Dongas)
Date: Tue, 22 Mar 2011 02:52:19 +0800
Subject: dma cache coherency issue
Message-ID: <AANLkTi=ZdiZATPde6W8bStZCwu05Am6Z216+LxaEzaTj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Similar as stated in the following articles,
http://lwn.net/Articles/2265/
The issue is that i got a SDIO WiFi dirver which has the folliowing
structure definitions:
??? struct iostruct {
        ...
?       int ifield;
        char dma_buffer[SMALL_SIZE];
        ...
??? };
And the ifield may share the same cache line with dma_buffer which is
used for dma transfer.
Consider the case that if CPU accesses ifield during the DMA transfer,
then the CPU cache line may get the stale data from dma buffer.
After DMA completes, in current kernel code(2.6.38), the dma_unmap_sg
will finally call v7_dma_unmap_area and v7_dma_inv_range to clean and
invalidate cache again for DMA_FROM_DEVICE operation.
However, since the cache line already contains the stale data of dma
buffer, the clean to write back the cache line to memory may cause
data corruption.
My question is:
Is it a bug of current linux kernel or still as above old article
said, there's no better solutions for it?
If not for both, how does kernel handle such an issue?

One solution i know is that changing the driver to use
dma_alloc_coherency to guarantee the buffer is cache line alignment.
But the problem is that it's hard for me to do that because this type
of definition is widely used in that driver.
The current solution is to use DMABOUNCE to fix this issue.But the dma
bounce buffer has performance issues due to large number of extra
memory copies for allocating safe buffer.
Therefore, i wonder if there's any other way to fix this issue?

Thanks

Regards
Dongas
