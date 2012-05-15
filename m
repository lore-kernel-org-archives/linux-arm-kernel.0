From: stigge@antcom.de (Roland Stigge)
Date: Tue, 15 May 2012 17:49:56 +0200
Subject: [PATCH] MTD: LPC32xx MLC NAND driver
In-Reply-To: <20120515143428.GC13860@n2100.arm.linux.org.uk>
References: <1337091832-10138-1-git-send-email-stigge@antcom.de>
 <20120515143428.GC13860@n2100.arm.linux.org.uk>
Message-ID: <4FB27B24.3030604@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell!

Thanks for your notes!

On 05/15/2012 04:34 PM, Russell King - ARM Linux wrote:
> On Tue, May 15, 2012 at 04:23:52PM +0200, Roland Stigge wrote:
>> +static int lpc32xx_xmit_dma(struct mtd_info *mtd, dma_addr_t dma,
>> +			    void *mem, int len, enum dma_transfer_direction dir)
>> +{
>> +	struct nand_chip *chip = mtd->priv;
>> +	struct lpc32xx_nand_host *host = chip->priv;
>> +	struct dma_async_tx_descriptor *desc;
>> +	int flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>> +	int res;
>> +	dma_cookie_t cookie;
>> +
>> +	host->dma_slave_config.direction = dir;
>> +	host->dma_slave_config.src_addr = dma;
>> +	host->dma_slave_config.dst_addr = dma;
>> +	if (dmaengine_slave_config(host->dma_chan, &host->dma_slave_config)) {
>> +		dev_err(mtd->dev.parent, "Failed to setup DMA slave\n");
>> +		return -ENXIO;
>> +	}
> 
> The 'direction' argument should be ignored by all modern DMA engine
> drivers

Good - this way, I can move dmaengine_slave_config() to the dma_setup()
function, i.e., to probe().

However, I needed to set it there to some initial value (e.g., DMA_DEV_TO_MEM) -
otherwise the amba-pl08x driver didn't accept it. Is this a bug in the pl08x
driver?

Can we remove the .direction element from the struct dma_slave_config to prevent
others from making the same mistakes? Or is it useful for sth. else still?

>> +
>> +	sg_init_one(&host->sgl, mem, len);
>> +
>> +	res = dma_map_sg(host->dma_chan->device->dev, &host->sgl, 1, dir);
> 
> Also note that dma transfer directions and dma data directions are
> different things.  You shouldn't mix the two.

Thanks for pointing this out - I wasn't aware that the distinction between the
two is so important. Also consider e.g.:

arch/arm/mm/dma-mapping.c:
/**
 * dma_map_sg - map a set of SG buffers for streaming mode DMA
 * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
 * @sg: list of buffers
 * @nents: number of buffers to map 
 * @dir: DMA transfer direction
         ^^^^^^^^^^^^^^^^^^^^^^
 *
[...]
 * Device ownership issues as mentioned for dma_map_single are the same
 * here.
 */
int dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
                enum dma_data_direction dir)
                ^^^^^^^^^^^^^^^^^^^^^^^
;-)

Roland
