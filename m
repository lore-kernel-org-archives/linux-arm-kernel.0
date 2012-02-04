From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Sat, 4 Feb 2012 01:46:52 +0000
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <alpine.DEB.2.00.1202031731500.27947@utopia.booyaka.com>
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
 <alpine.DEB.2.00.1202031731500.27947@utopia.booyaka.com>
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73493107B@DLEE10.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Friday, February 03, 2012 7:00 PM

> > One irritation was some internal interrupt sources were not linked to
> > low power wakeup events. If you were in interrupt mode and got
> > characters below watermark you could sleep before interrupt status
> > showed up (as you had to wait several frame times before functional
> > interrupt asserted) but there was no wake at anticipated frame timeout
> > because lack of linking of internal event to wake event.
> 
> Indeed, it seems that we are just now working around these wakeup-related
> bugs.  Kind of surprising that no errata showed up for them.

There have been errata over time in this area. Several I hit were updated at 3630 time. UART did get IER2 but I don't recall all details for UART.  Probably that is not being used.

> What's particularly remarkable is that it looks like the UARTs will
> idle-ack while their transmit FIFOs have data in them (!)

Generally a module can ACK its ICLK if it is not used internally. The FCLK can push data out with out ICLK and is controlled separately always (omap4 changed encoding, to optional clock). This allows interconnect to idle during tx to save power. The trick is to ensure all module wakeup plumbing is enabled so a functional tx irq will flow.  Audits last showed several drivers missing steps (omap specific). Some drivers seemed to rely on static dependencies or coincident neighbor activity to allow their functional interrupt to flow... to many interdependent custom details... and yes some errata.

Anyway, even with all SOC specific wake bits you may lose the character with latency of restart. Point I was raising was external chip hook can not be neglected as its part of equation.

Regards,
Richard W.
