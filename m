From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 May 2011 14:44:54 +0200
Subject: [PATCH 1/2] spi/pl022: timeout on polled transfer
In-Reply-To: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
References: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110519124454.GC2219@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -		/* FIXME: insert a timeout so we don't hang here indefinitely */
> -		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end)
> +
> +		timeout = jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);

Won't you miss the transfer if you get interrupted here longer than
SPI_POLLING_TIMEOUT?

> +		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
> +			if (time_after(jiffies, timeout)) {
> +				dev_warn(&pl022->adev->dev,
> +				"%s: timeout!\n", __func__);
> +				message->state = STATE_ERROR;
> +				goto out;
> +			}
>  			readwriter(pl022);
> +		}

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110519/d5c2ab71/attachment.sig>
