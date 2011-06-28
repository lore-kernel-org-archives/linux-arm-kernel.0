From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 28 Jun 2011 15:58:01 +0200
Subject: [RFC PATCH] MTD: atmel_nand: optimize read/write buffer functions
In-Reply-To: <20110628111043.GH6588@pengutronix.de>
References: <1309261856-27402-1-git-send-email-nicolas.ferre@atmel.com>
	<20110628111043.GH6588@pengutronix.de>
Message-ID: <4E09DDE9.2070900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/06/2011 13:10, Uwe Kleine-K?nig :
> On Tue, Jun 28, 2011 at 01:50:56PM +0200, Nicolas Ferre wrote:
>> For PIO NAND access functions, we use the features of the SMC:
>> - no need to take into account the NAND bus width: SMC will deal with this
>> - a word aligned memcpy on the NAND chip-select space is able to generate
>>   proper SMC behavior while optimizing AHB bus usage thanks to optimized memcpy
>>   implementation.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/mtd/nand/atmel_nand.c |   71 +++++++++++++++++-----------------------
>>  1 files changed, 30 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
>> index b300705..cb8a04b 100644
>> --- a/drivers/mtd/nand/atmel_nand.c
>> +++ b/drivers/mtd/nand/atmel_nand.c
>> @@ -160,37 +160,6 @@ static int atmel_nand_device_ready(struct mtd_info *mtd)
>>                  !!host->board->rdy_pin_active_low;
>>  }
>>  
>> -/*
>> - * Minimal-overhead PIO for data access.
>> - */
>> -static void atmel_read_buf8(struct mtd_info *mtd, u8 *buf, int len)
>> -{
>> -	struct nand_chip	*nand_chip = mtd->priv;
>> -
>> -	__raw_readsb(nand_chip->IO_ADDR_R, buf, len);
>> -}
>> -
>> -static void atmel_read_buf16(struct mtd_info *mtd, u8 *buf, int len)
>> -{
>> -	struct nand_chip	*nand_chip = mtd->priv;
>> -
>> -	__raw_readsw(nand_chip->IO_ADDR_R, buf, len / 2);
>> -}
>> -
>> -static void atmel_write_buf8(struct mtd_info *mtd, const u8 *buf, int len)
>> -{
>> -	struct nand_chip	*nand_chip = mtd->priv;
>> -
>> -	__raw_writesb(nand_chip->IO_ADDR_W, buf, len);
>> -}
>> -
>> -static void atmel_write_buf16(struct mtd_info *mtd, const u8 *buf, int len)
>> -{
>> -	struct nand_chip	*nand_chip = mtd->priv;
>> -
>> -	__raw_writesw(nand_chip->IO_ADDR_W, buf, len / 2);
>> -}
>> -
>>  static void dma_complete_func(void *completion)
>>  {
>>  	complete(completion);
>> @@ -265,33 +234,53 @@ err_buf:
>>  static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
>>  {
>>  	struct nand_chip *chip = mtd->priv;
>> -	struct atmel_nand_host *host = chip->priv;
>> +	u32 align;
>> +	u8 *pbuf;
>>  
>>  	if (use_dma && len > mtd->oobsize)
>>  		/* only use DMA for bigger than oob size: better performances */
>>  		if (atmel_nand_dma_op(mtd, buf, len, 1) == 0)
>>  			return;
>>  
>> -	if (host->board->bus_width_16)
>> -		atmel_read_buf16(mtd, buf, len);
>> -	else
>> -		atmel_read_buf8(mtd, buf, len);
>> +	/* if no DMA operation possible, use PIO */
>> +	pbuf = buf;
>> +	align = 0x03 & ((unsigned)pbuf);
>> +
>> +	if (align) {
>> +		u32 align_len = 4 - align;
>> +
>> +		/* non aligned buffer: re-align to next word boundary */
>> +		ioread8_rep(chip->IO_ADDR_R, pbuf, align_len);
>> +		pbuf += align_len;
>> +		len -= align_len;
>> +	}
>> +	memcpy((void *)pbuf, chip->IO_ADDR_R, len);
> I think you don't need to cast to (void *). I think you need to cast the
> 2nd parameter instead because sparse don't like you passing an void
> __iomem *.

Yes but if I try to cast it, sparse will notice it anyway. So yes, it
seems that I am doing something _bad_ and that the use of memcpy() here
is not the preferred way to deal with hardware FIFO.
On the other hand, the memcpy_fromio() function is far from being as
optimized as the ARM memcpy() implementation... I am wandering what is
the best solution?

> Is it correct to read from chip->IO_ADDR_R, don't you need
> chip->IO_ADDR_R + align_len?

No, it is a FIFO, so each reading from it will give the next data.

> Taking this into account, does it really help to align pbuf?

Aligning to next 32bit word address avoid having to deal with memcpy()
alignment management that reads twice to rearrange data (loosing datas
in the case of a FIFO ;-)). So yes, aligning really helps.

So, all this leads me to append RFC to this patch title...

Best regards,
-- 
Nicolas Ferre
