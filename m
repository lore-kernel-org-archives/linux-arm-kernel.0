From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 10:19:31 +0100
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
In-Reply-To: <20150608064113.GX18985@pengutronix.de>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150608064113.GX18985@pengutronix.de>
Message-ID: <20150608091931.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 08:41:13AM +0200, Uwe Kleine-K?nig wrote:
> >From reading the commit log I would expect that you only touch the
> set_mctrl function, but not get_mctrl. Assuming your code change is
> right, can you mention this in the commit log please? The bits
> UARTMODEM_TXCTSE and UARTMODEM_RXRTSE only control the automatic mode?

And... another point. UARTMODEM_TXCTSE and UARTMODEM_RXRTSE are the
auto flow control _enable_ signals.  That's not something that
get_mctrl() should ever return.  get_mctrl() is about reporting the
actual current state of the CTS, DSR, DCD and RI signals _only_.

If the hardware doesn't let you read the state, then reporting that
CTS, DSR and DCD are all asserted is recommended, as that's the
state needed to make the UART do useful stuff.  So that part of
this patch is the sane thing to do.

What isn't sane is to use the auto-cts enable bit to report a
ficticious current CTS state.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
