From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue, 3 Apr 2018 16:03:32 +0300
Subject: [PATCH 6/6] spi: sun4i: add DMA transfers support
In-Reply-To: <20180403081711.rqsp77mgnuvlnzt5@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-7-ssuloev@orpaltech.com>
 <20180403081711.rqsp77mgnuvlnzt5@flea>
Message-ID: <19d5907c-f081-21ce-1b72-7c0a331eb073@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 11:17 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:07PM +0300, Sergey Suloev wrote:
>> +static int sun4i_spi_dma_setup(struct device *dev,
>> +			       struct resource *res)
>> +{
>> +	struct spi_master *master = dev_get_drvdata(dev);
>> +	struct dma_slave_config dma_sconf;
>> +	int ret;
>> +
>> +	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
>> +	if (IS_ERR(master->dma_tx)) {
>> +		dev_err(dev, "Unable to acquire DMA TX channel\n");
>> +		ret = PTR_ERR(master->dma_tx);
>> +		goto out;
>> +	}
>> +
>> +	dma_sconf.direction = DMA_MEM_TO_DEV;
>> +	dma_sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>> +	dma_sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> I guess that would depend on the size of the transfer, right?
no
"this is the width in bytes of the source (RX)register where DMA data 
shall be read. If the sourceis memory this may be ignored depending on 
architecture."
AFAIK is should be 1 byte for SPI side and seems to be ignored for 
memory side, but as soon as I don't know what should be correct value 
for memory side I just put 1 there too.
>
>> +	dma_sconf.dst_addr = res->start + SUN4I_TXDATA_REG;
>> +	dma_sconf.dst_maxburst = 1;
>> +	dma_sconf.src_maxburst = 1;
> And a burst of 1 seems sub-optimal here.
I did some tests before with 3/4 FIFO size but it didn't work and I got 
stuck with 1 byte.
It seems like 1 byte is the correct value because in SPI protocol we can 
only send 1 byte in 1 burst.

>
>> +	ret = sun4i_spi_dma_setup(&pdev->dev, res);
>> +	if (ret) {
>> +		if (ret == -EPROBE_DEFER) {
>> +			/* wait for the dma driver to load */
>> +			goto err_free_master;
>> +		}
>> +		dev_warn(&pdev->dev, "DMA transfer not supported\n");
> Saying why it's not supported would be great.
I can put more info in this log
but there is already a message printed from sun4_spi_dma_setup() if any 
error occurs
>
> Maxime
>
