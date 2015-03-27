From: moorray3@wp.pl (Jakub =?UTF-8?B?S2ljacWEc2tp?=)
Date: Fri, 27 Mar 2015 19:10:40 +0100
Subject: [PATCH v4 2/2] serial/amba-pl011: Refactor and simplify TX FIFO
 handling
In-Reply-To: <20150327174223.GA12666@e103592.cambridge.arm.com>
References: <1427468371-11915-1-git-send-email-Dave.Martin@arm.com>
 <1427468371-11915-3-git-send-email-Dave.Martin@arm.com>
 <20150327174055.1a2dc194@north>
 <20150327174223.GA12666@e103592.cambridge.arm.com>
Message-ID: <20150327191040.1119319d@north>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Mar 2015 17:42:24 +0000, Dave P Martin wrote:
> [Resend -- apologies again for any duplicates received]
> 
> On Fri, Mar 27, 2015 at 05:40:55PM +0100, Jakub Kicinski wrote:
> > On Fri, 27 Mar 2015 14:59:31 +0000, Dave Martin wrote:
> > > Commit 734745c serial/amba-pl011: Activate TX IRQ passively
> > > adds some unnecessary complexity and overhead in the form of
> > > a softirq mechanism for transmitting in the absence of interrupts.
> > > 
> > > After some discussion [1], this turns out to be unnecessary.
> > > 
> > > This patch simplifies the code flow to reduce the reliance on
> > > subtle behaviour and avoid fragility under future maintenance.
> > > 
> > > To this end, the TX softirq mechanism is removed and instead
> > > pl011_start_tx() will now simply stuff the FIFO until full
> > > (guaranteeing future TX IRQs), or until there are no more chars
> > > to write (in which case we don't care whether an IRQ happens).
> > > 
> > > [1] Thanks to Jakub Kicinski for his input and similar patch.
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > ---
> > >  drivers/tty/serial/amba-pl011.c |  119 +++++++++------------------------------
> > >  1 file changed, 26 insertions(+), 93 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> 
> [...]
> 
> > > -
> > > -	/*
> > > -	 * If the FIFO is full we're guaranteed a TX IRQ at some later point,
> > > -	 * and can't transmit immediately in any case:
> > > -	 */
> > > -	if (unlikely(uap->tx_irq_seen < 2 &&
> > > -		     readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF))
> > > -		return false;
> > > +	int count = uap->fifosize >> 1;
> > 
> > Dave, I'd prefer if you kept my .prev_from_irq thing.  If .start_tx()
> > races with the IRQ we may have a situation where the IRQ arrives
> > but .start_tx() already filled the FIFO.  The guarantee of half of the
> > FIFO being empty will not hold in this case.  That's why I use the
> > guarantee only if the previous load was also from FIFO.
> 
> I thought about this, but I think port->lock prevents this from
> happening.  I was overly defensive about this in the earlier versions
> of the patches, and that made the code a fair bit more complicated...
> I was hoping it could just go away ;)
> 
> 
> In pl011_int(), we have
> 
> -8<-
> 
> spin_lock_irqsave(&uap->port.lock, flags);
> 
> [...]
> 
> while (status = readw(uap->port.membase + UART012_MIS), status != 0) {
> 
> [...]
> 
> 	if (status & UART011_TXIS)
> 		pl011_tx_chars(uap, true);
> 
> } while (status != 0);
> 
> [...]
> 
> spin_unlock_irqrestore(&uap->port.lock, flags);
> 
> ->8-
> 
> 
> serial_core always holds port->lock around _start_tx(), so it should be
> impossible for any part of _start_tx() to run in parallel with this.  If
> TXIS is asserted and nothing can write the FIFO in the meantime, then
> that should mean that the FIFO is definitely half-empty on entry to
> pl011_tx_chars(..., from_irq=true) -- this is also why it's safe for
> pl011_int() to loop and potentially make repeated calls to
> pl011_tx_chars().
> 
> Can you see a way this could break, or does this reasoning sound good to
> you?

It doesn't have to run in parallel, perhaps using the word "race" was
not entirely justified on my side.  Sorry if my English is not
super-clear ;)  Even when the accesses are serialized the problem
remains.

 - start_tx() runs holding the lock,
 - IRQ fires and waits for the lock,
 - start_tx() exists and releases the lock,
 - IRQ handler grabs the lock and proceeds even though FIFO is full.

I think this would require some adverse condition to trigger (high load
+ high baudrate) or IRQ pending during first unmask (which I think
shouldn't happen, but hey, let's not trust HW too much...).
