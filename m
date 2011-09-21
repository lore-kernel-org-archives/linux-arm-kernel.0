From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2011 16:49:01 +0200
Subject: [PATCH v2] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
References: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <201109211649.01440.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Barry,

I just looked at the driver again and stumbled over a potential race:

On Friday 16 September 2011, Barry Song wrote:
> +
> +/* Execute all queued DMA descriptors */
> +static void sirfsoc_dma_execute(struct sirfsoc_dma_chan *schan)
> +{
> +       struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(&schan->chan);
> +       int cid = schan->chan.chan_id;
> +       struct sirfsoc_dma_desc *sdesc = NULL;
> +
> +       sdesc = list_first_entry(&schan->queued, struct sirfsoc_dma_desc,
> +               node);
> +       /* Move the first queued descriptor to active list */
> +       list_move_tail(&schan->queued, &schan->active);
> +
> +       /* Start the DMA transfer */
> +       writel_relaxed(sdesc->width, sdma->base + SIRFSOC_DMA_WIDTH_0 + cid * 4);
> +       writel_relaxed(cid | (schan->mode << SIRFSOC_DMA_MODE_CTRL_BIT) |
> +               (schan->direction << SIRFSOC_DMA_DIR_CTRL_BIT),
> +               sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_CTRL);
> +       writel_relaxed(sdesc->xlen, sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_XLEN);
> +       writel_relaxed(sdesc->ylen, sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_YLEN);
> +       writel_relaxed(readl_relaxed(sdma->base + SIRFSOC_DMA_INT_EN) | (1 << cid),
> +               sdma->base + SIRFSOC_DMA_INT_EN);
> +       writel_relaxed(schan->addr >> 2, sdma->base + cid * 0x10 + SIRFSOC_DMA_CH_ADDR);
> +}

I think you need to add a memory write barrier somewhere in here, because 
writel_relaxed() does not flush out the CPUs write buffers, unlike writel().

Theoretically, you might be starting a DMA that reads from coherent memory
but the data is still stuck in the CPU. I assume that the last writel_relaxed()
is the access that actually starts the DMA, so it should be airtight once you
replace that with writel().

> +/* Interrupt handler */
> +static irqreturn_t sirfsoc_dma_irq(int irq, void *data)
> +{
> +       struct sirfsoc_dma *sdma = data;
> +       struct sirfsoc_dma_chan *schan;
> +       u32 is;
> +       int ch;
> +
> +       is = readl_relaxed(sdma->base + SIRFSOC_DMA_CH_INT);
> +       while ((ch = fls(is) - 1) >= 0) {
> +               is &= ~(1 << ch);
> +               writel_relaxed(1 << ch, sdma->base + SIRFSOC_DMA_CH_INT);
> +               schan = &sdma->channels[ch];
> +
> +               spin_lock(&schan->lock);
> +
> +               /* Execute queued descriptors */
> +               list_splice_tail_init(&schan->active, &schan->completed);
> +               if (!list_empty(&schan->queued))
> +                       sirfsoc_dma_execute(schan);
> +
> +               spin_unlock(&schan->lock);
> +       }

Similarly, readl_relaxed() does might not force in inbound DMA to be
completed, causing you to call the tasklet before the data is visible
to the CPU. While your hardware might have better guarantees, the
API you are using does not. It should be find when you replace the
first read_relaxed with readl() here.

	Arnd
