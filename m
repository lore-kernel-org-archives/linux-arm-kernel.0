From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 Aug 2013 11:38:32 +0100
Subject: [PATCH v3 4/4] spi:Add Freescale DSPI driver for Vybrid VF610
 platform
In-Reply-To: <1376622535-8474-5-git-send-email-b44548@freescale.com>
References: <1376622535-8474-1-git-send-email-b44548@freescale.com>
 <1376622535-8474-5-git-send-email-b44548@freescale.com>
Message-ID: <20130822103832.GB26118@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 11:08:55AM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> The serial peripheral interface (SPI) module implemented on Freescale Vybrid
> platform provides a synchronous serial bus for communication between Vybrid
> and the external peripheral device.
> The SPI supports full-duplex, three-wire synchronous transfer, has TX/RX FIFO
> with depth of four entries.

Applied, thanks.  Couple of things though:

> +
> +	if (!dspi->len) {
> +		if (dspi->dataflags & TRAN_STATE_WORD_ODD_NUM)
> +			set_bit_mode(dspi, 16);
> +		dspi->waitflags = 1;
> +		wake_up_interruptible(&dspi->waitq);

There's no reason for this to be interruptible.

> +static int dspi_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct fsl_dspi *dspi = spi_master_get_devdata(master);
> +
> +	spi_master_suspend(master);
> +	clk_disable_unprepare(dspi->clk);

You could get a small power optimisation by enabling and disabling the
clock using runtime PM instead so it's only active while the controller
is actually being used rather than whenever the CPU is active.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130822/601758fc/attachment.sig>
