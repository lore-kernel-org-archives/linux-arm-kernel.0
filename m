From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 19 May 2011 16:23:23 +0200
Subject: [PATCH 1/2] spi/pl022: timeout on polled transfer
In-Reply-To: <BANLkTinrk-FjMy1trDnsxwT_NTgQ5x_8Rg@mail.gmail.com>
References: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
	<20110519124454.GC2219@pengutronix.de>
	<BANLkTinrk-FjMy1trDnsxwT_NTgQ5x_8Rg@mail.gmail.com>
Message-ID: <20110519142323.GD2219@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> + ? ? ? ? ? ? while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
> >> + ? ? ? ? ? ? ? ? ? ? if (time_after(jiffies, timeout)) {
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_warn(&pl022->adev->dev,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? "%s: timeout!\n", __func__);
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? message->state = STATE_ERROR;
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto out;
> >> + ? ? ? ? ? ? ? ? ? ? }
> >> ? ? ? ? ? ? ? ? ? ? ? readwriter(pl022);
> >> + ? ? ? ? ? ? }
> 
> What about we move readerwriter() above if (time_after...) then it atleast
> gets one chance to run even if we're preempted for 10 seconds.

This will fix the initial problem, but still exit early if e.g. the
preemption came on a subsequent iteration of the while loop, say during
readwriter().

> 
> Any other design patterns that'd be better?

A bit better might be:

	while (...) {
		time = jiffies;
		readwriter();
		if (time_after(time, timeout)...)
			...
	}

So you continue triggering transfers as long as the last one was in the
valid timespan. In case of an preemption, you made sure you tried the
whole timespan (+ the jitter) which is probably better than stop trying
too early.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110519/af841886/attachment.sig>
