From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 19 Feb 2015 23:35:54 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150219112346.GA13659@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2502710.nOuZfdq5QP@vostro.rjw.lan> <20150219112346.GA13659@leverpostej>
Message-ID: <5225828.OI8hbGqrC4@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 19, 2015 11:23:46 AM Mark Rutland wrote:
> On Thu, Feb 19, 2015 at 01:16:50AM +0000, Rafael J. Wysocki wrote:
> > On Monday, February 16, 2015 12:23:43 PM Mark Rutland wrote:
> > > [...]
> > > 
> > > > > The "suspend" part is kind of a distraction to me here, because that really
> > > > > only is about sharing an IRQ with a timer and the "your interrupt handler
> > > > > may be called when the device is suspended" part is just a consequence of that.
> > > > > 
> > > > > So IMO it's better to have "TIMER" in the names to avoid encouraging people to
> > > > > abuse this for other purposes not related to timers.
> > > > 
> > > > Sorry to be late to the bike-shed party, but what about:
> > > 
> > > [...]
> > > 
> > > > arch/arm/mach-omap2/mux.c:		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
> > > > arch/arm/mach-omap2/pm34xx.c:		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
> > > > drivers/pinctrl/pinctrl-single.c:				  IRQF_SHARED | IRQF_NO_SUSPEND,
> > > 
> > > These are chained IRQ handlers. If any of these have a chained timer irq
> > > then the IRQF_NO_SUSPEND may be legitimate. I can't imagine why these
> > > would be shared, however.
> > > 
> > > It also looks like these abuse IRQF_NO_SUSPEND for wakeup interrupts.
> > > 
> > > > drivers/rtc/rtc-pl031.c:	.irqflags = IRQF_SHARED | IRQF_NO_SUSPEND,
> > > 
> > > This looks to be an abuse and should use {enable,disable}_irq_wake.
> > > 
> > > However, we'd then need to handle mismatch with wakeup interrupts (which
> > > is effectively the same problem as sharing with a timer).
> > 
> > IRQF_NO_SUSPEND and wakeup fundamentally don't match due to the way
> > wakeup is implemented in the IRQ core now.
> > 
> > Unless drivers with IRQF_NO_SUSPEND do the wakeup behind the core's back
> > which is just disgusting and should never happen.
> 
> I completely agree that using IRQF_NO_SUSPEND in that manner is a
> disgusting abuse. It seems like some drivers are abusing it for wakeup,
> and those need to be corrected.
> 
> If those are corrected, the same issue with mismatch will happen with
> those wakeup interrupts, and we need to fix that somehow given people
> seem to already be relying on being able to share a line with a wakeup
> device.

The way we handle wakeup interrupts in the core prevents that, because
wakeup is handled at the IRQ level rather than at a handler (irqaction)
level.  Interrupt handlers from irqactions are not run for wakeup
interrupts at all after suspend_device_irqs(), so if you have anyone
sharing an IRQ with a wakeup source, their interrupt handler won't be
run anyway then.

> I propose we add a new IRQF_BIKESHED, meaning that this interrupt line
> may be shared with an IRQF_NO_SUSPEND or wakeup interrupt handler.

As I said, sharing an IRQ with a wakeup source is OK (worst case you'll
cause spurious wakeup interrupts to occur if your device is not suspended
properly).  The problem is *entirely* about IRQF_NO_SUSPEND.

Moreover, I don't think any watchdogs have a legitimate reason to use
IRQF_NO_SUSPEND, because quite frankly if you don't want your watchdog
to abort system suspends in progress, then you have no reason to run that
watchdog during system suspend at all.  Conversely, if you want the watchdog
to abort system suspends in progress, its wakeup interrupt should be a wakeup
one.

So I claim that the only things having legitimate reasons to ever use
IRQF_NO_SUSPEND are (a) timers and (b) IPIs.  There really are no other
cases to worry about in my view, but I may be overlooking something.

Anyway, I wouldn't like to add flags allowing driver writers to do fishy
things in a hush-hush manner.  The warning trigger is there for a good
reason and if we allow it to be avoided, that has to be for a good reason
too.  In other words, it shouldn't be too easy to do that.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
