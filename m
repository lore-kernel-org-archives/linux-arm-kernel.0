From: b32955@freescale.com (Huang Shijie)
Date: Thu, 13 Dec 2012 10:20:27 +0800
Subject: [PATCH] mxs: uart: allow setting RTS from software
In-Reply-To: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1355329913-27666-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <50C93B6B.7090206@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?12?13? 00:31, Steffen Trumtrar ??:
> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
> mainline mxs-uart driver now sets RTSEN only when hardware flow control is
> enabled via software. It is not possible any longer to set RTS manually via
> software. However, the manual modification is a valid operation.
> Regain the possibility to set RTS via software and only set RTSEN when hardware
Is there any user case to set the RTS via software?
I am confused at this.
> flow control is explicitly enabled via settermios cflag CRTSCTS.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/tty/serial/mxs-auart.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 6db23b0..9b62c4b 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
>  
>  	u32 ctrl = readl(u->membase + AUART_CTRL2);
>  
> -	ctrl &= ~AUART_CTRL2_RTSEN;
> +	ctrl &= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
>  	if (mctrl & TIOCM_RTS) {
>  		if (tty_port_cts_enabled(&u->state->port))
>  			ctrl |= AUART_CTRL2_RTSEN;
> +		else
> +			ctrl |= AUART_CTRL2_RTS;
>  	}
>  
>  	s->ctrl = mctrl;
> @@ -678,6 +680,10 @@ static void mxs_auart_settermios(struct uart_port *u,
>  		}
>  		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
>  	} else {
> +		u->flags |= ASYNC_CTS_FLOW;
> +		ctrl2 |= AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN;
> +	} else {
> +		u->flags &= ~ASYNC_CTS_FLOW;
bug.

Your code adds TWO "else" here.

thanks
Huang Shijie
>  		ctrl2 &= ~(AUART_CTRL2_CTSEN | AUART_CTRL2_RTSEN);
>  	}
>  
