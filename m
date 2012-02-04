From: neilb@suse.de (NeilBrown)
Date: Sat, 4 Feb 2012 11:01:31 +1100
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com>
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
 <20120204085940.2de44594@notabene.brown>
 <alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com>
Message-ID: <20120204110131.7378b8fe@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012 16:02:42 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:

> On Sat, 4 Feb 2012, NeilBrown wrote:
> 
> > On Fri, 3 Feb 2012 13:10:28 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> > 
> > > Considering your theory that the UART clocks are being cut while there's 
> > > still data in the FIFO, you might consider removing this code at the end 
> > > of transmit_chars():
> > > 
> > > 	if (uart_circ_empty(xmit))
> > > 		serial_omap_stop_tx(&up->port);
> > 
> > I read the code and chickened out of just removing that.
> > serial_omap_stop_tx seem to do 2 things:
> >  1/ tell the uart to stop sending interrupts when the tx fifo is empty
> >  2/ set forceidle (really smartidle) on the uart.
> > 
> > I didn't feel comfortable removing '1' as I thought it might generate an
> > interrupt storm .. maybe not.
> 
> Might be worth a try.  In theory, since the current UART driver sets the 
> TX_EMPTY flag in the SCR register, the UART should only raise a TX 
> interrupt when the FIFO + shift register are totally empty.  So hopefully 
> you should only get one extra interrupt per TTY transmit operation.
> 
> > Instead I just removed '2'.  In fact I replaced the 'set_forceidle' call with
> > 'set_noidle'.  So the uart should never report that it was idle.
> > 
> > I did this with my other patch removed so pm_runtime_put() was still being
> > called.
> > 
> > Result:  I still get corruption.
> > So having the UART say "no, I'm not idle" does *not* stop the clock
> > being turned off when we use omap_hwmod_idle() to turn off the clocks.
> 
> Hmm that's doubtful.  If that's really so, then we should be seeing 
> massive UART transmit problems.  I'd expect that the driver wouldn't be 
> able to get any transmit buffers out the door at all before the UART's 
> fclk is cut.

Guess what happens if I set autosuspend_delay_ms to 0?
Massive transmit problems.  Driver can hardly get anything out before the
UART's fclk is cut...


> 
> What's probably happening in this case is that the hwmod code is rewriting 
> the UART SIDLEMODE bits in the hwmod code's _idle() function.  This gets 
> called as part of the PM runtime suspend operation.  So it's bypassing 
> your debugging hack :-)  The hwmod code expects to control the SYSCONFIG 
> register bits itself, and the current way that the UART driver messes with 
> the SYSCONFIG bits is a total hack that that hwmod code is not expecting.  
> You could try disabling that behavior in _idle_sysc() by adding a hack to 
> skip it if it's the UART3 hwmod.
> 
> > When we turn off a clock, if that is the last clock in the clock-domain, we
> > also turn off the clock-domain (I think).
> 
> That's only true if the clockdomain is programmed to use 
> software-supervised idle.  CORE & PER should both be programmed to 
> hardware-supervised idle by mach-omap2/pm34xx.c.  In that case, we let the 
> PRCM put the clockdomain to sleep by itself.
> 
> > Could it be that the clock-domain doesn't do any handshaking with modules,
> > and so turns off the clocks even though they are being used?
> 
> Probably not -- I'd think that hardware-supervised idle wouldn't work at 
> all if that were true.

Thanks for those hints.  Next time I dive into the code/doco they might help
me understand a bit more.

Thanks,
NeilBrown

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120204/f757a1ca/attachment.sig>
