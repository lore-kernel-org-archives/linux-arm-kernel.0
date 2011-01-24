From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 16:01:27 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
	<20101221135421.GS28157@n2100.arm.linux.org.uk>
	<20101221155935.GV28157@n2100.arm.linux.org.uk>
	<AANLkTin2fBLsq2YJHjZ=e+gmwWXWezH0t38bzsjiJ+i=@mail.gmail.com>
Message-ID: <20110124160127.GA24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Any response to doing this for MMCI:

+static int mmci_dma_start_data(struct mmci_host *host, unsigned int datactrl)
+{
+       struct variant_data *variant = host->variant;
+       struct dma_slave_config conf = {
+               .src_addr = host->phybase + MMCIFIFO,
+               .dst_addr = host->phybase + MMCIFIFO,
+               .src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+               .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+               .src_maxburst = variant->fifohalfsize >> 2, /* # of words */
+               .dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
+       };
...
+       if (data->flags & MMC_DATA_READ) {
+               conf.direction = DMA_FROM_DEVICE;
+               chan = host->dma_rx_channel;
+       } else {
+               conf.direction = DMA_TO_DEVICE;
+               chan = host->dma_tx_channel;
+       }
...
+       /* shouldn't this be in the DMA engine driver? */
+       if (host->size <= variant->dmasize_threshold) {
+               conf.src_maxburst = 1;
+               conf.dst_maxburst = 1;
+       }
+
+       /* Check for weird stuff in the sg list */
+       /* shouldn't this be in the DMA engine driver? */
+       for_each_sg(data->sg, sg, data->sg_len, i) {
+               dev_vdbg(mmc_dev(host->mmc), "MMCI SGlist %d dir %d: length: %08
+                        i, conf.direction, sg->length);
+               if (sg->offset & 3 || sg->length & 3)
+                       return -EINVAL;
+       }

Can we move that size threshold and scatterlist checks inside the slave
DMA engine driver?

It is entirely possible that different DMA engines have different alignment
requirements and different bursting requirements, so surely it makes sense
for this kind of stuff to be in their drivers rather than in the DMA engine
users?

After all, the DMA engine users don't have much idea about what kind of
DMA engine will be used with themselves with Primecells.
