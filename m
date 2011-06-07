From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2011 19:29:23 +0100
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
Message-ID: <20110607182923.GA28451@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 03:45:18PM +0530, Jassi Brar wrote:
> On Tue, Jun 7, 2011 at 1:45 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jun 07, 2011 at 01:39:43PM +0530, Jassi Brar wrote:
> >> Unfortunately, no. There are some features of Samsung's DMA API that
> >> the drivers have come to rely upon.
> >> Besides, I am not particularly a fan of the generic API. And IIRC,
> >> neither is Ben Dooks, the designer of the
> >> Samsung's DMA API.
> >
> > We are now at the point where this is non-optional. ?If the generic API
> > doesn't fit what Samsung needs, then that needs to be discussed and
> > whatever problems there are need to be resolved.
> The discussion did take off a few months ago, but we didn't reach anywhere.
> Being able to queue request from the 'done' callback, the need of
> circular buffer
> API (possibly a free-running one too) and callbacks in irq-context, as
> they happen,
> were a few requirements for having fast peripherals with shallow fifo
> work without underruns.

I can see why you have these concerns; the problem is the slave DMA
engine API was never properly documented.

1. The slave API does permit the done callback to submit new requests
   already (and any DMA engine driver which doesn't allow that is broken.)

Note that slave APIs _should_ permit several requests to be queued up
and as each finish, the next one should be started.  In other words,
once DMA has started it should continue until there is no more work for
the DMA engine to perform.

2. Circular buffer support has been added - see device_prep_dma_cyclic().

However, 2 is not really a requirement for audio - you can queue several
single slave transfers (one per period) initially, and then you get
callbacks as each transfer completes.  In the callback, you can submit
an additional buffer, and continue doing so causing DMA to never end.

I believe that this is a saner approach than the circular buffer support,
and its what I tried to put together for the AMBA PL041 AACI DMA (but
unfortunately, ARMs platforms are totally broken when it comes to DMA.)

This also removes the need for the callback to be in IRQ context.

So I don't see that anything you've mentioned is a problem with the API
as it stands today - there may be issues with the way the DMA engine
driver has been implemented which cause it not to conform to what I've
said above, but those are driver bugs and not a fault of the API.
