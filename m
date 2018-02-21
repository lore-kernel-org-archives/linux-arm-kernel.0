From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Feb 2018 09:17:47 +0100
Subject: [PATCH v3 1/1] tty: serial: imx: allow breaks to be received
 when using dma
In-Reply-To: <6a93d743-05ef-0b23-9419-913b9d2c78ee@boundarydevices.com>
References: <20180220182038.4325-1-troy.kisky@boundarydevices.com>
 <20180220195944.kgl4olfc7eitzpxg@pengutronix.de>
 <6a93d743-05ef-0b23-9419-913b9d2c78ee@boundarydevices.com>
Message-ID: <20180221081747.bajkq7kdgkx2ktug@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Troy,

On Tue, Feb 20, 2018 at 12:25:16PM -0800, Troy Kisky wrote:
> >> @@ -1028,6 +1027,7 @@ static int start_rx_dma(struct imx_port *sport)
> >>  
> >>  static void clear_rx_errors(struct imx_port *sport)
> >>  {
> >> +	struct tty_port *port = &sport->port.state->port;
> >>  	unsigned int status_usr1, status_usr2;
> >>  
> >>  	status_usr1 = readl(sport->port.membase + USR1);
> >> @@ -1036,12 +1036,18 @@ static void clear_rx_errors(struct imx_port *sport)
> >>  	if (status_usr2 & USR2_BRCD) {
> >>  		sport->port.icount.brk++;
> >>  		writel(USR2_BRCD, sport->port.membase + USR2);
> >> -	} else if (status_usr1 & USR1_FRAMERR) {
> >> -		sport->port.icount.frame++;
> >> -		writel(USR1_FRAMERR, sport->port.membase + USR1);
> >> -	} else if (status_usr1 & USR1_PARITYERR) {
> >> -		sport->port.icount.parity++;
> >> -		writel(USR1_PARITYERR, sport->port.membase + USR1);
> >> +		if (tty_insert_flip_char(port, 0, TTY_BREAK) == 0)
> >> +			sport->port.icount.buf_overrun++;
> >> +		tty_flip_buffer_push(port);
> > 
> > I think this needs to call uart_handle_break() as imx_rxint() does. Not sure
> > how to properly handle SYSRQ in the dma case though.
> > 
> 
> 
> SYSRQ is only for the console port, and console port is never dma. But UPF_SAK may be
> an issue. I don't know enough about "Secure Attention Key" to say.
> 
> 
> Should I add uart_handle_break anyway ?

You're right about both SYSRQ and SAK. I think uart_handle_break is the
right one for the latter.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
