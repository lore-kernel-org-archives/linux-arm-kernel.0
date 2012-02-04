From: neilb@suse.de (NeilBrown)
Date: Sat, 4 Feb 2012 14:09:23 +1100
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com>
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
 <20120204110131.7378b8fe@notabene.brown>
 <alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com>
Message-ID: <20120204140923.063706c8@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012 19:06:19 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:

> Hi Neil
> 
> On Sat, 4 Feb 2012, NeilBrown wrote:
> 
> > Guess what happens if I set autosuspend_delay_ms to 0?
> > Massive transmit problems.  Driver can hardly get anything out before the
> > UART's fclk is cut...
> 
> Just reproduced this on 35xx BeagleBoard.  Looks like the UART is indeed 
> going idle while the TX FIFO has bytes in it.

That makes me happy :-)

> 
> Here's a patch that helps.  It seems to work down to an 
> autosuspend_delay_ms of 1 ms.  Without it, the best I can get is 8 ms.
> 
> Of course, ideally it should work fine at autosuspend_delay_ms = 0, so 
> likely there's some other infelicity that we're currently missing.
> 
> Neil, care to give this a test and confirm it on your setup?

Yes, that seems to make the output corruption go away.

Even with small autosuspend_delay_ms down to 0 it doesn't corrupt output,
but as the first input byte is corrupted, I cannot really type with those
setting (so I ssh to gain control again).

The patch disables the IDLEMODE_SMART setting that happens on runtime
suspend/resume so that the IDLEMODE_NO setting stays in force.

So it clearly isn't "stopping the clocks" that is the problem - as I first
imagined - but rather the SIDLE handshake isn't doing what we think it should
do.

Thanks,
NeilBrown

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120204/23e3a5c8/attachment.sig>
