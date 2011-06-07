From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2011 23:28:10 +0100
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <BANLkTikXGpxpyF8kQORqswD5tqNEjtj3dA@mail.gmail.com>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
	<20110607184329.GA20849@sirena.org.uk>
	<BANLkTikXGpxpyF8kQORqswD5tqNEjtj3dA@mail.gmail.com>
Message-ID: <20110607222810.GB28451@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 12:31:42AM +0530, Jassi Brar wrote:
> On Wed, Jun 8, 2011 at 12:13 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Tue, Jun 07, 2011 at 07:29:23PM +0100, Russell King - ARM Linux wrote:
> >
> >> 2. Circular buffer support has been added - see device_prep_dma_cyclic().
> >
> >> However, 2 is not really a requirement for audio - you can queue several
> >> single slave transfers (one per period) initially, and then you get
> >> callbacks as each transfer completes. ?In the callback, you can submit
> >> an additional buffer, and continue doing so causing DMA to never end.
> >
> >> I believe that this is a saner approach than the circular buffer support,
> >> and its what I tried to put together for the AMBA PL041 AACI DMA (but
> >> unfortunately, ARMs platforms are totally broken when it comes to DMA.)
> >
> > Circular buffers are nice from the point of view of allowing you to
> > (providing the hardware supports it) totally disable the periodic audio
> > interrupts and leave the system to run for very long times off the
> > normal system timers. ?This gives a small but non-zero power benefit
> > providing the hardware gives you enough information about where the DMA
> > is so you can find out if you need to mix in a notification, otherwise
> > you get obvious latency issues.
> 
> This is what I called free-running circular buffer.
> Besides power saving scenario, it is necessary for a fast peripheral
> with shallow fifo.

Please stop perpetuating this myth.  It is not necessary for fast
peripherals with shallow fifos.

What is necessary for such peripherals is to have a large enough pending
DMA queue already in place that you don't encounter underrun errors.
That means chaining up several sequential smaller buffers so that you
can replenish the queue before the underrun occurs.

Eg, if you have eight 8K buffers, you submit 7 of the 8K buffers when
you start having filled those 7 with data.  You prepare the 8th and
when the 1st buffer completes, you submit the 8th buffer and start
re-filling the 1st buffer.  Then, when the 2nd buffer completes, you
re-submit the 1st buffer and start filling the 2nd buffer.  etc.

This means you always have at least 6 buffers of 8K available for the
peripheral to consume.

If you get to the end of all the pending buffers before you can service
the DMA interrupt, then you don't have the data in place to continue to
feed the peripheral, so DMA will stop and _correctly_ you will get an
underrun.  Hint: no more data prepared _is_ the underrun condition so
it is only right that DMA should stop at that point.

> The peripheral throws underrun errors, if the dma h/w doesn't support
> LLI and cpu takes
> a bit long loading-triggering the next transfer on DMA due to
> irq-latency for some reason.

There is no difference between moving to the next buffer in a chain of
buffers and having to re-load the DMA hardware to simulate a real
circular DMA buffer.

The only difference would be if the hardware provides you with support
for circular buffers itself, but it would also need some way of generating
an interrupt every X bytes transferred to support the requirements of
ALSA, or some other way to track progress.
