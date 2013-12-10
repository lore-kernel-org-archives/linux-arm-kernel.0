From: james.hogan@imgtec.com (James Hogan)
Date: Tue, 10 Dec 2013 22:48:06 +0000
Subject: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
In-Reply-To: <20131210121154.GA16238@localhost>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
 <CAAYSxhraDF6T9URw0CpEig2VpnuTBNdZYL9uuw6vdPn0=X4zGA@mail.gmail.com>
 <20131210121154.GA16238@localhost>
Message-ID: <5829576.XRqmsfpHkX@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013 09:11:55 Ezequiel Garcia wrote:
> Hi Tim, James:
> 
> On Mon, Dec 09, 2013 at 04:42:23PM -0800, Tim Kryger wrote:
> > On Fri, Dec 6, 2013 at 4:59 PM, James Hogan <james.hogan@imgtec.com> 
wrote:
> [..]
> 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c
> > b/drivers/tty/serial/8250/8250_dw.c
> > index 4658e3e..5f096c7 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -96,7 +96,8 @@ static void dw8250_serial_out(struct uart_port *p,
> > int offset, int value)
> > 
> >         if (offset == UART_LCR) {
> >         
> >                 int tries = 1000;
> >                 while (tries--) {
> > 
> > -                       if (value == p->serial_in(p, UART_LCR))
> > +                       unsigned int lcr = p->serial_in(p, UART_LCR);
> > +                       if ((value & ~UART_LCR_SPAR) == (lcr &
> > ~UART_LCR_SPAR))> 
> >                                 return;
> >                         
> >                         dw8250_force_idle(p);
> >                         writeb(value, p->membase + (UART_LCR <<
> >                         p->regshift));
> > 
> > @@ -132,7 +133,8 @@ static void dw8250_serial_out32(struct uart_port
> > *p, int offset, int value)
> > 
> >         if (offset == UART_LCR) {
> >         
> >                 int tries = 1000;
> >                 while (tries--) {
> > 
> > -                       if (value == p->serial_in(p, UART_LCR))
> > +                       unsigned int lcr = p->serial_in(p, UART_LCR);
> > +                       if ((value & ~UART_LCR_SPAR) == (lcr &
> > ~UART_LCR_SPAR))> 
> >                                 return;
> >                         
> >                         dw8250_force_idle(p);
> >                         writel(value, p->membase + (UART_LCR <<
> >                         p->regshift));
> > 
> > Would you mind posting this for proper review so we can get the fix in?
> 
> Applying this change fixes all the problems I reported (just did a quick
> test on the board I have currently on my desk).
> 
> Nice work!

Thanks for testing it.

I've posted Tim's version for proper review with both your tested-by.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131210/b0ab9fde/attachment-0001.sig>
