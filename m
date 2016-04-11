From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Apr 2016 11:57:40 +0100
Subject: [PATCH v3] spi: orion.c: Add direct access mode
In-Reply-To: <1460030811-13787-1-git-send-email-sr@denx.de>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
Message-ID: <20160411105740.GB3351@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 02:06:51PM +0200, Stefan Roese wrote:

> @@ -372,10 +383,44 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>  {
>  	unsigned int count;
>  	int word_len;
> +	struct orion_spi *orion_spi;
> +	int cs = spi->chip_select;
>  
>  	word_len = spi->bits_per_word;
>  	count = xfer->len;
>  
> +	orion_spi = spi_master_get_devdata(spi->master);
> +
> +	/* Use SPI direct access mode if base address is available */
> +	if (orion_spi->direct_access[cs].vaddr) {
> +		struct orion_direct_acc *da = &orion_spi->direct_access[cs];
> +
> +		if (count > da->size) {
> +			dev_err(&spi->dev,
> +				"max transfer size exceeded (%d > %d)\n",
> +				count, da->size);
> +			return 0;
> +		}

This seems obviously broken, we're neither returning an error nor
falling back to PIO here but instead silently ignoring the transfer.  If
we can't fall back then I'd expect the driver to be setting
max_transfer_size but it isn't, it's probably a good idea from a
performance point of view to set it even if we can fall back.

> +		if (xfer->tx_buf) {
> +			/*
> +			 * Send the tx-data to the SPI device via the direct
> +			 * mapped address window
> +			 */
> +			memcpy(da->vaddr, xfer->tx_buf, count);
> +		}
> +
> +		if (xfer->rx_buf) {
> +			/*
> +			 * Read the rx-data from the SPI device via the direct
> +			 * mapped address window
> +			 */
> +			memcpy(xfer->rx_buf, da->vaddr, count);
> +		}

Do bidirectional transfers work properly with this method (how much
incoming data can we queue up, is there memory backing the whole
region?), and are we guaranteed that the transfer finished by the time
we return?  I'm also not seeing anything here that handles word size so
I suspect this will cause data corruption with anything other than 8 bit
words and the driver does support 16 bit with PIO.  If only 8 bit words
can be supported with direct access I'd expect to see the
bits_per_word_mask updated.

> +               spi->direct_access[cs].vaddr = devm_ioremap_resource(&pdev->dev,
> +                                                                    r);
> +               if (IS_ERR(spi->direct_access[cs].vaddr)) {
> +                       status = PTR_ERR(spi->direct_access[cs].vaddr);
> +                       goto out_rel_clk;
> +               }
> +
> +               spi->direct_access[cs].size = resource_size(r);
> +               dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
> +       }

I seem to be missing where we configure the hardware to connect the
windows to the chip selects.  We just seem to map the windows but never
otherwise interact with the hardware.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160411/a428120e/attachment.sig>
