From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Oct 2011 17:11:07 +0200
Subject: [PATCH v3] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAGsJ_4y4ZxqmefxXS+2QEtTcq6Jr9+o92pd4enRYQMkG3kZ=ng@mail.gmail.com>
References: <1318844199-19303-1-git-send-email-Barry.Song@csr.com>
	<1318859861.23438.137.camel@vkoul-udesk3>
	<CAGsJ_4y4ZxqmefxXS+2QEtTcq6Jr9+o92pd4enRYQMkG3kZ=ng@mail.gmail.com>
Message-ID: <201110171711.07384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 October 2011, Barry Song wrote:
> >> +
> >> +     /* Start the DMA transfer */
> >> +     writel_relaxed(sdesc->width, sdma->base + SIRFSOC_DMA_WIDTH_0 + cid * 4);
> >> +     writel_relaxed(cid | (schan->mode << SIRFSOC_DMA_MODE_CTRL_BIT) |
> >> +             (sdesc->dir << SIRFSOC_DMA_DIR_CTRL_BIT),
> >> +             sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_CTRL);
> >> +     writel_relaxed(sdesc->xlen, sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_XLEN);
> >> +     writel_relaxed(sdesc->ylen, sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_YLEN);
> >> +     writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) | (1 << cid),
> >> +             sdma->base + SIRFSOC_DMA_INT_EN);
> >> +     writel(sdesc->addr >> 2, sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_ADDR);
> >> +
> >> +     if (sdesc->cyclic) {
> >> +             writel((1 << cid) | 1 << (cid + 16) |
> >> +                     readl_relaxed(sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL),
> >> +                     sdma->base + SIRFSOC_DMA_CH_LOOP_CTRL);
> >> +             schan->happened_cyclic = schan->completed_cyclic = 0;
> >> +     }
> > any reason why we have mixed use of writel_relaxes and writel?
> > Shouldn't all the DMA register writes be done only using writel?
> 
> Arnd comment this in v2.

The new version looks good to me, but a comment in the source code would
be very helpful, especially to prevent people from attempting to "fix" it
in the future.

I'm not sure about the writel/readl_relaxed in the end of that function,
because I don't understand what having a "cyclic" descriptor means.

	Arnd
