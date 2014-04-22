From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 17:02:19 +0200
Subject: [PATCH v2 0/7] of: setup dma parameters using dma-ranges and
 dma-coherent
In-Reply-To: <20140419182528.414b9b2e@skate>
References: <1397917972-6293-1-git-send-email-santosh.shilimkar@ti.com>
 <20140419182528.414b9b2e@skate>
Message-ID: <201404221702.19842.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 April 2014, Thomas Petazzoni wrote:
> 
> I am not sure whether there is an intersection or not, but I wanted to
> mention that the mvebu platform (in mach-mvebu) supports hardware I/O
> coherency, which makes it a coherent DMA platform. However, we are not
> able to use arm_coherent_dma_ops for this platform, because when a
> transfer is being made DMA_FROM_DEVICE, at the end of the transfer, we
> need to perform an I/O barrier to wait for the snooping unit to
> complete its coherency work. So we're coherent, but not with
> arm_coherent_dma_ops: we have our own dma operation implementation (see
> arch/arm/mach-mvebu/coherency.c).

I had completely missed the fact that this support was merged already.

It's an interesting question if this should actually be called
'coherent' or not. It's certainly more coherent than without that
support, but then again, you still can't rely on incoming data to
be visible after a readl() from the device has returned or an MSI
interrupt has been delivered, which is what we normally expect.

In particular, it means you can't really use arm_coherent_dma_alloc(),
which is a shame, since that is a significante performance overhead.

I would hope we can find a way to avoid the platform notifiers for
mvebu as well and come up with a generic way to express this
'semi-coherent' mode. I believe x-gene has a similar issue, and
I wouldn't be surprised if there are others like this.

	Arnd
