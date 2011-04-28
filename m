From: martin.furmanski@gmail.com (Martin Furmanski)
Date: Fri, 29 Apr 2011 00:24:05 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <20110428170342.GA17290@n2100.arm.linux.org.uk>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<20110428170342.GA17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikAZjUw5q6FnbwaD_HzTG8BYp9TRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 7:03 PM, Russell King - ARM Linux <
linux@arm.linux.org.uk> wrote:

> On Wed, Apr 20, 2011 at 06:29:40PM +0200, Linus Walleij wrote:
> > On Tue, Apr 19, 2011 at 2:03 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Tue, Apr 19, 2011 at 02:00:17PM +0200, Linus Walleij wrote:
> > >>
> > >> On a high-speeded ux500 the DATAEND IRQ will assert before the
> > >> DMA data is actually finished, thus if we start hammering in the next
> > >> request we break an ongoing transfer. :-(
> > >
> > > Yes, you've already said that in the past.  And this is partly why we
> > > have this code in the dma unmap:
> > >
> > >        /* Wait up to 1ms for the DMA to complete */
> > >        for (i = 0; ; i++) {
> > >                status = readl(host->base + MMCISTATUS);
> > >                if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
> > >                        break;
> > >                udelay(10);
> > >        }
> > >
> > > So, we wait until the DMA has drained the FIFO before we fire off the
> > > next request - or even unmap the DMA buffer.  Should the DMA fail to
> > > drain the FIFO in a reasonable time, we timeout and disable DMA.
> > >
> > > Again, I ask, why is this not sufficient to cover the case where the
> > > data end IRQ occurs before the DMA engine has completed the transfer -
> > > which is likely to take a very short time indeed.
> >
> > It doesn't help, we have really tested this and at high speed transfers
> > (especially if we use Per Fridens speed-up patches) apparently
> > the flag RXDATAAVLBL goes to zero before the block is really
> > finished.
> >
> > My rough guess (after looking at the VHDL code) is that
> > RXDATAVLBL flag goes low when the FIFO is empty, but that
> > doesn't mean that the DMA handshake logic is out of its send/recieve
> > state and thus we screw it up if we hammer in another transfer before
> > it has had time to deassert the single/burst request signals and go to
> > idle state. This can only be seen by the side effect of the DMA
> > transfer actually terminating, and the DMA engine calling its
> > callback.
>
>
Even this would be no guarantee. The callback is hopefully a guarantee
that the clr has been asserted, but for the peripheral's state machine
there is still an uncertain time left, so the callback is a guess as good as
any other, although the reference point has been shifted forwards. Since the
time is uncertain, might just add a suitable delay. Preferably based on VHDL
analysis and as a function of peripheral clock.

At the very least the last data element should be out of the FIFO when
RxDataAvlbl
deasserts and a read of status should not arrive any sooner than that
element
to the DMAC. If this is true, then the read of status itself implies that
the DMAC
has asserted clr (or in some very pessimistic scenario within a few
cycles?),
and the delay can be chosen fixed from this point in time. Since udelays are
already tolerated, I don't see much more ugliness added by this.


> That's rather unfortunate, because it means that trying it on ARM
> hardware is going to hang indefinitely waiting for the nonexistent
> DMA stuff to finish.
>
> I remain unconvinced whether this problem applies only to ARMs
> evaluation boards as I believe the whole primecell DMA stuff from
> the outset is fundamentally misdesigned.  I suspect there maybe SoCs
> out there which suffer from the same broken DMA issues which ARMs
> eval boards do.
>
> Maybe an alternative solution is on data end to set a timer, which
> is cancelled when the DMA engine callback arrives.  If the timer
> expires, it means we have broken DMA and that needs to be shutdown
> for that instance.
>
> However, one thing worries me - what if the DMA callback comes before
> we get the data end interrupt.  Given the weirdnesses of your
> implementation found so far (which are well beyond what's visible
> on ARMs own implementation) I wouldn't put any guarantees on the
> relative ordering of that either.
>
>
So this would build on the old solution, and won't break the broken ones.


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110429/0de4a203/attachment-0001.html>
