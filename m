From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 19:03:35 +0000
Subject: dma cache coherency issue
In-Reply-To: <AANLkTi=ZdiZATPde6W8bStZCwu05Am6Z216+LxaEzaTj@mail.gmail.com>
References: <AANLkTi=ZdiZATPde6W8bStZCwu05Am6Z216+LxaEzaTj@mail.gmail.com>
Message-ID: <20110321190335.GG4340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 02:52:19AM +0800, Dongas wrote:
> Hi All,
> 
> Similar as stated in the following articles,
> http://lwn.net/Articles/2265/
> The issue is that i got a SDIO WiFi dirver which has the folliowing
> structure definitions:
> ??? struct iostruct {
>         ...
> ?       int ifield;
>         char dma_buffer[SMALL_SIZE];
>         ...
> ??? };
> And the ifield may share the same cache line with dma_buffer which is
> used for dma transfer.
> Consider the case that if CPU accesses ifield during the DMA transfer,
> then the CPU cache line may get the stale data from dma buffer.
> After DMA completes, in current kernel code(2.6.38), the dma_unmap_sg
> will finally call v7_dma_unmap_area and v7_dma_inv_range to clean and
> invalidate cache again for DMA_FROM_DEVICE operation.
> However, since the cache line already contains the stale data of dma
> buffer, the clean to write back the cache line to memory may cause
> data corruption.

Correct.

> My question is:
> Is it a bug of current linux kernel or still as above old article
> said, there's no better solutions for it?

It is a bug.

Another solution would be to allocate the dma buffer separately using
kmalloc, and store a pointer to it in the iostruct.  Don't forget to
free it after you've finished with it though.  That probably requires
the smallest overall change.
