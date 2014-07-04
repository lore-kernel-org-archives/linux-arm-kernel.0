From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Jul 2014 19:32:49 +0100
Subject: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
In-Reply-To: <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140704183249.GC14896@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:03:59AM +0800, addy ke wrote:
> In order to facilitate understanding, rockchip SPI controller IP design
> looks similar in its registers to designware. But IC implementation
> is different from designware, So we need a dedicated driver for Rockchip
> RK3XXX SoCs integrated SPI. The main differences:

This looks good overall, a nice clean driver.  I've applied it but there
are a few small issues that need fixing up which I've noted below, can
you please send followup patches dealing with these?

> +	 * static void spi_set_cs(struct spi_device *spi, bool enable)
> +	 * {
> +	 *		if (spi->mode & SPI_CS_HIGH)
> +	 *			enable = !enable;
> +	 *
> +	 *		if (spi->cs_gpio >= 0)
> +	 *			gpio_set_value(spi->cs_gpio, !enable);
> +	 *		else if (spi->master->set_cs)
> +	 *		spi->master->set_cs(spi, !enable);
> +	 * }
> +	 *
> +	 * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
> +	 */

So, the point here is that chip select is an active low signal by
default which means that if chip select is asserted we have a low logic
level and the parameter means "asserted" not "logic level for the
output".  It doesn't really matter but it might be clearer to say so
directly.

> +	if (spi->mode & SPI_CS_HIGH) {
> +		dev_err(rs->dev, "spi_cs_hign: not support\n");
> +		return -EINVAL;

Typo here (high).

> +static int rockchip_spi_unprepare_message(struct spi_master *master,
> +		struct spi_message *msg)
> +{
> +	unsigned long flags;
> +	struct rockchip_spi *rs = spi_master_get_devdata(master);
> +
> +	spin_lock_irqsave(&rs->lock, flags);
> +
> +	if (rs->use_dma) {
> +		if (rs->state & RXBUSY) {
> +			dmaengine_terminate_all(rs->dma_rx.ch);
> +			flush_fifo(rs);
> +		}
> +
> +		if (rs->state & TXBUSY)
> +			dmaengine_terminate_all(rs->dma_tx.ch);
> +	}

This initially looks wrong - the DMA should all be quiesced by the time
that we get to unpreparing the hardware, otherwise the transfer might be
ongoing while the chip select is deasserted.  However this is really
just error handling in case something went wrong which is sensible and
reasonable, a comment explaining this would help so can you please send
a followup patch adding one.

The error handling here is actually a good point - we should probably
add a callback for the core to use when it times out since the issue
also applies if there are further transactions queued with the hardware.
I'll look into that later unless someone does it first.

> +	/* Delay until the FIFO data completely */
> +	if (xfer->tx_buf)
> +		xfer->delay_usecs
> +			= rs->fifo_len * rs->bpw * 1000000 / rs->speed;

The driver shouldn't be doing this, if it needs a delay it needs to
implement it itself.  delay_usecs can be set by devices if they need a
delay between transfers, it should be in addition to the time taken for
the transfer to complete.

Please send a followup patch fixing this.

> +static bool rockchip_spi_can_dma(struct spi_master *master,
> +		struct spi_device *spi,
> +		struct spi_transfer *xfer)
> +{
> +	struct rockchip_spi *rs = spi_master_get_devdata(master);
> +
> +	return (xfer->len > rs->fifo_len);
> +}

We should factor this out into the core as well, just let the driver set
the minimum size for DMA since it's such a common pattern.  I'll look
into this as well.

> +	master = spi_alloc_master(&pdev->dev, sizeof(struct rockchip_spi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "No memory for spi_master\n");
> +		return -ENOMEM;
> +	}

No need to print an error message - OOM messags from the memory
management subsystem are already noisy enough as it is.

> +	dev_info(&pdev->dev, "Rockchip SPI controller initialized\n");

Please send a followup patch removing this, it's not really adding
anything and there's core debug messages that can be enabled - usually
these prints are done when there is some information that has been read
back from the hardware (eg, IP revisions).

> +static const struct of_device_id rockchip_spi_dt_match[] = {
> +	{ .compatible = "rockchip,rk3066-spi", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);

Your DT binding defined some additional compatible strings, please add
those to the driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/4974b73c/attachment.sig>
