From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jun 2015 10:14:48 +0100
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
In-Reply-To: <20150608064113.GX18985@pengutronix.de>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150608064113.GX18985@pengutronix.de>
Message-ID: <20150608091448.GT7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 08:41:13AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
> > The LPUART does not provide manual control of RTS/CTS signals,
> > those can only be controlled by the hardware directly. Therefore
> > manual control of those signals through mctrl can not be provided.
> > The current implementation enables/disables the automatic control,
> > which is not what mctrl should do, hence remove the incorrect
> > implementation.
> > 
> > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 63 +++++------------------------------------
> >  1 file changed, 7 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> > index 08ce76f..532cfb7 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -822,64 +822,15 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
> >  
> >  static unsigned int lpuart_get_mctrl(struct uart_port *port)
> >  {
> > -	unsigned int temp = 0;
> > -	unsigned char reg;
> > -
> > -	reg = readb(port->membase + UARTMODEM);
> > -	if (reg & UARTMODEM_TXCTSE)
> > -		temp |= TIOCM_CTS;
> > -
> > -	if (reg & UARTMODEM_RXRTSE)
> > -		temp |= TIOCM_RTS;
> > -
> > -	return temp;
> >From reading the commit log I would expect that you only touch the
> set_mctrl function, but not get_mctrl. Assuming your code change is
> right, can you mention this in the commit log please? The bits
> UARTMODEM_TXCTSE and UARTMODEM_RXRTSE only control the automatic mode?

Dumb serial writers common fault #1 is to make get_mctrl return TIOCM_RTS
and/or TIOCM_DTR.  It should never return these.  This is a sure sign
that the serial writer doesn't know what they're doing, and doesn't
understand the interface they're implementing.  That's a good enough
reason IMHO to reject a driver prior to merging.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
