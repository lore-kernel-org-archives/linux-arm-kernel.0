From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 06 Dec 2013 23:29:02 +0000
Subject: [PATCH v2] serial: 8250_dw: Improve unwritable LCR workaround
In-Reply-To: <20131126183559.GA18570@localhost>
References: <1380647888-32473-1-git-send-email-tim.kryger@linaro.org>
 <20131126183559.GA18570@localhost>
Message-ID: <4548523.McqEijQYrs@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 November 2013 15:36:00 Ezequiel Garcia wrote:
> Hello,
> 
> On Tue, Oct 01, 2013 at 10:18:08AM -0700, Tim Kryger wrote:
> > When configured with UART_16550_COMPATIBLE=NO or in versions prior to
> > the introduction of this option, the Designware UART will ignore writes
> > to the LCR if the UART is busy.  The current workaround saves a copy of
> > the last written LCR and re-writes it in the ISR for a special interrupt
> > that is raised when a write was ignored.
> > 
> > Unfortunately, interrupts are typically disabled prior to performing a
> > sequence of register writes that include the LCR so the point at which
> > the retry occurs is too late.  An example is serial8250_do_set_termios()
> > where an ignored LCR write results in the baud divisor not being set and
> > instead a garbage character is sent out the transmitter.
> > 
> > Furthermore, since serial_port_out() offers no way to indicate failure,
> > a serious effort must be made to ensure that the LCR is actually updated
> > before returning back to the caller.  This is difficult, however, as a
> > UART that was busy during the first attempt is likely to still be busy
> > when a subsequent attempt is made unless some extra action is taken.
> > 
> > This updated workaround reads back the LCR after each write to confirm
> > that the new value was accepted by the hardware.  Should the hardware
> > ignore a write, the TX/RX FIFOs are cleared and the receive buffer read
> > before attempting to rewrite the LCR out of the hope that doing so will
> > force the UART into an idle state.  While this may seem unnecessarily
> > aggressive, writes to the LCR are used to change the baud rate, parity,
> > stop bit, or data length so the data that may be lost is likely not
> > important.  Admittedly, this is far from ideal but it seems to be the
> > best that can be done given the hardware limitations.
> > 
> > Lastly, the revised workaround doesn't touch the LCR in the ISR, so it
> > avoids the possibility of a "serial8250: too much work for irq" lock up.
> > This problem is rare in real situations but can be reproduced easily by
> > wiring up two UARTs and running the following commands.
> > 
> >   # stty -F /dev/ttyS1 echo
> >   # stty -F /dev/ttyS2 echo
> >   # cat /dev/ttyS1 &
> >   [1] 375
> >   # echo asdf > /dev/ttyS1
> >   asdf
> >   
> >   [   27.700000] serial8250: too much work for irq96
> >   [   27.700000] serial8250: too much work for irq96
> >   [   27.710000] serial8250: too much work for irq96
> >   [   27.710000] serial8250: too much work for irq96
> >   [   27.720000] serial8250: too much work for irq96
> >   [   27.720000] serial8250: too much work for irq96
> >   [   27.730000] serial8250: too much work for irq96
> >   [   27.730000] serial8250: too much work for irq96
> >   [   27.740000] serial8250: too much work for irq96
> > 
> > Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> > Reviewed-by: Matt Porter <matt.porter@linaro.org>
> > Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> > ---
> > 
> > Changes in v2:
> >   - Rebased on tty-next
> >   - Updated commit messsage to mention UART_16550_COMPATIBLE
> >   - Removed potentially unnecessary read of LSR and MSR
> >   - Only attempt workaround when LCR write is ignored
> >  
> >  drivers/tty/serial/8250/8250_dw.c | 41
> >  ++++++++++++++++++++++++++++++--------- 1 file changed, 32
> >  insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dw.c
> > b/drivers/tty/serial/8250/8250_dw.c index d04a037..4658e3e 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -57,7 +57,6 @@
> > 
> >  struct dw8250_data {
> >  
> >  	u8			usr_reg;
> > 
> > -	int			last_lcr;
> > 
> >  	int			last_mcr;
> >  	int			line;
> >  	struct clk		*clk;
> > 
> > @@ -77,17 +76,33 @@ static inline int dw8250_modify_msr(struct uart_port
> > *p, int offset, int value)> 
> >  	return value;
> >  
> >  }
> > 
> > +static void dw8250_force_idle(struct uart_port *p)
> > +{
> > +	serial8250_clear_and_reinit_fifos(container_of
> > +					  (p, struct uart_8250_port, port));
> > +	(void)p->serial_in(p, UART_RX);
> > +}
> > +
> > 
> >  static void dw8250_serial_out(struct uart_port *p, int offset, int value)
> >  {
> >  
> >  	struct dw8250_data *d = p->private_data;
> > 
> > -	if (offset == UART_LCR)
> > -		d->last_lcr = value;
> > -
> > 
> >  	if (offset == UART_MCR)
> >  	
> >  		d->last_mcr = value;
> >  	
> >  	writeb(value, p->membase + (offset << p->regshift));
> > 
> > +
> > +	/* Make sure LCR write wasn't ignored */
> > +	if (offset == UART_LCR) {
> > +		int tries = 1000;
> > +		while (tries--) {
> > +			if (value == p->serial_in(p, UART_LCR))
> > +				return;
> > +			dw8250_force_idle(p);
> > +			writeb(value, p->membase + (UART_LCR << p->regshift));
> > +		}
> > +		dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > +	}
> > 
> >  }
> >  
> >  static unsigned int dw8250_serial_in(struct uart_port *p, int offset)
> > 
> > @@ -108,13 +123,22 @@ static void dw8250_serial_out32(struct uart_port *p,
> > int offset, int value)> 
> >  {
> >  
> >  	struct dw8250_data *d = p->private_data;
> > 
> > -	if (offset == UART_LCR)
> > -		d->last_lcr = value;
> > -
> > 
> >  	if (offset == UART_MCR)
> >  	
> >  		d->last_mcr = value;
> >  	
> >  	writel(value, p->membase + (offset << p->regshift));
> > 
> > +
> > +	/* Make sure LCR write wasn't ignored */
> > +	if (offset == UART_LCR) {
> > +		int tries = 1000;
> > +		while (tries--) {
> > +			if (value == p->serial_in(p, UART_LCR))
> > +				return;
> > +			dw8250_force_idle(p);
> > +			writel(value, p->membase + (UART_LCR << p->regshift));
> > +		}
> > +		dev_err(p->dev, "Couldn't set LCR to %d\n", value);
> > +	}
> > 
> >  }
> >  
> >  static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
> > 
> > @@ -132,9 +156,8 @@ static int dw8250_handle_irq(struct uart_port *p)
> > 
> >  	if (serial8250_handle_irq(p, iir)) {
> >  	
> >  		return 1;
> >  	
> >  	} else if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
> > 
> > -		/* Clear the USR and write the LCR again. */
> > +		/* Clear the USR */
> > 
> >  		(void)p->serial_in(p, d->usr_reg);
> > 
> > -		p->serial_out(p, UART_LCR, d->last_lcr);
> > 
> >  		return 1;
> >  	
> >  	}
> 
> Since v3.13-rc1, this commit seems to have introduced some oddities on
> some of our boards. See this log snippet:
> 
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> ????R?console [ttyS0] enabled
> console [ttyS0] enabled
> bootconsole [earlycon0] disabled
> bootconsole [earlycon0] disabled
> dw-apb-uart d0012100.serial: Couldn't set LCR to 191
> dw-apb-uart d0012100.serial: Couldn't set LCR to 191
> dw-apb-uart d0012100.serial: Couldn't set LCR to 224
> dw-apb-uart d0012100.serial: Couldn't set LCR to 224
> d0012100.serial: ttyS1 at MMIO 0xd0012100 (irq = 18, base_baud = 15625000)
> is a 16550A
> 
> This behavior appear in at least Armada 370 and Armada XP boxes.
> 
> I confirm reverting this commit fixes the issue and things get back to
> normal. Here's the complete kernel log: sprunge.us/gMdL
> 
> Ideas?

Hi,

This commit is causing problems for me too on v3.13-rc1. I get the LCR errors 
during boot. Output works fine (the console log is on ttyS0), but input just 
doesn't respond. Reverting this commit makes it work again.

I added some debug to print on first loop iteration:
* the previous last_lcr
* the read back LCR before the LCR write
* the new written LCR value
* the read back LCR after the LCR write
Also added a print in the special busy handling in dw8250_handle_irq which 
doesn't get hit in this case.
This is the ooutput:

Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
LCR set failed [0]->3->[bf]->9f
dw-apb-uart 2004b00.uart: Couldn't set LCR to 191
LCR set succeeded [bf]->9f->[0]->0
LCR set succeeded [0]->0->[80]->80
LCR set failed [80]->80->[bf]->9f
dw-apb-uart 2004b00.uart: Couldn't set LCR to 191
LCR set succeeded [bf]->9f->[0]->0
LCR set failed [0]->0->[e0]->c0
dw-apb-uart 2004b00.uart: Couldn't set LCR to 224
LCR set succeeded [e0]->c0->[0]->0
LCR set failed [0]->0->[e0]->c0
dw-apb-uart 2004b00.uart: Couldn't set LCR to 224
LCR set failed [e0]->c0->[0]->80
dw-apb-uart 2004b00.uart: Couldn't set LCR to 0
LCR set failed [0]->80->[0]->80
dw-apb-uart 2004b00.uart: Couldn't set LCR to 0
LCR set succeeded [0]->80->[80]->80
LCR set failed [80]->80->[0]->80
dw-apb-uart 2004b00.uart: Couldn't set LCR to 0
LCR set failed [0]->80->[3]->80
dw-apb-uart 2004b00.uart: Couldn't set LCR to 3
2004b00.uart: ttyS0 at MMIO 0x2004b00 (irq = 4, base_baud = 114495) is a 
XScale

So it looks like the LCR does always change immediately for me in this case 
(obviously it hasn't hit the BUSY case), but not all the bits can be written. 
In particular bit 5 and bit 7 at the least. If I do this (sorry for whitespace 
munging):

diff --git a/drivers/tty/serial/8250/8250_dw.c 
b/drivers/tty/serial/8250/8250_dw.c
index 4658e3e..722d448 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -96,7 +96,7 @@ static void dw8250_serial_out(struct uart_port *p, int 
offset, int value)
 	if (offset == UART_LCR) {
 		int tries = 1000;
 		while (tries--) {
-			if (value == p->serial_in(p, UART_LCR))
+			if (value & ~0xa0 == p->serial_in(p, UART_LCR) & ~0xa0)
 				return;
 			dw8250_force_idle(p);
 			writeb(value, p->membase + (UART_LCR << p->regshift));
@@ -132,7 +132,7 @@ static void dw8250_serial_out32(struct uart_port *p, int 
offset, int value)
 	if (offset == UART_LCR) {
 		int tries = 1000;
 		while (tries--) {
-			if (value == p->serial_in(p, UART_LCR))
+			if (value & ~0xa0 == p->serial_in(p, UART_LCR) & ~0xa0)
 				return;
 			dw8250_force_idle(p);
 			writel(value, p->membase + (UART_LCR << p->regshift));

Then all is well again (note, BUSY case not actually tested).

According to include/uapi/linux/serial_reg.h:

#define UART_LCR_DLAB		0x80 /* Divisor latch access bit */
#define UART_LCR_SPAR		0x20 /* Stick parity (?) */

I don't know much about the 8250 interface to have much clue why these bits 
wouldn't change. I suppose it's conceivable bit 5 is simply unimplemented in 
the hardware since it sounds like it's just for debugging purposes, Note the 
last failure which failed to set 0x80 -> 0x03 (software probably thinking 
0x00->0x03).

Thoughts anybody? Any other useful info I can provide?

Thanks
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/81209637/attachment.sig>
