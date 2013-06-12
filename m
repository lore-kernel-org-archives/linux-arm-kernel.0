From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 12 Jun 2013 10:35:44 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVPRWxjXqyv-L6yU1OLXHFYCbe7cQxGnaFxqbEXwBK=hfQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306121008420.1431-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Ming Lei wrote:

> If not, I am wondering why one USB driver need register another hard
> interrupt handler? Could you share such examples? I understand the
> case only exists with timer handler as discussed with Oliver, don't I?

Here's another possibility.  A USB driver has a private lock, and it
acquires this lock in its completion handler.  But it also acquires
this lock in other routines, and those other routines may be called by
other drivers or subsystems in interrupt context.

> > The drivers _do_ need to be changed, as explained above.  And that
> > explanation was only one failure scenario.  There may be others.
> 
> OK, I'd like to know what the others are? :-)

Me too.  :-)

> >> And finally, USB HCDs themselves will benefit from the change, won't they?
> >
> > How will they benefit?  Merely from not releasing their private locks?
> 
> The interrupt of one HCD will be responded lately since another HCD's
> interrupt handler takes very long time. With the change, the problem can
> be avoided.

For reasonably sophisticated host controllers like EHCI, the delay in
responding to an interrupt doesn't matter much.  But for simpler host
controllers (for example, those using PIO instead of DMA) it matters
more, so those other HCDs will benefit more from the conversion.

> >> Compared with "usb-storage" task's schedule latency, the tasklet
> >> schedule delay should be lower at most of situations since the tasklet
> >> is scheduled inside irq handler.
> >
> > True.  But the two latencies add.
> 
> I think it should be one tasklet latency added, but what is the other one?

I meant that the latency in tasklet scheduling has to be added to the 
latency in scheduling the usb-storage thread.

> > Or you could have a separate tasklet for each host controller.
> 
> Yes, but I will compare tasklet with interrupt threaded handler first.

Switching to a threaded interrupt handler offers more possibilities.  
Instead of moving just the givebacks to the thread, we could put almost 
all the processing there.  (At least, we can for ehci-hcd.  Other HCDs 
may not be able to do this.)

At this point we are talking about multiple changes:

	Moving the givebacks to a tasklet or threaded handler.

	Changing the USB completion handlers so that they can be called 
	with interrupts enabled.	

	Allowing the tasklet/thread to run with interrupts enabled.

	Moving more of the HCD processing into the tasklet/thread.

Maybe other things too.  In principle, the first and second items can 
be done simultaneously.

Alan Stern
