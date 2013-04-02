From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Apr 2013 01:29:41 +0200
Subject: [PATCH V2 05/12] spi/mxs: Fix chip select control bits in DMA mode
In-Reply-To: <1364905195-24286-5-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
 <1364905195-24286-5-git-send-email-tpiepho@gmail.com>
Message-ID: <201304030129.41380.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> In DMA mode the chip select control bits would be ORed into the CTRL0
> register without first clearing the bits.  This means that after
> addressing slave 1 the bit would be still be set when addressing slave
> 0, resulting in slave 1 continuing to be addressed.
> 
> The message handing function would pass the cs value to the txrx
> function, which would re-program the bits on each transfer in the
> message.  The selected cs does not change during a message so this is
> inefficient.  It also means there are two different sets of code for
> selecting the CS, one for PIO that worked and one for DMA that didn't.
> 
> Change the code to set the CS bits in the message transfer function
> once.  Now the DMA and PIO txrx functions don't need to care about CS
> at all.
> 
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>

[...]

> @@ -409,9 +396,12 @@ static int mxs_spi_transfer_one(struct spi_master
> *master, struct spi_transfer *t, *tmp_t;
>  	unsigned int flag;
>  	int status = 0;
> -	int cs;
> 
> -	cs = m->spi->chip_select;
> +	/* Program CS register bits here, it will be used for all transfers. */
> +	writel(BM_SSP_CTRL0_WAIT_FOR_CMD | BM_SSP_CTRL0_WAIT_FOR_IRQ,
> +	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> +	writel(mxs_spi_cs_to_reg(m->spi->chip_select),
> +	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);

I have no problem with this patch in general, but put this stuff back into a 
function with proper description stating that these bits are not what their name 
means. Having this stuff in the code just like that looks like hell and is 
absolutely not clear about what it really does. Besides, having such things well 
encapsulated makes further hacking on/maintainance of the driver much easier.

>  	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
> 

[...]
Best regards,
Marek Vasut
