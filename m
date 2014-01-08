From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 13:21:47 +0000
Subject: [PATCH] spi: atmel: Refactor spi-atmel to use SPI framework queue
In-Reply-To: <1389160188-4030-1-git-send-email-wenyou.yang@atmel.com>
References: <1389160188-4030-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20140108132147.GF31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 01:49:48PM +0800, Wenyou Yang wrote:

> The patch is based on for-next branch of
> 	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git

Sorry, there was a patch from Richard which got applied but not pushed
out - I've pushed it now but it conflicts with this.  Can you please
rebase?  It should be a simple update from the looks of things.

> -		tasklet_schedule(&as->tasklet);
> +		atmel_spi_lock(as);
> +		complete(&as->xfer_completion);
> +		atmel_spi_unlock(as);

Why do you need to hold the lock to complete the transfer?  That seems
very odd.

> +	/*
> +	 * DMA map early, for performance (empties dcache ASAP) and
> +	 * better fault reporting.
> +	 */
> +	if ((!msg->is_dma_mapped)
> +		&& (atmel_spi_use_dma(as, xfer)	|| as->use_pdc)) {
> +		if (atmel_spi_dma_map_xfer(as, xfer) < 0)
> +			return -ENOMEM;
> +	}

Just a heads up at this point but this is most likely going to be moved
into the core soon.

> +	if (xfer->delay_usecs)
> +		udelay(xfer->delay_usecs);

If you convert to transfer_one() instead of transfer_one_message() then
this will be handled for you.  What you're doing at the minute is still
an improvement so it should be OK but it'd be worth a look.  There will
be further changes in this to factor out the DMA and message push code.

> +	if (xfer->cs_change) {
> +		cs_deactivate(as, msg->spi);
> +		udelay(1);
> +		cs_activate(as, msg->spi);
> +	}

This is buggy, cs_change should flip the polarity of /CS rather than
bounce it on and off except if set on the last transfer in a message in
which case it should cause /CS to remain asserted after the message is
finished.  Again, transfer_one() factors this out - you can at least
look at this to see what should be done.

> +	if (as->stopping)
> +		return -ESHUTDOWN;

You shouldn't need to worry about this, the core should handle this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/aef6145d/attachment.sig>
