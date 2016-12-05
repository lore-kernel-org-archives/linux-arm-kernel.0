From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Dec 2016 12:05:40 +0000
Subject: [PATCH v3 1/5] spi: Add basic support for Armada 3700 SPI
 Controller
In-Reply-To: <20161201102719.4291-2-romain.perier@free-electrons.com>
References: <20161201102719.4291-1-romain.perier@free-electrons.com>
 <20161201102719.4291-2-romain.perier@free-electrons.com>
Message-ID: <20161205120540.mvihgafelszitzhq@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 11:27:15AM +0100, Romain Perier wrote:

> +config SPI_ARMADA_3700
> +	tristate "Marvell Armada 3700 SPI Controller"
> +	depends on ARCH_MVEBU && OF

Why does this not have a COMPILE_TEST dependency?

> +	/* Reset SPI unit */
> +	val = spireg_read(a3700_spi, A3700_SPI_IF_CFG_REG);
> +	val |= A3700_SPI_SRST;
> +	spireg_write(a3700_spi, A3700_SPI_IF_CFG_REG, val);
> +
> +	for (i = 0; i < A3700_SPI_TIMEOUT; i++)
> +		udelay(1);

Why not just do a single udelay()?

> +static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
> +{
> +	struct spi_master *master = dev_id;
> +	struct a3700_spi *a3700_spi;
> +	u32 cause;
> +
> +	a3700_spi = spi_master_get_devdata(master);
> +
> +	/* Get interrupt causes */
> +	cause = spireg_read(a3700_spi, A3700_SPI_INT_STAT_REG);
> +
> +	/* mask and acknowledge the SPI interrupts */
> +	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
> +	spireg_write(a3700_spi, A3700_SPI_INT_STAT_REG, cause);
> +
> +	/* Wake up the transfer */
> +	if (a3700_spi->wait_mask & cause)
> +		complete(&a3700_spi->done);
> +
> +	return IRQ_HANDLED;
> +}

This reports that we handled an interrupt even if we did not in fact
handle an interrupt.  It's also a bit dodgy that it doesn't check what
the interrupt was but that's less serious.

> +	master->bus_num = (pdev->id != -1) ? pdev->id : 0;

At most this should be just setting the bus number to pdev->id like
other drivers do.

> +	ret = clk_prepare_enable(spi->clk);
> +	if (ret) {
> +		dev_err(dev, "could not prepare clk: %d\n", ret);
> +		goto error;
> +	}

I'd expect the hardware prepare/unprepare to be managing the enable and
disable of the clock in order to save a little power.

> +	dev_info(dev, "Marvell Armada 3700 SPI Controller at 0x%08lx, irq %d\n",
> +		 (unsigned long)res->start, spi->irq);

This is just adding noise to the boot, remove it.  It's not telling us
anything we read from the hardware or anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161205/bce7957d/attachment.sig>
