From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 May 2015 12:58:54 +0100
Subject: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
 GQSPI controller
In-Reply-To: <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <20150522115854.GG21391@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 12:57:51PM +0530, Ranjit Waghmode wrote:

This looks pretty good overall but there are a few issues below from a
first read through.

> +static void zynqmp_gqspi_selectflash(struct zynqmp_qspi *instanceptr,
> +				     u8 flashcs, u8 flashbus)

Is this a SPI controller or a flash controller?  It looks like it is
actually a SPI controller but the above is a bit worrying.

> +{
> +	/*
> +	 * Bus and CS lines selected here will be updated in the instance and
> +	 * used for subsequent GENFIFO entries during transfer.
> +	 */
> +	/* Choose slave select line */

Coding style - at least a blank linne between the two comment blocks.

> +	switch (flashcs) {
> +	case GQSPI_SELECT_FLASH_CS_BOTH:
> +		instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER |
> +		    GQSPI_GENFIFO_CS_UPPER;
> +		break;
> +	case GQSPI_SELECT_FLASH_CS_UPPER:
> +		instanceptr->genfifocs = GQSPI_GENFIFO_CS_UPPER;
> +		break;
> +	case GQSPI_SELECT_FLASH_CS_LOWER:
> +	default:
> +		instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER;
> +	}

Why is there a default case here?  That's going to men we try to handle
any random chip select that gets passed in as pointing to this lower
device which doesn't seem right.  The fact that this is trying to handle
mirroring of the chip select to two devices is also raising alarm bells
here...

> +/**
> + * zynqmp_qspi_copy_read_data:	Copy data to RX buffer
> + * @xqspi:	Pointer to the zynqmp_qspi structure
> + * @data:	The 32 bit variable where data is stored
> + * @size:	Number of bytes to be copied from data to RX buffer
> + */
> +static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
> +				       u32 data, u8 size)
> +{
> +	memcpy(xqspi->rxbuf, ((u8 *) &data), size);
> +	xqspi->rxbuf += size;
> +	xqspi->bytes_to_receive -= size;
> +}

This looks like there's some type abuse going on and is going to be
broken for 64 bit systems - why are we passing pointers around as 32 bit
unsigned values?

> +static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
> +{
> +	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> +
> +	clk_enable(xqspi->refclk);
> +	clk_enable(xqspi->pclk);

Should be checking return codes here.

> +static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
> +{

> +	if (is_high) {
> +		/* Manually start the generic FIFO command */
> +		zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> +				zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> +				GQSPI_CFG_START_GEN_FIFO_MASK);

No, this is broken - setting the chip select should set the chip select,
it shouldn't have any impact on transfers.  Transfers should be started
in the transfer operations.

> +	/* If req_hz == 0, default to lowest speed */
> +	while ((baud_rate_val < GQSPI_BAUD_DIV_MAX) &&
> +	       (clk_get_rate(xqspi->refclk) /
> +		(GQSPI_BAUD_DIV_SHIFT << baud_rate_val)) > req_hz)
> +		baud_rate_val++;

It'd be better to factor the clk_get_rate() out of the loop rather than
repeatedly calling into the clock API.

> + * Sets the operational mode of QSPI controller for the next QSPI transfer,
> + * baud rate and divisor value to setup the requested qspi clock.
> + *
> + * Return:	0 Always
> + */
> +static int zynqmp_qspi_setup(struct spi_device *qspi)
> +{
> +	if (qspi->master->busy)
> +		return -EBUSY;
> +	return zynqmp_qspi_setup_transfer(qspi, NULL);
> +}

The setup() function shouldn't affect the hardwaer but _setup_transfer()
does.  See spi-summary.

> +static void zynqmp_qspi_filltxfifo(struct zynqmp_qspi *xqspi, int size)
> +{
> +	u32 count = 0;
> +
> +	while ((xqspi->bytes_to_transfer > 0) && (count < size)) {
> +		writel(*((u32 *) xqspi->txbuf), xqspi->regs + GQSPI_TXD_OFST);
> +		if (xqspi->bytes_to_transfer >= 4) {
> +			xqspi->txbuf += 4;
> +			xqspi->bytes_to_transfer -= 4;
> +		} else {
> +			xqspi->txbuf += xqspi->bytes_to_transfer;
> +			xqspi->bytes_to_transfer = 0;
> +		}
> +		count++;
> +	}
> +}

This doesn't appear to take any account of endianness which is
especially alarming in the case where we're dealing with the final word
and the casting here looks unsafe.  I'd expect to be using endanness
annotated pointers with no need for casting.

> + */
> +static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
> +{
> +	u32 config_reg, genfifoentry;
> +
> +	dma_unmap_single(xqspi->dev, xqspi->dma_addr,
> +				xqspi->dma_rx_bytes, DMA_FROM_DEVICE);

Don't manually do DMA mapping, let the core do it.  It looks like we
need to enhance the core DMA mapping to support partial mapping of
transfers here, this case where you're doing the tail of the transfer as
PIO is a reasonable one (I'm a bit surprised we haven't run into it
before to be honest).

> +static inline u32 zynqmp_qspi_selectspimode(u8 spimode)
> +{
> +	u32 mask;
> +
> +	switch (spimode) {
> +	case GQSPI_SELECT_MODE_DUALSPI:
> +		mask = GQSPI_GENFIFO_MODE_DUALSPI;
> +		break;
> +	case GQSPI_SELECT_MODE_QUADSPI:
> +		mask = GQSPI_GENFIFO_MODE_QUADSPI;
> +		break;
> +	case GQSPI_SELECT_MODE_SPI:
> +	default:
> +		mask = GQSPI_GENFIFO_MODE_SPI;
> +	}

Again this default case looks buggy.

> +static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = container_of(dev,
> +						    struct platform_device,
> +						    dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +
> +	spi_master_suspend(master);
> +
> +	zynqmp_unprepare_transfer_hardware(master);

Why are you manually unpreparing the hardware here?  Obviously if the
core has suspended it ought to have done this...

> +	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
> +	if (ret < 0)
> +		master->num_chipselect = GQSPI_DEFAULT_NUM_CS;
> +	else
> +		master->num_chipselect = num_cs;

Why is this selectable from DT?  I'm not seeing any code here which
really validates chip select numbers or handles arbatrary chip select
numbers...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/1768a9da/attachment.sig>
