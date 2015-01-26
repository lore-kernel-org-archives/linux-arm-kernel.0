From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Jan 2015 23:54:38 +0000
Subject: [PATCH 04/18] spi-xilinx: Simplify spi_fill_tx_fifo
In-Reply-To: <1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <20150126235438.GJ21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:08:36PM +0100, Ricardo Ribalda Delgado wrote:
> Instead of checking the TX_FULL flag for every transaction, find out the
> size of the buffer at probe time and use it.

So, I see what's going on here and the potential performance benefit
from avoiding the MMIO access.  However I can't help but worry that this
makes things more fragile - the current code will transparently handle
any races or anything which result in a misfilling of the FIFO for some
reason either now or in the future as performance is improved and the
driver gets more fancy.

As things stand if I look at the code it's fairly clear it should be
safe and unfortunately we only have an underrun interrupt which will be
triggered normally (no overflow interrupt) so we can't really use that
to add a bit of robustness.  I'm tempted to suggest checking that we did
trigger the FIFO full flag when we fill the FIFO but that feels like
overengineering.

Let me think about this, I'll probably apply it but if you can think
about ways of making this more robust that'd be good.

> @@ -413,6 +424,8 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>  		goto put_master;
>  	}
>  
> +	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
> +
>  	/* SPI controller initializations */
>  	xspi_init_hw(xspi);

It seems safer to reset the hardware, probe the FIFO size and then reset
the hardware again in case something decided to leave some data in the
FIFO (perhaps some bootloader wasn't as well programmed as one might
desire for example).  Not cricial now but it could again become
important with future optimizations.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/905f07e9/attachment.sig>
