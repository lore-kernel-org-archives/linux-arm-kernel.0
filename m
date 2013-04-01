From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 14:12:07 +0100
Subject: [PATCH V3 2/5] spi: s3c64xx: added support for polling mode
In-Reply-To: <1363157014-9615-3-git-send-email-ks.giri@samsung.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-3-git-send-email-ks.giri@samsung.com>
Message-ID: <20130401131207.GI18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 12:13:31PM +0530, Girish K S wrote:

> Some SoC's that adopt this controller might not have have dma
> interface. This patch adds support for complete polling mode
> and gives flexibity for the user to select poll/dma mode.

Ouch, that sounds like a regression.

> @@ -419,6 +422,27 @@ static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
>  
>  	cs = spi->controller_data;
>  	gpio_set_value(cs->line, spi->mode & SPI_CS_HIGH ? 1 : 0);
> +
> +	/* Start the signals */
> +	writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
> +}
> +

This looks odd and not obviously related to the rest of the change -
does it belong as part of some of your other commits adding support for
using the controller /CS functionality?  In general it feels like this
ought to be broken down a bit - there's some refactoring as well as the
new functionality.

> +static u32 wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
> +					int timeout_ms)
> +{
> +	void __iomem *regs = sdd->regs;
> +	unsigned long val;
> +	u32 status;
> +	/* max fifo depth available */
> +	u32 max_fifo = (FIFO_LVL_MASK(sdd) >> 1) + 1;
> +
> +	val = msecs_to_loops(timeout_ms);
> +	do {
> +		status = readl(regs + S3C64XX_SPI_STATUS);
> +	} while (RX_FIFO_LVL(status, sdd) < max_fifo && --val);
> +
> +	/* return the actual received data length */
> +	return RX_FIFO_LVL(status, sdd);

This is really wait_for_fifo_empty_with_timeout() isn't it?  It feels
like there ought to be at least a cpu_relax() in the busy wait too.

> +		/*
> +		 * If the receive length is bigger than the controller fifo
> +		 * size, calculate the loops and read the fifo as many times.
> +		 * loops = length / max fifo size (calculated by using the
> +		 * fifo mask).
> +		 * For any size less than the fifo size the below code is
> +		 * executed atleast once.
> +		 */
> +		loops = xfer->len / ((FIFO_LVL_MASK(sdd) >> 1) + 1);
> +		buf = xfer->rx_buf;
> +		do{

Coding style.

> -	if (!sdd->pdev->dev.of_node) {
> +	if (!sdd->pdev->dev.of_node && !is_polling(sdd)) {
>  		res = platform_get_resource(pdev, IORESOURCE_DMA,  0);
>  		if (!res) {
>  			dev_err(&pdev->dev, "Unable to get SPI tx dma "

It seems like it'd be sensible to also handle failure to get the DMA
resource by going into polling mode.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/ff4ab212/attachment.sig>
