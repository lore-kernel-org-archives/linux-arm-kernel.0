From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 09:06:35 +0800
Subject: [PATCH v3] mxs: uart: allow setting RTS from software
In-Reply-To: <50EA98CA.1060303@pengutronix.de>
References: <1355405263-29625-1-git-send-email-s.trumtrar@pengutronix.de>
 <50CA8E8C.5060906@freescale.com> <50EA98CA.1060303@pengutronix.de>
Message-ID: <20130108010631.GG29281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 10:43:38AM +0100, Marc Kleine-Budde wrote:
> On 12/14/2012 03:27 AM, Huang Shijie wrote:
> > ? 2012?12?13? 21:27, Steffen Trumtrar ??:
> >> With the patch "serial: mxs-auart: fix the wrong RTS hardware flow control" the
> >> mainline mxs-uart driver now sets RTSEN only when hardware flow control is
> >> enabled via software. It is not possible any longer to set RTS manually via
> >> software. However, the manual modification is a valid operation.
> >> Regain the possibility to set RTS via software and only set RTSEN when hardware
> >> flow control is explicitly enabled via settermios cflag CRTSCTS.
> >>
> >> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >> ---
> >>  drivers/tty/serial/mxs-auart.c |    4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> >> index 6db23b0..9f63f88 100644
> >> --- a/drivers/tty/serial/mxs-auart.c
> >> +++ b/drivers/tty/serial/mxs-auart.c
> >> @@ -412,10 +412,12 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
> >>  
> >>  	u32 ctrl = readl(u->membase + AUART_CTRL2);
> >>  
> >> -	ctrl &= ~AUART_CTRL2_RTSEN;
> >> +	ctrl &= ~(AUART_CTRL2_RTSEN | AUART_CTRL2_RTS);
> >>  	if (mctrl & TIOCM_RTS) {
> >>  		if (tty_port_cts_enabled(&u->state->port))
> >>  			ctrl |= AUART_CTRL2_RTSEN;
> >> +		else
> >> +			ctrl |= AUART_CTRL2_RTS;
> >>  	}
> >>  
> >>  	s->ctrl = mctrl;
> > Reviewed-by: Huang Shijie <b32955@freescale.com>
> 
> This patch is not not in today's next. What's the current status? Who
> will take it?
> 
I see stable at vger.kernel.org is on copy.  But it's not the correct way
submit a fix for stable tree.  Check out Documentation/stable_kernel_rules.txt
for the correct one.

Remember to copy Greg Kroah-Hartman <gregkh@linuxfoundation.org> who
is collecting serial patches believe.

Shawn
