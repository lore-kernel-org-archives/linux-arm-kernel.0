From: neilb@suse.de (NeilBrown)
Date: Sat, 4 Feb 2012 08:59:40 +1100
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
Message-ID: <20120204085940.2de44594@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012 13:10:28 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:

> One other comment..
> 
> On Fri, 3 Feb 2012, NeilBrown wrote:
> 
> > On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> > 
> > > On Fri, 3 Feb 2012, NeilBrown wrote:
> > > 
> > > > I can remove this effect with:
> > > > 
> > > > diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> > > > index f809041..c7ef760 100644
> > > > --- a/drivers/tty/serial/omap-serial.c
> > > > +++ b/drivers/tty/serial/omap-serial.c
> > > > @@ -440,7 +440,8 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
> > > >  	spin_lock_irqsave(&up->port.lock, flags);
> > > >  	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
> > > >  	spin_unlock_irqrestore(&up->port.lock, flags);
> > > > -	pm_runtime_put(&up->pdev->dev);
> > > > +	pm_runtime_mark_last_busy(&up->pdev->dev);
> > > > +	pm_runtime_put_autosuspend(&up->pdev->dev);
> > > >  	return ret;
> > > >  }
> 
> It's a little surprising that this helps.  The pm_runtime_get*() and 
> _put*() in serial_omap_tx_empty() are just intended to ensure that the 
> UART's clocks are running for that LSR register read.
> 
> Considering your theory that the UART clocks are being cut while there's 
> still data in the FIFO, you might consider removing this code at the end 
> of transmit_chars():
> 
> 	if (uart_circ_empty(xmit))
> 		serial_omap_stop_tx(&up->port);

I read the code and chickened out of just removing that.
serial_omap_stop_tx seem to do 2 things:
 1/ tell the uart to stop sending interrupts when the tx fifo is empty
 2/ set forceidle (really smartidle) on the uart.

I didn't feel comfortable removing '1' as I thought it might generate an
interrupt storm .. maybe not.
Instead I just removed '2'.  In fact I replaced the 'set_forceidle' call with
'set_noidle'.  So the uart should never report that it was idle.

I did this with my other patch removed so pm_runtime_put() was still being
called.

Result:  I still get corruption.
So having the UART say "no, I'm not idle" does *not* stop the clock
being turned off when we use omap_hwmod_idle() to turn off the clocks.

When we turn off a clock, if that is the last clock in the clock-domain, we
also turn off the clock-domain (I think).
Could it be that the clock-domain doesn't do any handshaking with modules,
and so turns off the clocks even though they are being used?

NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120204/73feba82/attachment.sig>
