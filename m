From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Apr 2011 13:03:44 +0100
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
Message-ID: <20110419120344.GG22799@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 02:00:17PM +0200, Linus Walleij wrote:
> On Tue, Apr 19, 2011 at 11:20 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Apr 19, 2011 at 11:02:34AM +0200, Linus Walleij wrote:
> >> From: Ulf Hansson <ulf.hansson@stericsson.com>
> >>
> >> The end of a dma job must be synced with a DATAEND irq. This will
> >> prevent the mmci driver from ending the mmc request before the
> >> dma driver is completely done. By using DMA_PREP_INTERRUPT we
> >> register a callback function which will is called when from the
> >> dma driver when the dma transfer is completed.
> >
> > Why is what we currently do not sufficient?
> 
> On a high-speeded ux500 the DATAEND IRQ will assert before the
> DMA data is actually finished, thus if we start hammering in the next
> request we break an ongoing transfer. :-(

Yes, you've already said that in the past.  And this is partly why we
have this code in the dma unmap:

        /* Wait up to 1ms for the DMA to complete */
        for (i = 0; ; i++) {
                status = readl(host->base + MMCISTATUS);
                if (!(status & MCI_RXDATAAVLBLMASK) || i >= 100)
                        break;
                udelay(10);
        }

So, we wait until the DMA has drained the FIFO before we fire off the
next request - or even unmap the DMA buffer.  Should the DMA fail to
drain the FIFO in a reasonable time, we timeout and disable DMA.

Again, I ask, why is this not sufficient to cover the case where the
data end IRQ occurs before the DMA engine has completed the transfer -
which is likely to take a very short time indeed.
