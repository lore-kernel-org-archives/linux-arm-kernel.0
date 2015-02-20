From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Feb 2015 10:31:44 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <5225828.OI8hbGqrC4@vostro.rjw.lan>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2502710.nOuZfdq5QP@vostro.rjw.lan>
 <20150219112346.GA13659@leverpostej>
 <5225828.OI8hbGqrC4@vostro.rjw.lan>
Message-ID: <20150220103144.GI13659@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > > IRQF_NO_SUSPEND and wakeup fundamentally don't match due to the way
> > > wakeup is implemented in the IRQ core now.
> > > 
> > > Unless drivers with IRQF_NO_SUSPEND do the wakeup behind the core's back
> > > which is just disgusting and should never happen.
> > 
> > I completely agree that using IRQF_NO_SUSPEND in that manner is a
> > disgusting abuse. It seems like some drivers are abusing it for wakeup,
> > and those need to be corrected.
> > 
> > If those are corrected, the same issue with mismatch will happen with
> > those wakeup interrupts, and we need to fix that somehow given people
> > seem to already be relying on being able to share a line with a wakeup
> > device.
> 
> The way we handle wakeup interrupts in the core prevents that, because
> wakeup is handled at the IRQ level rather than at a handler (irqaction)
> level.  Interrupt handlers from irqactions are not run for wakeup
> interrupts at all after suspend_device_irqs(), so if you have anyone
> sharing an IRQ with a wakeup source, their interrupt handler won't be
> run anyway then.

I had missed that fact; thank you for correcting me!

> > I propose we add a new IRQF_BIKESHED, meaning that this interrupt line
> > may be shared with an IRQF_NO_SUSPEND or wakeup interrupt handler.
> 
> As I said, sharing an IRQ with a wakeup source is OK (worst case you'll
> cause spurious wakeup interrupts to occur if your device is not suspended
> properly).  The problem is *entirely* about IRQF_NO_SUSPEND.

I see that now.

> So I claim that the only things having legitimate reasons to ever use
> IRQF_NO_SUSPEND are (a) timers and (b) IPIs.  There really are no other
> cases to worry about in my view, but I may be overlooking something.

Assuming you also include any chained irqchip handlers necessary for
those timers or IPIs, that makes sense to me.

> Anyway, I wouldn't like to add flags allowing driver writers to do fishy
> things in a hush-hush manner.  The warning trigger is there for a good
> reason and if we allow it to be avoided, that has to be for a good reason
> too.  In other words, it shouldn't be too easy to do that.

Sure.

Given all of the above I'll go back to the IRQF_SHARED_TIMER_OK approach
you proposed, along with documentation updates and comments at usage
sites to make it clear when it is valid to use.

Thank you for bearing with me so far.

Mark.
