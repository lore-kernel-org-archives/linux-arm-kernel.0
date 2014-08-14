From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Aug 2014 22:02:53 +0100
Subject: [PATCH] spi: rockchip: return 0 if tx_buf and rx_buf are NULL
In-Reply-To: <1407977544-2989-1-git-send-email-addy.ke@rock-chips.com>
References: <1407977544-2989-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140814210253.GF17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 08:52:24AM +0800, Addy Ke wrote:
> To do so, spi communication can use an empty buf to pull up CS.

> This patch merged from ChromiumOS tree.
> Cros_ec use this function to turn off CS and add a delay to ensure
> the rising edge doesn't come too soon after the end of the data.

>  	if (!xfer->tx_buf && !xfer->rx_buf) {
> -		dev_err(rs->dev, "No buffer for transfer\n");
> -		return -EINVAL;
> +		dev_dbg(rs->dev, "No buffer for transfer\n");
> +		return 0;
>  	}

We should be implementing this in the core rather than the driver - just
not even call into the controller driver if there's nothing to do.  That
way we make sure that every driver works properly.  After all, the delay
itself is implemented in the core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140814/19f8f028/attachment.sig>
