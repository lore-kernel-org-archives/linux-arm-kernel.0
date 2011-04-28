From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 18:03:42 +0100
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
Message-ID: <20110428170342.GA17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 06:29:40PM +0200, Linus Walleij wrote:
> On Tue, Apr 19, 2011 at 2:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Apr 19, 2011 at 02:00:17PM +0200, Linus Walleij wrote:
> >>
> >> On a high-speeded ux500 the DATAEND IRQ will assert before the
> >> DMA data is actually finished, thus if we start hammering in the next
> >> request we break an ongoing transfer. :-(
> >
> > Yes, you've already said that in the past. ?And this is partly why we
> > have this code in the dma unmap:
> >
> > ? ? ? ?/* Wait up to 1ms for the DMA to complete */
> > ? ? ? ?for (i = 0; ; i++) {
> > ? ? ? ? ? ? ? ?status = readl(host->base + MMCISTATUS);
> > ? ? ? ? ? ? ? ?if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
> > ? ? ? ? ? ? ? ? ? ? ? ?break;
> > ? ? ? ? ? ? ? ?udelay(10);
> > ? ? ? ?}
> >
> > So, we wait until the DMA has drained the FIFO before we fire off the
> > next request - or even unmap the DMA buffer. ?Should the DMA fail to
> > drain the FIFO in a reasonable time, we timeout and disable DMA.
> >
> > Again, I ask, why is this not sufficient to cover the case where the
> > data end IRQ occurs before the DMA engine has completed the transfer -
> > which is likely to take a very short time indeed.
> 
> It doesn't help, we have really tested this and at high speed transfers
> (especially if we use Per Fridens speed-up patches) apparently
> the flag RXDATAAVLBL goes to zero before the block is really
> finished.
> 
> My rough guess (after looking at the VHDL code) is that
> RXDATAVLBL flag goes low when the FIFO is empty, but that
> doesn't mean that the DMA handshake logic is out of its send/recieve
> state and thus we screw it up if we hammer in another transfer before
> it has had time to deassert the single/burst request signals and go to
> idle state. This can only be seen by the side effect of the DMA
> transfer actually terminating, and the DMA engine calling its
> callback.

That's rather unfortunate, because it means that trying it on ARM
hardware is going to hang indefinitely waiting for the nonexistent
DMA stuff to finish.

I remain unconvinced whether this problem applies only to ARMs
evaluation boards as I believe the whole primecell DMA stuff from
the outset is fundamentally misdesigned.  I suspect there maybe SoCs
out there which suffer from the same broken DMA issues which ARMs
eval boards do.

Maybe an alternative solution is on data end to set a timer, which
is cancelled when the DMA engine callback arrives.  If the timer
expires, it means we have broken DMA and that needs to be shutdown
for that instance.

However, one thing worries me - what if the DMA callback comes before
we get the data end interrupt.  Given the weirdnesses of your
implementation found so far (which are well beyond what's visible
on ARMs own implementation) I wouldn't put any guarantees on the
relative ordering of that either.
