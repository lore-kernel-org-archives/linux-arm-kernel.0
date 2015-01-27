From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 00:04:28 +0000
Subject: [PATCH 08/18] spi/xilinx: Support cores with no interrupt
In-Reply-To: <1422029330-10971-9-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-9-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150127000428.GK21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:08:40PM +0100, Ricardo Ribalda Delgado wrote:

> The core can run in polling mode. In fact, the performance of the core
> is similar (or even better), due to the fact most of the spi
> transactions are just a couple of bytes and there is one irq per
> transactions.

> When an mtd device is connected via spi, reading 8MB of data produces
> more than 80K interrupts (with irq disabling, context swith....)

Right, for short transfers polling tends to win every time over
interrupts - if you look at other controller drivers you'll see a lot of
them use this technique.  The best practice here is generally to use a
copy break and do very short transfers in polling mode and go back to
interrupts for larger ones.  This break is typically done at the point
where we go over a FIFO in transfer size since normally if the device is
designed to be run with DMA the FIFO will be quite small.

Obviously this isn't quite the same case since not only is there no DMA
support (yet?) but the FIFO could be any size but similar things apply
especially if someone configured the device with a large FIFO.

> -	xspi_init_hw(xspi);
> -
>  	xspi->irq = platform_get_irq(pdev, 0);
> -	if (xspi->irq < 0) {
> -		ret = xspi->irq;
> -		goto put_master;
> +	if (xspi->irq >= 0) {
> +		/* Register for SPI Interrupt */
> +		ret = devm_request_irq(&pdev->dev, xspi->irq, xilinx_spi_irq, 0,
> +				dev_name(&pdev->dev), xspi);
> +		if (ret)
> +			goto put_master;
>  	}
>  
> -	/* Register for SPI Interrupt */
> -	ret = devm_request_irq(&pdev->dev, xspi->irq, xilinx_spi_irq, 0,
> -			       dev_name(&pdev->dev), xspi);
> -	if (ret)
> -		goto put_master;
> +	/* SPI controller initializations */
> +	xspi_init_hw(xspi);

This appears to move the interrupt request before the hardware reset.
Are you sure the interrupt handler won't misbehave if it fires before we
finished initializing?  One thing the hardware reset should do is get
the device in a known good state.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/058cb42d/attachment.sig>
