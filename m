From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Jun 2017 16:13:00 +0100
Subject: [PATCH 2/2] spi: add driver for STM32 SPI controller
In-Reply-To: <1498055526-6918-3-git-send-email-amelie.delaunay@st.com>
References: <1498055526-6918-1-git-send-email-amelie.delaunay@st.com>
 <1498055526-6918-3-git-send-email-amelie.delaunay@st.com>
Message-ID: <20170621151300.s74lbymyisvde2zo@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 04:32:06PM +0200, Amelie Delaunay wrote:

A few minor stylistic things but overall this looks really nice, please
send followup patches fixing these style things.

> +	/* Determine the first power of 2 greater than or equal to div */
> +	mbrdiv = (div & (div - 1)) ? fls(div) : fls(div) - 1;

Please write normal conditional statements, it makes things much easier
to read.

> +static bool stm32_spi_can_dma(struct spi_master *master,
> +			      struct spi_device *spi_dev,
> +			      struct spi_transfer *transfer)
> +{
> +	struct stm32_spi *spi = spi_master_get_devdata(master);
> +
> +	dev_dbg(spi->dev, "%s: %s\n", __func__,
> +		(!!(transfer->len > spi->fifo_size)) ? "true" : "false");
> +
> +	return !!(transfer->len > spi->fifo_size);

This !! is redundant, you're converting a boolean value into a boolean
value.

> +	buswidth = (spi->cur_bpw <= 8) ? DMA_SLAVE_BUSWIDTH_1_BYTE :
> +		   (spi->cur_bpw <= 16) ? DMA_SLAVE_BUSWIDTH_2_BYTES :
> +		   DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	/* Valid for DMA Half or Full Fifo threshold */
> +	maxburst = (spi->cur_fthlv == 2) ? 1 : spi->cur_fthlv;

Again, please use normal conditional statements - people have to read
things.

> +static int stm32_spi_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct stm32_spi *spi = spi_master_get_devdata(master);
> +	int ret;
> +
> +	ret = spi_master_suspend(master);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(spi->clk);

It'd be good to also have the clock disabled by runtime PM, that will
save a little more power.  There's support for enabling and disabling
the device in the core so it should just be adding callbacks.  Not
essential though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/47311c59/attachment.sig>
