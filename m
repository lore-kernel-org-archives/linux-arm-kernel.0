From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 22 Dec 2010 21:25:42 +0100
Subject: [PATCH] ARM: mxs: Change duart device to use amba-pl011
In-Reply-To: <1292937130-32155-1-git-send-email-shawn.guo@freescale.com>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
	<1292937130-32155-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101222202542.GT14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Tue, Dec 21, 2010 at 09:12:10PM +0800, Shawn Guo wrote:
> The mxs duart is actually an amba-pl011 device. This commit changes
> the duart device code to dynamically allocate amba-pl011 device,
> so that drivers/serial/amba-pl011.c can be used on mxs.
I have problems using this.  The problem I found up to now is that
during probe of the device (triggered by mxs_add_duart ->
amba_device_register -> amba_put_disable_pclk) the uart clock is
disabled.  This happens because initially its usage count is 0 but the
clock is enabled by barebox.  clk_enable doesn't hurt, but in the
matching clk_disable the usage count drops to zero again and so the
clock is disabled in hardware.  After that no further outputs can be
seen.

I assume the machine dies with a circular exception while trying to
write something out (e.g. that it cannot write to the console :-), but I
havn't checked that.

My first try to put an clk_enable(&uart_clk) after it is registered
didn't help.

Did you face the same problem?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
