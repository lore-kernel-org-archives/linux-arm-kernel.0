From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 29 Jun 2011 15:09:59 +0200
Subject: [RFC PATCH] MTD: atmel_nand: optimize read/write buffer	functions
In-Reply-To: <20110628145937.GG21898@n2100.arm.linux.org.uk>
References: <1309261856-27402-1-git-send-email-nicolas.ferre@atmel.com>
	<20110628111043.GH6588@pengutronix.de>
	<20110628145937.GG21898@n2100.arm.linux.org.uk>
Message-ID: <4E0B2427.9020202@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/06/2011 16:59, Russell King - ARM Linux :
> On Tue, Jun 28, 2011 at 01:10:43PM +0200, Uwe Kleine-K?nig wrote:
>>> @@ -265,33 +234,53 @@ err_buf:
>>>  static void atmel_read_buf(struct mtd_info *mtd, u8 *buf, int len)
>>>  {
>>>  	struct nand_chip *chip = mtd->priv;
>>> -	struct atmel_nand_host *host = chip->priv;
>>> +	u32 align;
>>> +	u8 *pbuf;
>>>  
>>>  	if (use_dma && len > mtd->oobsize)
>>>  		/* only use DMA for bigger than oob size: better performances */
>>>  		if (atmel_nand_dma_op(mtd, buf, len, 1) == 0)
>>>  			return;
>>>  
>>> -	if (host->board->bus_width_16)
>>> -		atmel_read_buf16(mtd, buf, len);
>>> -	else
>>> -		atmel_read_buf8(mtd, buf, len);
>>> +	/* if no DMA operation possible, use PIO */
>>> +	pbuf = buf;
>>> +	align = 0x03 & ((unsigned)pbuf);
>>> +
>>> +	if (align) {
>>> +		u32 align_len = 4 - align;
>>> +
>>> +		/* non aligned buffer: re-align to next word boundary */
>>> +		ioread8_rep(chip->IO_ADDR_R, pbuf, align_len);
>>> +		pbuf += align_len;
>>> +		len -= align_len;
>>> +	}
>>> +	memcpy((void *)pbuf, chip->IO_ADDR_R, len);
>> I think you don't need to cast to (void *). I think you need to cast the
>> 2nd parameter instead because sparse don't like you passing an void
>> __iomem *.
>> Is it correct to read from chip->IO_ADDR_R, don't you need
>> chip->IO_ADDR_R + align_len? Taking this into account, does it really
>> help to align pbuf?
> 
> I think you need to read Documentation/bus-virt-phys-mapping.txt,
> particularly the part after "NOTE NOTE NOTE".
> 
> Dereferencing ioremap'd memory is not permitted.  That includes passing
> it to memcpy.  Even with a cast.

So that means that I should use memcpy_fromio() even if the code if far
less optimized.

Shouldn't I re-implement some kind of IO copying function to deal with
this IO memory so that I could take advantage of 8 words bursts?

Best regards,
-- 
Nicolas Ferre
