From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 10 Jun 2013 10:03:00 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVOrniwAUaJN1dkUZD4HzfV6StajzL3Okw2dNBpkSPRjNA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306100946570.1133-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Thomas and Steve, please see the question below.]

On Mon, 10 Jun 2013, Ming Lei wrote:

> On Sun, Jun 9, 2013 at 11:48 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Sun, 9 Jun 2013, Ming Lei wrote:
> >
> >> Hi,
> >>
> >> The patchset supports to run giveback of URB in tasklet context, so that
> >> DMA unmapping/mapping on transfer buffer and compelte() callback can be
> >> run with interrupt enabled, then time of HCD interrupt handler can be
> >> saved much. Also this approach may simplify HCD since HCD lock needn't
> >> be released any more before calling usb_hcd_giveback_urb().
> >
> > That's a lot of material.  However, you haven't specifically said
> > _what_ you want to accomplish.  It sounds like you're trying to
> 
> All IRQs are disabled(locally) in hard interrupt context, but they are
> enabled in softirq context, this patchset can decrease the time a lot.

That isn't clear.  It is documented that USB completion handlers are 
called with local interrupts disabled.  An IRQ arriving before the 
tasklet starts up might therefore be serviced during the short interval 
before the tasklet disables local interrupts, but if that happens it 
would mean that the completion handler would be delayed.

In effect, you are prioritizing other IRQs higher than USB completion
handlers.  Nevertheless, the total time spent with interrupts disabled
will remain the same.

(There's one other side effect that perhaps you haven't considered.  
When multiple URBs are addressed to the same endpoint, their completion 
handlers are called in order of URB completion, which is the same as 
the order of URB submission unless an URB is cancelled.  By delegating 
the completion handlers to tasklets, and particularly by using per-CPU 
tasklets, you may violate this behavior.)

> > minimize the amount of time spent in hardirq context, but I can't be
> > sure that is really what you want.
> >
> > If it is, this is not a good way to do it.  A better way to minimize
> > the time spent in hardirq context is to use a threaded interrupt
> > handler.  But why do you want to minimize this time in the first place?
> 
> Process context switch may have more cost than switching to softirq,
> then USB performance may be effected, that is why I choose to use
> tasklet.  Also now there is no any sleep in URB giveback, so it isn't
> necessary to introduce process to handle the giveback or completion.

Thomas and Steve, can you comment on this?  I do not have a good 
understanding of the relative benefits/drawbacks of tasklets vs. 
threaded interrupt handlers.

> > The CPU will be still have to use at least as much time as before; the
> > only difference is that it will be in softirq or in a high-priority
> > thread instead of in hardirq.
> 
> Yes, as I said above, but we can allow other IRQs to be served in
> handling URB giveback in softirq context, that is the value of softirq/tasklet.
> Of course, system may have more important things to do during the time.
> Generally speaking, for one driver, hard interrupt handler should always
> consume less time as possible.

As I understand it, the tradeoff between hardirq and softirq is
generally unimportant.  It does matter a lot in realtime settings --
but the RT kernel effectively makes _every_ interrupt handler threaded,
so it won't benefit from this change.

Alan Stern
