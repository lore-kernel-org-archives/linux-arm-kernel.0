From: Anton_Bondarenko@mentor.com (Bondarenko, Anton)
Date: Thu, 1 Oct 2015 00:34:54 +0000
Subject: [PATCH v2 3/8] spi: imx: add support for all SPI word width for
 DMA transfer
In-Reply-To: <20150930083539.GD2709@shlinux2>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <f8844a7a52ab44f00e7b6a1c3ce55d72d7999514.1442923630.git.anton_bondarenko@mentor.com>
 <20150930083539.GD2709@shlinux2>
Message-ID: <04376A3D786BD947B28569C998A374A62E280E21@NA-MBX-02.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2015 10:35, Robin Gong wrote:
> On Fri, Sep 25, 2015 at 07:57:10PM +0200, Anton Bondarenko wrote:
>> @@ -91,11 +91,15 @@ struct spi_imx_data {
>>  
>>  	struct completion xfer_done;
>>  	void __iomem *base;
>> +	unsigned long base_phys;
>> +
>>  	struct clk *clk_per;
>>  	struct clk *clk_ipg;
>>  	unsigned long spi_clk;
>>  	unsigned int spi_bus_clk;
>>  
>> +	unsigned int bpw_w;
>> +
> It's better to change bytes_per_word for clear understanding,since bpw in spi means
> bits_per_word...
Agree. Fixed in V3
>>  	unsigned int count;
>>  	void (*tx)(struct spi_imx_data *);
>>  	void (*rx)(struct spi_imx_data *);
>> @@ -201,9 +205,13 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>  			 struct spi_transfer *transfer)
>>  {
>>  	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
>> +	unsigned int bpw_w = transfer->bits_per_word;
>>  
>> -	if (spi_imx->dma_is_inited &&
>> -	    (transfer->len > spi_imx->wml * sizeof(u32)))
>> +	if (!bpw_w)
>> +		bpw_w = spi->bits_per_word;
>> +
>> +	bpw_w = DIV_ROUND_UP(bpw_w, 8);
>> +	if (spi_imx->dma_is_inited && (transfer->len > spi_imx->wml * bpw_w))
> Please remove bpw_w here as I talked in the first patch.
As explained in patch1 we need to use SPI word size in calculation to decide 
if we want to go with DMA or PIO mode. Just a short example:
We need to transfer 24 SPI words with BPW == 32. This will take ~ 24 PIO writes
to FIFO (and same for reads). But transfer->len will be 24*4=96 bytes.
WML is 32 SPI words. The decision will be incorrect if we do not take into account
SPI bits per word.  
>>  		return true;
>>  	return false;
>>  }
>> @@ -1007,7 +1058,8 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>  					    DMA_FROM_DEVICE);
>>  
>>  			spi_imx->rx_buf = pio_buffer;
>> -			spi_imx->txfifo = left;
>> +			spi_imx->txfifo = DIV_ROUND_UP(left, spi_imx->bpw_w);
>> +
> Looks not enough here, you have to set 'spi_imx->rx' per the right bpw.
What do you mean? We have had bpw_w == 1 before so 
spi_imx->txfifo = DIV_ROUND_UP(left, spi_imx->bpw_w);
is equivalent to
spi_imx->txfifo = left;
Now we could have bpw_w equal to 2 or 4 also. txfifo is number of SPI words
and not number of bytes.
>>  			reinit_completion(&spi_imx->xfer_done);
>>  
>>  			spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TCEN);
