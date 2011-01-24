From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Jan 2011 22:06:53 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <20110124160127.GA24104@n2100.arm.linux.org.uk>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
	<20110124160127.GA24104@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=GmYoDYhKGpvzt2vHWSEb2b72cQbQfVc4PANdH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Any response to doing this for MMCI:

Sorry, got stalled tinkering with other stuff.

> +static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
> +{
> + ? ? ? struct variant_data *variant = host->variant;
> + ? ? ? struct dma_slave_config conf = {
> + ? ? ? ? ? ? ? .src_addr = host->phybase + MMCIFIFO,
> + ? ? ? ? ? ? ? .dst_addr = host->phybase + MMCIFIFO,
> + ? ? ? ? ? ? ? .src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
> + ? ? ? ? ? ? ? .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
> + ? ? ? ? ? ? ? .src_maxburst = variant->fifohalfsize >> 2, /* # of words */
> + ? ? ? ? ? ? ? .dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
> + ? ? ? };
> ...
> + ? ? ? if (data->flags & MMC_DATA_READ) {
> + ? ? ? ? ? ? ? conf.direction = DMA_FROM_DEVICE;
> + ? ? ? ? ? ? ? chan = host->dma_rx_channel;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? conf.direction = DMA_TO_DEVICE;
> + ? ? ? ? ? ? ? chan = host->dma_tx_channel;
> + ? ? ? }
> ...
> + ? ? ? /* shouldn't this be in the DMA engine driver? */
> + ? ? ? if (host->size <= variant->dmasize_threshold) {
> + ? ? ? ? ? ? ? conf.src_maxburst = 1;
> + ? ? ? ? ? ? ? conf.dst_maxburst = 1;
> + ? ? ? }

This was an addition from Per Forlin, IIRC the requirement
to not push more than one word at the time into the FIFO
below a certain threadhold is a requirement for the MMCI,
not the DMA engine.

What it does is to emulate single requests below a certain
threshold by requesting one-word bursts. I think this is
primarily for SDIO, not card transfers.

I'd have to ask around as to the reasons for. We'd better
understand that, but I noted we added a special hardware
register to the PL011 just to handle this kind of thresholds,
so there is something about emulating that threshold in
software.

> + ? ? ? /* Check for weird stuff in the sg list */
> + ? ? ? /* shouldn't this be in the DMA engine driver? */
> + ? ? ? for_each_sg(data->sg, sg, data->sg_len, i) {
> + ? ? ? ? ? ? ? dev_vdbg(mmc_dev(host->mmc), "MMCI SGlist %d dir %d: length: %08
> + ? ? ? ? ? ? ? ? ? ? ? ?i, conf.direction, sg->length);
> + ? ? ? ? ? ? ? if (sg->offset & 3 || sg->length & 3)
> + ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }

This one is just overcautious and for SDIO we don't even want to do
such things, so it should be dropped altogether.

The original intent was to avoid writing anything than 32bit words
into the register, and with the SDIO-modified versions you can
actually do that.

So I'll drop it for the next iteration.

> Can we move that size threshold and scatterlist checks inside the slave
> DMA engine driver?
>
> It is entirely possible that different DMA engines have different alignment
> requirements and different bursting requirements, so surely it makes sense
> for this kind of stuff to be in their drivers rather than in the DMA engine
> users?
>
> After all, the DMA engine users don't have much idea about what kind of
> DMA engine will be used with themselves with Primecells.

True.

Linus Walleij
