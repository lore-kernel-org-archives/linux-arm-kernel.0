From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Jan 2011 14:00:09 +0000
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <AANLkTimTbn-rQik+PvC-GyLd3HBAuGi3f8kR-T2GcvK8@mail.gmail.com>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<AANLkTi=HzzOkVmD9z=9uRdzHsaixFAfOv9BmxoY=u7uf@mail.gmail.com>
	<20110131102726.GA8948@n2100.arm.linux.org.uk>
	<AANLkTinBbXN-fxppo1Pa33DxiS6QYSdwqFsadFDxmPPy@mail.gmail.com>
	<20110131104009.GC8948@n2100.arm.linux.org.uk>
	<AANLkTimTbn-rQik+PvC-GyLd3HBAuGi3f8kR-T2GcvK8@mail.gmail.com>
Message-ID: <20110131140009.GA13918@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 31, 2011 at 02:53:32PM +0100, Linus Walleij wrote:
> On Mon, Jan 31, 2011 at 11:40 AM, Russell King - ARM Linux <
> linux at arm.linux.org.uk> wrote:
> 
> What can happen is you receive the DATAEND interrupt,
> > which tears down the data side of the request, and starts the stop
> > command.  Meanwhile there's still data left in the FIFO for the CPU
> > to read.
> >
> > I suspect there's a similar race between DMA and the host CPU too as
> > you leave the DATAEND interrupt on.  I suspect for reliability, we
> > need to have the DMA controller callback function in place to enable
> > the DATAEND interrupt.  Or something like that.
> >
> 
> Yes I get it now, well, what we do is essentially create three state
> variables that are all checked at end of DMA (by adding a
> DMA termination callback), end of PIO or DATAEND IRQ arrival.

There's no need, and you don't want to do it like that.  If you receive
and ack the data end interrupt before you've completed the transfer,
then you need additional complexity in the PIO data handler.

Keep it simple.  Keep DATAEND masked until you've finished transfering
the data and then enable it - you'll get the interrupt at the right point
that way.

> I'll cook up some patch ASAP, just need to backport some
> stuff on top of your latest MMCI patches.

I have a number of patches on top of just these two.  There's eight
in total.  See the mmci-dma branch.  I want to discard the top patch
as I still don't think the mmci imposes that requirement.

PS, don't send me html encoded mail...
