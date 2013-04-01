From: marex@denx.de (Marek Vasut)
Date: Tue, 2 Apr 2013 01:11:13 +0200
Subject: [PATCH 1/5] spi/mxs: Fix extra CS pulses and read mode in
 multi-transfer messages
In-Reply-To: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
References: <1364570381-17605-1-git-send-email-tpiepho@gmail.com>
Message-ID: <201304020111.13969.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Trent Piepho,

> There are two bits which control the CS line in the CTRL0 register:
> LOCK_CS and IGNORE_CRC.  The latter would be better named DEASSERT_CS
> in SPI mode.
> 
> LOCK_CS keeps CS asserted though the entire transfer.  This should
> always be set.  The DMA code will always set it, explicitly on the
> first segment of the first transfer, and then implicitly on all the
> rest by never clearing the bit from the value read from the ctrl0
> register.
> 
> The only reason to not set LOCK_CS would be to attempt an altered
> protocol where CS pulses between each word.  Though don't get your
> hopes up, as the hardware doesn't appear to do this in any sane
> manner.
> 
> Setting DEASSERT_CS causes CS to be de-asserted at the end of the
> transfer.  It would normally be set on the final segment of the final
> transfer.  The DMA code explicitly sets it in this case, but because
> it never clears the bit from the ctrl0 register is will remain set for
> all transfers in subsequent messages.  This results in a CS pulse
> between transfers.
> 
> There is a similar problem with the read mode bit never being cleared
> in DMA mode.
> 
> The spi transfer "cs_change" flag is ignored by the driver.
> 
> The driver passes a "first" and "last" flag to the transfer functions
> for a message, so they can know how to set these bits.  It does this
> by passing them as pointers.  There is no reason to do this, as the
> flags are not modified in the transfer function.  And since LOCK_CS
> can be set and left that way, there is no need for a "first" flag at
> all.
> 
> This patch fixes DEASSERT_CS and READ being left on in DMA mode,
> eliminates the flags being passed as separate pointers, and adds
> support for the cs_change flag.
> 
> Note that while using the cs_change flag to leave CS asserted after
> the final transfer works, getting the CS to automatically turn off
> when a different slave is addressed might not work.
> 
> Signed-off-by: Trent Piepho <tpiepho@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/spi/spi-mxs.c |   86
> +++++++++++++++++++++---------------------------- 1 file changed, 36
> insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 22a0af0..aa77d96b9 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -58,6 +58,11 @@
> 
>  #define SG_MAXLEN		0xff00
> 
> +/* Flags for txrx functions.  More efficient that using an argument
> register for + * each one. */

Fix the comment please.

/*
 * Multiline comment should really
 * be like this.
 */

> +#define TXRX_WRITE		1	/* This is a write */
> +#define TXRX_DEASSERT_CS	2	/* De-assert CS at end of txrx */

New flags? I'm sure the GCC can optimize function parameters pretty well, esp. 
if you make the bool.

>  struct mxs_spi {
>  	struct mxs_ssp		ssp;
>  	struct completion	c;
> @@ -91,6 +96,8 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
> 
>  	mxs_ssp_set_clk_rate(ssp, hz);
> 
> +	writel(BM_SSP_CTRL0_LOCK_CS,
> +		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
>  	writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
>  		     BF_SSP_CTRL1_WORD_LENGTH
>  		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
> @@ -155,26 +162,6 @@ static void mxs_spi_set_cs(struct mxs_spi *spi,
> unsigned cs) writel(select, ssp->base + HW_SSP_CTRL0 +
> STMP_OFFSET_REG_SET);
>  }
> 
> -static inline void mxs_spi_enable(struct mxs_spi *spi)
> -{
> -	struct mxs_ssp *ssp = &spi->ssp;
> -
> -	writel(BM_SSP_CTRL0_LOCK_CS,
> -		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> -	writel(BM_SSP_CTRL0_IGNORE_CRC,
> -		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> -}
> -
> -static inline void mxs_spi_disable(struct mxs_spi *spi)
> -{
> -	struct mxs_ssp *ssp = &spi->ssp;
> -
> -	writel(BM_SSP_CTRL0_LOCK_CS,
> -		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> -	writel(BM_SSP_CTRL0_IGNORE_CRC,
> -		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
> -}
> -
>  static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool
> set) {
>  	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
> @@ -214,7 +201,7 @@ static irqreturn_t mxs_ssp_irq_handler(int irq, void
> *dev_id)
> 
>  static int mxs_spi_txrx_dma(struct mxs_spi *spi, int cs,
>  			    unsigned char *buf, int len,
> -			    int *first, int *last, int write)
> +			    unsigned int flags)
>  {
>  	struct mxs_ssp *ssp = &spi->ssp;
>  	struct dma_async_tx_descriptor *desc = NULL;
> @@ -241,20 +228,21 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs, INIT_COMPLETION(spi->c);
> 
>  	ctrl0 = readl(ssp->base + HW_SSP_CTRL0);
> -	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT;
> +	ctrl0 &= ~BM_SSP_CTRL0_XFER_COUNT & ~BM_SSP_CTRL0_IGNORE_CRC &
> +		 ~BM_SSP_CTRL0_READ;

Well ... ctrl0 &= ~(FOO | BAR | BAZ); ... won't cut it?

>  	ctrl0 |= BM_SSP_CTRL0_DATA_XFER | mxs_spi_cs_to_reg(cs);
> 
> -	if (*first)
> -		ctrl0 |= BM_SSP_CTRL0_LOCK_CS;

The DMA will overwrite ctrl0 in each turn, did you try very long (>64kB long) 
transfers with your adjustments? To test this, you can try

$ dd if=/dev/mtdN of=/dev/null bs=1M

on sufficiently large SPI flash supporting the FAST_READ opcode.

> -	if (!write)
> +	if (!(flags & TXRX_WRITE))
>  		ctrl0 |= BM_SSP_CTRL0_READ;
> 
>  	/* Queue the DMA data transfer. */
>  	for (sg_count = 0; sg_count < sgs; sg_count++) {
> +		/* Prepare the transfer descriptor. */
>  		min = min(len, desc_len);
> 
> -		/* Prepare the transfer descriptor. */
> -		if ((sg_count + 1 == sgs) && *last)
> +		/* De-assert CS on last segment if flag is set (i.e., no more
> +		 * transfers will follow) */

Wrong multi-line comment. See Documentation/CodingStyle chapter 8.

> +		if ((sg_count + 1 == sgs) && (flags & TXRX_DEASSERT_CS))
>  			ctrl0 |= BM_SSP_CTRL0_IGNORE_CRC;
> 
>  		if (ssp->devid == IMX23_SSP) {
> @@ -279,7 +267,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs,
> 
>  		sg_init_one(&dma_xfer[sg_count].sg, sg_buf, min);
>  		ret = dma_map_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
> -			write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +			(flags & TXRX_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);

I think this is unneeded.

>  		len -= min;
>  		buf += min;
> @@ -299,7 +287,7 @@ static int mxs_spi_txrx_dma(struct mxs_spi *spi, int
> cs,
> 
>  		desc = dmaengine_prep_slave_sg(ssp->dmach,
>  				&dma_xfer[sg_count].sg, 1,
> -				write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
> +				(flags & TXRX_WRITE) ? DMA_MEM_TO_DEV : 
DMA_DEV_TO_MEM,
>  				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> 
>  		if (!desc) {
> @@ -336,7 +324,7 @@ err_vmalloc:
>  	while (--sg_count >= 0) {
>  err_mapped:
>  		dma_unmap_sg(ssp->dev, &dma_xfer[sg_count].sg, 1,
> -			write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +			(flags & TXRX_WRITE) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
>  	}
> 
>  	kfree(dma_xfer);
> @@ -346,18 +334,20 @@ err_mapped:
> 
>  static int mxs_spi_txrx_pio(struct mxs_spi *spi, int cs,
>  			    unsigned char *buf, int len,
> -			    int *first, int *last, int write)
> +			    unsigned int flags)
>  {
>  	struct mxs_ssp *ssp = &spi->ssp;
> 
> -	if (*first)
> -		mxs_spi_enable(spi);
> +	/* Clear this now, set it on last transfer if needed */
> +	writel(BM_SSP_CTRL0_IGNORE_CRC,
> +	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
> 
>  	mxs_spi_set_cs(spi, cs);
> 
>  	while (len--) {
> -		if (*last && len == 0)
> -			mxs_spi_disable(spi);
> +		if (len == 0 && (flags & TXRX_DEASSERT_CS))
> +			writel(BM_SSP_CTRL0_IGNORE_CRC,
> +			       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);

Ok, I'll stop here. You mixed two kinds of changes here:
1) The "fixup" of the flags
2) The adjustments to handling the IGNORE_CRC and LOCK_CS

Split the patch please.
