From: neilb@suse.de (NeilBrown)
Date: Sat, 4 Feb 2012 13:31:01 +1100
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
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
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <20120203231113.25ae2d3a@notabene.brown>
 <EF62F09C0797D947AD4180A1043C0DF73492FFC3@DLEE10.ent.ti.com>
Message-ID: <20120204133101.1ab3500f@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Feb 2012 00:23:09 +0000 "Woodruff, Richard" <r-woodruff2@ti.com>
wrote:

> 
> > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > owner at vger.kernel.org] On Behalf Of NeilBrown
> 
> > > Not sure if it's the same problem but with 3530 on 3.2 with
> > > sleep_timeout set, I usually get first char dropped (as expected) but
> > > sometimes I get corrupted char instead too. Corrupt char seems to
> > > almost always happen if I set cpufreq to powersave, on performace it's
> > > almost always ok, so maybe it's some timing problem,
> > 
> > I see that too - I'm glad someone else does :-)
> 
> When you have aggressive PM working at the SOC level you many times lost a character on UART every since OMAP2. A strange but true statement is it is nice to see it losing a character on mainline as it as in indication that PM is likely working.
> 
> If you just hook up simple RX and TX lines and not other flow control it is very likely especially with older OMAPs you can lose the 'wake' character on debug console. The UART operates on a derived clock from a 96MHz DPLL which was probably stopped. When the wakeup event hits the IO ring many internals may need to repower and its source DPLL needs to relock. This all can take a while and you can lose the start bit at high baud rate. If you use flow control you might be able to get ahead of it.

So... if flow control is available, then when we idle the uart we should set
the trigger so that RTS is de-asserted as soon as one character arrives.
That would minimise the number of corrupt character we receive and ensure we
resync as early as possible (I have seen 2 corrupt characters when CR,NL
arrive back-to-back.  Neither get through correctly).

Actually ... could we make the off-mode setting of the RTS pin be "ready to
send", but as soon as we wake up, it is reset to "don't send now" until
everything is properly awake and configured?  That should ensure only one
byte is lost.


> Outside of debug console, this loss has not been huge. Protocols like irda would retransmit their magic wake packets. You can move between DMA and interrupt modes with activity. So far there has been a work around per attached device.


What about bluetooth?  HCI/UART doesn't seem to have a lot of error
handling.  Maybe it has enough though.
(I have bluetooth on UART1 ... of course we might not have the same problems
on UART1 .. I haven't played with bluetooth much yet).

Thanks for the insights,

NeilBrown
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120204/51a0d25d/attachment-0001.sig>
