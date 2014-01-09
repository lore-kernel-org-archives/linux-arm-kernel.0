From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Jan 2014 11:58:25 +0100
Subject: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
In-Reply-To: <20140109103515.164af26c@ipc1.ka-ro>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
 <1389236681-30372-3-git-send-email-yao.yuan@freescale.com>
 <20140109103515.164af26c@ipc1.ka-ro>
Message-ID: <201401091158.25902.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 January 2014, Lothar Wa?mann wrote:
> > +static int lpuart_dma_rx(struct lpuart_port *sport)
> > +{
> > +     dma_sync_single_for_device(sport->port.dev, sport->dma_rx_buf_bus,
> > +                     DMA_RX_BUFFER_SIZE, DMA_TO_DEVICE);
> >
> dma_alloc_coherent() (which you use to allocate the DMA rx buffer) and
> dma_symc_*() are orthogonal to each other!
> You either allocate DMA coherent memory as DMA buffer or use ordinary
> memory with the DMA streaming API (dma_map_*(), dma_sync_*()).
> See Documentation/DMA-API-HOWTO.txt

Well spotted, it took me a while to figure out what the driver actually
does mixing these two. Apparently the tx path is using the streaming
DMA API, while the rx path uses the consistent API.

I think the driver should really use the same API both ways, and it
depends on the amount of data transferred with each DMA which API
fits better. I'd say that if typical transfer is just a few dozen
bytes at most, it should perform better if you use the consistent API
with uncacheable memory buffers, because it won't have the overhead
from the cache flushes. If you often transfer kilobytes at once,
the streaming API would be faster because it avoids uncached memory
accesses.

	Arnd
