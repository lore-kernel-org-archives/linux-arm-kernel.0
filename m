From: broonie@kernel.org (Mark Brown)
Date: Tue, 1 Oct 2013 15:24:56 +0100
Subject: [PATCH] i2c: s3c2410 : Add polling mode support
In-Reply-To: <1380623620-31901-1-git-send-email-yuvaraj.cd@samsung.com>
References: <1380623620-31901-1-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <20131001142456.GP19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 04:03:40PM +0530, Yuvaraj Kumar C D wrote:

> +static bool is_ack(struct s3c24xx_i2c *i2c)
> +{
> +	u32 time_out = i2c->tx_setup;
> +
> +	while (--time_out) {
> +		if (readl(i2c->regs + S3C2410_IICCON)
> +			& S3C2410_IICCON_IRQPEND) {
> +			if (!(readl(i2c->regs + S3C2410_IICSTAT)
> +				& S3C2410_IICSTAT_LASTBIT))
> +				return true;
> +		}
> +		udelay(time_out);
> +	}
> +
> +	return false;

This is a bit weird - the amount of time the driver waits between polls
shrinks as the timeout approaches.  It'd be more normal to see either an
even period between polls or (ideally if the delay is non-trivial) a
dead reckoning sleep based on the expected time to complete followed by
polling at even intervals.

Also consider usleep_range() for the delay, it's a bit nicer to the rest
of the system than udelay().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/5722264d/attachment.sig>
