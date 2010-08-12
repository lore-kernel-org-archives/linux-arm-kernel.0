From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 12 Aug 2010 15:58:08 +0200
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180 v10
In-Reply-To: <20100811144859.GC5846@debian>
References: <1281454328-22805-1-git-send-email-linus.walleij@stericsson.com>
	<20100811144859.GC5846@debian>
Message-ID: <AANLkTimriY-NerBUBeuPf_qX_01iZvntH3TMVdkn7wJv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/11 Rabin Vincent <rabin@rab.in>:

> On Tue, Aug 10, 2010 at 05:32:08PM +0200, Linus Walleij wrote:
>> (...)
>> +static void __devexit mmci_disable_dma(struct mmci_host *host)
>> +{
>
> I don't think this should be __devexit since you're also calling it from
> a __devinit function.

Yeah it's either __devinit or __devexit, and there is no such
macro naturally, so I'll inline it simply.

>> (...)
>> +static void mmci_dma_data_error(struct mmci_host *host)
>> +{
>> + ? ? struct mmc_data *data = host->data;
>> + ? ? struct dma_chan *chan;
>> +
>> + ? ? dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
>> + ? ? if (data->flags & MMC_DATA_READ)
>> + ? ? ? ? ? ? chan = host->dma_rx_channel;
>> + ? ? else
>> + ? ? ? ? ? ? chan = host->dma_tx_channel;
>> + ? ? dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
>> + ? ? ? ? ? ? ? ? ?(data->flags & MMC_DATA_WRITE)
>> + ? ? ? ? ? ? ? ? ?? DMA_TO_DEVICE : DMA_FROM_DEVICE);
>
> Might as well call mmci_dma_data_end() here?

Nah, that makes it hard to integrate elegantly with the mmci_data_irq()
which has a special MCI_DATA_END clause. Same reason as why
the error routine in mmci_data_irq() fall through to mmci_stop_data().

>> +
>> +/*
>> + * This one gets called repeatedly to copy data using
>> + * DMA until there is no more data left to copy.
>> + */
>
> Is this comment correct? ?Why is this called repeatedly for a single
> request?

Its repeatedly as in repeatedly called from the MMC framework,
to copy data from the card i.e. for an entire file. Indeed with
the multiblock patch it is called once per xfer. I can take the comment
out.

>> +static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
>> +{
>> + ? ? struct variant_data *variant = host->variant;
>> + ? ? struct dma_slave_config rx_conf = {
>> + ? ? ? ? ? ? .src_addr = host->phybase + MMCIFIFO,
>> + ? ? ? ? ? ? .src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
>> + ? ? ? ? ? ? .direction = DMA_FROM_DEVICE,
>> + ? ? ? ? ? ? .src_maxburst = variant->fifohalfsize >> 2,
>> + ? ? };
>> + ? ? struct dma_slave_config tx_conf = {
>> + ? ? ? ? ? ? .dst_addr = host->phybase + MMCIFIFO,
>> + ? ? ? ? ? ? .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
>> + ? ? ? ? ? ? .direction = DMA_TO_DEVICE,
>> + ? ? ? ? ? ? .dst_maxburst = variant->fifohalfsize >> 2,
>> + ? ? };
>> + ? ? struct mmc_data *data = host->data;
>> + ? ? enum dma_data_direction direction;
>> + ? ? struct dma_chan *chan;
>> + ? ? struct dma_async_tx_descriptor *desc;
>> + ? ? struct scatterlist *sg;
>> + ? ? unsigned int sglen;
>> + ? ? dma_cookie_t cookie;
>> + ? ? int i;
>> +
>> + ? ? datactrl |= MCI_DPSM_DMAENABLE;
>> + ? ? datactrl |= variant->dmareg_enable;
>> +
>> + ? ? if (data->flags & MMC_DATA_READ) {
>> + ? ? ? ? ? ? direction = DMA_FROM_DEVICE;
>> + ? ? ? ? ? ? chan = host->dma_rx_channel;
>> + ? ? ? ? ? ? chan->device->device_control(chan, DMA_SLAVE_CONFIG,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(unsigned long) &rx_conf);
>> + ? ? } else {
>> + ? ? ? ? ? ? direction = DMA_TO_DEVICE;
>> + ? ? ? ? ? ? chan = host->dma_tx_channel;
>> + ? ? ? ? ? ? chan->device->device_control(chan, DMA_SLAVE_CONFIG,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(unsigned long) &tx_conf);
>> + ? ? }
>> +
>> + ? ? /* Check for weird stuff in the sg list */
>> + ? ? for_each_sg(data->sg, sg, data->sg_len, i) {
>> + ? ? ? ? ? ? if (sg->offset & 3 || sg->length & 3)
>> + ? ? ? ? ? ? ? ? ? ? return -EINVAL;
>> + ? ? }
>> +
>> + ? ? sglen = dma_map_sg(mmc_dev(host->mmc), data->sg,
>> + ? ? ? ? ? ? ? ? ? ? ? ?data->sg_len, direction);
>> + ? ? if (sglen != data->sg_len)
>> + ? ? ? ? ? ? goto unmap_exit;
>
> sglen < data->sg_len is not an error condition.

In arch/arm/mm/dma-mapping.c
dma_map_sg() returns 0 on a mapping error, and the same as
passed in the third parameter on success.

Sorry I don't get it, you usually know these things much better than
me so help :-?

The rest of the comments I fixed up..

Yours,
Linus Walleij
