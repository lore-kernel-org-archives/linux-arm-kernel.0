From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2011 17:07:49 +0200
Subject: [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
Message-ID: <201106131707.49217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 June 2011 16:12:05 KyongHo Cho wrote:
> Of course, the mapping created by by dma_alloc_writecombine()
> may be more efficient for CPU to update the DMA buffer.
> But I think mapping with dma_alloc_coherent() is not such a
> performance bottleneck.
> 
> I think it is better to remove dma_alloc_writecombine() and replace
> all of it with dma_alloc_coherent().

I'm sure that the graphics people will disagree with you on that.
Having the frame buffer mapped in write-combine mode is rather
important when you want to efficiently output videos from your
CPU.

> In addition, IMHO, mapping to user's address is not a duty of dma_map_ops.
> dma_mmap_*() is not suitable for a system that has IOMMU
> because a DMA address does not equal to its correspondent physical
> address semantically.
> 
> I think DMA APIs of ARM must be changed drastically to support IOMMU
> because IOMMU API does not manage virtual address space.

I can understand that there are arguments why mapping a DMA buffer into
user space doesn't belong into dma_map_ops, but I don't see how the
presence of an IOMMU is one of them.

The entire purpose of dma_map_ops is to hide from the user whether
you have an IOMMU or not, so that would be the main argument for
putting it in there, not against doing so.

	Arnd
