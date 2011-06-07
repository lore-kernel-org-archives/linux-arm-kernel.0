From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Jun 2011 19:43:30 +0100
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <20110607182923.GA28451@n2100.arm.linux.org.uk>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
Message-ID: <20110607184329.GA20849@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 07:29:23PM +0100, Russell King - ARM Linux wrote:

> 2. Circular buffer support has been added - see device_prep_dma_cyclic().

> However, 2 is not really a requirement for audio - you can queue several
> single slave transfers (one per period) initially, and then you get
> callbacks as each transfer completes.  In the callback, you can submit
> an additional buffer, and continue doing so causing DMA to never end.

> I believe that this is a saner approach than the circular buffer support,
> and its what I tried to put together for the AMBA PL041 AACI DMA (but
> unfortunately, ARMs platforms are totally broken when it comes to DMA.)

Circular buffers are nice from the point of view of allowing you to
(providing the hardware supports it) totally disable the periodic audio
interrupts and leave the system to run for very long times off the
normal system timers.  This gives a small but non-zero power benefit
providing the hardware gives you enough information about where the DMA
is so you can find out if you need to mix in a notification, otherwise
you get obvious latency issues.

You can also do this with an circular chain of sequential buffers of
course.

> 
> This also removes the need for the callback to be in IRQ context.
> 
> So I don't see that anything you've mentioned is a problem with the API
> as it stands today - there may be issues with the way the DMA engine
> driver has been implemented which cause it not to conform to what I've
> said above, but those are driver bugs and not a fault of the API.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
