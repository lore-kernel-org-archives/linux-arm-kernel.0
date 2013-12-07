From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 06 Dec 2013 16:59:16 -0800 (PST)
Subject: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
In-Reply-To: <CAAYSxhpR664Od7AaWZrX0rE=iDUHo0h+4=uY=gvkFps4Hz4aew@mail.gmail.com>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
 <5548535.pYirbknue4@radagast>
 <CAAYSxhpR664Od7AaWZrX0rE=iDUHo0h+4=uY=gvkFps4Hz4aew@mail.gmail.com>
Message-ID: <3010367.6CxxZ6Dpea@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013 16:31:38 Tim Kryger wrote:
> On Fri, Dec 6, 2013 at 3:51 PM, James Hogan <james.hogan@imgtec.com> wrote:
> > On Friday 06 December 2013 23:29:02 James Hogan wrote:
> >> So it looks like the LCR does always change immediately for me in this
> >> case
> >> (obviously it hasn't hit the BUSY case), but not all the bits can be
> >> written. In particular bit 5 and bit 7 at the least. If I do this (sorry
> >> for whitespace munging):
> >> 
> >> diff --git a/drivers/tty/serial/8250/8250_dw.c
> >> b/drivers/tty/serial/8250/8250_dw.c
> >> index 4658e3e..722d448 100644
> >> --- a/drivers/tty/serial/8250/8250_dw.c
> >> +++ b/drivers/tty/serial/8250/8250_dw.c
> >> @@ -96,7 +96,7 @@ static void dw8250_serial_out(struct uart_port *p, int
> >> offset, int value)
> >> 
> >>       if (offset == UART_LCR) {
> >>       
> >>               int tries = 1000;
> >>               while (tries--) {
> >> 
> >> -                     if (value == p->serial_in(p, UART_LCR))
> >> +                     if (value & ~0xa0 == p->serial_in(p, UART_LCR) &
> >> ~0xa0)>> 
> >>                               return;
> >>                       
> >>                       dw8250_force_idle(p);
> >>                       writeb(value, p->membase + (UART_LCR <<
> >>                       p->regshift));
> >> 
> >> @@ -132,7 +132,7 @@ static void dw8250_serial_out32(struct uart_port *p,
> >> int offset, int value)
> >> 
> >>       if (offset == UART_LCR) {
> >>       
> >>               int tries = 1000;
> >>               while (tries--) {
> >> 
> >> -                     if (value == p->serial_in(p, UART_LCR))
> >> +                     if (value & ~0xa0 == p->serial_in(p, UART_LCR) &
> >> ~0xa0)> 
> > My appologies, that should have had some more brackets (I should have
> > retested after cleaning up my debugging). I.e.
> > +                       if ((value & ~0xa0) == (p->serial_in(p, UART_LCR)
> > & ~0xa0))
> > 
> > Cheers
> > James
> 
> James,
> 
> Thanks for the information.  This is really helpful.
> 
> You are right about bit 5 being a problem.  Its behavior differs
> between IP versions 3.00a and 3.14c per the docs.
> 
> As for bit 7, when it doesn't change this indicates the UART was busy
> and we need to do the workaround.
> 
> Would you mind testing it again using a mask of ~0x20?

It appears to work with ~0x20 too, and the workaround isn't getting hit (only 
tested boot and logging in - nothing fancy). I think having the printks in 
this code with the console directed at the serial must have caused 
resursion/busy problems somehow.

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/50eb5703/attachment.sig>
