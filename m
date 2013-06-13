From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 11:05:25 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVOB1e6cptrXqbXyt_JxU7YnRp++HABvR90cG8rUMa2xog@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306131054420.1561-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Ming Lei wrote:

> > For reasonably sophisticated host controllers like EHCI, the delay in
> > responding to an interrupt doesn't matter much.  But for simpler host
> 
> EHCI might still benefit from the change: suppose uvc video is playing on
> one EHCI bus, and mass storage's performance over another EHCI may
> decrease because of the IRQ latency introduced.

If multiple CPUs are involved, then we could see an improvement in the 
case where the two EHCI controllers share the same IRQ line.  With 
different IRQs, though, everything would run in parallel on different 
CPUs, so there is no advantage.

> > At this point we are talking about multiple changes:
> >
> >         Moving the givebacks to a tasklet or threaded handler.
> >
> >         Changing the USB completion handlers so that they can be called
> >         with interrupts enabled.
> >
> >         Allowing the tasklet/thread to run with interrupts enabled.
> >
> >         Moving more of the HCD processing into the tasklet/thread.
> >
> > Maybe other things too.  In principle, the first and second items can
> > be done simultaneously.
> 
> Very good summery, we can push the 1st change with disabling local IRQ
> when calling complete(), so that at least DMA unmapping can be done
> with IRQ enabled, and at the same time do the API change, which
> should be a bit slow but the mechanical way proposed by Oliver may
> be OK.
> 
> The 3rd item is easy once the 1st two items are completed.
> 
> For the 4th one, it might be a long term thing, since refactoring
> HCD interrupt handler is a bit complicated. Also, when the 1st
> three items are completed, hard interrupt handler takes less time,
> often less than 20us at average about EHCI, so I am wondering
> if the 4th is worthy.

Yes, I don't know about that.  If the time spent in the hardirq
processing is reasonably short then moving it to the threaded handler
won't help very much.

Alan Stern
