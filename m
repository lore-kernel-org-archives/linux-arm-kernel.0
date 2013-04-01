From: marex@denx.de (Marek Vasut)
Date: Tue, 2 Apr 2013 01:13:41 +0200
Subject: [PATCH 2/5] spi/mxs: Fix chip select control bits in DMA mode
In-Reply-To: <1364570381-17605-2-git-send-email-tpiepho@gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
 <1364570381-17605-2-git-send-email-tpiepho@gmail.com>
Message-ID: <201304020113.42124.marex@denx.de>
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

Ok, lemme ask this one more time -- will the DMA work with long transfers where 
the CTRL0 will be overwritten on each turn? Did you actually test this?

> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/spi/spi-mxs.c |   40 +++++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index aa77d96b9..5d63b21 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -130,9 +130,9 @@ static int mxs_spi_setup(struct spi_device *dev)
>  	return err;
>  }
> 
> -static uint32_t mxs_spi_cs_to_reg(unsigned cs)
> +static u32 mxs_spi_cs_to_reg(unsigned cs)
>  {
> -	uint32_t select = 0;
> +	u32 select = 0;

This change is unneeded, remove it.

>  	/*
>  	 * i.MX28 Datasheet: 17.10.1: HW_SSP_CTRL0
> @@ -150,18 +150,6 @@ static uint32_t mxs_spi_cs_to_reg(unsigned cs)
>  	return select;
>  }
> 
> -static void mxs_spi_set_cs(struct mxs_spi *spi, unsigned cs)
> -{
> -	const uint32_t mask =
> -		BM_SSP_CTRL0_WAIT_FOR_CMD | BM_SSP_CTRL0_WAIT_FOR_IRQ;
> -	uint32_t select;
> -	struct mxs_ssp *ssp = &spi->ssp;
> -
> -	writel(mask, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> -	select = mxs_spi_cs_to_reg(cs);
> -	writel(select, ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> -}
> -
>  static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool
> set) {
>  	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
> @@ -199,7 +187,7 @@ static irqreturn_t mxs_ssp_irq_handler(int irq, void
> *dev_id) return IRQ_HANDLED;
>  }
> 
> -static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
> +static int mxs_spi_txrx_dma(struct mxs_spi *spi,
>  			    unsigned char *buf, int len,
>  			    unsigned int flags)
>  {
> @@ -227,10 +215,11 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs,
> 
>  	INIT_COMPLETION(spi->c);
> 
> +	/* Chip select was already programmed into CTRL0 */
>  	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
>  	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT & ~BM_SSP_CTRL0_IGNORE_CRC &
>  		 ~BM_SSP_CTRL0_READ;
> -	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
> +	ctrl0 |= BM_SSP_CTRL0_DATA_XFER;
> 
>  	if (!(flags & TXRX_WRITE))
>  		ctrl0 |= BM_SSP_CTRL0_READ;
> @@ -332,7 +321,7 @@ err_mapped:
>  	return ret;
>  }
> 
> -static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
> +static int mxs_spi_txrx_pio(struct mxs_spi *spi,
>  			    unsigned char *buf, int len,
>  			    unsigned int flags)
>  {
> @@ -342,8 +331,6 @@ static int mxs_spi_txrx_pio(struct mxs_spi *spi, int
> cs, writel(BM_SSP_CTRL0_IGNORE_CRC,
>  	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> 
> -	mxs_spi_set_cs(spi, cs);
> -
>  	while (len--) {
>  		if (len == 0 && (flags & TXRX_DEASSERT_CS))
>  			writel(BM_SSP_CTRL0_IGNORE_CRC,
> @@ -405,9 +392,12 @@ static int mxs_spi_transfer_one(struct spi_master
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
> 
>  	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
> 
> @@ -440,11 +430,11 @@ static int mxs_spi_transfer_one(struct spi_master
> *master, STMP_OFFSET_REG_CLR);
> 
>  			if (t->tx_buf)
> -				status = mxs_spi_txrx_pio(spi, cs,
> +				status = mxs_spi_txrx_pio(spi,
>  						(void *)t->tx_buf,
>  						t->len, flag | TXRX_WRITE);
>  			if (t->rx_buf)
> -				status = mxs_spi_txrx_pio(spi, cs,
> +				status = mxs_spi_txrx_pio(spi,
>  						t->rx_buf, t->len,
>  						flag);
>  		} else {
> @@ -453,11 +443,11 @@ static int mxs_spi_transfer_one(struct spi_master
> *master, STMP_OFFSET_REG_SET);
> 
>  			if (t->tx_buf)
> -				status = mxs_spi_txrx_dma(spi, cs,
> +				status = mxs_spi_txrx_dma(spi,
>  						(void *)t->tx_buf, t->len,
>  						flag | TXRX_WRITE);
>  			if (t->rx_buf)
> -				status = mxs_spi_txrx_dma(spi, cs,
> +				status = mxs_spi_txrx_dma(spi,
>  						t->rx_buf, t->len,
>  						flag);
>  		}

Best regards,
Marek Vasut
