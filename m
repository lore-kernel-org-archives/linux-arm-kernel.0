From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Sep 2014 11:21:05 +0100
Subject: [PATCH v5] spi: spi-imx: add DMA support
In-Reply-To: <1410312604-31949-1-git-send-email-b38343@freescale.com>
References: <1410312604-31949-1-git-send-email-b38343@freescale.com>
Message-ID: <20140910102105.GR2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 09:30:04AM +0800, Robin Gong wrote:

> +static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
> +			 struct spi_transfer *transfer)
> +{
> +	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
> +
> +	if (spi_imx->dma_is_inited && (transfer->len > spi_imx->rx_wml)
> +	    && (transfer->len > spi_imx->tx_wml))
> +		spi_imx->usedma = true;
> +	else
> +		spi_imx->usedma = false;
> +
> +	return spi_imx->usedma;
> +}

This isn't going to work, anything that looks at the usedma flag will
see the result of the last thing that was checked which may or may not
be the transfer that it's handling.  The driver should check to see if
the core mapped the transfer for DMA.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/b5cff6e2/attachment-0001.sig>
